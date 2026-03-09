resource "aws_ecr_repository" "ecr_projeto_devops" {
  name                 = "projeto-guinho"
  image_tag_mutability = "MUTABLE"
  force_delete = true
}