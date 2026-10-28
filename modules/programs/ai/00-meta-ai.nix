# AI assistant base: opencode with its basic tooling — the nix-skills
# skills and the mcp-nixos MCP server — plus aichat (commented out for now)
{ inputs, ... }:
{
  flake.modules.homeManager.meta-ai = {
    imports = with inputs.self.modules.homeManager; [
      opencode
      mcp-nixos
      nix-skills
      # aichat  # TODO: re-enable once the mistral-api-key sops secret exists for all hosts
    ];
  };
}
