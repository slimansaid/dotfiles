return {
  {
    "norcalli/nvim-colorizer.lua",
    event = "BufReadPre", -- optional: lazy-load on buffer read
    config = function()
      require("colorizer").setup({
        "*", -- highlight all files
      }, {
        mode = "background", -- show colors as background
      })
    end,
  },
}
