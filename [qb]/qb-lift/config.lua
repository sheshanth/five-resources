-- Copyright (C) 2021 KUMApt & Shadowskrt

Config = {}

Config.UseLanguage = "en"                                                           -- Select the language you want to use in the script (the translation is at the end of the file)
Config.UseSoundEffect = true                                                        -- Only use this if you use InteractSound

Config.Elevators = {
    -- The following tags are not required! You can add them if you want
    -- Group = "jobname" or "gangname" -> Only player with this job or gang can can go to the restricted floors
    -- Sound = "soundname" -> Use custom sound when player reaches the new floor | You can add your custom sound with .ogg extension in interactSound folder /client/html/sounds
    -- Simple example with restricted floors and custom sound
    ["restricted"] = {
        -- Group = {"police", "ambulance", "lostmc"},                                -- Leave blank if you don't want to use Player Job - You can add jobs or gangs groups
        Sound = "liftSoundBellRing",                                                -- Leave blank if you don't want to use Custom Sound
        Name = "EMS",
        Floors = {
            [1] = {
                Label = "Basement",
                FloorDesc = "vehicle parking",
                Coords = vector3(-662.55, 328.6, 78.12),
                ExitHeading = "28.74"
            },
            [2] = {
                Label = "Ground Floor",
                FloorDesc = "Checkin and reception",
                Coords = vector3(-662.69, 328.71, 83.08),
                ExitHeading = "28.74"
            },
            [3] = {
                Label = "Floor 1",
                FloorDesc = "Consultation and OPD",
                Coords = vector3(-662.68, 328.89, 88.02),
                ExitHeading = "28.74"
            },
            [4] = {
                Label = "Floor 2",
                FloorDesc = "Consultation and OPD",
                Coords = vector3(-662.69, 328.52, 92.74),
                ExitHeading = "28.74"
            },
            [5] = {
                Label = "Roof",
                FloorDesc = "Dean office",
                restricted= true,
                Coords = vector3(-662.59, 328.55, 140.12),
                ExitHeading = "28.74"
            }
        }
    },
    -- Simple example without custom sound and without restricted floors
    

}

Config.Language = {
    ["en"] = {
        Call = "~g~E~w~ - Call Lift",
        Waiting = "Waiting for Lift...",
        Restricted = "Restricted floor!",
        CurrentFloor = "Current floor: "
    }
}
