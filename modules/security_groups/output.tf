output "sec_grp_alb_id" {
  value = aws_security_group.sec_grp_alb.id
}

output "sec_grp_ecs_id" {
  value = aws_security_group.sec_grp_ecs.id
}