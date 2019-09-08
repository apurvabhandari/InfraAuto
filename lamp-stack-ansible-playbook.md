```
---
# Setup LAMP Stack
-  hosts: host1
   tasks:
 
      -  name: Add ppa repository
         become: yes
         apt_repository: repo=ppa:ondrej/php
 
      -  name: Install lamp stack
         become: yes
         apt:
            pkg:
              - apache2   
              - mysql-server
              - php7.0
              - php7.0-mysql   
            state: present
            update cache: yes
 
      -  name: start apache server
          become: yes
          service: 
              name: apache2
               state: started
                enabled: yes
 
      -  name: start mysql service
          become: yes
          services:
             name: mysql
             state: started
             enabled: yes
 
      -  name:  create target directory
          file: path=/var/www/html state=directory mode=0755
 
      - name:  deploy index.html
         became: yes
          copy: 
              src: /etc/ansible/index/index.html
              dest: var/www/html/index/index.html
```
