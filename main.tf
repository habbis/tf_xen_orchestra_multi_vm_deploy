terraform {
  required_providers {
    xenorchestra = {
      source = "terra-farm/xenorchestra"
      version = "0.23.0"
    }
  }
}

provider "xenorchestra" {
  url      = var.xoa_host_url
  username = var.xoa_user
  password = var.xoa_password
  insecure =  true


}


