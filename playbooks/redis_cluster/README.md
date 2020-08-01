#run this command on any of the vm to create cluster
# redis-cli --cluster create 10.42.0.247:6379 10.42.0.197:6379 10.42.0.132:6379 10.42.0.200:6379 10.42.0.21:6379 10.42.0.34:6379 --cluster-replicas 1
# redis-cli -h 10.42.0.247 -p 6379 cluster nodes
# redis-cli -c -h 10.42.0.247 -p 6379 set name 'TecMint.com'
# redis-cli -c -h 10.42.0.247 -p 6379 get name
#https://www.tecmint.com/setup-redis-cluster-in-centos-8/