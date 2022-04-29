local SeatPrompt
local active = false

local SeatGroup = GetRandomIntInRange(0, 0xffffff)

function Seat()
    Citizen.CreateThread(function()
        local str = 'Seat'
        local wait = 0
        SeatPrompt = Citizen.InvokeNative(0x04F97DE45A519419)
        PromptSetControlAction(SeatPrompt, 0xCEFD9220)
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(SeatPrompt, str)
        PromptSetEnabled(SeatPrompt, true)
        PromptSetVisible(SeatPrompt, true)
        PromptSetHoldMode(SeatPrompt, true)
        PromptSetGroup(SeatPrompt, SeatGroup)
        PromptRegisterEnd(SeatPrompt)
    end)
end

local target


Props = {
    {"P_CHAIRCOMFY04X", "PROP_HUMAN_SEAT_CHAIR_CIGAR"} ,
    {"P_CHAIR14X", "PROP_HUMAN_SEAT_CHAIR_CIGAR"} ,
    {"P_SIT_CHAIRWICKER01B", "PROP_HUMAN_SEAT_CHAIR_CIGAR"} ,
    {"P_SIT_CHAIRWICKER01A", "PROP_HUMAN_SEAT_CHAIR_CIGAR"} ,
    {"S_CRATESEAT03X", "PROP_HUMAN_SEAT_CHAIR_CIGAR"} ,
    {"P_CHAIRWICKER01X", "PROP_HUMAN_SEAT_CHAIR_CIGAR"} ,
    {"P_CHAIRROCKING06X", "PROP_HUMAN_SEAT_CHAIR_CIGAR"} ,
    {"P_WINDSORCHAIR03X", "PROP_HUMAN_SEAT_CHAIR_CIGAR"} ,
    {"P_CHAIR13X", "PROP_HUMAN_SEAT_CHAIR_CIGAR"} ,
    {"P_CHAIR12X", "PROP_HUMAN_SEAT_CHAIR_CIGAR"} ,

    {"p_bistrochair01x", "PROP_HUMAN_SEAT_CHAIR_CIGAR"} ,
    {"p_bistrochair02x", "PROP_HUMAN_SEAT_CHAIR_CIGAR"} ,

    {"P_CHAIRFOLDING02X", "PROP_HUMAN_SEAT_CHAIR_CIGAR"} ,
    {"P_CHAIR06X", "PROP_HUMAN_SEAT_CHAIR_CIGAR"} ,
    {"P_CHAIR22X", "PROP_HUMAN_SEAT_CHAIR_CIGAR"} ,
    {"P_WOODENCHAIR01X", "PROP_HUMAN_SEAT_CHAIR_CIGAR"} ,
    {"P_DININGCHAIRS01X", "PROP_HUMAN_SEAT_CHAIR_CIGAR"} ,
    {"P_WINDSORCHAIR02X", "PROP_HUMAN_SEAT_CHAIR_CIGAR"} ,
    {"P_LOVESEAT01X", "PROP_HUMAN_SEAT_BENCH_HARMONICA"} ,
    {"P_BENCH06X", "PROP_HUMAN_SEAT_BENCH_HARMONICA"} ,
    {"P_BENCH17X", "PROP_HUMAN_SEAT_BENCH_HARMONICA"} ,
    {"P_COUCH05X", "PROP_HUMAN_SEAT_BENCH_HARMONICA"} ,
    {"P_COUCH08X", "PROP_HUMAN_SEAT_BENCH_HARMONICA"} ,
    {"P_BENCH_LOG07X", "PROP_HUMAN_SEAT_BENCH_HARMONICA"} ,
    {"P_WINDSORBENCH01X", "PROP_HUMAN_SEAT_BENCH_HARMONICA"} ,
    {"P_BENCH15X", "PROP_HUMAN_SEAT_BENCH_HARMONICA"}
}

local target2
Props2 = {
    {"P_CHAIRCOMFY04X", "PROP_HUMAN_SEAT_CHAIR"} ,
    {"P_SIT_CHAIRWICKER01B", "PROP_HUMAN_SEAT_CHAIR"} ,
    {"P_CHAIR14X", "PROP_HUMAN_SEAT_CHAIR"} ,
    {"S_CRATESEAT03X", "PROP_HUMAN_SEAT_CHAIR"} ,
    {"P_SIT_CHAIRWICKER01A", "PROP_HUMAN_SEAT_CHAIR"} ,
    {"P_CHAIR13X", "PROP_HUMAN_SEAT_CHAIR"} ,
    {"P_CHAIR12X", "PROP_HUMAN_SEAT_CHAIR"} ,
    {"P_CHAIRWICKER01X", "PROP_HUMAN_SEAT_CHAIR"} ,
    {"P_CHAIRFOLDING02X", "PROP_HUMAN_SEAT_CHAIR"} ,
    {"p_bistrochair01x", "PROP_HUMAN_SEAT_CHAIR"} ,
    {"p_bistrochair02x", "PROP_HUMAN_SEAT_CHAIR"} ,

    {"P_CHAIR05X", "PROP_HUMAN_SEAT_CHAIR"} ,
    {"P_CHAIRROCKING06X", "PROP_HUMAN_SEAT_CHAIR"} ,
    {"P_WINDSORCHAIR03X", "PROP_HUMAN_SEAT_CHAIR"} ,
    {"P_CHAIR06X", "PROP_HUMAN_SEAT_CHAIR"} ,
    {"P_CHAIR22X", "PROP_HUMAN_SEAT_CHAIR"} ,
    {"P_WOODENCHAIR01X", "PROP_HUMAN_SEAT_CHAIR"} ,
    {"P_DININGCHAIRS01x", "PROP_HUMAN_SEAT_CHAIR"} ,
    {"P_WINDSORCHAIR02X", "PROP_HUMAN_SEAT_CHAIR"} ,
    {"P_LOVESEAT01X", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"P_BENCH06X", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"P_BENCH17X", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"P_COUCH05X", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"P_COUCH08X", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"P_BENCH_LOG07x", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"P_WINDSORBENCH01X", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"P_BENCH15X", "GENERIC_SEAT_BENCH_SCENARIO"}
}

local target3
Props3 = {
    {"P_CHAIRCOMFY04X", "MP_LOBBY_PROP_HUMAN_SEAT_CHAIR_WHITTLE"} ,
    {"P_SIT_CHAIRWICKER01B", "MP_LOBBY_PROP_HUMAN_SEAT_CHAIR_WHITTLE"} ,
    {"S_CRATESEAT03X", "MP_LOBBY_PROP_HUMAN_SEAT_CHAIR_WHITTLE"} ,
    {"P_SIT_CHAIRWICKER01A", "MP_LOBBY_PROP_HUMAN_SEAT_CHAIR_WHITTLE"} ,
    {"P_CHAIR14X", "MP_LOBBY_PROP_HUMAN_SEAT_CHAIR_WHITTLE"} ,
    {"P_CHAIRWICKER01X", "MP_LOBBY_PROP_HUMAN_SEAT_CHAIR_WHITTLE"} ,
    {"P_CHAIRFOLDING02X", "MP_LOBBY_PROP_HUMAN_SEAT_CHAIR_WHITTLE"} ,
    {"P_CHAIR13X", "MP_LOBBY_PROP_HUMAN_SEAT_CHAIR_WHITTLE"} ,
    {"P_CHAIR12X", "MP_LOBBY_PROP_HUMAN_SEAT_CHAIR_WHITTLE"} ,
    {"p_bistrochair01x", "MP_LOBBY_PROP_HUMAN_SEAT_CHAIR_WHITTLE"} ,
    {"p_bistrochair02x", "MP_LOBBY_PROP_HUMAN_SEAT_CHAIR_WHITTLE"} ,
    {"P_CHAIRROCKING06X", "MP_LOBBY_PROP_HUMAN_SEAT_CHAIR_WHITTLE"} ,
    {"P_WINDSORCHAIR03X", "MP_LOBBY_PROP_HUMAN_SEAT_CHAIR_WHITTLE"} ,
    {"P_CHAIR06X", "MP_LOBBY_PROP_HUMAN_SEAT_CHAIR_WHITTLE"} ,
    {"P_CHAIR22X", "MP_LOBBY_PROP_HUMAN_SEAT_CHAIR_WHITTLE"} ,
    {"P_WOODENCHAIR01X", "MP_LOBBY_PROP_HUMAN_SEAT_CHAIR_WHITTLE"} ,
    {"P_DININGCHAIRS01x", "MP_LOBBY_PROP_HUMAN_SEAT_CHAIR_WHITTLE"} ,
    {"P_WINDSORCHAIR02X", "MP_LOBBY_PROP_HUMAN_SEAT_CHAIR_WHITTLE"} ,
    {"P_LOVESEAT01X", "MP_LOBBY_PROP_HUMAN_SEAT_BENCH_PORCH_DRINKING"} ,
    {"P_BENCH06X", "MP_LOBBY_PROP_HUMAN_SEAT_BENCH_PORCH_DRINKING"} ,
    {"P_BENCH17X", "MP_LOBBY_PROP_HUMAN_SEAT_BENCH_PORCH_DRINKING"} ,
    {"P_COUCH05X", "MP_LOBBY_PROP_HUMAN_SEAT_BENCH_PORCH_DRINKING"} ,
    {"P_COUCH08X", "MP_LOBBY_PROP_HUMAN_SEAT_BENCH_PORCH_DRINKING"} ,
    {"P_BENCH_LOG07x", "MP_LOBBY_PROP_HUMAN_SEAT_BENCH_PORCH_DRINKING"} ,
    {"P_WINDSORBENCH01X", "MP_LOBBY_PROP_HUMAN_SEAT_BENCH_PORCH_DRINKING"} ,
    {"P_BENCH15X", "MP_LOBBY_PROP_HUMAN_SEAT_BENCH_PORCH_DRINKING"}
}

