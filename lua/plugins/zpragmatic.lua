return {
    "muhammadzkralla/zpragmatic.nvim",
    version = "1.0.2",
    config = function()
        require("zpragmatic").setup({
            filetype_questions = {
                ["*"] = {
                    "Don't break any windows.",
                    "Don't violate the DRY principle.",
                    "Comment your code."
                },
                ["java"] = {
                    "All maven tests must pass before you save.",
                    "Check for potential null pointer exceptions.",
                    "All public methods should have proper documentation.",
                },
                ["javascript"] = {
                    "Run the linter.",
                    "Test the code in multiple browsers if necessary.",
                    "Ensure there are no console logs left in the code.",
                },
            },
            bypass_filetypes = { "markdown", "txt", "text", "plain", "json" },
        })
    end,
}
