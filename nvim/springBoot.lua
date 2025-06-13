return {
  "JavaHello/spring-boot.nvim",
  ft = { "java", "yaml", "properties" },
  specs = {
    {
      "mfussenegger/nvim-jdtls",
      optional = true,
      opts = function(_, opts)
        -- Ensure init_options exists

        if not opts.init_options then
          opts.init_options = {}
        end
        if not opts.init_options.bundles then
          opts.init_options.bundles = {}
        end

        vim.list_extend(opts.init_options.bundles, require("spring_boot").java_extensions())
      end,
    },
  },
  opts = {},
}
