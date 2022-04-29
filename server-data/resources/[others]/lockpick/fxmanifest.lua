client_script {
	'client.lua'
}
ui_page('html/index.html')

files({
'html/index.html',
'html/script.js',
'html/TweenMax.min.js',
"html/style.css",
"html/jquery.min.js",
'html/collar.png',
'html/cylinder.png',
'html/driver.png',
'html/pinBott.png',
'html/pinTop.png',

})

fx_version "adamant"

rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

game "rdr3"

export "lockpick"
