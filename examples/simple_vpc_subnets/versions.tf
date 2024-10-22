terraform {
  required_version = ">= 1.3.0"

  required_providers {
    huaweicloud = {
      # source  = "huaweicloud/huaweicloud"
      # version = ">= 1.40.0"
      source  = "local-registry/huaweicloud/huaweicloud"
      version = "1.99.99"
    }
  }
}
