```
---
 - name: Create an ec2 instance
  hosts: web
  gather_facts: false
  
  vars:
      region: us-east-1
      instance_type: t2.micro
      ami: ami-05ea7729e394412c8
      keypair: priyajdm
  
  tasks:
  
    - name: Create an ec2 instance
      ec2:
         aws_access_key: '********************'
         aws_secret_key: '****************************************'
         key_name: "{{ keypair }}"
         group: launch-wizard-26
         instance_type: "{{ instance_type }}"
         image: "{{ ami }}"
         wait: true
         region: "{{ region }}"
         count: 1
         vpc_subnet_id: subnet-02f498e16fd56c277
         assign_public_ip: yes
    register: ec2
```
