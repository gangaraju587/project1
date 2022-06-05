output "domain-load-balancer" {
  description = "The public domain of the load-balancer"
  value       = aws_lb.alb.dns_name
}

output "Accesible-Domain" {
  description = "The public domain to access"
  value       = var.sub-domain-name
}

output "instance_id" {
  value = join("\n", data.aws_instances.test.ids)
}