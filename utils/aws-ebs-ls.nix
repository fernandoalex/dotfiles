{ pkgs }:

pkgs.writeShellApplication {
    name = "aws-ebs-ls";
    runtimeInputs = [ pkgs.awscli2 pkgs.jq ];
    text = ''
    aws ec2 describe-volumes | jq -r \
    ".Volumes[] | [.VolumeId, .State, .AvailabilityZone] @tsv" | \
    column -t
    '';
}
