fx_version 'adamant'
game 'rdr3'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

ui_page 'NUI/SaltyWebSocket.html'

client_scripts {
    'SaltyClient.net.dll'
}

server_scripts {
    'SaltyServer.net.dll'
}

files {
    'SaltyClient.net.pdb',
    'NUI/SaltyWebSocket.html',
    'Newtonsoft.Json.dll',
    'config.json',
}

exports {
    'GetVoiceRange',
    'GetRadioChannel',
    'GetRadioVolume',
    'GetRadioSpeaker',
    'SetRadioChannel',
    'SetRadioVolume',
    'SetRadioSpeaker',
    'GetPluginState',
    'PlaySound'
}

server_export 'SetPlayerAlive'
server_export 'EstablishCall'
server_export 'EndCall'
server_export 'SetPlayerRadioSpeaker'
server_export 'SetPlayerRadioChannel'
server_export 'RemovePlayerRadioChannel'
server_export 'SetRadioTowers'
