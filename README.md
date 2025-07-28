# 🧩 Lesson-6: Kubernetes кластер з Helm & ECR

Цей проєкт створений у рамках курсу DevOps CI/CD. Він автоматизує розгортання кластера Kubernetes на AWS з ECR, Helm-чартом для Django-застосунку, конфігурацією змінних середовища, автоскейлінгом та сервісом з зовнішнім доступом.

---

## Структура проєкту

![alt text](image.png)

## Команди для запуску

### Ініціалізація Terraform
terraform init
terraform plan
terraform apply

##Завантаження Docker-образ у ECR

## Логін до ECR
aws ecr get-login-password --region eu-north-1 | \
docker login --username AWS --password-stdin <your-account-id>.dkr.ecr.eu-north-1.amazonaws.com

## Побудова та пуш образу
docker build -t lesson-6-django .
docker tag lesson-6-django:latest <your-account-id>.dkr.ecr.eu-north-1.amazonaws.com/lesson-6-ecr
docker push <your-account-id>.dkr.ecr.eu-north-1.amazonaws.com/lesson-6-ecr

##Розгортання Helm-чарта
helm install django-app charts/django-app/

##Після встановлення Helm-чарта:
kubectl get svc         # перевірка LoadBalancer
kubectl get hpa         # перевірка масштабування
kubectl get configmap   # перевірка змінних середовища

##Модулі
# modules/eks
- Створює кластер Kubernetes через aws_eks_cluster
- Підключений до існуючої VPC (через subnet_ids)
- IAM роль з політикою eks:AssumeRole
- Виводить ім'я кластера та конфігурацію

# modules/ecr
- Створює репозиторій у ECR з автоматичним скануванням
- Тег lesson-6-ecr
- Використовується для зберігання Docker-образу Django

# charts/django-app  
- Описує застосунок у Helm-чарті
- deployment.yaml: використовує образ з ECR + envFrom для ConfigMap
- service.yaml: LoadBalancer для зовнішнього доступу
- hpa.yaml: масштабує від 2 до 6 подів при CPU > 70%

configmap.yaml: змінні середовища (SECRET_KEY, ALLOWED_HOSTS)