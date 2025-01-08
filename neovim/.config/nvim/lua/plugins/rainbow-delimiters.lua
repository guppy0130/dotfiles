return {
    'HiPhish/rainbow-delimiters.nvim',
    main = 'rainbow-delimiters.setup',
    opts = {
        strategy = {
            -- [''] = rainbow_delimiters.strategy['global'],
            -- vim = rainbow_delimiters.strategy['local'],
        },
        query = {
            [''] = 'rainbow-delimiters',
            lua = 'rainbow-blocks',
        },
        highlight = {
            'RainbowDelimiterRed',
            'RainbowDelimiterYellow',
            'RainbowDelimiterBlue',
            'RainbowDelimiterOrange',
            'RainbowDelimiterGreen',
            'RainbowDelimiterViolet',
            'RainbowDelimiterCyan',
        },
    },
}