local target4
Props4 = {
    {"P_CHAIRCOMFY04X", "PROP_HUMAN_SEAT_CHAIR_BANJO"} ,
    {"P_SIT_CHAIRWICKER01B", "PROP_HUMAN_SEAT_CHAIR_BANJO"} ,
    {"S_CRATESEAT03X", "PROP_HUMAN_SEAT_CHAIR_BANJO"} ,
    {"P_SIT_CHAIRWICKER01A", "PROP_HUMAN_SEAT_CHAIR_BANJO"} ,
    {"P_CHAIR14X", "PROP_HUMAN_SEAT_CHAIR_BANJO"} ,
    {"p_bistrochair01x", "PROP_HUMAN_SEAT_CHAIR_BANJO"} ,
    {"p_bistrochair02x", "PROP_HUMAN_SEAT_CHAIR_BANJO"} ,
    {"P_CHAIRWICKER01X", "PROP_HUMAN_SEAT_CHAIR_BANJO"} ,
    {"P_CHAIRFOLDING02X", "PROP_HUMAN_SEAT_CHAIR_BANJO"} ,
    {"P_CHAIRROCKING06X", "PROP_HUMAN_SEAT_CHAIR_BANJO"} ,
    {"P_CHAIR13X", "PROP_HUMAN_SEAT_CHAIR_BANJO"} ,
    {"P_CHAIR12X", "PROP_HUMAN_SEAT_CHAIR_BANJO"} ,
    {"P_WINDSORCHAIR03X", "PROP_HUMAN_SEAT_CHAIR_BANJO"} ,
    {"P_CHAIR06X", "PROP_HUMAN_SEAT_CHAIR_BANJO"} ,
    {"P_CHAIR22X", "PROP_HUMAN_SEAT_CHAIR_BANJO"} ,
    {"P_WOODENCHAIR01X", "PROP_HUMAN_SEAT_CHAIR_BANJO"} ,
    {"P_DININGCHAIRS01x", "PROP_HUMAN_SEAT_CHAIR_BANJO"} ,
    {"P_WINDSORCHAIR02X", "PROP_HUMAN_SEAT_CHAIR_BANJO"} ,
    {"P_LOVESEAT01X", "PROP_HUMAN_SEAT_BENCH_CONCERTINA"} ,
    {"P_BENCH06X", "PROP_HUMAN_SEAT_BENCH_CONCERTINA"} ,
    {"P_BENCH17X", "PROP_HUMAN_SEAT_BENCH_CONCERTINA"} ,
    {"P_COUCH05X", "PROP_HUMAN_SEAT_BENCH_CONCERTINA"} ,
    {"P_COUCH08X", "PROP_HUMAN_SEAT_BENCH_CONCERTINA"} ,
    {"P_BENCH_LOG07x", "PROP_HUMAN_SEAT_BENCH_CONCERTINA"} ,
    {"P_WINDSORBENCH01X", "PROP_HUMAN_SEAT_BENCH_CONCERTINA"} ,
    {"P_BENCH15X", "PROP_HUMAN_SEAT_BENCH_CONCERTINA"}
}

local target5
Props5 = {
    {"P_CHAIRCOMFY04X", "PROP_HUMAN_SEAT_CHAIR_GUITAR"} ,
    {"P_SIT_CHAIRWICKER01B", "PROP_HUMAN_SEAT_CHAIR_GUITAR"} ,
    {"S_CRATESEAT03X", "PROP_HUMAN_SEAT_CHAIR_GUITAR"} ,
    {"P_SIT_CHAIRWICKER01A", "PROP_HUMAN_SEAT_CHAIR_GUITAR"} ,
    {"P_CHAIR14X", "PROP_HUMAN_SEAT_CHAIR_GUITAR"} ,
    {"P_CHAIR13X", "PROP_HUMAN_SEAT_CHAIR_GUITAR"} ,
    {"P_CHAIR12X", "PROP_HUMAN_SEAT_CHAIR_GUITAR"} ,
    {"P_CHAIRWICKER01X", "PROP_HUMAN_SEAT_CHAIR_GUITAR"} ,
    {"P_CHAIRFOLDING02X", "PROP_HUMAN_SEAT_CHAIR_GUITAR"} ,
    {"P_CHAIRROCKING06X", "PROP_HUMAN_SEAT_CHAIR_GUITAR"} ,
    {"p_bistrochair01x", "PROP_HUMAN_SEAT_CHAIR_GUITAR"} ,
    {"p_bistrochair02x", "PROP_HUMAN_SEAT_CHAIR_GUITAR"} ,
    {"P_WINDSORCHAIR03X", "PROP_HUMAN_SEAT_CHAIR_GUITAR"} ,
    {"P_CHAIR06X", "PROP_HUMAN_SEAT_CHAIR_GUITAR"} ,
    {"P_CHAIR22X", "PROP_HUMAN_SEAT_CHAIR_GUITAR"} ,
    {"P_WOODENCHAIR01X", "PROP_HUMAN_SEAT_CHAIR_GUITAR"} ,
    {"P_DININGCHAIRS01x", "PROP_HUMAN_SEAT_CHAIR_GUITAR"} ,
    {"P_WINDSORCHAIR02X", "PROP_HUMAN_SEAT_CHAIR_GUITAR"} ,
    {"P_LOVESEAT01X", "PROP_HUMAN_SEAT_BENCH_FIDDLE"} ,
    {"P_BENCH06X", "PROP_HUMAN_SEAT_BENCH_FIDDLE"} ,
    {"P_BENCH17X", "PROP_HUMAN_SEAT_BENCH_FIDDLE"} ,
    {"P_COUCH05X", "PROP_HUMAN_SEAT_BENCH_FIDDLE"} ,
    {"P_COUCH08X", "PROP_HUMAN_SEAT_BENCH_FIDDLE"} ,
    {"P_BENCH_LOG07x", "PROP_HUMAN_SEAT_BENCH_FIDDLE"} ,
    {"P_WINDSORBENCH01X", "PROP_HUMAN_SEAT_BENCH_FIDDLE"} ,
    {"P_BENCH15X", "PROP_HUMAN_SEAT_BENCH_FIDDLE"}
}

local target6
Props6 = {
    {"P_CHAIRCOMFY04X", "PROP_HUMAN_SEAT_CHAIR_KNITTING"} ,
    {"P_SIT_CHAIRWICKER01B", "PROP_HUMAN_SEAT_CHAIR_KNITTING"} ,
    {"S_CRATESEAT03X", "PROP_HUMAN_SEAT_CHAIR_KNITTING"} ,
    {"P_SIT_CHAIRWICKER01A", "PROP_HUMAN_SEAT_CHAIR_KNITTING"} ,
    {"P_CHAIRWICKER01X", "PROP_HUMAN_SEAT_CHAIR_KNITTING"} ,
    {"P_CHAIR14X", "PROP_HUMAN_SEAT_CHAIR_KNITTING"} ,
    {"P_CHAIR13X", "PROP_HUMAN_SEAT_CHAIR_KNITTING"} ,
    {"P_CHAIR12X", "PROP_HUMAN_SEAT_CHAIR_KNITTING"} ,
    {"p_bistrochair01x", "PROP_HUMAN_SEAT_CHAIR_KNITTING"} ,
    {"p_bistrochair02x", "PROP_HUMAN_SEAT_CHAIR_KNITTING"} ,
    {"P_CHAIRFOLDING02X", "PROP_HUMAN_SEAT_CHAIR_KNITTING"} ,
    {"P_CHAIRROCKING06X", "PROP_HUMAN_SEAT_CHAIR_KNITTING"} ,
    {"P_WINDSORCHAIR03X", "PROP_HUMAN_SEAT_CHAIR_KNITTING"} ,
    {"P_CHAIR06X", "PROP_HUMAN_SEAT_CHAIR_KNITTING"} ,
    {"P_CHAIR22X", "PROP_HUMAN_SEAT_CHAIR_KNITTING"} ,
    {"P_WOODENCHAIR01X", "PROP_HUMAN_SEAT_CHAIR_KNITTING"} ,
    {"P_DININGCHAIRS01x", "PROP_HUMAN_SEAT_CHAIR_KNITTING"} ,
    {"P_WINDSORCHAIR02X", "PROP_HUMAN_SEAT_CHAIR_KNITTING"} ,
    {"P_LOVESEAT01X", "PROP_HUMAN_SEAT_BENCH_JAW_HARP"} ,
    {"P_BENCH06X", "PROP_HUMAN_SEAT_BENCH_JAW_HARP"} ,
    {"P_BENCH17X", "PROP_HUMAN_SEAT_BENCH_JAW_HARP"} ,
    {"P_COUCH05X", "PROP_HUMAN_SEAT_BENCH_JAW_HARP"} ,
    {"P_COUCH08X", "PROP_HUMAN_SEAT_BENCH_JAW_HARP"} ,
    {"P_BENCH_LOG07x", "PROP_HUMAN_SEAT_BENCH_JAW_HARP"} ,
    {"P_WINDSORBENCH01X", "PROP_HUMAN_SEAT_BENCH_JAW_HARP"} ,
    {"P_BENCH15X", "PROP_HUMAN_SEAT_BENCH_JAW_HARP"}
}

