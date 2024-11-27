--  See `:help lua-guide-autocommands`

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local mabqGroup = augroup('Mabq', {})

autocmd('TextYankPost', {
    group = augroup('HighlightYank', {}),
    pattern = '*',
    callback = function()
        vim.highlight.on_yank()
    end,
})

autocmd({ 'BufWritePre' }, {
    group = mabqGroup,
    pattern = '*',
    command = [[%s/\s\+$//e]],
})

-- autocmd('BufEnter', {
--     group = mabqGroup,
--     callback = function()
--         if vim.bo.filetype == 'zig' then
--             vim.cmd.colorscheme 'tokyonight-night'
--         else
--             vim.cmd.colorscheme 'rose-pine-moon'
--         end
--     end,
-- })

autocmd('LspAttach', {
    group = mabqGroup,
    callback = function(e)
        -- LSP keymaps
        local opts = { buffer = e.buf }

        vim.keymap.set('n', 'K', function()
            vim.lsp.buf.hover()
        end, opts)

        -- Jump to the definition of the word under your cursor.
        --  This is where a variable was first declared, or where a function is defined, etc.
        vim.keymap.set('n', 'gd', function()
            --  IMPORTANT! Do not use Trouble for this on in order to be able to jump back with `<C-t>`.
            vim.lsp.buf.definition()
        end, opts)

        -- Find references for the word under your cursor.
        vim.keymap.set('n', '<leader>lf', '<cmd>Trouble lsp_references focus<CR>', opts)

        -- LPS diagnitics
        vim.keymap.set('n', '<leader>ld', '<cmd>Trouble diagnostics focus<CR>', opts)
        vim.keymap.set('n', '<leader>lD', '<cmd>Trouble diagnostics focus filter.buf=0<CR>', opts)
        vim.keymap.set('n', '<leader>lq', '<cmd>Trouble quickfix focus<CR>', opts)

        -- Important! This is not Goto Definition, this is Goto Declaration.
        --  For example, in C this would take you to the header.
        -- vim.keymap.set('n', '<leader>lD', '<cmd>Trouble lsp_declarations focus<CR>', opts)

        -- Jump to the implementation of the word under your cursor.
        --  Useful when your language has ways of declaring types without an actual implementation.
        vim.keymap.set('n', '<leader>li', '<cmd>Trouble lsp_implementations focus<CR>', opts)

        -- Jump to the type of the word under your cursor.
        --  Useful when you're not sure what type a variable is and you want to see
        --  the definition of its *type*, not where it was *defined*.
        vim.keymap.set('n', '<leader>lt', '<cmd>Trouble lsp_type_definitions focus<CR>', opts)

        -- Fuzzy find all the symbols in your current document.
        --  Symbols are things like variables, functions, types, etc.
        vim.keymap.set('n', '<leader>ls', '<cmd>Trouble lsp_document_symbols focus<CR>', opts)

        vim.keymap.set('n', '<leader>lr', function()
            vim.lsp.buf.rename()
        end, opts)

        vim.keymap.set('n', '<leader>lca', function()
            vim.lsp.buf.code_action()
        end, opts)

        vim.keymap.set('i', '<leader>lhs', function()
            vim.lsp.buf.signature_help()
        end, opts)

        -- -- When you move your cursor, the highlights will be cleared (the second autocommand).
        local client = vim.lsp.get_client_by_id(e.data.client_id)
        -- if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
        --     local highlight_augroup = augroup('mabq-lsp-highlight', { clear = false })
        --     vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        --         buffer = e.buf,
        --         group = highlight_augroup,
        --         callback = vim.lsp.buf.document_highlight,
        --     })
        --     vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        --         buffer = e.buf,
        --         group = highlight_augroup,
        --         callback = vim.lsp.buf.clear_references,
        --     })
        --     vim.api.nvim_create_autocmd('LspDetach', {
        --         group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
        --         callback = function(event2)
        --             vim.lsp.buf.clear_references()
        --             vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
        --         end,
        --     })
        -- end
        --
        -- The following code creates a keymap to toggle inlay hints in your
        -- code, if the language server you are using supports them
        -- This may be unwanted, since they displace some of your code
        if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            vim.keymap.set('n', '<leader>lhi', function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled)
            end, opts)
        end
    end,
})
