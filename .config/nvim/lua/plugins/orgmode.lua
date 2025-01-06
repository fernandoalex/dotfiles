return {
    {
        'nvim-orgmode/orgmode',
        event = 'VeryLazy',
        ft = { 'org' },
        config = function()
            -- Setup orgmode
            require('orgmode').setup({
                org_agenda_files = '~/brain/agenda/**/*',
                org_default_notes_file = '~/brain/refile.org',
            })
        end,
    }
}