local target7
Props7 = {
    {"P_CHAIRCOMFY04X", "PROP_HUMAN_SEAT_CHAIR_KNIFE_BADASS"} ,
    {"P_SIT_CHAIRWICKER01B", "PROP_HUMAN_SEAT_CHAIR_KNIFE_BADASS"} ,
    {"S_CRATESEAT03X", "PROP_HUMAN_SEAT_CHAIR_KNIFE_BADASS"} ,
    {"P_SIT_CHAIRWICKER01A", "PROP_HUMAN_SEAT_CHAIR_KNIFE_BADASS"} ,
    {"P_CHAIRWICKER01X", "PROP_HUMAN_SEAT_CHAIR_KNIFE_BADASS"} ,
    {"P_CHAIRFOLDING02X", "PROP_HUMAN_SEAT_CHAIR_KNIFE_BADASS"} ,
    {"p_bistrochair01x", "PROP_HUMAN_SEAT_CHAIR_KNIFE_BADASS"} ,
    {"p_bistrochair02x", "PROP_HUMAN_SEAT_CHAIR_KNIFE_BADASS"} ,
    {"P_CHAIR14X", "PROP_HUMAN_SEAT_CHAIR_KNIFE_BADASS"} ,
    {"P_CHAIRROCKING06X", "PROP_HUMAN_SEAT_CHAIR_KNIFE_BADASS"} ,
    {"P_WINDSORCHAIR03X", "PROP_HUMAN_SEAT_CHAIR_KNIFE_BADASS"} ,
    {"P_CHAIR13X", "PROP_HUMAN_SEAT_CHAIR_KNIFE_BADASS"} ,
    {"P_CHAIR12X", "PROP_HUMAN_SEAT_CHAIR_KNIFE_BADASS"} ,
    {"P_CHAIR06X", "PROP_HUMAN_SEAT_CHAIR_KNIFE_BADASS"} ,
    {"P_CHAIR22X", "PROP_HUMAN_SEAT_CHAIR_KNIFE_BADASS"} ,
    {"P_WOODENCHAIR01X", "PROP_HUMAN_SEAT_CHAIR_KNIFE_BADASS"} ,
    {"P_DININGCHAIRS01x", "PROP_HUMAN_SEAT_CHAIR_KNIFE_BADASS"} ,
    {"P_WINDSORCHAIR02X", "PROP_HUMAN_SEAT_CHAIR_KNIFE_BADASS"} ,
    {"P_LOVESEAT01X", "PROP_HUMAN_SEAT_BENCH_MANDOLIN"} ,
    {"P_BENCH06X", "PROP_HUMAN_SEAT_BENCH_MANDOLIN"} ,
    {"P_BENCH17X", "PROP_HUMAN_SEAT_BENCH_MANDOLIN"} ,
    {"P_COUCH05X", "PROP_HUMAN_SEAT_BENCH_MANDOLIN"} ,
    {"P_COUCH08X", "PROP_HUMAN_SEAT_BENCH_MANDOLIN"} ,
    {"P_BENCH_LOG07x", "PROP_HUMAN_SEAT_BENCH_MANDOLIN"} ,
    {"P_WINDSORBENCH01X", "PROP_HUMAN_SEAT_BENCH_MANDOLIN"} ,
    {"P_BENCH15X", "PROP_HUMAN_SEAT_BENCH_MANDOLIN"}
}

local target8
Props8 = {
    {"P_CHAIRCOMFY04X", "PROP_HUMAN_SEAT_CHAIR_GROOMING_GROSS"} ,
    {"P_SIT_CHAIRWICKER01B", "PROP_HUMAN_SEAT_CHAIR_GROOMING_GROSS"} ,
    {"S_CRATESEAT03X", "PROP_HUMAN_SEAT_CHAIR_GROOMING_GROSS"} ,
    {"P_SIT_CHAIRWICKER01A", "PROP_HUMAN_SEAT_CHAIR_GROOMING_GROSS"} ,
    {"P_CHAIRWICKER01X", "PROP_HUMAN_SEAT_CHAIR_GROOMING_GROSS"} ,
    {"P_CHAIRFOLDING02X", "PROP_HUMAN_SEAT_CHAIR_GROOMING_GROSS"} ,
    {"P_CHAIRROCKING06X", "PROP_HUMAN_SEAT_CHAIR_GROOMING_GROSS"} ,
    {"P_CHAIR14X", "PROP_HUMAN_SEAT_CHAIR_GROOMING_GROSS"} ,
    {"p_bistrochair01x", "PROP_HUMAN_SEAT_CHAIR_GROOMING_GROSS"} ,
    {"p_bistrochair02x", "PROP_HUMAN_SEAT_CHAIR_GROOMING_GROSS"} ,
    {"P_WINDSORCHAIR03X", "PROP_HUMAN_SEAT_CHAIR_GROOMING_GROSS"} ,
    {"P_CHAIR13X", "PROP_HUMAN_SEAT_CHAIR_GROOMING_GROSS"} ,
    {"P_CHAIR12X", "PROP_HUMAN_SEAT_CHAIR_GROOMING_GROSS"} ,
    {"P_CHAIR06X", "PROP_HUMAN_SEAT_CHAIR_GROOMING_GROSS"} ,
    {"P_CHAIR22X", "PROP_HUMAN_SEAT_CHAIR_GROOMING_GROSS"} ,
    {"P_WOODENCHAIR01X", "PROP_HUMAN_SEAT_CHAIR_GROOMING_GROSS"} ,
    {"P_DININGCHAIRS01x", "PROP_HUMAN_SEAT_CHAIR_GROOMING_GROSS"} ,
    {"P_WINDSORCHAIR02X", "PROP_HUMAN_SEAT_CHAIR_GROOMING_GROSS"} ,
    {"P_LOVESEAT01X", "MP_LOBBY_PROP_HUMAN_SEAT_BENCH_PORCH_SMOKING"} ,
    {"P_BENCH06X", "MP_LOBBY_PROP_HUMAN_SEAT_BENCH_PORCH_SMOKING"} ,
    {"P_BENCH17X", "MP_LOBBY_PROP_HUMAN_SEAT_BENCH_PORCH_SMOKING"} ,
    {"P_COUCH05X", "MP_LOBBY_PROP_HUMAN_SEAT_BENCH_PORCH_SMOKING"} ,
    {"P_COUCH08X", "MP_LOBBY_PROP_HUMAN_SEAT_BENCH_PORCH_SMOKING"} ,
    {"P_BENCH_LOG07x", "MP_LOBBY_PROP_HUMAN_SEAT_BENCH_PORCH_SMOKING"} ,
    {"P_WINDSORBENCH01X", "MP_LOBBY_PROP_HUMAN_SEAT_BENCH_PORCH_SMOKING"} ,
    {"P_BENCH15X", "MP_LOBBY_PROP_HUMAN_SEAT_BENCH_PORCH_SMOKING"}
}

