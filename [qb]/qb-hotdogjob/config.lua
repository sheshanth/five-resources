Config = Config or {}
Config.UseTarget = GetConvar('UseTarget', 'false') == 'true'
-- Config --

Config.StandDeposit = 250

Config.MyLevel = 1
Config.MaxReputation = 200

Config.Locations = {
    ["take"] = {
        coords = vector4(39.31, -1005.54, 29.48, 240.57),
    },
    ["spawn"] = {
        coords = vector4(38.15, -1001.65, 29.44, 342.5),
    },
}

Config.Stock = {
    ["exotic"] = {
        Current = 0,
        Max = {
            [1] = 15,
            [2] = 30,
            [3] = 45,
            [4] = 60,
        },
        Label = Lang:t("info.label_a"),
        Price = {
            [1] = {
                min = 6000,
                max = 6000,
            },
            [2] = {
                min = 6000,
                max = 6000,
            },
            [3] = {
                min = 6000,
                max = 6000,
            },
            [4] = {
                min = 6000,
                max = 6000,
            },
        }
    },
    ["rare"] = {
        Current = 0,
        Max = {
            [1] = 15,
            [2] = 30,
            [3] = 45,
            [4] = 60,
        },
        Label = Lang:t("info.label_b"),
        Price = {
            [1] = {
                min = 4000,
                max = 4000,
            },
            [2] = {
                min = 4000,
                max = 4000,
            },
            [3] = {
                min = 4000,
                max = 4000,
            },
            [4] = {
                min = 4000,
                max = 4000,
            },
        }
    },
    ["common"] = {
        Current = 0,
        Max = {
            [1] = 15,
            [2] = 30,
            [3] = 45,
            [4] = 60,
        },
        Label = Lang:t('info.label_c'),
        Price = {
            [1] = {
                min = 2000,
                max = 2000,
            },
            [2] = {
                min = 2000,
                max = 2000,
            },
            [3] = {
                min = 2000,
                max = 2000,
            },
            [4] = {
                min = 2000,
                max = 2000,
            },
        }
    },
}
