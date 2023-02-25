#!/bin/bash
#
K8S_NAMESPACE=$(kubectl get namespaces | awk '{print $1}' | fzf)

kubectl config set-context --current --namespace="$K8S_NAMESPACE"
