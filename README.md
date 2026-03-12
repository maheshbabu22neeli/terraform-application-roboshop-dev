# terraform-application-roboshop-dev


# Roboshop Dev Architecture
![roboshop-dev.drawio.svg](images/roboshop-dev.drawio.svg)



## Create Infra
1. From Local go to terraform-application-roboshop-dev and run below command.
````
for i in 00-vpc/ 10-sg/ 20-sg-rules/ 30-bastion/ 50-backend-alb/; do cd $i; terraform init --reconfigure; terraform apply -auto-approve; cd ..; done
````
2. Login to Bastion EC2 instance and clone terraform-application-roboshop-dev repo
3. Go to 40-databases and run terraform command
````
    terraform init
    terraform plan
    terraform apply -auto-approve
````
4. 