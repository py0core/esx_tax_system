fx_version 'adamant'

game 'gta5'

description 'ESX Tax System'

version '0.0.1'

client_scripts {
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'config.lua',
	'server/main.lua'
}

dependency 'es_extended'
