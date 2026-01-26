#!/bin/bash

echo "=== Проверка конфигурации безопасности ==="

echo "1. Проверяем установку Gatekeeper..."
kubectl get pods -n gatekeeper-system

echo -e "\n2. Проверяем ConstraintTemplates..."
kubectl get constrainttemplates

echo -e "\n3. Проверяем Constraints..."
kubectl get constraints -A

echo -e "\n4. Аудит нарушений..."
kubectl get k8snoprivileged no-privileged-pods -o yaml
kubectl get k8snohostpath no-hostpath-volumes -o yaml
kubectl get k8srequirerunasnonroot require-nonroot-readonly -o yaml

echo -e "\n5. Проверяем политики PodSecurity..."
kubectl describe namespace audit-zone | grep -A5 -B5 "Labels"
