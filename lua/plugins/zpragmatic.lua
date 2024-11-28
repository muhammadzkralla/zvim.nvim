return {
    "muhammadzkralla/zpragmatic.nvim",
    version = "1.0.2",
    config = function()
        require("zpragmatic").setup({
            filetype_questions = {
                ["*"] = {
                },
                ["java"] = {
                },
                ["javascript"] = {
                },
            },
            bypass_filetypes = { "markdown", "txt", "text", "plain", "json" },
        })
    end,
}
