# STEPS TO Configure Terraform

## AWS ACCOUNT PREREQUISITES
   - Create an IAM User in AWS Account with programatic access
   - Add S3Bucket ,VPC ,EC2 Instace fullaccess permission to user
   - Create an Access key and Secret key for User and saved it 
   - Create one key_pair in AWS Account that key we will use to login with EC2 Intance

## Terraform Prerequisites && Steup 

   - Clone the git repo xyz
   - Git clone xyz
   - Check you are using same bucket or new bucket make changes according to Bucket name,  Region.
#### Exoprting AWS Credentials
   ```
     export AWS_ACCESS_KEY_ID="your access key"
     export AWS_SECRET_ACCESS_KEY="Your secret access key"
     export AWS_REGION="Region_name"

  ```
   - Now we start to build resource
```
terraform init
```
```
terraform plan
```
```
terraform apply
```

## Login to EC2 intance with ssh

- Now we use key pair that we created in AWS Account for login to EC2 instance with ssh
```
ssh -i your_key_name EC2_instace_username@EC2_instance_Public_ip
```
## Sonarqube Server Creation

- Now done the below steps to run Sonarqube server in your EC2 Instance

```
    1  sudo apt update && sudo apt upgrade -y
    2  sudo apt install openjdk-17-jdk -y
    3  wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-10.7.0.96327.zip
    4  sudo apt install unzip
    5  unzip sonarqube-10.7.0.96327.zip -d/opt
    6  sudo mv /opt/sonarqube-10.7.0.96327 /opt/sonarqube
    7  adduser sonar
    8  sudo adduser sonar sonar
    9  sudo chown -R sonar:sonar /opt/sonarqube
   10  sudo vi /opt/sonarqube/conf/sonar.properties 
   11  sudo vi /etc/systemd/system/sonarqube.service
 ```
   - Add below content in sonarqube.service file 
 ```
	 		[Unit]
Description=SonarQube service
After=syslog.target network.target
[Service]
Type=forking
ExecStart=/opt/sonarqube/bin/linux-x86-64/sonar.sh start
ExecStop=/opt/sonarqube/bin/linux-x86-64/sonar.sh stop
User=sonar
Group=sonar
Restart=always
LimitNOFILE=65536
LimitNPROC=4096
[Install]
WantedBy=multi-user.target
```  
    12  sudo systemctl daemon-reload
    13  sudo systemctl start sonarqube
    14  sudo systemctl start sonarqube
    15  netstat -tlnp (for checking it will work on which port)
    16  cat /opt/sonarqube/logs/sonar.log 
   

   ## Root device Size Increase Code

  - df -h (Command to check root_device storage)
  - Add Code to EC2 instace file for increasing root device value 
  - reboot the system with command **reboot**
 



