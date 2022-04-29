local entity_one_natives = {
    0x083D497D57B7400F,
    0x1FF441D7954F8709,
    0x255B6DB4E3AD3C3E,
    0x2A77EF9BEC8518F4,
    0x37B01666BAE8F7EF,
    0x4735E2A4BB83D9DA,
    0x5594AFE9DE0C01B7,
    0x5AFFA9DDC87846F8,
    0x66B2B83B94B22458,
    0x6888A43C35A5F630,
    0x6D58167F62238284,
    0x75DF9E73F2F005FD,
    0x857ACB0AB4BD0D55,
    0x88AD6CC10D8D35B2,
    0x8DE41E9902E85756,
    0x935A30AA88FB1014,
    0x964000D355219FC0,
    0x9A100F1CF4546629,
    0x9A87FF82FD35822F,
    0xA7E51B53309EAC97,
    0xAAACB74442C1BED3,
    0xB16C780C51E51E2B,
    0xC2E71D7E0A7B4C89,
    0xC346A546612C49A9,
    0xD21C7418C590BB40,
    0xD4636C2EDB0DEA8A,
    0xE12F56CB25D9CE23,
    0xEF2D9ED7CE684F08,
    0xF59FDE7B4D31A630,
}

RegisterCommand('entity_one_test', function(source, args, rawCommand)
    if args[1] then
        args[1] = ConvertArg(args[1])
    end
    Citizen.CreateThread(function()
        print('Start entity_one_test')
        for key, nativeHash in pairs(entity_one_natives) do
            Citizen.CreateThread(function()
                local result = Citizen.InvokeNative(nativeHash, table.unpack(args))
                if result then
                    local nativeHashString = string.format("0x%2X", nativeHash)
                    print(nativeHashString)
                    print(table.unpack(args))
                    if tonumber(result) == nil then
                        print(result)
                    else
                        local s = string.pack("i4", tonumber(result))
                        local f = string.unpack("f", s)
                        print(tonumber(result), f)
                    end
                    print('--------')
                end
            end)
            Citizen.Wait(500)
        end
        print('End entity_one_test')
    end)
end)

local entity_two_natives = {
    0x0B7CB1300CBFE19C,
    0x120376C23F019C6C,
    0x188736456D1DEDE6,
    0x1E804EA9B12030A4,
    0x2A08A32B6D49906F,
    0x34F008A7E48C496B,
    0x350E9211074955AF,
    0x5E214112806591EA,
    0x808077647856DE62,
    0x8C03CD6B5E0E85E8,
    0x9587913B9E772D29,
    0xD4E5C1E93C466127,
    0xDFC2B226D56D85F6,
    0xF7424890E4A094C0,
}

RegisterCommand('entity_two_test', function(source, args, rawCommand)
    if args[1] then
        args[1] = ConvertArg(args[1])
    end
    if args[2] then
        args[2] = ConvertArg(args[2])
    end
    Citizen.CreateThread(function()
        print('Start entity_two_test')
        for key, nativeHash in pairs(entity_two_natives) do
            Citizen.CreateThread(function()
                local result = Citizen.InvokeNative(nativeHash, table.unpack(args))
                if result then
                    local nativeHashString = string.format("0x%2X", nativeHash)
                    print(nativeHashString)
                    print(table.unpack(args))
                    if tonumber(result) == nil then
                        print(result)
                    else
                        local s = string.pack("i4", tonumber(result))
                        local f = string.unpack("f", s)
                        print(tonumber(result), f)
                    end
                    print('--------')
                end
            end)
            Citizen.Wait(500)
        end
        print('End entity_two_test')
    end)
end)

local object_one_natives = {
    0x007BD043587F7C82,
    0x0378C08504160D0D,
    0x08C5825A2932EA7B,
    0x20135AF9C10D2A3D,
    0x250EBB11E81A10BE,
    0x2BF1953C0C21AC88,
    0x3397CD4E0353DFBA,
    0x3E2616E7EA539480,
    0x44B09A23D728045A,
    0x4D8611DFE1126478,
    0x4F89DAD4156BA145,
    0x58DE624FA7FB0E7F,
    0x614D0B4533F842D3,
    0x8433E1954BE323FC,
    0xACD4F9831DFAD7F5,
    0xB5DED7B65C604FDF,
    0xB6CBD40F8EA69E8A,
    0xEBA314768FB35D58,
    0xFA3B61EC249B4674,
}

