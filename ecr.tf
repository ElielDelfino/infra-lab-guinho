resource "aws_ecr_repository" "ecr_portfolio" {
  name                 = "portfolio-guinho"
  image_tag_mutability = "MUTABLE"
  force_delete = true
}