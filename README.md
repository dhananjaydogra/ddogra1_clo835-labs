# ddogra1_clo835-lab1
Lab1 for CLO835   
	
		
Readme  Steps  to implement :
	
1) Create three S3 bucket :ddogra1-clo835-labs 
	   	
		This value needs to be used in the below location:
	   	ddogra1_clo835-lab1/terraform_code/instance/config.tf
			

2) Now clone the git  repository in your local environment from Prod
	
		git clone https://github.com/dhananjaydogra/ddogra1_clo835-lab1.git
	
  Once done create a ssh key pairs 
	a) path : ddogra1_clo835-lab1/terraform_code/instance/     key-name: lab1-dev
		  
3) Validate the value of iam_instance profile that should have a policy "AmazonEC2ContainerRegistryReadOnly",
   If you can create one, then create add attach that policy or use an existing profile and update the role assoicated with it and add the above policy.
   Need to use the name of the User Role which has that policy and update the default value in the 
    	
	variable "iam_instance_profile_name" 
	present at location : ddogra1_clo835-lab1/terraform_code/instance/variables.tf
 
4) Update the gitHub action secrets for AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY, AWS_SESSION_TOKEN need to connect to AWS ECR.
   
	
5) After that you need to deploy infrastructure in sequential order
   	use below commands at given location: ddogra1_clo835-lab1/terraform_code/instance/
		
		terraform init
		terraform fmt
		terraform validate
		terraform plan
		terraform --auto-approve

    Take a note of the output having the  Public IP address named as "DevInstance" which is needed for testing and validation
	   
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------

TESTING

6)  Once infrastructure is in place and AWS ECR is created.

	a) Make some changes to git and merge with main branch , it will trigger the workflow to push the docker images to aws ECR.

	b) Once the docker images are pushed to ECR,  You can connect to the created EC2 instance using the ssh
		
		location:  ddogra1_clo835-lab1/terraform_code/instance/
		command : ssh -i lab1-dev ec2-user@<DevInstance>    (You will get the IP address from the output of terraform deployment)

	c) login to the ECR use the below commands 

		export ECR= "<Paste the ECR uri taken from the portal or from command "aws ecr describe-repositories" >
		
		docker login -u AWS -p $(aws ecr get-login-password --region us-east-1) ${ECR}
   
	d)  Pull and Create the docker images 

		docker pull  <URI (copy the docker images uri from aws ECR  with the images)>
		
		docker run -d -p 8080:80 --name  cats <docker cats image uri>
		docker run -d -p 8081:80 --name  dogs <docker dogs image uri>

	e) Validate the running docker containers using the web browser 
   
   
	f) To create the ping capability between the containers use the below commmands

		From the Host machine : 
		docker network create mynet

		#After that connect your containers to the network:
		docker network connect mynet cats
		docker network connect mynet dogs

		#Check if your containers are part of the new network:
		docker network inspect mynet

		docker exec -ti cats ping dogs
		docker exec -ti dogs ping cats
  
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------

CLEAN UP

	#To destroy the infrastructure use the reverse order from above 
	  (use command: terraform destroy --auto-approve ) at all the below location: ddogra1_clo835-lab1/terraform_code/instance/
