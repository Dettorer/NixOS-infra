{ pkgs, ... }:

let
  SYNVARPackages = with pkgs.rPackages; [
    ggplot2
    dplyr
    readr
  ];

  SYNVAR = pkgs.rWrapper.override {
    packages = SYNVARPackages;
  };

  SYNVARstudio = pkgs.rstudioWrapper.override {
    packages = SYNVARPackages;
  };

  jupyterWith = import (pkgs.fetchFromGitHub {
    owner = "tweag";
    repo = "jupyterWith";
    # Replace this with current revision.
    rev = "c71a01a39a3f51951da0dbf0192cf9d1d000151b";
    sha256 = "0cbyxdbsdn35508n1qv0zy9lawyz5d1ifd8klz31m4n0yssv37xh";
    fetchSubmodules = true;
  }) {};

  kernels = jupyterWith.kernels;

  irkernel = kernels.iRWith {
    name = "nixpkgs";
    # Libraries to be available to the kernel.
    packages = _: SYNVARPackages;
  };

  SYNVAJupyter = (jupyterWith.jupyterlabWith {
    kernels = [ irkernel ];
  });
in
{
  # Tools for SYNVA work
  home.packages = with pkgs; [
    _my.via # TODO: no via on server
    SYNVAR
    SYNVARstudio
    SYNVAJupyter
  ];
}