local target9
Props9 = {
    {"P_CHAIRCOMFY04X", "PROP_HUMAN_SEAT_CHAIR_GROOMING_POSH"} ,
    {"P_SIT_CHAIRWICKER01B", "PROP_HUMAN_SEAT_CHAIR_GROOMING_POSH"} ,
    {"P_CHAIR14X", "PROP_HUMAN_SEAT_CHAIR_GROOMING_POSH"} ,
    {"S_CRATESEAT03X", "PROP_HUMAN_SEAT_CHAIR_GROOMING_POSH"} ,
    {"P_SIT_CHAIRWICKER01A", "PROP_HUMAN_SEAT_CHAIR_GROOMING_POSH"} ,
    {"P_CHAIRWICKER01X", "PROP_HUMAN_SEAT_CHAIR_GROOMING_POSH"} ,
    {"P_CHAIRFOLDING02X", "PROP_HUMAN_SEAT_CHAIR_GROOMING_POSH"} ,
    {"P_CHAIRROCKING06X", "PROP_HUMAN_SEAT_CHAIR_GROOMING_POSH"} ,
    {"P_WINDSORCHAIR03X", "PROP_HUMAN_SEAT_CHAIR_GROOMING_POSH"} ,
    {"P_CHAIR13X", "PROP_HUMAN_SEAT_CHAIR_GROOMING_POSH"} ,
    {"P_CHAIR12X", "PROP_HUMAN_SEAT_CHAIR_GROOMING_POSH"} ,
    {"P_CHAIR06X", "PROP_HUMAN_SEAT_CHAIR_GROOMING_POSH"} ,
    {"P_CHAIR22X", "PROP_HUMAN_SEAT_CHAIR_GROOMING_POSH"} ,
    {"p_bistrochair01x", "PROP_HUMAN_SEAT_CHAIR_GROOMING_POSH"} ,
    {"p_bistrochair02x", "PROP_HUMAN_SEAT_CHAIR_GROOMING_POSH"} ,
    {"P_WOODENCHAIR01X", "PROP_HUMAN_SEAT_CHAIR_GROOMING_POSH"} ,
    {"P_DININGCHAIRS01x", "PROP_HUMAN_SEAT_CHAIR_GROOMING_POSH"} ,
    {"P_WINDSORCHAIR02X", "PROP_HUMAN_SEAT_CHAIR_GROOMING_POSH"} 
    
}

local target10
Props10 = {
    {"P_CHAIRCOMFY04X", "PROP_HUMAN_SEAT_CHAIR_FAN"} ,
    {"P_SIT_CHAIRWICKER01B", "PROP_HUMAN_SEAT_CHAIR_FAN"} ,
    {"S_CRATESEAT03X", "PROP_HUMAN_SEAT_CHAIR_FAN"} ,
    {"P_SIT_CHAIRWICKER01A", "PROP_HUMAN_SEAT_CHAIR_FAN"} ,
    {"P_CHAIR14X", "PROP_HUMAN_SEAT_CHAIR_FAN"} ,
    {"P_CHAIRWICKER01X", "PROP_HUMAN_SEAT_CHAIR_FAN"} ,
    {"p_bistrochair01x", "PROP_HUMAN_SEAT_CHAIR_FAN"} ,
    {"p_bistrochair02x", "PROP_HUMAN_SEAT_CHAIR_FAN"} ,
    {"P_CHAIRFOLDING02X", "PROP_HUMAN_SEAT_CHAIR_FAN"} ,
    {"P_CHAIRROCKING06X", "PROP_HUMAN_SEAT_CHAIR_FAN"} ,
    {"P_WINDSORCHAIR03X", "PROP_HUMAN_SEAT_CHAIR_FAN"} ,
    {"P_CHAIR13X", "PROP_HUMAN_SEAT_CHAIR_FAN"} ,
    {"P_CHAIR12X", "PROP_HUMAN_SEAT_CHAIR_FAN"} ,
    {"P_CHAIR06X", "PROP_HUMAN_SEAT_CHAIR_FAN"} ,
    {"P_CHAIR22X", "PROP_HUMAN_SEAT_CHAIR_FAN"} ,
    {"P_WOODENCHAIR01X", "PROP_HUMAN_SEAT_CHAIR_FAN"} ,
    {"P_DININGCHAIRS01x", "PROP_HUMAN_SEAT_CHAIR_FAN"} ,
    {"P_WINDSORCHAIR02X", "PROP_HUMAN_SEAT_CHAIR_FAN"} 
    
}

local target11
Props11 = {
    {"P_CHAIRCOMFY04X", "PROP_HUMAN_SEAT_CHAIR_READING"} ,
    {"P_SIT_CHAIRWICKER01B", "PROP_HUMAN_SEAT_CHAIR_READING"} ,
    {"S_CRATESEAT03X", "PROP_HUMAN_SEAT_CHAIR_READING"} ,
    {"P_SIT_CHAIRWICKER01A", "PROP_HUMAN_SEAT_CHAIR_READING"} ,
    {"P_CHAIR14X", "PROP_HUMAN_SEAT_CHAIR_READING"} ,
    {"P_CHAIRWICKER01X", "PROP_HUMAN_SEAT_CHAIR_READING"} ,
    {"P_CHAIRFOLDING02X", "PROP_HUMAN_SEAT_CHAIR_READING"} ,
    {"P_CHAIRROCKING06X", "PROP_HUMAN_SEAT_CHAIR_READING"} ,
    {"P_CHAIR13X", "PROP_HUMAN_SEAT_CHAIR_READING"} ,
    {"p_bistrochair01x", "PROP_HUMAN_SEAT_CHAIR_READING"} ,
    {"p_bistrochair02x", "PROP_HUMAN_SEAT_CHAIR_READING"} ,
    {"P_CHAIR12X", "PROP_HUMAN_SEAT_CHAIR_READING"} ,
    {"P_WINDSORCHAIR03X", "PROP_HUMAN_SEAT_CHAIR_READING"} ,
    {"P_CHAIR06X", "PROP_HUMAN_SEAT_CHAIR_READING"} ,
    {"P_CHAIR22X", "PROP_HUMAN_SEAT_CHAIR_READING"} ,
    {"P_WOODENCHAIR01X", "PROP_HUMAN_SEAT_CHAIR_READING"} ,
    {"P_DININGCHAIRS01x", "PROP_HUMAN_SEAT_CHAIR_READING"} ,
    {"P_WINDSORCHAIR02X", "PROP_HUMAN_SEAT_CHAIR_READING"} 
    
}

local target12
Props12 = {
    {"P_CHAIRCOMFY04X", "MP_LOBBY_PROP_HUMAN_SEAT_CHAIR"} ,
    {"P_SIT_CHAIRWICKER01B", "MP_LOBBY_PROP_HUMAN_SEAT_CHAIR"} ,
    {"S_CRATESEAT03X", "MP_LOBBY_PROP_HUMAN_SEAT_CHAIR"} ,
    {"P_SIT_CHAIRWICKER01A", "MP_LOBBY_PROP_HUMAN_SEAT_CHAIR"} ,
    {"P_CHAIR14X", "MP_LOBBY_PROP_HUMAN_SEAT_CHAIR"} ,
    {"P_CHAIR13X", "MP_LOBBY_PROP_HUMAN_SEAT_CHAIR"} ,
    {"P_CHAIR12X", "MP_LOBBY_PROP_HUMAN_SEAT_CHAIR"} ,
    {"p_bistrochair01x", "MP_LOBBY_PROP_HUMAN_SEAT_CHAIR"} ,
    {"p_bistrochair02x", "MP_LOBBY_PROP_HUMAN_SEAT_CHAIR"} ,
    {"P_CHAIRWICKER01X", "MP_LOBBY_PROP_HUMAN_SEAT_CHAIR"} ,
    {"P_CHAIRFOLDING02X", "MP_LOBBY_PROP_HUMAN_SEAT_CHAIR"} ,
    {"P_CHAIRROCKING06X", "MP_LOBBY_PROP_HUMAN_SEAT_CHAIR"} ,
    {"P_WINDSORCHAIR03X", "MP_LOBBY_PROP_HUMAN_SEAT_CHAIR"} ,
    {"P_CHAIR06X", "MP_LOBBY_PROP_HUMAN_SEAT_CHAIR"} ,
    {"P_CHAIR22X", "MP_LOBBY_PROP_HUMAN_SEAT_CHAIR"} ,
    {"P_WOODENCHAIR01X", "MP_LOBBY_PROP_HUMAN_SEAT_CHAIR"} ,
    {"P_DININGCHAIRS01x", "MP_LOBBY_PROP_HUMAN_SEAT_CHAIR"} ,
    {"P_WINDSORCHAIR02X", "MP_LOBBY_PROP_HUMAN_SEAT_CHAIR"} 
    
}

local target13
Props13 = {
    {"P_CHAIRCOMFY04X", "PROP_HUMAN_SEAT_CHAIR"} ,
    {"P_SIT_CHAIRWICKER01B", "PROP_HUMAN_SEAT_CHAIR"} ,
    {"S_CRATESEAT03X", "PROP_HUMAN_SEAT_CHAIR"} ,
    {"P_SIT_CHAIRWICKER01A", "PROP_HUMAN_SEAT_CHAIR"} ,
    {"P_CHAIR14X", "PROP_HUMAN_SEAT_CHAIR"} ,
    {"P_CHAIR13X", "PROP_HUMAN_SEAT_CHAIR"} ,
    {"p_bistrochair01x", "PROP_HUMAN_SEAT_CHAIR"} ,
    {"p_bistrochair02x", "PROP_HUMAN_SEAT_CHAIR"} ,
    {"P_CHAIR12X", "PROP_HUMAN_SEAT_CHAIR"} ,
    {"P_CHAIRWICKER01X", "PROP_HUMAN_SEAT_CHAIR"} ,
    {"P_CHAIRFOLDING02X", "PROP_HUMAN_SEAT_CHAIR"} ,
    {"P_CHAIRROCKING06X", "PROP_HUMAN_SEAT_CHAIR"} ,
    {"P_WINDSORCHAIR03X", "PROP_HUMAN_SEAT_CHAIR"} ,
    {"P_CHAIR06X", "PROP_HUMAN_SEAT_CHAIR"} ,
    {"P_CHAIR22X", "PROP_HUMAN_SEAT_CHAIR"} ,
    {"P_WOODENCHAIR01X", "PROP_HUMAN_SEAT_CHAIR"} ,
    {"P_DININGCHAIRS01x", "PROP_HUMAN_SEAT_CHAIR"} ,
    {"P_WINDSORCHAIR02X", "PROP_HUMAN_SEAT_CHAIR"} 
    
}

