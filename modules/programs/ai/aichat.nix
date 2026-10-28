{
  flake.modules.homeManager.aichat = { config, ... }: {
    # add the mistral api key from the sops secrets repo to
    # an .env file in ~/.config/aichat/.env
    sops = {
      secrets.mistral-api-key = { };

      templates."aichat.env" = {
        content = ''
          MISTRAL_API_KEY=${config.sops.placeholder.mistral-api-key}
        '';
        path = "${config.xdg.configHome}/aichat/.env";
        mode = "0400";
      };
    };

    programs.aichat = {
      enable = true;
      settings = {
        model = "mistral:mistral-small-2603";
        clients = [
          {
            type = "openai-compatible";
            name = "mistral";
            api_base = "https://api.mistral.ai/v1";
          }
        ];
      };
    };
  };
}
