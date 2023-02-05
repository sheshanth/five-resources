QBShared = QBShared or {}
QBShared.ForceJobDefaultDutyAtLogin = true -- true: Force duty state to jobdefaultDuty | false: set duty state from database last saved
QBShared.QBJobsStatus = false -- true: integrate qb-jobs into the whole of qb-core | false: treat qb-jobs as an add-on resource.
QBShared.Jobs = {} -- All of below has been migrated into qb-jobs
if QBShared.QBJobsStatus then return end
QBShared.Jobs = {
	['unemployed'] = {
		label = 'Civilian',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Freelancer',
                payment = 1000
            },
        },
	},
	['police'] = {
		label = 'Law Enforcement',
        type = "leo",
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Recruit',
                payment = 5000
            },
			['1'] = {
                name = 'Officer',
                payment = 7000
            },
			['2'] = {
                name = 'Sergeant',
                payment = 10000
            },
			['3'] = {
                name = 'Lieutenant',
                payment = 12500
            },
			['4'] = {
                name = 'Chief',
				isboss = true,
                payment = 15000
            },
        },
	},
	['ambulance'] = {
		label = 'EMS',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Recruit',
                payment = 5000
            },
			['1'] = {
                name = 'Paramedic',
                payment = 7000
            },
			['2'] = {
                name = 'Doctor',
                payment = 10000
            },
			['3'] = {
                name = 'Surgeon',
                payment = 12500
            },
			['4'] = {
                name = 'Chief',
				isboss = true,
                payment = 15000
            },
        },
	},
	['realestate'] = {
		label = 'Real Estate',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Recruit',
                payment = 2000
            },
			['1'] = {
                name = 'House Sales',
                payment = 3000
            },
			['2'] = {
                name = 'Business Sales',
                payment = 5000
            },
			['3'] = {
                name = 'Broker',
                payment = 6000
            },
			['4'] = {
                name = 'Manager',
				isboss = true,
                payment = 7000
            },
        },
	},
	['taxi'] = {
		label = 'Taxi',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Recruit',
                payment = 2000
            },
			['1'] = {
                name = 'Driver',
                payment = 3000
            },
			['2'] = {
                name = 'Event Driver',
                payment = 5000
            },
			['3'] = {
                name = 'Sales',
                payment = 6000
            },
			['4'] = {
                name = 'Manager',
				isboss = true,
                payment = 7000
            },
        },
	},
    ['bus'] = {
		label = 'Bus',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Driver',
                payment = 1500
            },
		},
	},
	['cardealer'] = {
		label = 'Vehicle Dealer',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Recruit',
                payment = 2000
            },
			['1'] = {
                name = 'Showroom Sales',
                payment = 3000
            },
			['2'] = {
                name = 'Business Sales',
                payment = 5000
            },
			['3'] = {
                name = 'Finance',
                payment = 6000
            },
			['4'] = {
                name = 'Manager',
				isboss = true,
                payment = 7000
            },
        },
	},
	['mechanic'] = {
		label = 'Mechanic',
        type = "mechanic",
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Recruit',
                payment = 2000
            },
			['1'] = {
                name = 'Novice',
                payment = 3000
            },
			['2'] = {
                name = 'Experienced',
                payment = 5000
            },
			['3'] = {
                name = 'Advanced',
                payment = 6000
            },
			['4'] = {
                name = 'Manager',
				isboss = true,
                payment = 7000
            },
        },
	},
	['judge'] = {
		label = 'Honorary',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Judge',
                payment = 100
            },
        },
	},
	['lawyer'] = {
		label = 'Law Firm',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Associate',
                payment = 50
            },
        },
	},
	['reporter'] = {
		label = 'Reporter',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Journalist',
                payment = 5000
            },
        },
	},
	['trucker'] = {
		label = 'Trucker',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Driver',
                payment = 2000
            },
        },
	},
	['tow'] = {
		label = 'Towing',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Driver',
                payment = 2000
            },
        },
	},
	['garbage'] = {
		label = 'Garbage',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Collector',
                payment = 2000
            },
        },
	},
	['vineyard'] = {
		label = 'Vineyard',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Picker',
                payment = 5000
            },
        },
	},
	['hotdog'] = {
		label = 'Hotdog',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Sales',
                payment = 2000
            },
        },
	},
    ['tuner'] = {
		label = 'LS Tuner',
        type = "tuner",
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Recruit',
                payment = 50
            },
			['1'] = {
                name = 'Novice',
                payment = 75
            },
			['2'] = {
                name = 'Experienced',
                payment = 100
            },
			['3'] = {
                name = 'Advanced',
                payment = 125
            },
			['4'] = {
                name = 'Manager',
				isboss = true,
                payment = 150
            },
        },
	},
}
