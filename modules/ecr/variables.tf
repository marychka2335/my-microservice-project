variable "ecr_name" {
  description = "Ім’я ECR репозиторію"
  type        = string
}

variable "scan_on_push" {
  description = "Чи сканувати образ при завантаженні"
  type        = bool
}
