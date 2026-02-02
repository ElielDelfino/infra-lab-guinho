resource "aws_ecr_repository" "ecr_site" {
  name                 = "ecr-lab-guinho"
  image_tag_mutability = "MUTABLE"
  force_delete = true
}