{ pkgs }:

pkgs.writeShellApplication {
    name = "kubectl-get-nodes";
    runtimeInputs = [ pkgs.kubectl];
    text = ''
    kubectl get nodes \
    -o=custom-columns=NAME:.metadata.name,\
    "ZONE":".metadada.labels.topology\.kubernetes\.io/zone"
    '';
}
