module "cicd" {
  source        = "./modules/cicd"
  app_name      = "cicd"
  image_name    = "cicd_default_ubuntu_1804"
  image_version = "0.0.4"
}