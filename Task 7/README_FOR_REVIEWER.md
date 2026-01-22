Структура 
Task7/
├── 01-create-namespace.yaml
├── insecure-manifests/
│   ├── 01-privileged-pod.yaml
│   ├── 02-hostpath-pod.yaml
│   └── 03-root-user-pod.yaml
├── secure-manifests/
│   ├── 01-secure.yaml
│   ├── 02-secure.yaml
│   └── 03-secure.yaml
├── gatekeeper/
│   ├── constraint-templates/
│   │   ├── privileged.yaml
│   │   ├── hostpath.yaml
│   │   └── runasnonroot.yaml
│   └── constraints/
│       ├── privileged.yaml
│       ├── hostpath.yaml
│       └── runasnonroot.yaml
├── verify/
│   ├── verify-admission.sh
│   └── validate-security.sh
├── audit-policy.yaml
├── README_FOR_REVIEWER.md 


## Порядок проверки:

**Создайте namespace:**
   ```bash
   kubectl apply -f 01-create-namespace.yaml

Установите OPA Gatekeeper (если не установлен)
   kubectl apply -f https://raw.githubusercontent.com/open-policy-agent/gatekeeper/master/deploy/gatekeeper.yaml

Применить ConstraintTemplates:

bash
kubectl apply -f gatekeeper/constraint-templates/

Применить Constraints:

bash
kubectl apply -f gatekeeper/constraints/

Проверить блокировку небезопасных подов:

bash
chmod +x verify/verify-admission.sh
./verify/verify-admission.sh

Проверить работу Gatekeeper:

bash
chmod +x verify/validate-security.sh
./verify/validate-security.sh
