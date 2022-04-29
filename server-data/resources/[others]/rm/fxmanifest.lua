fx_version "adamant"
games {"rdr3"}
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

client_script {
    "config.lua",
    "rm.lua"
}
server_script {'server.lua'}

ui_page "html/menu.html"

files {
	"html/menu.html",
	"html/raphael.min.js",
    "html/wheelnav.min.js",
}