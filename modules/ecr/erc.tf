resource "aws_ecr_repository" "main" {
  name                 = var.ecr_name
  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }

  tags = {
    Name        = var.ecr_name
    Environment = "lesson-5"
  }
}

resource "aws_ecr_repository" "django" {
  name = var.ecr_name

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name = "lesson-6-ecr"
  }
}
