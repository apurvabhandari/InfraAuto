data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "ignite-cluster" {
  count                   = 3
  ami                     = data.aws_ami.ubuntu.id
  instance_type           = "m5a.xlarge"
  key_name                = "mumbai-key"
  //user_data_base64        = "${base64encode(data.template_file.user-data.rendered)}"
  //iam_instance_profile    = "${var.iam_instance_profile}"
  //monitoring              = "${var.enable_monitoring}"
  
  security_groups        = ["${aws_security_group.ignite-sg.id}"]
  subnet_id              = element(aws_subnet.public.*.id, count.index + 0)
  //subnet_id              = element(var.subnet1, count.index)
  
  root_block_device {
    volume_size           = 1000
    volume_type           = "io1"
    iops                  = 3000
  }

  provisioner "file" {
    source      = "aws-s3-ip-finder.xml"
    destination = "/tmp/aws-s3-ip-finder.xml"
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("~/Downloads/mumbai-key.pem")
      host        = self.public_dns
    }
  }

  user_data = <<-EOF
                  #! /bin/bash
                  cd /home/ubuntu
                  apt-get update
                  apt-get install openjdk-11-jdk -y
                  apt-get install unzip
                  sudo curl https://archive.apache.org/dist/ignite/2.9.0/apache-ignite-2.9.0-bin.zip --output apache-ignite-2.9.0-bin.zip
                  unzip apache-ignite-2.9.0-bin.zip
                  cd apache-ignite-2.9.0-bin/bin
                  sudo wget https://repo1.maven.org/maven2/javax/xml/bind/jaxb-api/2.3.1/jaxb-api-2.3.1.jar -P ../libs/
                  sudo cp -r ../libs/optional/ignite-aws ../libs/
                  sudo cp -r /tmp/aws-s3-ip-finder.xml .
                  sudo nohup ./ignite.sh aws-s3-ip-finder.xml &
                  EOF

  # launch_template = {
  #   id      = "lt-0ab278e9941de0c63"
  #   version = "7"
  # }
  tags = {
    Name = "ignite-cluster"
  }

}

resource "aws_s3_bucket" "s3_bucket" {
  bucket = "ignite-s3-ip-finder"
  //region = var.aws_region
}