{ ... }:

rec {
  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  users.users.dettorer.openssh.authorizedKeys.keys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDdlaaQEimG2YlHDcOW8uuh3cabpPeHBfQg9ijrrMteWfs1frGLFE+3CwODtDTXtbmY+gddVvA+hzBpeXhn2vS5v2JK1uMWxzgtJ480KFszP1grWooanbmI6U/i9L9hBotSxROLMaJFsxXmJ/YzXm5YgPFGDOJcf5uaNv9pKYd8FXMrfFiuP3exmFngv0tINURu9LFYMrgiEpJ48fljLLf2lkdBMKVEOcPaX4BaQv3Bkb3ZeThNFccbFrXeJk4qs+BgH/ow8xx9Hn6e27EsSoJr74G9F+mTE8EDzoMuWxf8X1VQcxKEOmn+fyF/NOWGjeb6J5ukZZrcq+MmKF8dmcxZRkVfW661pK+9+egAjocqrFnJQe/Up5ZpyogJbgc2GB0Pp2THaBm77l6yDvnvGr2SLtQkFIsDZkKkwjB8riyTqf4Jt5B8ENytGn8zX+Yo3bz8JnmesJVLsmDRmleqMLW1/r+nPSzbeV1LbQ1xue44z+N16N1+suM4A71Y5vj+THDayfuVIm10ww5yUTuw05J0Mgm8AZUBi8Ay8olLubkiuFuCbhWBa31iAio69LqHM8PngTeGtgWB86k0vH3Hy2+E1eCKFsD8/9Uia0rcYui9vX1+04mU6N+kJnycaKOVHBVOSO0Qyi/j8qECKC8rbB4Rh+3aGD9XXpcFh7VRuzM3mQ== dettorer@dettorer.net"
  ];
  users.users.root.openssh.authorizedKeys.keys = users.users.dettorer.openssh.authorizedKeys.keys;
}
