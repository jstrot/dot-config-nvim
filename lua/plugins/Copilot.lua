-- https://docs.github.com/en/copilot/getting-started-with-github-copilot?tool=vimneovim
return {
  {
    "github/copilot.vim",
    event = 'InsertEnter',
    cmd = {
      'Copilot',
    },
  },
}

-- vim: sw=2 et
