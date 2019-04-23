guiLanguage.portugues = {
    --
    -- GENERAL STRINGS
    --
    windowHeader = "Handling Editor Evolution v"..HVER.." r"..HREV,
    
    restrictedPassenger = "Você não tem permissão para utilizar o editor de Handling como passageiro.",
    needVehicle = "Você deve estar dirigindo um veículo para usar o editor de Handling!",
    needLogin = "Você deve estar logado para visualizar este menu.",
    needAdmin = "Você deve estar logado como administrador para acessar a este menu.",
    invalidMenu = "Este menu não existe!",
    disabledMenu = "Este menu foi desativado.",
    notifyUpdate = "O editor de Handling foi atualizado desde a última vez que você usou. Gostaria de ver uma lista das alterações agora? \nVocê sempre pode ver a lista de mudanças em 'Extras'> 'Atualizações'",
    notifyUpgrade = "O editor de manipulação foi atualizado. Isso significa que alguns de seus arquivos, como manejos salvos foram alteradas para outro formato. Como resultado, os servidores com uma versão desatualizada do hedit não são totalmente suportados. \nVocê gostaria de ver uma lista das alterações agora? \nVocê sempre pode ver a lista de mudanças em 'Extras'> 'Atualizações'",
    outdatedUpdate = "Este servidor executa uma versão desatualizada do editor de Handling. Como resultado, alguns recursos podem estar faltando. \nPor favor, contate um administrador.",
    outdatedUpgrade = "Este servidor executa uma versão extremamente desatualizada do editor de Handling. Como resultado, todas as definições / configurações de Handling salvos são incompatíveis. \nPor favor, contate um administrador.",
    mtaUpdate = "Se você tiver alguma Handlings guardados no MTA 1.1, os Handlings não são mais compatíveis, visite 'http://hedit.googclecode.com/' para obter detalhes.",
    
    sameValue = "O valor ja esta definido como este!",
    exceedLimits = "O Valor usado não é permitido por passar dos limites. [%s]!",
    cantSameValue = "%s não pode ser o mesmo que %s!",
    needNumber = "Você deve usar um número!",
    unsupportedProperty = "%s não é uma propriedade suportada.",
    successRegular = "%s definido para %s.",
    successHex = "%s %s.",
    unableToChange = "Não é possível definir o %s para %s!",
	disabledProperty = "Edição %s esta desabilitada pelo Server Evolution!",
    
    resetted = "Sucesso em redefinir as configurações de Handling do veículo!",
    loaded = "Sucesso em carregar susas configurações de Handling!",
    imported = "Sucesso em importar seus configurações de Handling!",
    invalidImport = "Falha na Importação; Os Dados fornecido por você são invalidos!",
    invalidSave = "Por favor, forneça um nome e uma descrição válida para salvar os dados de Handling deste veículo!",
    
    confirmReplace = "Tem certeza que você gostaria de substituir os save existentes?",
    confirmLoad = "Tem certeza que você gostaria de carregar essas configurações de Handling? Quaisquer alterações não salvas serão perdidas!",
    confirmDelete = "Tem certeza de que deseja excluir essas configurações de Handling?",
    confirmReset = "Tem certeza que você gostaria de redefinir a sua Handling? Quaisquer alterações não salvas serão perdidas!",
    confirmImport = "Tem certeza que você gostaria de importar esta Handling? Quaisquer alterações não salvas serão perdidas!",

    successSave = "Salvo com sucesso as configurações de Handling!",
    successLoad = "Carregado com êxito as suas definições de Handling!",
    
	confirmVersionReset = "Tem a certeza que pretende definir o número da versão do editor deste servidor? Seus Handlings salvos podem se tornar incompatíveis.",
	successVersionReset = "A versão do seu editor foi atualizado.",
    wantTheSettings = "Tem certeza que você gostaria de aplicar essas configurações? O editor de Handling será reiniciado.",
    
    vehicle = "Veículo",
    unsaved = "Não Salvo",
    
    clickToEdit = "Click para editar.",
    enterToSubmit = "Aperte Enter para confirmar.",
    clickToViewFullLog = "Clique para ver o log veículo completo.",
    copiedToClipboard = "As definições de Handling foram copiados para o clipboard! (crtl + V)",
    
    special = {
        commode = {
            "Divisão",
            "Mesclado"
        }
    },
    
    --
    -- BUTTON / MENU STRINGS
    --
    
    --Warning level strings
    warningtitles = {
        info = "Informação",
        question = "Pergunta",
        warning = "Perigo!",
        ["error"] = "Erro!"
    },
    --Strings for the buttons at the top
    utilbuttons = {
        handling = "Handling",
        tools = "Ferramentas",
        extra = "Extras",
        close = "X"
    },

    --Strings for the buttons at the right
    menubuttons = {
        engine = "Motor",
        body = "Corpo",
        wheels = "Rodas",
        appearance = "Aparência",
        modelflags = "Modelo \nBandeiras",
        handlingflags = "Handling\nBandeiras",
        dynamometer = "Avaliar",
        help = "Ajuda"
    },
    
    --Strings for the various menus of the editor. Empty strings are placeholder to avoid debug as the debug is meant to show items which are missing text.
    menuinfo = {
        engine = {
            shortname = "Motor",
            longname = "Configurações de Motor"
        },
        body = {
            shortname = "Corpo",
            longname = "Configurações do Corpor e Suspensão"
        },
        wheels = {
            shortname = "Rodas",
            longname = "Configurações das Rodas"
        },
        appearance = {
            shortname = "Aparência",
            longname = "Configurações de Aparência"
        },
        modelflags = {
            shortname = "Modelo",
            longname = "Configurações do Modelo do Veículo"
        },
        handlingflags = {
            shortname = "Handling Bandeiras",
            longname = "Configurações Especiais de Handling"
        },
        dynamometer = {
            shortname = "Teste",
            longname = "Iniciar o teste de dinamômetro"
        },
        help = {
            shortname = "Ajuda e Informações",
            longname = "Ajuda",
            itemtext = {
                textlabel = "Bem-vindo ao editor oficial de Handling Evolution Server MTA! Este recurso permite que você edite a movimentação de qualquer veículo no jogo em tempo real. \n"..
                            "Você pode salvar e carregar Handlings personalizados que você faz, através do menu 'Handling' no canto superior direito. \n"..
                            "Para mais informações sobre este editor de Handling, como o changelog oficial, visite: \n",
                websitebox = "http://hedit.googlecode.com/",
                morelabel = "Obrigado por escolher o Evolution Server, Quaisquer duvida acesse: evolserver.com!"
            }
        },
        reset = {
            shortname = "Resetar",
            longname = "Redefinir as configurações de Handling deste veículo.",
            itemtext = {
                label = "Veículo de base:",
                combo = "-----",
                button = "Resetar"
            }
        },
        save = {
            shortname = "Salvar",
            longname = "Salvar as configurações de Handling deste veículo",
            itemtext = {
                nameLabel = "Nome",
                descriptionLabel = "Descrição",
                button = "Salvar",
                grid = "",
                nameEdit = "",
                descriptionEdit = ""
            }
        },
        load = {
            shortname = "Carregar",
            longname = "Carregar uma Configuração salva de Handling nesse veículo",
            itemtext = {
                button = "Carregar",
                grid = ""
            }
        },
        import = {
            shortname = "Importar",
            longname = "Importar uma linha de configurações em formato handling.cfg.",
            itemtext = {
                button = "Importar",
                III = "GTA III",
                VC = "GTA VC",
                SA = "GTA SA",
                IV = "GTA IV",
                memo = ""
            }
        },
        export = {
            shortname = "Exportar",
            longname = "Exportar as configurações de Handling em formato handling.cfg.",
            itemtext = {
                button = "Copiar para o Clipboard. (Ctrl + V)",
                memo = ""
            }
        },
        get = {
            shortname = "Obter",
            longname = "Obter linhas as configurações de outro jogador."
        },
        share = {
            shortname = "Compartilhar",
            longname = "Compartilhe suas configurações de Handling com outro jogador."
        },
        upload = {
            shortname = "Upload",
            longname = "Upload sua Handling para o Evolution Server."
        },
        download = {
            shortname = "Baixar (Download)",
            longname = "Baixar um conjunto de Handling do Evolution Server."
        },
        
        resourcesave = {
            shortname = "Recurso Salvo.",
            longname = "Salva sua Handling no Recurso."
        },
        resourceload = {
            shortname = "Recurso Carregado",
            longname = "Carrega sua Handling do Recurso."
        },
        options = {
            shortname = "Opções",
            longname = "Opções",
            itemtext = {
                label_key = "Alterar Chave",
                label_cmd = "Alterar Comando:",
                label_template = "Modelo GUI (janela):",
                label_language = "Linguagem:",
                label_commode = "Centro De modo de edição em massa:",
                checkbox_versionreset = "Downgrade meu número da versão do %s para %s?",
                button_save = "Aplicar",
                combo_key = "",
                combo_template = "",
                edit_cmd = "",
                combo_commode = "",
                combo_language = "",
				checkbox_lockwhenediting = "Bloqueio do veículo durante a edição?"
            }
        },
        administration = {
            shortname = "Administração",
            longname = "Ferramentas de Administração."
        },
        handlinglog = {
            shortname = "Handling Log",
            longname = "Log de ​​mudanças recentes para lidar com configurações.",
            itemtext = {
                logpane = ""
            }
        },
        updatelist = {
            shortname = "Atualizações",
            longname = "Lista de atualizações recentes.",
            itemtext = {
                scrollpane = ""
            }
        },
        mtaversionupdate = {
            shortname = "Atualização do MTA",
            longname = "Multi Theft Auto foi atualizado com sucesso!",
            itemtext = {
                infotext = "Multi Theft Auto foi atualizado. Devido a isso, seus manejos salvos na versão anterior não são mais compatíveis. Por favor, visite o link abaixo para ajudar e obter os seus manejos de volta.",
                websitebox = "http://hedit.googlecode.com/"
            }
        }
    },
    
    --
    --NOTE: 12/17/2011 This section is pending review for typos and grammar.
    --
    handlingPropertyInformation = { 
        ["identifier"] = {
            friendlyName = "Identificador veículo",
            information = "Isto representa o identificador de veículo a ser utilizado em handling.cfg.",
            syntax = { "corda", "Só use identificadores válidos, caso contrário não vai funcionar exportação." }
        },
        ["mass"] = {
            friendlyName = "Massa",
            information = "Define o peso do seu veículo em KG.",
            syntax = { "Flutuar", "Lembre-se de mudar o 'Transformar Massa' primeiro para evitar saltar!" }
        },
        ["turnMass"] = {
            friendlyName = "Transformar Massa",
            information = "Usados ​​para calcular os efeitos do movimento.",
            syntax = { "Flutuar", "Valores mais altos fazem o seu veículo um pouco mais 'flutuante'." }
        },
        ["dragCoeff"] = {
            friendlyName = "Multiplicador de Arraste",
            information = "Variações de resistência ao movimento.",
            syntax = { "Flutuar", "Quanto maior o valor, menor será a sua velocidade máxima terá." }
        },
        ["centerOfMass"] = {
            friendlyName = "Centro de massa",
            information = "Define o ponto de gravidade do seu veículo, em metros.",
            syntax = { "Flutuar", "Pairar X, Y ou Z para obter informações." }
        },
        ["centerOfMassX"] = {
            friendlyName = "Centro da massa em X",
            information = "Define a distância frente-traseira do centro de massa em metros.",
            syntax = { "Flutuar", "Os valores mais altos são os valores para a parte inferior dianteira à parte traseira." }
        },
        ["centerOfMassY"] = {
            friendlyName = "Centro da massa em Y",
            information = "Define a distância esquerda-direita do centro de massa em metros.",
            syntax = { "Flutuar", "Os valores mais altos são os valores mais baixos para a direita e da esquerda." }
        },
        ["centerOfMassZ"] = {
            friendlyName = "Centro da massa em Z",
            information = "Define a altura do centro de massa em metros.",
            syntax = { "Flutuar", "Quanto maior for o valor, maior será o ponto." }
        },
        ["percentSubmerged"] = {
            friendlyName = "por cento submerso",
            information = "Define o quão profundo o seu veículo precisa estar na água antes que ele irá flutuar em porcentagem.",
            syntax = { "Totalidade", "Os valores mais altos fará com que o seu veículo flutuando mais profundo." }
        },
        ["tractionMultiplier"] = {
            friendlyName = "Multiplicador de tração",
            information = "Define a quantidade de aderência de seu veículo terá nas curvas.",
            syntax = { "Flutuar", "Os valores mais altos fará com que seu veículo tenha mais aderência." }
        },
        ["tractionLoss"] = {
            friendlyName = "Perda de tração",
            information = "Define a quantidade de aderência de seu veículo terá quando aceleração e desaceleração.",
            syntax = { "Flutuar", "Os valores mais altos fará com que seus cantos cortados veículo melhor." }
        },
        ["tractionBias"] = {
            friendlyName = "Viés de tração",
            information = "Define onde toda a aderência de suas rodas vão para.",
            syntax = { "Flutuar", "Os valores mais altos irá definir o viés mais para a frente." }
        },
        ["numberOfGears"] = {
            friendlyName = "Número de engrenagens",
            information = "Define o número de engrenagens que você deseja ter em seu veículo.",
            syntax = { "Totalidade", "Não tem efeito sobre a velocidade máxima ou aceleração." }
        },
        ["maxVelocity"] = {
            friendlyName = "Velocidade Máxima",
            information = "Define a velocidade máxima do seu veículo em KM/H.",
            syntax = { "Flutuar", "Afetado por outras propriedades." }
        },
        ["engineAcceleration"] = {
            friendlyName = "Aceleração",
            information = "Define a aceleração do seu ceículo em MS^2.",
            syntax = { "Flutuar", "Os valores mais elevados irá aumentar a taxa de aceleração do veículo." }
        },
        ["engineInertia"] = {
            friendlyName = "Inércia",
            information = "Suaviza ou aguça a curva de aceleração.",
            syntax = { "Flutuar", "Valores mais altos fazem a curva de aceleração mais suave." }
        },
        ["driveType"] = {
            friendlyName = "Tipo de direção",
            information = "Define que as rodas serão utilizados durante a condução.",
            syntax = { "corda", "Escolhendo 'Todas as rodas' resultará no veículo sendo mais fácil de controlar." },
            options = { ["f"]="Rodas da Frontais",["r"]="Rodas Traseiras",["4"]="Todas as Rodas" }
        },
        ["engineType"] = {
            friendlyName = "Tipo de Motor",
            information = "Define o tipo de motor para o seu veículo.",
            syntax = { "corda", "Define qual sera a fonte de energia de seu veículo" },
            options = { ["p"]="Gasolina",["d"]="Diesel",["e"]="Eletrico" }
        },
        ["brakeDeceleration"] = {
            friendlyName = "Desaceleração freio",
            information = "Define sua desaceleração em MS^2.",
            syntax = { "Flutuar", "Os valores mais altos fará com que o mais forte travagem, mas pode escorregar se sua tração é muito baixo." }
        },
        ["brakeBias"] = {
            friendlyName = "Freio Viés",
            information = "Define a posição principal dos freios.",
            syntax = { "Flutuar", "Os valores mais altos vão colocar o viés mais para a frente." }
        },
        ["ABS"] = {
            friendlyName = "ABS",
            information = "Enable or disable ABS on your vehicle.",
            syntax = { "Bool", "No effect." },
            options = { ["ativar"]="Ativa",["desativar"]="Desativa" }
        },
        ["steeringLock"] = {
            friendlyName = "Direcção travar",
            information = "Define o ângulo máximo de seu veículo pode dirigir.",
            syntax = { "Flutuar", "Ângulo de direção fica menor quanto mais rápido você ir." }
        },
        ["suspensionForceLevel"] = {
            friendlyName = "Suspensão nível de força",
            information = "Nenhum Efeito.",
            syntax = { "Flutuar", "Nada." }
        },
        ["suspensionDamping"] = {
            friendlyName = "Amortecimento da suspensão",
            information = "Nenhum Efeito.",
            syntax = { "Flutuar", "Nada." }
        },
        ["suspensionHighSpeedDamping"] = {
            friendlyName = "Suspensão de amortecimento de alta velocidade",
            information = "Define a sua suspensão mais dura vai ser quando a condução mais rápida.",
            syntax = { "Flutuar", "não testado" } -- HERE
        },
        ["suspensionUpperLimit"] = {
            friendlyName = "Suspensão limite superior",
            information = "Movimento superior de rodas em metros.",
            syntax = { "Flutuar", "não testado" } -- HERE
        },
        ["suspensionLowerLimit"] = {
            friendlyName = "Suspensão Limite Inferior",
            information = "A altura da sua suspensão.",
            syntax = { "Flutuar", "Os valores mais baixos vão fazer o seu veículo maior." }
        },
        ["suspensionFrontRearBias"] = {
            friendlyName = "Viés de suspensão",
            information = "Define onde a maior parte do poder de suspensão vai para.",
            syntax = { "Flutuar", "Os valores mais altos vão colocar o viés mais para a frente." }
        },
        ["suspensionAntiDiveMultiplier"] = {
            friendlyName = "Suspensão Anti Multiplicador Mergulho",
            information = "Altera a quantidade de arremesso corpo em travagem e aceleração.",
            syntax = { "Flutuar", "" }
        },
        ["seatOffsetDistance"] = {
            friendlyName = "Assento Distância de offset",
            information = "Define o quanto o banco é da porta do seu veículo.",
            syntax = { "Flutuar", "" }
        },
        ["collisionDamageMultiplier"] = {
            friendlyName = "multiplicador de dano",
            information = "Define o dano que seu veículo vai começar a partir de colisões.",
            syntax = { "Flutuar", "" }
        },
        ["monetary"] = {
            friendlyName = "Monetary Value",
            information = "Sets the exact price of your vehicle.",
            syntax = { "Integer", "" }
        },
        ["modelFlags"] = {
            friendlyName = "Model Flags",
            information = "Special animations features of the which can be enabled or disabled.",
            syntax = { "Hexadecimal", "" },
            items = {
                {
                    ["1"] = {"IS_VAN","Allows double doors for the rear animation."},
                    ["2"] = {"IS_BUS","Vehicle uses bus stops and will try to take on passengers."},
                    ["4"] = {"IS_LOW","Drivers and passengers sit lower and lean back."},
                    ["8"] = {"IS_BIG","Changes the way that the AI drives around corners."}
                },
                {
                    ["1"] = {"REVERSE_BONNET","Bonnet and boot open in opposite direction from normal."},
                    ["2"] = {"HANGING_BOOT","Boot opens from top edge."},
                    ["4"] = {"TAILGATE_BOOT","Boot opens from bottom edge."},
                    ["8"] = {"NOSWING_BOOT","Boot does not open."}
                },
                {
                    ["1"] = {"NO_DOORS","Door open and close animations are skipped."},
                    ["2"] = {"TANDEM_SEATS","Two people will use the front passenger seat."},
                    ["4"] = {"SIT_IN_BOAT","Uses seated boat animation instead of standing."},
                    ["8"] = {"CONVERTIBLE","Changes how hookers operate and other small effects."}
                },
                {
                    ["1"] = {"NO_EXHAUST","Removes all exhaust particles."},
                    ["2"] = {"DBL_EXHAUST","Adds a second exhaust particle on opposite side to first."},
                    ["4"] = {"NO1FPS_LOOK_BEHIND","Prevents player using rear view when in first-person mode."},
                    ["8"] = {"FORCE_DOOR_CHECK","Needs testing."}
                },
                {
                    ["1"] = {"AXLE_F_NOTILT","Front wheels stay vertical to the car like GTA 3."},
                    ["2"] = {"AXLE_F_SOLID","Front wheels stay parallel to each other."},
                    ["4"] = {"AXLE_F_MCPHERSON","Front wheels tilt like GTA Vice City."},
                    ["8"] = {"AXLE_F_REVERSE","Reverses the tilting of wheels when using AXLE_F_MCPHERSON suspension."}
                },
                {
                    ["1"] = {"AXLE_R_NOTILT","Rear wheels stay vertical to the car like GTA 3."},
                    ["2"] = {"AXLE_R_SOLID","Rear wheels stay parallel to each other."},
                    ["4"] = {"AXLE_R_MCPHERSON","Rear wheels tilt like GTA Vice City."},
                    ["8"] = {"AXLE_R_REVERSE","Reverses the tilting of wheels when using AXLE_R_MCPHERSON suspension."}
                },
                {
                    ["1"] = {"IS_BIKE","Use extra handling settings in the bikes section."},
                    ["2"] = {"IS_HELI","Use extra handling settings in the flying section."},
                    ["4"] = {"IS_PLANE","Use extra handling settings in the flying section."},
                    ["8"] = {"IS_BOAT","Use extra handling settings in the flying section."}
                },
                {
                    ["1"] = {"BOUNCE_PANELS","Needs testing."},
                    ["2"] = {"DOUBLE_RWHEELS","Places a second instance of each rear wheel next to the normal one."},
                    ["4"] = {"FORCE_GROUND_CLEARANCE","Needs testing."},
                    ["8"] = {"IS_HATCHBACK","Needs testing."}
                }
            }
        },
        ["handlingFlags"] = {
            friendlyName = "Handling Flags",
            information = "Special performance features.",
            syntax = { "Hexadecimal", "" },
            items = {
                {
                    ["1"] = {"1G_BOOST","Gives more engine power for standing starts; better hill climbing."},
                    ["2"] = {"2G_BOOST","Gives more engine power at slightly higher speeds."},
                    ["4"] = {"NPC_ANTI_ROLL","No body roll when driven by AI characters."},
                    ["8"] = {"NPC_NEUTRAL_HANDL","Less likely to spin out when driven by AI characters."}
                },
                {
                    ["1"] = {"NO_HANDBRAKE","Disables the handbrake effect."},
                    ["2"] = {"STEER_REARWHEELS","Rear wheels steer instead of front, like a forklift truck."},
                    ["4"] = {"HB_REARWHEEL_STEER","Handbrake makes the rear wheels steer as well as front, like the monster truck"},
                    ["8"] = {"ALT_STEER_OPT","Needs testing."}
                },
                {
                    ["1"] = {"WHEEL_F_NARROW2","Very narrow front wheels."},
                    ["2"] = {"WHEEL_F_NARROW","Narrow front wheels."},
                    ["4"] = {"WHEEL_F_WIDE","Wide front wheels."},
                    ["8"] = {"WHEEL_F_WIDE2","Very wide front wheels."}
                },
                {
                    ["1"] = {"WHEEL_R_NARROW2","Very narrow rear wheels."},
                    ["2"] = {"WHEEL_R_NARROW","Narrow rear wheels."},
                    ["4"] = {"WHEEL_R_WIDE","Wide rear wheels."},
                    ["8"] = {"WHEEL_R_WIDE2","Very wide rear wheels."}
                },
                {
                    ["1"] = {"HYDRAULIC_GEOM","Needs testing."},
                    ["2"] = {"HYDRAULIC_INST","Will spawn with hydraulics installed."},
                    ["4"] = {"HYDRAULIC_NONE","Hydraulics cannot be installed."},
                    ["8"] = {"NOS_INST","Vehicle automatically gets NOS installed when it spawns."}
                },
                {
                    ["1"] = {"OFFROAD_ABILITY","Vehicle will perform better on loose surfaces like dirt."},
                    ["2"] = {"OFFROAD_ABILITY2","Vehicle will perform better on soft surfaces like sand."},
                    ["4"] = {"HALOGEN_LIGHTS","Makes headlights brighter and more blue."},
                    ["8"] = {"PROC_REARWHEEL_1ST","Needs testing."}
                },
                {
                    ["1"] = {"USE_MAXSP_LIMIT","Prevents vehicle going faster than the maximum speed."},
                    ["2"] = {"LOW_RIDER","Allows vehicle to be modified at Loco Low Co shops."},
                    ["4"] = {"STREET_RACER","When set, vehicle can only be modified at Wheel Arch Angels."},
                    ["8"] = {"UNDEFINED","No effect."}
                },
                {
                    ["1"] = {"SWINGING_CHASSIS","Lets the car body move from side to side on the suspension."},
                    ["2"] = {"UNDEFINED","No effect."},
                    ["4"] = {"UNDEFINED","No effect."},
                    ["8"] = {"UNDEFINED","No effect."}
                }
            }
        },
        ["headLight"] = {
            friendlyName = "Head Lights",
            information = "Sets the type of front lights your vehicle will have.",
            syntax = { "Integer", "" },
            options = { ["0"]="Long",["1"]="Small",["2"]="Big",["3"]="Tall" }
        },
        ["tailLight"] = {
            friendlyName = "Tail Lights",
            information = "Sets the type of rear lights your vehicle will have.",
            syntax = { "Integer", "" },
            options = { ["0"]="Long",["1"]="Small",["2"]="Big",["3"]="Tall" }
        },
        ["animGroup"] = {
            friendlyName = "Animation Group",
            information = "Sets the group of animation your ped will use for it's vehicle.",
            syntax = { "Integer", "" }
        }
    }
}