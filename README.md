# DevOps Automation

[![Generic badge](https://img.shields.io/badge/SUBJECT-DevOps_Automation-Blue.svg)](https://shields.io/)
![Watchers](https://img.shields.io/github/watchers/apurvabhandari/DevOps?style=social)
![last commit](https://img.shields.io/github/last-commit/apurvabhandari/DevOps)

## Infrastructure Automation
## Terraform
- [Terraform](./terraform/README.md)

### Ansible
- [EC2 Creation with Ansible](./AWS-EC2-creation-ansible-playbook.md)
- [Lamp Stack installation with Ansible](./lamp-stack-ansible-playbook.md)
- Roles and Playbook
  - Playbooks are created and some playbooks need to have specific inventory format to work. You can go to each playbook and refer ansible_host file.
    - Roles:
    1. elasticsearch
    2. iptables
    3. jave7
    4. java8
    5. nginx
    6. packages
    7. rabbitmq
    8. blackbox_exporter
    9. node_exporter
    10. pushgateway
    11. prometheus
    12. memcached_exporter
    13. consul
    14. consul_exporter
    15. memcached
    16. rabbitmq_exporter
    17. redis_cluster
    18. redis_exporter
    - Playbooks
    1. blackbox_exporter
    2. consul
    3. consul_exporter
    4. elasticsearch
    5. java7
    6. java8
    7. memcached
    8. memcached_exporter
    9. node_exporter
    10. prometheus
    11. pushgateway
    12. rabbitmq
    13. rabbitmq_exporter
    14. redis_cluster (Refer this playbook readme to create cluster)
    15. redis_exporter

      Note: All playbooks are specific to work for only centos 7.<br>
      How to run<br>
      ansible-playbook PLAYBOOK_NAME -i INVENTORY_NAME<br>
      ansible-playbook playbooks/elasticsearch/elasticsearch-playbook.yaml -i host_file<br>


### Creator

- [Apurva Bhandari](https://www.linkedin.com/in/apurvabhandari-linux/)
- [![Twitter URL](https://img.shields.io/twitter/follow/Apurv_Bhandari?style=social)](https://twitter.com/Apurv_Bhandari)

### LICENSE
[Apache License 2.0](./LICENSE)