local target14
Props14 = {
    {"P_CHAIRCOMFY04X", "PROP_CAMP_FIRE_SEAT_CHAIR"} ,
    {"P_SIT_CHAIRWICKER01B", "PROP_CAMP_FIRE_SEAT_CHAIR"} ,
    {"S_CRATESEAT03X", "PROP_CAMP_FIRE_SEAT_CHAIR"} ,
    {"P_SIT_CHAIRWICKER01A", "PROP_CAMP_FIRE_SEAT_CHAIR"} ,
    {"P_CHAIR14X", "PROP_CAMP_FIRE_SEAT_CHAIR"} ,
    {"p_bistrochair01x", "PROP_CAMP_FIRE_SEAT_CHAIR"} ,
    {"p_bistrochair02x", "PROP_CAMP_FIRE_SEAT_CHAIR"} ,
    {"P_CHAIR13X", "PROP_CAMP_FIRE_SEAT_CHAIR"} ,
    {"P_CHAIR12X", "PROP_CAMP_FIRE_SEAT_CHAIR"} ,
    {"P_CHAIRWICKER01X", "PROP_CAMP_FIRE_SEAT_CHAIR"} ,
    {"P_CHAIRFOLDING02X", "PROP_CAMP_FIRE_SEAT_CHAIR"} ,
    {"P_CHAIRROCKING06X", "PROP_CAMP_FIRE_SEAT_CHAIR"} ,
    {"P_WINDSORCHAIR03X", "PROP_CAMP_FIRE_SEAT_CHAIR"} ,
    {"P_CHAIR06X", "PROP_CAMP_FIRE_SEAT_CHAIR"} ,
    {"P_CHAIR22X", "PROP_CAMP_FIRE_SEAT_CHAIR"} ,
    {"P_WOODENCHAIR01X", "PROP_CAMP_FIRE_SEAT_CHAIR"} ,
    {"P_DININGCHAIRS01x", "PROP_CAMP_FIRE_SEAT_CHAIR"} ,
    {"P_WINDSORCHAIR02X", "PROP_CAMP_FIRE_SEAT_CHAIR"} 
    
}

local target15
Props15 = {
    {"P_CHAIRCOMFY04X", "PROP_HUMAN_SEAT_CHAIR_PORCH"} ,
    {"P_SIT_CHAIRWICKER01B", "PROP_HUMAN_SEAT_CHAIR_PORCH"} ,
    {"S_CRATESEAT03X", "PROP_HUMAN_SEAT_CHAIR_PORCH"} ,
    {"P_SIT_CHAIRWICKER01A", "PROP_HUMAN_SEAT_CHAIR_PORCH"} ,
    {"P_CHAIRWICKER01X", "PROP_HUMAN_SEAT_CHAIR_PORCH"} ,
    {"P_CHAIR14X", "PROP_HUMAN_SEAT_CHAIR_PORCH"} ,
    {"P_CHAIR13X", "PROP_HUMAN_SEAT_CHAIR_PORCH"} ,
    {"P_CHAIR12X", "PROP_HUMAN_SEAT_CHAIR_PORCH"} ,
    {"p_bistrochair01x", "PROP_HUMAN_SEAT_CHAIR_PORCH"} ,
    {"p_bistrochair02x", "PROP_HUMAN_SEAT_CHAIR_PORCH"} ,
    {"P_CHAIRFOLDING02X", "PROP_HUMAN_SEAT_CHAIR_PORCH"} ,
    {"P_CHAIRROCKING06X", "PROP_HUMAN_SEAT_CHAIR_PORCH"} ,
    {"P_WINDSORCHAIR03X", "PROP_HUMAN_SEAT_CHAIR_PORCH"} ,
    {"P_CHAIR06X", "PROP_HUMAN_SEAT_CHAIR_PORCH"} ,
    {"P_CHAIR22X", "PROP_HUMAN_SEAT_CHAIR_PORCH"} ,
    {"P_WOODENCHAIR01X", "PROP_HUMAN_SEAT_CHAIR_PORCH"} ,
    {"P_DININGCHAIRS01x", "PROP_HUMAN_SEAT_CHAIR_PORCH"} ,
    {"P_WINDSORCHAIR02X", "PROP_HUMAN_SEAT_CHAIR_PORCH"} 
    
}

local target16
Props16 = {
    {"p_piano03x", "PROP_HUMAN_PIANO"} ,
    {"p_piano02x", "PROP_HUMAN_PIANO"},
    {"p_nbxpiano01x", "PROP_HUMAN_PIANO"}
    
}

local target17
Props17 = {
    {"p_piano03x", "PROP_HUMAN_ABIGAIL_PIANO"} ,
    {"p_piano02x", "PROP_HUMAN_ABIGAIL_PIANO"},
    {"p_nbxpiano01x", "PROP_HUMAN_ABIGAIL_PIANO"}
    
}




Citizen.CreateThread(function()
    WarMenu.CreateMenu('seats', "Interactions")
    WarMenu.SetSubTitle('seats', 'Animations')
    WarMenu.CreateSubMenu('seats2', 'seats', 'Benches')
    WarMenu.CreateSubMenu('seats3', 'seats', 'Chairs')
  

    while true do
        local ped = PlayerPedId()
        local coords = GetEntityCoords(PlayerPedId())

        if WarMenu.IsMenuOpened('seats') then
            if WarMenu.MenuButton('Benches', 'seats2') then
            end
            if WarMenu.MenuButton('Chairs', 'seats3') then
            end
            if WarMenu.MenuButton('Pianos', 'seats4') then
            end
            WarMenu.Display()

        elseif WarMenu.IsMenuOpened('seats2') then
            if WarMenu.Button('Harmonica Male') then
                    TriggerEvent("seats:harmonica")
                    WarMenu.CloseMenu()
            elseif WarMenu.Button('Sit Down') then
                    TriggerEvent("seats:sit")
                    WarMenu.CloseMenu()
            elseif WarMenu.Button('Drinking') then
                    TriggerEvent("seats:drink")
                    WarMenu.CloseMenu()
            elseif WarMenu.Button('Concertina Male') then
                    TriggerEvent("seats:banjo")
                    WarMenu.CloseMenu()
            elseif WarMenu.Button('Fiddle Female') then
                    TriggerEvent("seats:fiddle")
                    WarMenu.CloseMenu()
            elseif WarMenu.Button('Jaw Harp Male') then
                    TriggerEvent("seats:harp")
                    WarMenu.CloseMenu()
            elseif WarMenu.Button('Mandolin Male') then
                    TriggerEvent("seats:fan")
                    WarMenu.CloseMenu()
            elseif WarMenu.Button('Smoke Cigarette') then
                    TriggerEvent("seats:gross")
                    WarMenu.CloseMenu()
                    
                    
            -- elseif WarMenu.Button('Spin Cotton into Yarn') then
            --         TriggerServerEvent("wcrpseats:yarn")
                   -- WarMenu.CloseMenu()
           -- elseif WarMenu.Button('Venison Meal') then
                    --TriggerServerEvent("wcrp_seats:venisonmeal")
                    --WarMenu.CloseMenu()
            --elseif WarMenu.Button('FOOD4') then
                    --TriggerServerEvent("wcrp_seats:food4")
                    --WarMenu.CloseMenu()
                end
                WarMenu.Display()

        elseif WarMenu.IsMenuOpened('seats3') then
            if WarMenu.Button('Cigar Male') then
                    TriggerEvent("seats:harmonica")
                    WarMenu.CloseMenu()
            elseif WarMenu.Button('Sit Down') then
                    TriggerEvent("seats:sit")
                    WarMenu.CloseMenu()
            elseif WarMenu.Button('Sit Down2') then
                    TriggerEvent("seats:clean")
                    WarMenu.CloseMenu() 
            elseif WarMenu.Button('Sit Down3') then
                    TriggerEvent("seats:sit3")
                    WarMenu.CloseMenu() 
            elseif WarMenu.Button('Sit Down Camp Fire Chair') then
                    TriggerEvent("seats:sit4")
             elseif WarMenu.Button('Sit Down Porch Chair') then
                    TriggerEvent("seats:sit5")
                    WarMenu.CloseMenu()
            elseif WarMenu.Button('Sit Down & Whittle') then
                    TriggerEvent("seats:drink")
                    WarMenu.CloseMenu()
            elseif WarMenu.Button('Banjo Male') then
                    TriggerEvent("seats:banjo")
                    WarMenu.CloseMenu()
            elseif WarMenu.Button('Guitar Male') then
                    TriggerEvent("seats:fiddle")
                    WarMenu.CloseMenu()
            elseif WarMenu.Button('Knitting Female') then
                    TriggerEvent("seats:harp")
                    WarMenu.CloseMenu()
            elseif WarMenu.Button('Knife Bad-Ass Male') then
                    TriggerEvent("seats:fan")
                    WarMenu.CloseMenu()
            elseif WarMenu.Button('Groom Gross Male') then
                    TriggerEvent("seats:gross")
                    WarMenu.CloseMenu()
            elseif WarMenu.Button('Groom Posh Female') then
                    TriggerEvent("seats:posh")
                    WarMenu.CloseMenu()
            elseif WarMenu.Button('Fan Self Female') then
                    TriggerEvent("seats:fan2")
                    WarMenu.CloseMenu()
            elseif WarMenu.Button('Read Book Female') then
                    TriggerEvent("seats:read")
                    WarMenu.CloseMenu()        
            --elseif WarMenu.Button('NAMEHERE') then
            --        TriggerServerEvent("wcrp_seats:item6")
            --        WarMenu.CloseMenu()
            --elseif WarMenu.Button('Item7') then
            --        TriggerServerEvent("wcrp_seats:item7")
            --        WarMenu.CloseMenu()
                end
   
                 WarMenu.Display()

        elseif WarMenu.IsMenuOpened('seats4') then
            if WarMenu.Button('Play Piano Male') then
                    TriggerEvent("seats:piano1")
                    WarMenu.CloseMenu()
            elseif WarMenu.Button('Play Piano Female') then
                    TriggerEvent("seats:piano2")
                    WarMenu.CloseMenu()
                end
   
                WarMenu.Display()
		
        end
        Citizen.Wait(0)
    end
end)
function DrawText3D(x, y, z, text)
	local onScreen,_x,_y=GetScreenCoordFromWorldCoord(x, y, z)
	local px,py,pz=table.unpack(GetGameplayCamCoord())  
	local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
	local str = CreateVarString(10, "LITERAL_STRING", text, Citizen.ResultAsLong())
	if onScreen then
	  SetTextScale(0.30, 0.30)
	  SetTextFontForCurrentCommand(1)
	  SetTextColor(255, 255, 255, 215)
	  SetTextCentre(1)
	  DisplayText(str,_x,_y)
	  local factor = (string.len(text)) / 225
	  DrawSprite("feeds", "hud_menu_4a", _x, _y+0.0125,0.015+ factor, 0.03, 0.1, 35, 35, 35, 190, 0)
	end
