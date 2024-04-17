provider "aws" {
  alias="us-east-2"
  region  = "us-east-2"
}

provider "aws" {
  alias   = "us-east-1"
  region  = "us-east-1"
}


module "my_vpc" {
  source = "../modules/vpc"
  vpc_cider = "192.168.0.0/16"
  tenancy= "default"
  vpc_id= "${module.my_vpc.vpc_id}"
  subnet_cidr="192.168.1.0/24" 
  providers = {
    aws=aws.us-east-1
  }
  }

module "my_ec2" {
    source = "../modules/ec2"
    ec2count="1"
    ami_id = "ami-051f8a213df8bc089"
    instance_type=""
    subnet_id="${module.my_vpc.subnet_id}"  
    providers = {
      aws= aws.us-east-1
    }
}



module "my_vpc_us-east-2" {
  source = "../modules/vpc"
  vpc_cider = "192.168.0.0/16"
  tenancy= "default"
  vpc_id= "${module.my_vpc.vpc_id}"
  subnet_cidr="192.168.1.0/24" 
  providers = {
    aws = aws.us-east-2
  }
  } 

 module "my_ec2__us-east-2" {
    source = "../modules/ec2"
    ec2count="1"
    ami_id = "ami-0900fe555666598a2"
    instance_type=""
    subnet_id="${module.my_vpc.subnet_id}"  

    providers = {
       aws = aws.us-east-2
    }
}  