RegisterCommand("object_one_test", function(source, args, rawCommand)
    if args[1] then
        args[1] = ConvertArg(args[1])
    end
    Citizen.CreateThread(function()
        for key, nativeHash in pairs(object_one_natives) do
            Citizen.CreateThread(function()
                local result = Citizen.InvokeNative(nativeHash, table.unpack(args))
                if result then
                    local nativeHashString = string.format("0x%2X", nativeHash)
                    print(nativeHashString)
                    print(table.unpack(args))
                    if tonumber(result) == nil then
                        print(result)
                    else
                        local s = string.pack("i4", tonumber(result))
                        local f = string.unpack("f", s)
                        print(tonumber(result), f)
                    end
                    print('--------')
                end
            end)
            Citizen.Wait(500)
        end
    end)
end)

local object_two_natives = {
    0x0943113E02322164,
    0x6E2AA80BB0C03728,
    0x7D4411D6736CD295,
    0x9F52AD67D1A91BAD,
    0xD91E55B6C005EB09,
}

RegisterCommand("object_two_test", function(source, args, rawCommand)
    if args[1] then
        args[1] = ConvertArg(args[1])
    end
    if args[2] then
        args[2] = ConvertArg(args[2])
    end
    Citizen.CreateThread(function()
        for key, nativeHash in pairs(object_two_natives) do
            Citizen.CreateThread(function()
                local result = Citizen.InvokeNative(nativeHash, table.unpack(args))
                if result then
                    local nativeHashString = string.format("0x%2X", nativeHash)
                    print(nativeHashString)
                    print(table.unpack(args))
                    if tonumber(result) == nil then
                        print(result)
                    else
                        local s = string.pack("i4", tonumber(result))
                        local f = string.unpack("f", s)
                        print(tonumber(result), f)
                    end
                    print('--------')
                end
            end)
            Citizen.Wait(500)
        end
    end)
end)