end
local show = true
local chaircoords2
Citizen.CreateThread(function()
    while true do 
        Wait(2)
        local sleep = true 
        local pedCoords = GetEntityCoords(PlayerPedId())
        if chaircoords2 ~= nil then
            local dist = Vdist(pedCoords, chaircoords2)
            if dist < 1.8 then
                sleep = false 
                if show then 
                    DrawText3D(chaircoords2.x, chaircoords2.y, chaircoords2.z, "B to Sit")
                    if Citizen.InvokeNative(0x91AEF906BCA88877, 0, 0x4CC0E2FE) then
                        show = false
                        TriggerEvent("seats:open")
                        active = true
                        target = v
                    end
                end
            end
        end
        if sleep then 
            Wait(500)
        end
    end
end)
Citizen.CreateThread(function()
    while true do 
        Wait(2)
        if Citizen.InvokeNative(0x91AEF906BCA88877, 0, 0xA5BDCD3C) then
            show = true
        end
        if Citizen.InvokeNative(0x91AEF906BCA88877, 0, 0x308588E6) then
            show = true
        end
    end
end)
Citizen.CreateThread(function()
    while true do 
        Wait(500)
        for k,v in pairs(Props) do
            local pedCoords = GetEntityCoords(PlayerPedId())
            local ChairId = GetClosestObjectOfType(pedCoords.x, pedCoords.y, pedCoords.z, 2.0 ,GetHashKey(v[1]) , false)
            local chaircoords = GetEntityCoords(ChairId)
            local dist = Vdist(pedCoords, chaircoords)
            SetEntityCanBeDamaged(ChairId, false)
            ClearEntityLastDamageEntity(ChairId)
            SetEntityOnlyDamagedByPlayer(ChairId, false)
            FreezeEntityPosition(ChairId, true)
            if dist < 1.8 then
                chaircoords2 = chaircoords
            end
        end
    end
end)

--[[ Citizen.CreateThread(function()    
    while true do 
        Citizen.Wait(1)
        if active then

            
            if IsControlJustPressed(0, 0x8FD015D8) then
                active = false
                ClearPedTasks(PlayerPedId())
                --SetCurrentPedWeapon(PlayerPedId(), -1569615261, true)
            end    
        end
    end
end) ]]

--[[ RegisterCommand('chair', function(source, args, rawCommand)
    active = false
    ClearPedTasks(PlayerPedId())
    SetCurrentPedWeapon(PlayerPedId(), -1569615261, true)
    WarMenu.OpenMenu('seats')
end) ]]

AddEventHandler('seats:open', function()
    local _source = source
    if seats ~= 0 then
        seats = 0
    end
    WarMenu.OpenMenu('seats')
end)

AddEventHandler('seats:harmonica', function()
    for k,v in pairs(Props) do
        local pedCoords = GetEntityCoords(PlayerPedId())
        local ChairId = GetClosestObjectOfType(pedCoords.x, pedCoords.y, pedCoords.z, 2.0 ,GetHashKey(v[1]) , false)
        local chaircoords = GetEntityCoords(ChairId)
        local dist = Vdist(pedCoords, chaircoords)
        SetEntityCanBeDamaged(ChairId, false)
        ClearEntityLastDamageEntity(ChairId)
        SetEntityOnlyDamagedByPlayer(ChairId, false)
        FreezeEntityPosition(ChairId, true)
        if dist < 1.5 then
            if active == false then
                    -- local SeatGroupName  = CreateVarString(10, 'LITERAL_STRING', "Chair")
                    -- PromptSetActiveGroupThisFrame(SeatGroup, SeatGroupName)
            end
            active = true
            target = v
            local player = PlayerPedId()
            local chairpos = GetOffsetFromEntityInWorldCoords(ChairId,0.0,0.0,0.5)
            local chairheading = GetEntityHeading(ChairId)
            TaskStartScenarioAtPosition(player, GetHashKey(v[2]), chairpos.x, chairpos.y, chairpos.z, chairheading+180.0, 0, false)

        else
            if active and v ==target then
                 active = false
            end
        end
    end
end)

AddEventHandler('seats:sit', function()
    for k,v in pairs(Props2) do
        local pedCoords = GetEntityCoords(PlayerPedId())
        local ChairId = GetClosestObjectOfType(pedCoords.x, pedCoords.y, pedCoords.z, 2.0 ,GetHashKey(v[1]) , false)
        local chaircoords = GetEntityCoords(ChairId)
        local dist = Vdist(pedCoords, chaircoords)
        SetEntityCanBeDamaged(ChairId, false)
        ClearEntityLastDamageEntity(ChairId)
        SetEntityOnlyDamagedByPlayer(ChairId, false)
        FreezeEntityPosition(ChairId, true)
        if dist < 1.5 then
            if active == false then
                    -- local SeatGroupName  = CreateVarString(10, 'LITERAL_STRING', "Chair")
                    -- PromptSetActiveGroupThisFrame(SeatGroup, SeatGroupName)
            end
            active = true
            target2 = v
            local player = PlayerPedId()
            local chairpos = GetOffsetFromEntityInWorldCoords(ChairId,0.0,0.0,0.5)
            local chairheading = GetEntityHeading(ChairId)
            TaskStartScenarioAtPosition(player, GetHashKey(v[2]), chairpos.x, chairpos.y, chairpos.z, chairheading+180.0, 0, false)

        else
            if active and v ==target2 then
                 active = false
            end
        end
    end
end)


AddEventHandler('seats:drink', function()
    for k,v in pairs(Props3) do
        local pedCoords = GetEntityCoords(PlayerPedId())
        local ChairId = GetClosestObjectOfType(pedCoords.x, pedCoords.y, pedCoords.z, 2.0 ,GetHashKey(v[1]) , false)
        local chaircoords = GetEntityCoords(ChairId)
        local dist = Vdist(pedCoords, chaircoords)
        SetEntityCanBeDamaged(ChairId, false)
        ClearEntityLastDamageEntity(ChairId)
        SetEntityOnlyDamagedByPlayer(ChairId, false)
        FreezeEntityPosition(ChairId, true)
        if dist < 1.5 then
            if active == false then
                    -- local SeatGroupName  = CreateVarString(10, 'LITERAL_STRING', "Chair")
                    -- PromptSetActiveGroupThisFrame(SeatGroup, SeatGroupName)
            end
            active = true
            target3 = v
            local player = PlayerPedId()
            local chairpos = GetOffsetFromEntityInWorldCoords(ChairId,0.0,0.0,0.5)
            local chairheading = GetEntityHeading(ChairId)
            TaskStartScenarioAtPosition(player, GetHashKey(v[2]), chairpos.x, chairpos.y, chairpos.z, chairheading+180.0, 0, false)
            

        else
            if active and v ==target3 then
                 active = false
            end
        end
    end
end)

