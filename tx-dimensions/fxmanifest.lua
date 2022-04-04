fx_version 'cerulean'
game 'gta5'

author "Toxicz#2641"
version "0.0.1"

ui_page 'ui/ui.html'

client_scripts {
	'client/*.lua'
}

server_scripts {
	'server/*.lua',
	'config.lua'
}

files {
	'ui/ui.html',
	'ui/css/style.css',
	'ui/css/reset.css',
	'ui/js/app.js',
}
