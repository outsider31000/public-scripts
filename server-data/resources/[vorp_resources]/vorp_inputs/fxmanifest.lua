game 'rdr3'
fx_version 'adamant'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
ui_page 'html/index.html'

author 'Emollit'

client_scripts {
  'client/models/*.lua',
  'client/services/*.lua',
  'client/controllers/*.lua'
}

files {
  'html/**/*'
}

version '1.1'
vorp_checker 'yes'
vorp_name '^4Resource version Check^3'
vorp_github 'https://github.com/VORPCORE/vorp_inputs-lua'
