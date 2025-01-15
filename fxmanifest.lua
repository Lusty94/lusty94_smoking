fx_version 'cerulean'

game 'gta5'

author 'Lusty94'

name "lusty94_smoking"

description 'Simple Smoking & Vaping Script For QB-Core'

version '2.1.1'

lua54 'yes'

client_script {
    'client/smoking_client.lua',
}


server_scripts { 
    'server/smoking_server.lua',
}


shared_scripts { 
	'shared/config.lua',
    '@ox_lib/init.lua'
}

escrow_ignore {
    'shared/**.lua',
    'client/**.lua',
    'server/**.lua',
}