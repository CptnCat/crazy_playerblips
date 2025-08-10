fx_version 'cerulean'
game 'gta5'

author 'EpicCat'
description 'Playerblips for Admins'
version '1.0'
repository 'https://github.com/CptnCat/crazy_playerblips'

lua54 'yes'

shared_scripts { 
    '@ox_lib/init.lua',
    'config.lua'
}

client_script 'client.lua'

server_script 'server.lua'

dependencies {
    'ox_lib'
}