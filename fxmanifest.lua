fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'John Atlas aka Galaxic Dev'
description 'QBcore gang F6 menu'
version '1.0.1'

-- What to run
client_scripts {
    'client/*.lua'
}

-- What to run server side
server_script 'server/server.lua'

dependencies { 'mysql-async', 'ox_lib'}
shared_scripts { '@ox_lib/init.lua', 'configuration/*.lua' }
