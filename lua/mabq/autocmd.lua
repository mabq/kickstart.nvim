--  See `:help lua-guide-autocommands`

local function augroup(name)
    return vim.api.nvim_create_augroup('mabq_' .. name, { clear = true })
end

local autocmd = vim.api.nvim_create_autocmd

--

autocmd('TextYankPost', {
    group = augroup 'highlightYank',
    callback = function()
        (vim.hl or vim.highlight).on_yank()
    end,
})

autocmd({ 'BufWritePre' }, {
    group = augroup 'removeTraillingSpace',
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
    group = augroup 'lspAttach',
    callback = function(e)
        -- LSP keymaps
        local opts = { buffer = e.buf }

        vim.keymap.set('n', 'K', function()
            vim.lsp.buf.hover()
        end, opts)

        -- Jump to the definition of the word under your cursor.
        --  This is where a variable was first declared, or where a function is defined, etc.
        vim.keymap.set('n', 'gd', function()
            --  Do not use Trouble for this one in order to be able to jump back with `<C-t>`.
            vim.lsp.buf.definition()
        end, opts)

        -- Find references for the word under your cursor.
        vim.keymap.set('n', '<leader>lr', '<cmd>Trouble lsp_references toggle<CR>', opts)

        -- LPS diagnitics
        vim.keymap.set('n', '<leader>ld', '<cmd>Trouble diagnostics toggle<CR>', opts)
        vim.keymap.set('n', '<leader>lD', '<cmd>Trouble diagnostics toggle filter.buf=0<CR>', opts)

        -- Important! This is not Goto Definition, this is Goto Declaration.
        --  For example, in C this would take you to the header.
        -- vim.keymap.set('n', '<leader>lD', '<cmd>Trouble lsp_declarations focus<CR>', opts)

        -- Jump to the implementation of the word under your cursor.
        --  Useful when your language has ways of declaring types without an actual implementation.
        vim.keymap.set('n', '<leader>li', '<cmd>Trouble lsp_implementations toggle<CR>', opts)

        -- Jump to the type of the word under your cursor.
        --  Useful when you're not sure what type a variable is and you want to see
        --  the definition of its *type*, not where it was *defined*.
        vim.keymap.set('n', '<leader>lt', '<cmd>Trouble lsp_type_definitions toggle<CR>', opts)

        -- Fuzzy find all the symbols in your current document.
        --  Symbols are things like variables, functions, types, etc.
        vim.keymap.set('n', '<leader>ls', '<cmd>Trouble lsp_document_symbols toggle<CR>', opts)

        vim.keymap.set('n', '<leader>ln', function()
            vim.lsp.buf.rename()
        end, opts)

        vim.keymap.set('n', '<leader>la', function()
            vim.lsp.buf.code_action()
        end, opts)

        vim.keymap.set('i', '<C-h>', function()
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
            vim.keymap.set('n', '<leader>lh', function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled)
            end, opts)
        end
    end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd('FileType', {
    group = augroup 'close_with_q',
    pattern = {
        'PlenaryTestPopup',
        'checkhealth',
        'dbout',
        'gitsigns-blame',
        'grug-far',
        'help',
        'lspinfo',
        'neotest-output',
        'neotest-output-panel',
        'neotest-summary',
        'notify',
        'qf',
        'snacks_win',
        'spectre_panel',
        'startuptime',
        'tsplayground',
    },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.schedule(function()
            vim.keymap.set('n', 'q', function()
                vim.cmd 'close'
                pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
            end, {
                buffer = event.buf,
                silent = true,
                desc = 'Quit buffer',
            })
        end)
    end,
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd('BufReadPost', {
    group = augroup 'last_loc',
    callback = function(event)
        local exclude = { 'gitcommit' }
        local buf = event.buf
        if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then
            return
        end
        vim.b[buf].lazyvim_last_loc = true
        local mark = vim.api.nvim_buf_get_mark(buf, '"')
        local lcount = vim.api.nvim_buf_line_count(buf)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd('FileType', {
    group = augroup 'wrap_spell',
    pattern = { 'text', 'plaintex', 'typst', 'gitcommit', 'markdown' },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
    end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
    group = augroup 'auto_create_dir',
    callback = function(event)
        if event.match:match '^%w%w+:[\\/][\\/]' then
            return
        end
        local file = vim.uv.fs_realpath(event.match) or event.match
        vim.fn.mkdir(vim.fn.fnamemodify(file, ':p:h'), 'p')
    end,
})