AddEventHandler('seats:banjo', function()
    for k,v in pairs(Props4) do
        local pedCoords = GetEntityCoords(PlayerPedId())
        local ChairId = GetClosestObjectOfType(pedCoords.x, pedCoords.y, pedCoords.z, 2.0 ,GetHashKey(v[1]) , false)
        local chaircoords = GetEntityCoords(ChairId)
        local dist = Vdist(pedCoords, chaircoords)
        SetEntityCanBeDamaged(ChairId, false)
        ClearEntityLastDamageEntity(ChairId)
        SetEntityOnlyDamagedByPlayer(ChairId, false)
        FreezeEntityPosition(ChairId, true)
        if dist < 1.5 then
            if active == false then
                    -- local SeatGroupName  = CreateVarString(10, 'LITERAL_STRING', "Chair")
                    -- PromptSetActiveGroupThisFrame(SeatGroup, SeatGroupName)
            end
            active = true
            target4 = v
            local player = PlayerPedId()
            local chairpos = GetOffsetFromEntityInWorldCoords(ChairId,0.0,0.0,0.5)
            local chairheading = GetEntityHeading(ChairId)
            TaskStartScenarioAtPosition(player, GetHashKey(v[2]), chairpos.x, chairpos.y, chairpos.z, chairheading+180.0, 0, false)

        else
            if active and v ==target4 then
                 active = false
            end
        end
    end
end)

AddEventHandler('seats:fiddle', function()
    for k,v in pairs(Props5) do
        local pedCoords = GetEntityCoords(PlayerPedId())
        local ChairId = GetClosestObjectOfType(pedCoords.x, pedCoords.y, pedCoords.z, 2.0 ,GetHashKey(v[1]) , false)
        local chaircoords = GetEntityCoords(ChairId)
        local dist = Vdist(pedCoords, chaircoords)
        SetEntityCanBeDamaged(ChairId, false)
        ClearEntityLastDamageEntity(ChairId)
        SetEntityOnlyDamagedByPlayer(ChairId, false)
        FreezeEntityPosition(ChairId, true)
        if dist < 1.5 then
            if active == false then
                    -- local SeatGroupName  = CreateVarString(10, 'LITERAL_STRING', "Chair")
                    -- PromptSetActiveGroupThisFrame(SeatGroup, SeatGroupName)
            end
            active = true
            target5 = v
            local player = PlayerPedId()
            local chairpos = GetOffsetFromEntityInWorldCoords(ChairId,0.0,0.0,0.5)
            local chairheading = GetEntityHeading(ChairId)
            TaskStartScenarioAtPosition(player, GetHashKey(v[2]), chairpos.x, chairpos.y, chairpos.z, chairheading+180.0, 0, false)

        else
            if active and v ==target5 then
                 active = false
            end
        end
    end
end)

AddEventHandler('seats:harp', function()
    for k,v in pairs(Props6) do
        local pedCoords = GetEntityCoords(PlayerPedId())
        local ChairId = GetClosestObjectOfType(pedCoords.x, pedCoords.y, pedCoords.z, 2.0 ,GetHashKey(v[1]) , false)
        local chaircoords = GetEntityCoords(ChairId)
        local dist = Vdist(pedCoords, chaircoords)
        SetEntityCanBeDamaged(ChairId, false)
        ClearEntityLastDamageEntity(ChairId)
        SetEntityOnlyDamagedByPlayer(ChairId, false)
        FreezeEntityPosition(ChairId, true)
        if dist < 1.5 then
            if active == false then
                    -- local SeatGroupName  = CreateVarString(10, 'LITERAL_STRING', "Chair")
                    -- PromptSetActiveGroupThisFrame(SeatGroup, SeatGroupName)
            end
            active = true
            target6 = v
            local player = PlayerPedId()
            local chairpos = GetOffsetFromEntityInWorldCoords(ChairId,0.0,0.0,0.5)
            local chairheading = GetEntityHeading(ChairId)
            TaskStartScenarioAtPosition(player, GetHashKey(v[2]), chairpos.x, chairpos.y, chairpos.z, chairheading+180.0, 0, false)

        else
            if active and v ==target6 then
                 active = false
            end
        end
    end
end)

AddEventHandler('seats:fan', function()
    for k,v in pairs(Props7) do
        local pedCoords = GetEntityCoords(PlayerPedId())
        local ChairId = GetClosestObjectOfType(pedCoords.x, pedCoords.y, pedCoords.z, 2.0 ,GetHashKey(v[1]) , false)
        local chaircoords = GetEntityCoords(ChairId)
        local dist = Vdist(pedCoords, chaircoords)
        SetEntityCanBeDamaged(ChairId, false)
        ClearEntityLastDamageEntity(ChairId)
        SetEntityOnlyDamagedByPlayer(ChairId, false)
        FreezeEntityPosition(ChairId, true)
        if dist < 1.5 then
            if active == false then
                    -- local SeatGroupName  = CreateVarString(10, 'LITERAL_STRING', "Chair")
                    -- PromptSetActiveGroupThisFrame(SeatGroup, SeatGroupName)
            end
            active = true
            target7 = v
            local player = PlayerPedId()
            local chairpos = GetOffsetFromEntityInWorldCoords(ChairId,0.0,0.0,0.5)
            local chairheading = GetEntityHeading(ChairId)
            TaskStartScenarioAtPosition(player, GetHashKey(v[2]), chairpos.x, chairpos.y, chairpos.z, chairheading+180.0, 0, false)

        else
            if active and v ==target7 then
                 active = false
            end
        end
    end
end)

AddEventHandler('seats:gross', function()
    for k,v in pairs(Props8) do
        local pedCoords = GetEntityCoords(PlayerPedId())
        local ChairId = GetClosestObjectOfType(pedCoords.x, pedCoords.y, pedCoords.z, 2.0 ,GetHashKey(v[1]) , false)
        local chaircoords = GetEntityCoords(ChairId)
        local dist = Vdist(pedCoords, chaircoords)
        SetEntityCanBeDamaged(ChairId, false)
        ClearEntityLastDamageEntity(ChairId)
        SetEntityOnlyDamagedByPlayer(ChairId, false)
        FreezeEntityPosition(ChairId, true)
        if dist < 1.5 then
            if active == false then
                    -- local SeatGroupName  = CreateVarString(10, 'LITERAL_STRING', "Chair")
                    -- PromptSetActiveGroupThisFrame(SeatGroup, SeatGroupName)
            end
            active = true
            target8 = v
            local player = PlayerPedId()
            local chairpos = GetOffsetFromEntityInWorldCoords(ChairId,0.0,0.0,0.5)
            local chairheading = GetEntityHeading(ChairId)
            TaskStartScenarioAtPosition(player, GetHashKey(v[2]), chairpos.x, chairpos.y, chairpos.z, chairheading+180.0, 0, false)

        else
            if active and v ==target8 then
                 active = false
            end
        end
    end
end)

AddEventHandler('seats:posh', function()
    for k,v in pairs(Props9) do
        local pedCoords = GetEntityCoords(PlayerPedId())
        local ChairId = GetClosestObjectOfType(pedCoords.x, pedCoords.y, pedCoords.z, 2.0 ,GetHashKey(v[1]) , false)
        local chaircoords = GetEntityCoords(ChairId)
        local dist = Vdist(pedCoords, chaircoords)
        SetEntityCanBeDamaged(ChairId, false)
        ClearEntityLastDamageEntity(ChairId)
        SetEntityOnlyDamagedByPlayer(ChairId, false)
        FreezeEntityPosition(ChairId, true)
        if dist < 1.5 then
            if active == false then
                    -- local SeatGroupName  = CreateVarString(10, 'LITERAL_STRING', "Chair")
                    -- PromptSetActiveGroupThisFrame(SeatGroup, SeatGroupName)
            end
            active = true
            target9 = v
            local player = PlayerPedId()
            local chairpos = GetOffsetFromEntityInWorldCoords(ChairId,0.0,0.0,0.5)
            local chairheading = GetEntityHeading(ChairId)
            TaskStartScenarioAtPosition(player, GetHashKey(v[2]), chairpos.x, chairpos.y, chairpos.z, chairheading+180.0, 0, false)

        else
            if active and v ==target9 then
                 active = false
            end
        end
    end
end)

