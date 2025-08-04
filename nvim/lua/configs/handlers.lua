exports = {}

exports.tsserverDefinition = function(err, result, ctx, ...)
  local res = result
  if result and #result > 1 then
    -- shave off .d.ts references when they occur together with actual source location
    res = vim.tbl_filter(function(entry)
      return not vim.endswith(entry.targetUri, ".d.ts")
    end, result)
  end
  return vim.lsp.handlers["textDocument/definition"](err, res, ctx, ...)
end

return exports
