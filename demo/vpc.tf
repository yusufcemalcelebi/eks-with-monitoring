module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.19.0"

  name = "demo"
  cidr = "10.0.0.0/16"

  azs             = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  private_subnets = ["10.0.0.0/23", "10.0.2.0/23", "10.0.4.0/23"]       # 512 IPs for each Subnet
  public_subnets  = ["10.0.100.0/23", "10.0.102.0/23", "10.0.104.0/23"] # 512 IPs for each Subnet
  intra_subnets   = ["10.0.51.0/24", "10.0.52.0/24", "10.0.53.0/24"]    # 256 IPs for each Subnet

  enable_nat_gateway     = true
  single_nat_gateway     = true
  one_nat_gateway_per_az = false

  enable_dns_support   = true
  enable_dns_hostnames = true
  enable_vpn_gateway   = true

  public_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                      = 1
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"             = 1
  }
}