AddEventHandler('seats:fan2', function()
    for k,v in pairs(Props10) do
        local pedCoords = GetEntityCoords(PlayerPedId())
        local ChairId = GetClosestObjectOfType(pedCoords.x, pedCoords.y, pedCoords.z, 2.0 ,GetHashKey(v[1]) , false)
        local chaircoords = GetEntityCoords(ChairId)
        local dist = Vdist(pedCoords, chaircoords)
        SetEntityCanBeDamaged(ChairId, false)
        ClearEntityLastDamageEntity(ChairId)
        SetEntityOnlyDamagedByPlayer(ChairId, false)
        FreezeEntityPosition(ChairId, true)
        if dist < 1.5 then
            if active == false then
                    -- local SeatGroupName  = CreateVarString(10, 'LITERAL_STRING', "Chair")
                    -- PromptSetActiveGroupThisFrame(SeatGroup, SeatGroupName)
            end
            active = true
            target10 = v
            local player = PlayerPedId()
            local chairpos = GetOffsetFromEntityInWorldCoords(ChairId,0.0,0.0,0.5)
            local chairheading = GetEntityHeading(ChairId)
            TaskStartScenarioAtPosition(player, GetHashKey(v[2]), chairpos.x, chairpos.y, chairpos.z, chairheading+180.0, 0, false)

        else
            if active and v ==target10 then
                 active = false
            end
        end
    end
end)

AddEventHandler('seats:read', function()
    for k,v in pairs(Props11) do
        local pedCoords = GetEntityCoords(PlayerPedId())
        local ChairId = GetClosestObjectOfType(pedCoords.x, pedCoords.y, pedCoords.z, 2.0 ,GetHashKey(v[1]) , false)
        local chaircoords = GetEntityCoords(ChairId)
        local dist = Vdist(pedCoords, chaircoords)
        SetEntityCanBeDamaged(ChairId, false)
        ClearEntityLastDamageEntity(ChairId)
        SetEntityOnlyDamagedByPlayer(ChairId, false)
        FreezeEntityPosition(ChairId, true)
        if dist < 1.5 then
            if active == false then
                    -- local SeatGroupName  = CreateVarString(10, 'LITERAL_STRING', "Chair")
                    -- PromptSetActiveGroupThisFrame(SeatGroup, SeatGroupName)
            end
            active = true
            target11 = v
            local player = PlayerPedId()
            local chairpos = GetOffsetFromEntityInWorldCoords(ChairId,0.0,0.0,0.5)
            local chairheading = GetEntityHeading(ChairId)
            TaskStartScenarioAtPosition(player, GetHashKey(v[2]), chairpos.x, chairpos.y, chairpos.z, chairheading+180.0, 0, false)

        else
            if active and v ==target11 then
                 active = false
            end
        end
    end
end)

AddEventHandler('seats:clean', function()
    for k,v in pairs(Props12) do
        local pedCoords = GetEntityCoords(PlayerPedId())
        local ChairId = GetClosestObjectOfType(pedCoords.x, pedCoords.y, pedCoords.z, 2.0 ,GetHashKey(v[1]) , false)
        local chaircoords = GetEntityCoords(ChairId)
        local dist = Vdist(pedCoords, chaircoords)
        SetEntityCanBeDamaged(ChairId, false)
        ClearEntityLastDamageEntity(ChairId)
        SetEntityOnlyDamagedByPlayer(ChairId, false)
        FreezeEntityPosition(ChairId, true)
        if dist < 1.5 then
            if active == false then
                    -- local SeatGroupName  = CreateVarString(10, 'LITERAL_STRING', "Chair")
                    -- PromptSetActiveGroupThisFrame(SeatGroup, SeatGroupName)
            end
            active = true
            target12 = v
            local player = PlayerPedId()
            local chairpos = GetOffsetFromEntityInWorldCoords(ChairId,0.0,0.0,0.5)
            local chairheading = GetEntityHeading(ChairId)
            TaskStartScenarioAtPosition(player, GetHashKey(v[2]), chairpos.x, chairpos.y, chairpos.z, chairheading+180.0, 0, false)

        else
            if active and v ==target12 then
                 active = false
            end
        end
    end
end)

AddEventHandler('seats:sit3', function()
    for k,v in pairs(Props13) do
        local pedCoords = GetEntityCoords(PlayerPedId())
        local ChairId = GetClosestObjectOfType(pedCoords.x, pedCoords.y, pedCoords.z, 2.0 ,GetHashKey(v[1]) , false)
        local chaircoords = GetEntityCoords(ChairId)
        local dist = Vdist(pedCoords, chaircoords)
        SetEntityCanBeDamaged(ChairId, false)
        ClearEntityLastDamageEntity(ChairId)
        SetEntityOnlyDamagedByPlayer(ChairId, false)
        FreezeEntityPosition(ChairId, true)
        if dist < 1.5 then
            if active == false then
                    -- local SeatGroupName  = CreateVarString(10, 'LITERAL_STRING', "Chair")
                    -- PromptSetActiveGroupThisFrame(SeatGroup, SeatGroupName)
            end
            active = true
            target13 = v
            local player = PlayerPedId()
            local chairpos = GetOffsetFromEntityInWorldCoords(ChairId,0.0,0.0,0.5)
            local chairheading = GetEntityHeading(ChairId)
            TaskStartScenarioAtPosition(player, GetHashKey(v[2]), chairpos.x, chairpos.y, chairpos.z, chairheading+180.0, 0, false)

        else
            if active and v ==target13 then
                 active = false
            end
        end
    end
end)

AddEventHandler('seats:sit4', function()
    for k,v in pairs(Props14) do
        local pedCoords = GetEntityCoords(PlayerPedId())
        local ChairId = GetClosestObjectOfType(pedCoords.x, pedCoords.y, pedCoords.z, 2.0 ,GetHashKey(v[1]) , false)
        local chaircoords = GetEntityCoords(ChairId)
        local dist = Vdist(pedCoords, chaircoords)
        SetEntityCanBeDamaged(ChairId, false)
        ClearEntityLastDamageEntity(ChairId)
        SetEntityOnlyDamagedByPlayer(ChairId, false)
        FreezeEntityPosition(ChairId, true)
        if dist < 1.5 then
            if active == false then
                    -- local SeatGroupName  = CreateVarString(10, 'LITERAL_STRING', "Chair")
                    -- PromptSetActiveGroupThisFrame(SeatGroup, SeatGroupName)
            end
            active = true
            target14 = v
            local player = PlayerPedId()
            local chairpos = GetOffsetFromEntityInWorldCoords(ChairId,0.0,0.0,0.5)
            local chairheading = GetEntityHeading(ChairId)
            TaskStartScenarioAtPosition(player, GetHashKey(v[2]), chairpos.x, chairpos.y, chairpos.z, chairheading+180.0, 0, false)

        else
            if active and v ==target14 then
                 active = false
            end
        end
    end
end)

AddEventHandler('seats:sit5', function()
    for k,v in pairs(Props15) do
        local pedCoords = GetEntityCoords(PlayerPedId())
        local ChairId = GetClosestObjectOfType(pedCoords.x, pedCoords.y, pedCoords.z, 2.0 ,GetHashKey(v[1]) , false)
        local chaircoords = GetEntityCoords(ChairId)
        local dist = Vdist(pedCoords, chaircoords)
        SetEntityCanBeDamaged(ChairId, false)
        ClearEntityLastDamageEntity(ChairId)
        SetEntityOnlyDamagedByPlayer(ChairId, false)
        FreezeEntityPosition(ChairId, true)
        if dist < 1.5 then
            if active == false then
                    -- local SeatGroupName  = CreateVarString(10, 'LITERAL_STRING', "Chair")
                    -- PromptSetActiveGroupThisFrame(SeatGroup, SeatGroupName)
            end
            active = true
            target15 = v
            local player = PlayerPedId()
            local chairpos = GetOffsetFromEntityInWorldCoords(ChairId,0.0,0.0,0.5)
            local chairheading = GetEntityHeading(ChairId)
            TaskStartScenarioAtPosition(player, GetHashKey(v[2]), chairpos.x, chairpos.y, chairpos.z, chairheading+180.0, 0, false)

        else
            if active and v ==target15 then
                 active = false
            end
        end
    end
end)

AddEventHandler('seats:sit5', function()
    for k,v in pairs(Props15) do
        local pedCoords = GetEntityCoords(PlayerPedId())
        local ChairId = GetClosestObjectOfType(pedCoords.x, pedCoords.y, pedCoords.z, 2.0 ,GetHashKey(v[1]) , false)
        local chaircoords = GetEntityCoords(ChairId)
        local dist = Vdist(pedCoords, chaircoords)
        SetEntityCanBeDamaged(ChairId, false)
        ClearEntityLastDamageEntity(ChairId)
        SetEntityOnlyDamagedByPlayer(ChairId, false)
        FreezeEntityPosition(ChairId, true)
        if dist < 1.5 then
            if active == false then
                    -- local SeatGroupName  = CreateVarString(10, 'LITERAL_STRING', "Chair")
                    -- PromptSetActiveGroupThisFrame(SeatGroup, SeatGroupName)
            end
            active = true
            target15 = v
            local player = PlayerPedId()
            local chairpos = GetOffsetFromEntityInWorldCoords(ChairId,0.0,0.0,0.5)
            local chairheading = GetEntityHeading(ChairId)
            TaskStartScenarioAtPosition(player, GetHashKey(v[2]), chairpos.x, chairpos.y, chairpos.z, chairheading+180.0, 0, false)

        else
            if active and v ==target15 then
                 active = false
            end
        end
    end
end)



