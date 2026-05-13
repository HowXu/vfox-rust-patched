--- mv the libs from rust-std-xxx to rustc
--- etc:
--- .vfox\cache\rust\v-1.90.0\rust-1.90.0\rust-std-x86_64-pc-windows-msvc\lib\rustlib\x86_64-pc-windows-msvc\lib
--- -> .vfox\cache\rust\v-1.90.0\rust-1.90.0\rustc\lib\rustlib\x86_64-pc-windows-msvc\lib
---
local utils = require("utils")
local strings = require("vfox.strings")

function PLUGIN:PostInstall(ctx)
    local sdkInfo = ctx.sdkInfo['rust']
    local mainPath = sdkInfo.path  --- refer to etc .vfox\cache\rust\v-1.90.0\rust-1.90.0
    local osType = RUNTIME.osType:lower()
    local archType = RUNTIME.archType:lower()
    local platform = utils:getPlatform(osType, archType)
    local separator = ""
    if osType == "windows" then
        separator = "\\"
    else
        separator = "/"
    end

    local rustc_std_path_unix = mainPath ..
    separator .. "rust-std-" .. platform .. separator .. "lib" .. separator .. "rustlib" .. separator .. platform .. separator

    local rustc_std_path_windows = mainPath ..
    separator .. "rust-std-" .. platform .. separator .. "lib" .. separator .. "rustlib" .. separator .."*"

    local sys_std_path_unix = mainPath ..
    separator .. "rustc" .. separator .. "lib" .. separator .. "rustlib" .. separator

    local sys_std_path_windows = mainPath ..
    separator .. "rustc" .. separator .. "lib" .. separator .. "rustlib"

    if osType == "windows" then
        local cmd = [[powershell -c 'Copy-Item -Path "]] .. rustc_std_path_windows .. [[" -Destination "]] .. sys_std_path_windows .. [[" -Recurse -Force']]
        print("")
        print("Please run this command by your self to set up libstd:")
        print("")
        print(cmd)
        print("")
        os.execute(cmd)
    else
        local cmd = [[cp -rf "]] .. rustc_std_path_unix .. [[" "]] .. sys_std_path_unix .. [[" > /dev/null 2>&1]]
        --- print(cmd) need log no more
        os.execute(cmd)
    end
end
