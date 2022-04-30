const playerLogged = [];

onNet('playerConnecting', (name, setKickReason, deferrals) => {
    const _source = source;
    deferrals.defer();
    const slotCount = GetConvar('sv_maxclients', 32);
    if (playerLogged.length == slotCount) {
        deferrals.done('Server is full');
        return;
    }
    deferrals.done();
    const index = playerLogged.indexOf(_source);
    if (index === -1) {
        playerLogged.push(_source);
    }
});

onNet('playerDropped', () => {
    const _source = source;
    const index = playerLogged.indexOf(_source);
    if (index !== -1) {
        playerLogged.splice(index, 1);
    }
});

setInterval(() => {
    for (const source of playerLogged) {
        if (!GetPlayerEndpoint(source)) {
            const index = playerLogged.indexOf(source);
            if (index !== -1) {
                playerLogged.splice(index, 1);
            }

            DropPlayer(source, 'Connection lost');
        }
    }
}, 30000);