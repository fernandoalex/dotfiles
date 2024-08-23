{ pkgs }:

pkgs.writeShellApplication {
    name = "aws-s3-ls";
    runtimeInputs = [ pkgs.awscli2 ];
    text = ''
    aws s3 ls
    '';
}
