# terraform-application-roboshop-dev


# Roboshop Dev Architecture
![roboshop-dev.drawio.svg](images/roboshop-dev.drawio.svg)



## Create Infra
1. From Local go to terraform-application-roboshop-dev and run below command.
````
for i in 00-vpc/ 10-sg/ 20-sg-rules/ 30-bastion/ 50-backend-alb/ 70-acm/ 80-frontend-alb; do cd $i; terraform init --reconfigure; terraform apply -auto-approve; cd ..; done
````
2. Login to Bastion EC2 instance and clone terraform-application-roboshop-dev repo
3. Go to 40-databases and run terraform command
````
    terraform init
    terraform plan
    terraform apply -auto-approve
````

## Delete infra
````
for i in 80-frontend-alb/ 70-acm/ 50-backend-alb/ 30-bastion/ 20-sg-rules/ 10-sg/ 00-vpc/; do cd $i;terraform destroy -auto-approve; cd ..; done
````


### How to create stress on EC2 instance to test autoscaling
1. Login to EC2 instance(ex: catalogue) using below command `ssh ec2-user@<private_ip>`
2. Install stress-ng using command `sudo yum install stress-ng -y`
3. Run stress command as `stress-ng --cpu 2 --cpu-load 70`