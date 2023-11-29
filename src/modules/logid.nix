{ pkgs, ... }: {
  environment.etc = {
    "logid.cfg".source = ./../configs/logid/logid.cfg;
  };
}
