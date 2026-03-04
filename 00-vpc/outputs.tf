output "out_azs" {
  value = module.vpc.out_azs
}

// catch the output from the modular
output "vpc_id" {
  value = module.vpc.vpc_id
}