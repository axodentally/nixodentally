{
  flake.modules.homeManager.ssh-agent = {
    services.ssh-agent.enable = true;
  };
}
