{ pkgs }:

pkgs.writeShellApplication {
    name = "aws-ec2-output";
    runtimeInputs = [ pkgs.awscli pkgs.jq ];
    text = ''
        aws ec2 get-console-output \
        --instance-id "$1" \
        --latest --output text
    '';
}
