local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- General Settings
local general = augroup("General Settings", { clear = true })

autocmd("BufEnter", {
    callback = function()
        vim.opt.formatoptions:remove({ "c", "r", "o" })
    end,
    group = general,
    desc = "Disable New Line Comment",
})

autocmd("BufEnter", {
    callback = function(opts)
        if vim.bo[opts.buf].filetype == "bicep" then
            vim.bo.commentstring = "// %s"
        end
    end,
    group = general,
    desc = "Set Bicep Comment String",
})

autocmd("BufWritePost", {
    pattern = "*.bicep*",
    callback = function()
        local winview = vim.fn.winsaveview()
        vim.cmd([[%s/\n\n}/\r}/ge]])
        vim.fn.winrestview(winview)
    end,
    group = general,
    desc = "Remove weird new lines added by LSP formatting",
})

autocmd("BufWritePost", {
    pattern = "*.ps1",
    callback = function()
        local winview = vim.fn.winsaveview()
        vim.cmd([[%s/\n\%$//ge]])
        vim.fn.winrestview(winview)
    end,
    group = general,
    desc = "Remove extra new lines at the end of formatted PowerShell files",
})

-- 沒用
-- autocmd RecordingEnter * set cmdheight=0
-- autocmd RecordingLeave * set cmdheight=0

-- local recordingGroup = augroup("Recording", { clear = true })

autocmd("RecordingEnter", {
    pattern = "*",
    callback = function()
        --vim.opt.cmdheight = 1
        require("lualine").refresh({
            place = { "statusline" },
        })
    end,
    -- group = recordingGroup,
    group = general,
    desc = "Enter recording mode",
})

autocmd("RecordingLeave", {
    pattern = "*",
    callback = function()
        --vim.opt.cmdheight = 0
        -- This is going to seem really weird!
        -- Instead of just calling refresh we need to wait a moment because of the nature of
        -- `vim.fn.reg_recording`. If we tell lualine to refresh right now it actually will
        -- still show a recording occuring because `vim.fn.reg_recording` hasn't emptied yet.
        -- So what we need to do is wait a tiny amount of time (in this instance 50 ms) to
        -- ensure `vim.fn.reg_recording` is purged before asking lualine to refresh.
        local timer = vim.loop.new_timer()
        timer:start(
            50,
            0,
            vim.schedule_wrap(function()
                require("lualine").refresh({
                    place = { "statusline" },
                })
            end)
        )
    end,
    -- group = recordingGroup,
    group = general,
    desc = "Leaving recording mode",
})

-- Create an autocommand group for semshi
--local semshiGroup = augroup("Semshi", { clear = true })
--
--autocmd("Semshi", {
--    pattern = "*.py",
--    callback = function()
--        vim.cmd("hi semshiLocal           ctermfg=209 guifg=#ff875f")
--        vim.cmd("hi semshiGlobal          ctermfg=214 guifg=#ffaf00")
--        vim.cmd("hi semshiImported        ctermfg=214 guifg=#ffaf00 cterm=bold gui=bold")
--        vim.cmd("hi semshiParameter       ctermfg=75  guifg=#5fafff")
--        vim.cmd("hi semshiParameterUnused ctermfg=117 guifg=#87d7ff cterm=underline gui=underline")
--        vim.cmd("hi semshiFree            ctermfg=218 guifg=#ffafd7")
--        vim.cmd("hi semshiBuiltin         ctermfg=207 guifg=#ff5fff")
--        vim.cmd("hi semshiAttribute       ctermfg=49  guifg=#00ffaf")
--        vim.cmd("hi semshiSelf            ctermfg=249 guifg=#b2b2b2")
--        vim.cmd("hi semshiUnresolved      ctermfg=226 guifg=#ffff00 cterm=underline gui=underline")
--        vim.cmd("hi semshiSelected        ctermfg=231 guifg=#ffffff ctermbg=161 guibg=#d7005f")
--
--        vim.cmd("hi semshiErrorSign       ctermfg=231 guifg=#ffffff ctermbg=160 guibg=#d70000")
--        vim.cmd("hi semshiErrorChar       ctermfg=231 guifg=#ffffff ctermbg=160 guibg=#d70000")
--        vim.cmd("sign define semshiError text=E> texthl=semshiErrorSign")
--    end
--    group = semshiGroup,
--    desc = "Python semshi color scheme",
--})

--
-- Messages:
-- E5107: Error loading lua [string ":source (no file)"]:93: '}' expected (to close '{' at line 74) near 'group'
-- Error:
-- Error detected while processing :source (no file):