RegisterCommand("mass_search", function(source, args, rawCommand)
    Citizen.CreateThread(function()
        local name_list = {
            "ABE_CABINET", "ADL_CABINET", "ADVDECOMPALLIGATOR", "ADVDECOMPALLIGATORLG", "ADVDECOMPBEAR", "ADVDECOMPBEARBLACK", "ADVDECOMPBOVINE", "ADVDECOMPBUFF", "ADVDECOMPBULL", "ADVDECOMPCANIFORM", "ADVDECOMPCAT", "ADVDECOMPCERVIDAE", "ADVDECOMPCOU", "ADVDECOMPCOW", "ADVDECOMPCOY", "ADVDECOMPELK", "ADVDECOMPHORSE", "ADVDECOMPLIONMANGYX", "ADVDECOMPMOOSE", "ADVDECOMPOX", "ADVDECOMPSUIDAE", "AMB_TENT", "AMBCHAIR", "AMBCLOTHSEAT", "AMBFRAME", "AMBTENTBURLAP", "AMBTENTDEBRIS", "AMBTENTHIDE", "AMBTENTLEATHER", "AMBTENTMULCH", "AMBTENTOILSKIN", "AMBTENTPATCH", "AMBTENTPLAID", "AMBTENTRUG", "AMBTENTSCRUB", "AMBTENTSTICKS", "AMBTENTSTRING", "AMBTENTSTRIPE", "AMMO", "AMMOBOX", "ANVIL", "APPLE", "ARMOIR", "ARMOIREREGAL", "ARMOIROFFICE", "ASHTRAY", "AWNING", "AWNINGBILLS", "AXE",
            "BAG", "BAGGAGE", "BAMBOOSTICK", "BANJO", "BANANA", "BARBERCHAIR", "BARREL", "BARRELGROUP", "BARRICADE", "BARSTOOL", "BASKET", "BEARTRAP", "BED", "BED20BLOODYX", "BEDINDIAN", "BEDROLLCLOSED", "BEDSLEPTINOLD", "BELL", "BENCH", "BENCH_LOG", "BENCHCH", "BENCHIRONNBX", "BENCHLONG", "BENCHNBX", "BINOCULARS", "BISTROCHAIR", "BLA_LUMBDESK", "BOILER", "BOOK", "BOOKCASE", "BOTTLE", "BOTTLEBEER", "BOTTLECHAMPAGNE", "BOTTLEJD", "BOW", "BOWL", "BOXCAR_ROB4_CRATES", "BOXLRGBIRCH", "BOXLRGCOTTON", "BOXLRGICE", "BOXLRGLEATHER", "BOXLRGMEAT", "BOXLRGPRODUCE", "BOXLRGSTOOL", "BOXLRGTIN", "BOXLRGTOOL", "BOXLRGWICKER", "BOXLRGWOVEN", "BOXMEDCHARRED", "BOXMEDDEPOSIT", "BOXMEDMEDICAL", "BOXMEDPAINT", "BOXMEDSUITCASE", "BOXMEDWICKER", "BOXSMLAMMO", "BOXSMLBIRCH", "BOXSMLHEALTH", "BOXSMLLEATHER", "BOXSMLTACKLE", "BRASSBOX", "BREAD", "BRICK", "BROOM", "BRUSH", "BUCKET", "BUFFET", "BULRUSH", "BUTTERCHURN", "BW_DESK",
            "CABINET", "CABINETCHINA", "CABINETDOCTOR", "CABINETPOSTAL", "CAMERA", "CAMERABOX", "CAMPFIRE", "CAMPFIREBASIN", "CAMPFIRECHAR", "CAMPFIRECHARSML", "CAMPFIREDIRT", "CAMPFIREDIRTSML", "CAMPFIREROCK", "CAMPFIREROCKSML", "CAMPHITCHHOOK", "CAN", "CANDLE", "CANDLESTICK", "CARCASSBONESMD", "CARCASSBONESPOSSUM", "CARCASSBONESSM", "CARCASSBONESTOAD", "CARCASSBONESTURTLE", "CARCASSBONESTURTSNAP", "CARCASSHANGFISH", "CARCASSHANGLRG", "CARCASSHANGMED", "CARDS", "CARDSSPLIT", "CARROT", "CART", "CARTCABINET", "CASK", "CHAIR", "CHAIR_BARREL", "CHAIR_CRATE", "CHAIR_CS", "CHAIRBROKEN", "CHAIRCOMFY", "CHAIRCOMFYCOMBO", "CHAIRCONVOROUND", "CHAIRDINING", "CHAIRDOCTOR", "CHAIRFOLDING", "CHAIRHOB", "CHAIRNBX", "CHAIRPOKERFANCY", "CHAIRROCKING", "CHAIRRUSTICSAV", "CHAIRVICTORIAN", "CHAIRWHITE", "CHAIRWICKER", "CHEST", "CHEST_LRG", "CHEST_MED", "CHESTCHAIR", "CHESTMEDBIN", "CHESTMEDHUNT", "CHESTMEDICE", "CHESTMEDLIVESTOCK", "CHESTMEDLOG", "CHESTMEDPRODUCE", "CHESTMEDTRAP", "CHESTMEDWICKER", "CHICKEN", "CHICKENFENCE", "CHICKENGATE", "CHINACABINET", "CIGAR", "CIGARBOX", "CIGARETTE_CS", "CLIPBOARD", "CLOCK", "CLOTHESLINE", "COAL", "COALHOD", "COALPILE", "COASTER", "COATRACK", "COFFER", "COFFIN", "COFFINLID", "COIN", "COMMODE", "COMMODINI", "COOKGRATE", "CORN", "CORNERCABINET", "CORPSE", "COT", "COUCH", "COUNTERDOCTOR", "CRATE", "CRATETABLE", "CRATETNT", "CRATETOOLS", "CUP", "CUPBOARD", "CUPBOARDCORNER", "CUPBOARDFAC", "CUTTINGBOARD",
            "DESK", "DIS_STRONGBOXSM", "DISPLAY", "DOOR", "DOORCIRCUS", "DOORSGLW", "DRESSER", "DRESSERVAL", "DRMEDCABINET", "DRYSINK",
            "ENDTABLE", "EXAMTBLEDOCTOR",
            "FEEDTROUGH", "FENCE", "FEVERFEW", "FILECABINETDOCTOR", "FIRSTAIDKIT", "FISH", "FISHINGPOLE", "FLAG", "FLASK", "FOOTLOCKER", "FORK", "FURNACE",
            "GEN_CHAIR", "GEN_CHAIRPOKERFANCY", "GEN_DOCUMENTFOLDER", "GLASS", "GRAVE", "GRAVESTONE", "GRINDINGWHEEL", "GUITAR", "GUNCABINET", "GUNRACK", "GUNSMITHTRAPDOOR",
            "HALLBENCH", "HAM", "HAMMER", "HANDPLOW", "HANGER", "HARP", "HAT", "HATCHET", "HAYBALE", "HAYBALESTACK", "HAYPILE", "HERBSDRY", "HITCHINGPOST", "HITCHPOSTBLA", "HOE", "HOOK", "HORN", "HORSEHITCHNBD", "HORSESHOE", "HUTCH", "HUTCHWHITE",
            "ICEBOX", "INKWELL", "INLAIDSECRETARY", "IRON",
            "JAIL", "JAR", "JEWELRYBOX", "JOURNAL", "JUG",
            "KEROSENETABLELAMP", "KETTLE", "KEVEK", "KEY", "KEYS", "KNIFE",
            "LADDER", "LAMP", "LAMPPOST", "LAMPSTREET", "LANTERN", "LEDGER", "LETTER", "LETTERBOX", "LOCKBOX_LRG", "LOCKBOX_MED", "LOCKBOX_SML", "LOOTABLECRATE", "LOVESEAT", "LUMBER",
            "MALLET", "MAP", "MATCHES", "MEDBED", "MEDICINE", "MEDICINECHEST", "MIRROR", "MOLD", "MUG",
            "NAILBOX", "NBMCHINACABINET", "NBMNIGHTSTAND", "NEEDLE", "NEWSPAPER", "NEWSPAPERROLL", "NEWSPAPERSTACK", "NIGHTSTAND", "NIGHTSTANDSIX", "NIGHTSTANDWINTER",
            "OIL", "OILLAMP", "OUTHOUSE",
            "PACKAGE", "PAINTING", "PALLET", "PAN", "PAPER", "PEANUTS", "PEDESTAL", "PEN", "PENCIL", "PEPPER", "PIANO", "PIANOCHAIR", "PICKLEDEGGS", "PIE", "PILLOW", "PIPE", "PITCHER", "PITCHFORK", "PLATE", "PODIUM", "POT", "POTATO", "POTFERNBALCONY", "POWDERHORN", "PRIVATELOUNGE_CHAIR",
            "RACK", "RAG", "RAKE", "REGISTER", "RHOSALOONBOOTHSEAT", "ROCKINGCHAIR",
            "SACK", "SADDLE_TANK", "SADDLESTAND", "SAFE", "SANDWICHBOARD", "SCARECROW", "SEATBENCH", "SEATSNORPASS01", "SEATSNORPASS", "SEATSNORPASS02", "SEATSNORPASS03", "SEATSNORPASS_UPPER", "SETTEE", "SEWINGMACHINE", "SHAKER", "SHARPENINGSTONE", "SHAVINGBOX", "SHELF", "SHOE", "SHOTGLASS", "SHOVEL", "SIDEBOARD", "SIDETABLE", "SIGN", "SINGLEBRASSBED", "SINK", "SIS_FRONTGATEB", "SIT_CHAIRWICKER", "SKELREMALLIGATOR", "SKELREMBIRD", "SKELREMBOVID", "SKELREMBUFFALO", "SKELREMBULL", "SKELREMCANIFORM", "SKELREMCERVIDAE", "SKELREMDOG", "SKELREMEQUINE", "SKELREMFELINE", "SKELREMFISHLARGE", "SKELREMRAT", "SKELREMRODENT", "SKELREMSUIDAE", "SLEDGEHAMMER", "SNIFTING_VALVE", "SOAP", "SOFA", "SPIKE", "SPITTOON", "SPOOL", "SPOON", "STAMP", "STATUE", "STEAMER_TRUNK", "STERILECABINET", "STILL", "STOOL", "STOOLCOMFY", "STOOLFOLDING", "STOOLWINTER", "STOVE", "STRONGBOX", "STRONGBOX_MUDDY", "STRONGBOX_RUSTED", "STRONGBOX_SNOW", "STRONGBOX_WATERLOGGED", "STRONGBOXSM", "STRONGBOXSM_MUDDY", "STRONGBOXSM_RUSTED", "STRONGBOXSM_WATERLOG", "STUMP", "STUMPWOODSPLIT", "SUITCASE", "SYRINGE",
            "TABLE", "TABLEANNSALOON", "TABLEBEDSIDE", "TABLEBRA", "TABLECOFFEE", "TABLECONSOLE", "TABLEPREP", "TABLEWORK", "TANK", "TARP", "TEACART", "TEATRAY", "TENTARMYPUP", "THEATERCHAIR", "TINCAN", "TNT", "TOBACCOTIN", "TOILET", "TOOLBOX", "TOOLSHED", "TRAP", "TRASHBIN", "TRAVELTRUNK", "TRAY", "TROLLEYMAILDESK", "TRUNK", "TRUNKVAR", "TUB",
            "UMBRELLA", "URN",
            "VANITY", "VASE",
            "WAGON", "WAGONWHEEL", "WALNUTHUTCH", "WASHBASINREGAL", "WASHBOARD", "WASHSTAND", "WATER", "WATERBUCKET", "WATERPUMP", "WATERTROUGH", "WEDDINGCHEST", "WELL", "WHEELBARROW", "WHISTLE", "WIN_JTL_DIRTY",
            "WINDSORBENCH", "WINDSORCHAIR", "WNT4_DRWDBL", "WOODBENCH", "WOODBOWL", "WOODENCHAIR", "WOODENDESKCHAIR", "WOODPILE", "WORKBENCH", "WORKBENCHDESK", "WRAPPEDMEAT", "WRITINGDESK",
            "YARROW",
        }
        for k, name in pairs(name_list) do
            ModelSearch(name)
            Citizen.Wait(5)
            ModelSearch('P_' .. name)
            Citizen.Wait(5)
            ModelSearch('P_' .. name .. '_')
            Citizen.Wait(5)
            ModelSearch('P_GEN_' .. name) -- Double Check accuracy
            Citizen.Wait(5)
            ModelSearch('P_GEN_' .. name .. '_') -- Double Check accuracy
            Citizen.Wait(5)
            ModelSearch('P_CS_' .. name)
            Citizen.Wait(5)
            ModelSearch('P_CS_' .. name .. '_')
            Citizen.Wait(5)
            ModelSearch('S_' .. name)
            Citizen.Wait(5)
            ModelSearch('S_' .. name .. '_')
            Citizen.Wait(5)
            ModelSearch('S_INV_' .. name)
            Citizen.Wait(5)
            ModelSearch('S_INV_' .. name .. '_')
            Citizen.Wait(5)
        end
    end)
end)

RegisterCommand('current_test', function(source, args, rawCommand)
    Citizen.InvokeNative(0xB8C984C0D47F4F07, -0.297, 0.352, 0)
    Citizen.InvokeNative(0xB8C984C0D47F4F07, -0.297, 0.352, 1)
    Citizen.InvokeNative(0x085C5B61A0114F32, -0.333, 0)
    Citizen.InvokeNative(0xFE7966DF01452F32, 1511.248, 3270.837, -1952.663)
    Citizen.InvokeNative(0x10C1767B93257480, 1521.417, 1273.795, -1962.431)
    Citizen.InvokeNative(0x1FF8731BE1DFC0C0, 0.774, 0.917)
end)
