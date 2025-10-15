-- https://github.com/hakonharnes/img-clip.nvim
-- support for image pasting
return {
  {
    "HakonHarnes/img-clip.nvim",
    event = "VeryLazy",
    opts = {
      -- recommended settings
      default = {
        embed_image_as_base64 = false,
        prompt_for_file_name = false,
        drag_and_drop = {
          insert_mode = true,
        },
        -- use_absolute_path = true, -- required for Windows users
        verbose = false,  -- Disable warnings such as "Content is not an image"
      },
    },
  },
}
