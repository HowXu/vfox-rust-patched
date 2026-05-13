--- Return all available versions provided by this plugin
--- @param ctx table Empty table used as context, for future extension
--- @return table Descriptions of available versions and accompanying tool descriptions

local http = require("http")
local URL = "https://releases.rs/"

function PLUGIN:Available(ctx)

    --- fetch from https://releases.rs/
    local resp, err = http.get({
        url = URL
    })
    if err ~= nil then
        error("Failed to fetch rust dist info: " .. err)
    end
    if resp.status_code ~= 200 then
        error("Failed to fetch rust dist info: status_code =>" .. resp.status_code)
    end

    --- get the html texts
    local versions = {}
    local latest = true
    local list = resp.body:match("<ul>(.-)</ul>")
    for version in list:gmatch('/docs/([^/]+)/') do
        local note = latest and "latest" or ""
        latest = false
        table.insert(versions, {version = version, note = note, addition = {}})
    end

    return versions
end
