--- Each SDK may have different environment variable configurations.
--- This allows plugins to define custom environment variables (including PATH settings)
--- Note: Be sure to distinguish between environment variable settings for different platforms!
--- @param ctx table Context information
--- @field ctx.path string SDK installation directory
function PLUGIN:EnvKeys(ctx)
    local mainPath = ctx.path
    local osType = RUNTIME.osType:lower()
    local separator = ""
    if osType == "windows" then
        separator = "\\"
    else
        separator = "/"
    end

    return {
        {
            key = 'PATH',
            value = mainPath .. separator .. "rustc" .. separator .. "bin",
        },
        {
            key = 'PATH',
            value = mainPath .. separator .. "cargo" .. separator .. "bin",
        },
        {
            key = 'PATH',
            value = mainPath .. separator .. "clippy-preview" .. separator .. "bin",
        },
        {
            key = 'PATH',
            value = mainPath .. separator .. "rust-analyzer-preview" .. separator .. "bin",
        },
        {
            key = 'PATH',
            value = mainPath .. separator .. "rustfmt-preview" .. separator .."bin",
        },
        {
            key = 'CARGO_HOME',
            value = mainPath .. separator .. 'cargo'
        }
    }
end