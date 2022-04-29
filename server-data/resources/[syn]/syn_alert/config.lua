Config = {}

Config.alerts = { 
    police = { -- job name
        command = "alertpolice",
        jobs = {"police","marshal"}, -- jobs the alert is sent to
        msg = "police help needed. check map for coords", -- alert sent to the players with the job name 
        isdoctor = false,
        blip = {
            blipsprite = 2119977580,
            Name = 'Police Alert',
        }
    },
    medic = {
        command = "alertmedic",
        jobs = {"medic"},
        msg = "medic help needed. check map for coords",
        isdoctor = true,
        blip = {
            blipsprite = 2119977580,
            Name = 'Medic Alert',
        }
    },
    doctor = {
        command = "alertdoctor",
        jobs = {"doctor"},
        msg = "doctor help needed. check map for coords",
        isdoctor = true,
        blip = {
            blipsprite = 2119977580,
            Name = 'Medic Alert',
        }
    },
}

Config.medicresponse = "resp"
Config.cancelblipcommand = "calert" -- removes alert blips
Config.alertcooldown = 900 -- seconds