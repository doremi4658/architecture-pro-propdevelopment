#!/bin/bash

echo "=== Проверка PodSecurity Admission ==="
echo "1. Проверяем namespace audit-zone..."
kubectl get ns audit-zone -o jsonpath='{.metadata.labels}' | jq

echo -e "\n2. Пытаемся создать поды с нарушениями..."
echo "2.1 Privileged pod:"
kubectl apply -f insecure-manifests/01-privileged-pod.yaml 2>&1

echo -e "\n2.2 HostPath pod:"
kubectl apply -f insecure-manifests/02-hostpath-pod.yaml 2>&1

echo -e "\n2.3 Root user pod:"
kubectl apply -f insecure-manifests/03-root-user-pod.yaml 2>&1

echo -e "\n=== Проверка безопасных подов ==="
echo "3. Создаем безопасные поды..."
kubectl apply -f secure-manifests/ 2>&1

echo -e "\n4. Проверяем состояние подов в audit-zone:"
kubectl get pods -n audit-zone
