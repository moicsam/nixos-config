let
  sam-drosera = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHjHguoSb77hDl7ux/KH+nOMl1N6wd+Cah09GpeIy8C0 sam@drosera";
  drosera = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILQx/UnRONTIEGWXLgCuJZp3cb8t0t3/WwuB5uKNqaXv root@denis";
  ficus = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJWruSc+BeTlWexSEvia54w4qhfpQwLi4xQs7SoU/QWX root@nixos";
  all = [ sam-drosera drosera ficus ];
in
{
  "backup_passphrase.age".publicKeys = all ;
}
