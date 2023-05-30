resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 't-contract made by taala'

version '1.0.0'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'sv_contract.lua'
}

client_scripts {
	'cl_contract.lua'
}

shared_scripts {
    '@ox_lib/init.lua'
}