{ pkgs }:

pkgs.writeShellApplication {
    name = "aws-s3-ls";
    runtimeInputs = [ pkgs.awscli ];
    text = ''
    aws s3 ls
    '';
}
