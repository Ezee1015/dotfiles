return {
    {
        "Vonr/align.nvim",
        -- branch = "v2",
        lazy = true,
        keys = {
            -- Aligns to 1 character
            {
                "ac",
                function()
                    require'align'.align_to_char({
                        length = 1,
                    })
                end,
                mode = 'x',
                noremap = true,
                silent = true,
                desc="Align to char"
            },

            -- Aligns to 2 characters with previews
            {
                "ad",
                function()
                    require'align'.align_to_char({
                        preview = true,
                        length = 2,
                    })
                end,
                mode = 'x',
                noremap = true,
                silent = true,
                desc="Align to 2 chars"
            },

            -- Aligns to a string with previews
            {
                "as",
                function()
                    require'align'.align_to_string({
                        preview = true,
                        regex = false,
                    })
                end,
                mode = 'x',
                noremap = true,
                silent = true,
                desc="Align to a string"
            },

            -- Aligns to a Vim regex with previews
            {
                "ar",
                function()
                    require'align'.align_to_string({
                        preview = true,
                        regex = true,
                    })
                end,
                mode = 'x',
                noremap = true,
                silent = true,
                desc="Align to a regex expression"
            },
        }
    },
}
