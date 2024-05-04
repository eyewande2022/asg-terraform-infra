variable "name_prefix" {
  default = "PFTD-LT"
  type = string
}

variable "ami_id" {
    default = "ami-008ea0202116dbc56"
    type = string
  
}

variable "instance_type" {
  default = "t2.micro"
  type = string
}

variable "desired_capacity" {
    default = 3
    type = number
}

variable "min_size" {
    default = 3
    type = number
}


variable "max_size" {
    default = 6
    type = number
}

variable "subnet_ranges" {
  type = list(string)
  default = ["subnet-02a9e5d00bbb8cc25", "subnet-0644c8c5d8ada7398", "subnet-04fb6726c16bdd4ca"]
  }

  variable "scaling_adjustment" {
    type = number
    default = 4
  }


  variable "env" {
    type = string
    default = "dev"
  }

  variable "vpc_id" {
  type    = string
  default = "vpc-043e1dc52827b0366"

}
 variable "key_name" {
   default =  "londonserver"
   type = string
 }

 variable "volume_size" {
  default = 11
  type = number
   
 }

 variable "device_name" {
   default =  "/dev/sdf"
   type = string
 }

 variable "load_balancer_type" {
   default = "network"
   type = string
 }

 variable "target_type" {
   default = "instance"
   type = string
 }