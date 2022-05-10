game 'rdr3'
fx_version 'adamant'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

client_scripts {
  'vorpmetabolism-cl.net.dll'
}

server_scripts {
  'vorpmetabolism-sv.net.dll'
}

files {
  'Newtonsoft.Json.dll',
  'ui/hud.html',
  'ui/css/style.css',
  'ui/js/circle-progress.js',
  'ui/js/circle-progress.min.js',
}

ui_page 'ui/hud.html'

version '1.0'
vorp_checker 'yes'
vorp_name '^4Resource version Check^3'
vorp_github 'https://github.com/VORPCORE/VORP-Metabolism'
