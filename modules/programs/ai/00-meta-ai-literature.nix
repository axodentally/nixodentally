# Literature / university work: reading PDFs and managing citations
# (ZotLit, Zotero). Imported by hosts doing such work on top of meta-ai.
{ inputs, ... }:
{
  flake.modules.homeManager.meta-ai-literature = {
    imports = with inputs.self.modules.homeManager; [
      zotlit-skills
      zotero-mcp
    ];

    # read-pdf skill lives here (not in the core opencode module), since it
    # is mainly useful for literature/lecture work
    programs.opencode.skills.read-pdf = ./skills/read-pdf/SKILL.md;
  };
}
