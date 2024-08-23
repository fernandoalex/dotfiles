{ pkgs }:

pkgs.writeShellApplication {
    name = "aws-ec2-ls";
    runtimeInputs = [ pkgs.awscli2 pkgs.jq ];
    text = ''
    aws ec2 describe-instances | jq -r \
    '.Reservations[].Instances[] | [.InstanceId, .State.Name] | @tsv' | \
    column -t
    '';
}
