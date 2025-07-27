#!/bin/bash

# Функція для перевірки встановлення
is_installed() {
    command -v "$1" &> /dev/null
}

# Docker
if is_installed docker; then
    echo "Docker вже встановлений"
else
    echo "Встановлюємо Docker"
    sudo apt update
    sudo apt install -y docker.io
    sudo systemctl start docker
    sudo systemctl enable docker
fi

# Docker Compose
if is_installed docker-compose; then
    echo "Docker Compose вже встановлений"
else
    echo " Встановлюємо Docker Compose"
    sudo apt install -y docker-compose
fi

# Python
PY_VERSION=$(python3 --version 2>/dev/null | cut -d' ' -f2)
if [[ $PY_VERSION > "3.8" ]]; then
    echo "Python $PY_VERSION вже встановлений"
else
    echo " Встановлюємо Python 3.9"
    sudo apt install -y python3.9 python3-pip
fi

# Django
if python3 -m django --version &>/dev/null; then
    echo "Django вже встановлений"
else
    echo " Встановлюємо Django"
    python3 -m pip install --upgrade pip
    pip3 install Django
fi

echo " Усі інструменти встановлено або були вже на системі"

