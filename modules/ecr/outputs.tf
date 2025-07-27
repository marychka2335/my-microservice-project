output "ecr_repository_url" {
  description = "URL репозиторію для Docker-образів"
  value       = aws_ecr_repository.main.repository_url
}
