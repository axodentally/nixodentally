# ZotLit skills for opencode — drive the obsidian CLI + ZotLit plugin
# to edit ZotLit templates and citation frontmatter. Pure markdown, no
# binaries; the actual work happens through the obsidian CLI.
{
  flake.modules.homeManager.zotlit-skills =
    { pkgs, ... }:
    {
      programs.opencode.skills = {
        zotlit-citations = pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/aidenlx/zotlit/zt-2.1.4/skills/zotlit-citations/SKILL.md";
          sha256 = "0hvpmywzidwj2w8q0im62f510khxcdzh8ch95dkqr1xfk43n02lf";
        };
        zotlit-template = pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/aidenlx/zotlit/zt-2.1.4/skills/zotlit-template/SKILL.md";
          sha256 = "1g4cvlyw6r7ap2jdg7szhjiz8482gqbd08mkrrcjdm958gv52p3w";
        };
      };
    };
}
