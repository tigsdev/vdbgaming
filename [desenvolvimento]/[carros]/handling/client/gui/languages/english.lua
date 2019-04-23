guiLanguage.english = {
    --
    -- GENERAL STRINGS
    --
    windowHeader = "Handling Br by #Lucas",
    
    restrictedPassenger = "Você não tem permissão de usar o editor-ação como um passageiro.",
    needVehicle = "Você deve estar dirigindo um veículo para usar o editor de manipulação!",
    needLogin = "Você precisa estar logado para ver este menu.",
    needAdmin = "Você deve estar logado como administrador para aceder a este menu.",
    invalidMenu = "Este menu não existe!",
    disabledMenu = "Este menu foi desativado.",
    notifyUpdate = "O editor de manipulação foi atualizado desde a última vez que você usou. Gostaria de ver uma lista das alterações agora? \ n Você sempre pode ver a lista de mudanças em 'Extras'> 'Atualizações'",
    notifyUpgrade = "O editor de manipulação foi atualizado. Isso significa que alguns de seus arquivos, como manejos salvos foram alteradas para outro formato. Como resultado, os servidores com uma versão desatualizada do hedit não são totalmente suportados. \ NVocê gostaria de ver uma lista das alterações agora? \ n Você sempre pode ver a lista de mudanças em 'Extras'> 'Atualizações'",
    outdatedUpdate = "Este servidor executa uma versão desactualizada do editor manuseio. Como resultado, alguns recursos podem estar faltando. \ NPor favor, contate um administrador.",
    outdatedUpgrade = "Este servidor executa uma versão extremamente desatualizada do editor manuseio. Como resultado, todas as definições / configurações de manuseio salvos são incompatíveis. \ NPor favor, contate um administrador.",
    mtaUpdate = "If you have any saved handlings on MTA 1.1, your handlings are no longer compatible; please visit 'http://hedit.googclecode.com/' for details.",
    sameValue = "O% s é que já!",
    exceedLimits = "Valor utilizado em% s excede o limite. [%s]!",
    cantSameValue = "% s não pode o mesmo que% s!",
    needNumber = "Você deve usar um número!",
    unsupportedProperty = "% s não é uma propriedade suportada.",
    successRegular = "set% s para% s.",
    successHex = "%s %s.",
    unableToChange = "Não é possível definir o% s para% s!",
	disabledProperty = "Editar% s está desativada neste servidor!",
    
    resetted = "Reiniciada com sucesso as configurações de manuseio do veículo!",
    loaded = "Carregado com êxito as suas definições de manipulação!",
    imported = "Importados com êxito as configurações de manuseio!",
    invalidImport = "Importação falhou; tratamento dos dados que você forneceu é inválido!",
    invalidSave = "Por favor, forneça um nome e uma descrição válida para salvar os dados de manuseio deste veículo!",
    
    confirmReplace = "Tem certeza que você gostaria de substituir os existentes save?",
    confirmLoad = "Tem certeza que você gostaria de carregar essas configurações de manipulação? Quaisquer alterações não salvas serão perdidas!",
    confirmDelete = "Tem certeza de que deseja excluir essas configurações de manipulação?",
    confirmReset = "Tem certeza que você gostaria de redefinir a sua manipulação? Quaisquer alterações não salvas serão perdidas!",
    confirmImport = "Tem certeza que você gostaria de importar esta manipulação? Quaisquer alterações não salvas serão perdidas!",

    successSave = "Salvo com sucesso suas configurações de manuseio!",
    successLoad = "Carregado com êxito as suas definições de manipulação!",
    
	confirmVersionReset = "Tem a certeza que pretende definir o número da versão do editor de um deste servidor? Seus manejos salvos podem se tornar incompatíveis.",
	successVersionReset = "A versão do seu editor foi atualizado.",
    wantTheSettings = "Tem certeza que você gostaria de aplicar essas configurações? O editor de manipulação será reiniciado.",
    
    vehicle = "Veículo.",
    unsaved = "não salvo",
    
    clickToEdit = "Clique para editar.",
    enterToSubmit = "Pressione Enter para confirmar.",
    clickToViewFullLog = "Clique para ver o log veículo completo.",
    copiedToClipboard = "As definições de manipulação foram copiados para o clipboard!",
    
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
        info = "Informações",
        question = "Pergunta",
        warning = "Aviso!",
        ["error"] = "Erro!"
    },
    --Strings for the buttons at the top
    utilbuttons = {
        handling = "Handling",
        tools = "Ferramentas",
        extra = "Extra",
        close = "X"
    },

    --Strings for the buttons at the right
    menubuttons = {
        engine = "Motor",
        body = "Corpo",
        wheels = "Rodas",
        appearance = "Aparência",
        modelflags = "Modelo\Flags",
        handlingflags = "Manuseio\nFlags",
        dynamometer = "Dyno",
        help = "Ajudar"
    },
    
    --Strings for the various menus of the editor. Empty strings are placeholder to avoid debug as the debug is meant to show items which are missing text.
    menuinfo = {
        engine = {
            shortname = "Motor",
            longname = "Configurações de motor"
        },
        body = {
            shortname = "Corpo",
            longname = "Configurações de suspensão do Corpo"
        },
        wheels = {
            shortname = "Rodas",
            longname = "Configurações de rodas"
        },
        appearance = {
            shortname = "Aparência",
            longname = "Configurações de Aparência"
        },
        modelflags = {
            shortname = "Flags modelo",
            longname = "Veículo Configurações Modelo"
        },
        handlingflags = {
            shortname = "Manipulação de Bandeiras",
            longname = "Configurações de tratamento especial"
        },
        dynamometer = {
            shortname = "Dyno",
            longname = "Iniciar dinamômetro"
        },
        help = {
            shortname = "Ajuda e Informações",
            longname = "Ajudar",
            itemtext = {
                textlabel = "Bem-vindo ao editor oficial manuseio mta! Este recurso permite que você edite a movimentação de qualquer veículo no jogo em tempo real. \ N"..
                            "Você pode salvar e carregar manejos personalizados que você faz, através do menu 'Handling' no canto superior direito. \ N"..
                            "Para mais informações sobre este editor de manipulação, como o changelog oficial, visite: \ n",
                websitebox = "http://hedit.googlecode.com/",
                morelabel = "Obrigado por escolher hedit!"
            }
        },
        reset = {
            shortname = "Restabelecer",
            longname = "Redefinir as configurações de manuseio deste veículo.",
            itemtext = {
                label = "Veículo de base:",
                combo = "-----",
                button = "Restabelecer"
            }
        },
        save = {
            shortname = "Salvar",
            longname = "Salve as configurações de manuseio deste veículo.",
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
            longname = "Carregar um conjunto de configurações de manuseio.",
            itemtext = {
                button = "Carregar",
                grid = ""
            }
        },
        import = {
            shortname = "Importar",
            longname = "Importar uma linha de tratamento em formato handling.cfg.",
            itemtext = {
                button = "Importar",
                III = "III",
                VC = "VC",
                SA = "SA",
                IV = "IV",
                memo = ""
            }
        },
        export = {
            shortname = "Exportar",
            longname = "Exportar as configurações de manuseio em formato handling.cfg.",
            itemtext = {
                button = "Copiar para o Clipboard",
                memo = ""
            }
        },
        get = {
            shortname = "Obter",
            longname = "Obter lidar com as configurações de outro jogador."
        },
        share = {
            shortname = "Share",
            longname = "Compartilhe suas configurações de manuseio com outro jogador."
        },
        upload = {
            shortname = "Carregar",
            longname = "Publique as suas configurações de manuseio para o servidor."
        },
        download = {
            shortname = "Baixar",
            longname = "Baixe um conjunto de manipulação configurações do servidor."
        },
        
        resourcesave = {
            shortname = "Save recurso",
            longname = "Salve o seu manuseio a um recurso."
        },
        resourceload = {
            shortname = "Carga de recursos",
            longname = "Carregar uma manipulação de um recurso."
        },
        options = {
            shortname = "Opções",
            longname = "Opções",
            itemtext = {
                label_key = "Alternar chave",
                label_cmd = "Command Alternar:",
                label_template = "GUI modelo:",
                label_language = "Idioma:",
                label_commode = "Centro De modo de edição em massa:",
                checkbox_versionreset = "Downgrade meu número da versão de% s para% s?",
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
            longname = "Ferramentas do Administrador."
        },
        handlinglog = {
            shortname = "Manuseio de toras",
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
            shortname = "MTA Atualização",
            longname = "Multi Theft Auto foi atualizado!",
            itemtext = {
                infotext = "Multi Theft Auto foi atualizado. Devido a isso, os seus manejos salvos na versão anterior não são mais compatíveis. Por favor, visite o link abaixo para ajudar e obter os seus manejos de volta.",
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
            syntax = { "Corda "," Só use identificadores válidos, caso contrário não vai funcionar exportação." }
        },
        ["mass"] = {
            friendlyName = "Massa",
            information = "Define o peso do seu veículo em KG.",
            syntax = { "Flutuar", "Lembre-se de mudar o 'transformar Mass' primeiro para evitar saltar!" }
        },
        ["turnMass"] = {
            friendlyName = "transformar Mass",
            information = "Usados ​​para calcular os efeitos do movimento.",
            syntax = { "Flutuar", "Valores mais altos fazem o seu veículo um pouco mais'flutuante'." }
        },
        ["dragCoeff"] = {
            friendlyName = "Arraste Multiplicador",
            information = "Variações resistência ao movimento.",
            syntax = { "Flutuar", "Quanto maior o valor, menor será a sua velocidade máxima vai ficar." }
        },
        ["centerOfMass"] = {
            friendlyName = "Centro de massa",
            information = "Define o ponto de gravidade do seu veículo, em metros.",
            syntax = { "Flutuar", "Hover X, Y ou Z para obter informações." }
        },
        ["centerOfMassX"] = {
            friendlyName = "Centro de massa X",
            information = "Define a distância frente-traseira do centro de massa em metros.",
            syntax = { "Flutuar", "Os valores mais altos são os valores para a parte inferior dianteira à parte traseira." }
        },
        ["centerOfMassY"] = {
            friendlyName = "Centro de massa Y",
            information = "Define a distância esquerda para a direita do centro de massa em metros.",
            syntax = { "Flutuar", "Os valores mais altos são os valores mais baixos para a direita e a esquerda." }
        },
        ["centerOfMassZ"] = {
            friendlyName = "Centro de massa Z",
            information = "Define a altura do centro de massa em metros.",
            syntax = { "Flutuar", "Quanto maior for o valor, maior será o ponto." }
        },
        ["percentSubmerged"] = {
            friendlyName = "por cento submerso",
            information = "Define o quão profundo o seu veículo precisa estar na água antes que ele irá flutuar em percentagem.",
            syntax = { "NúmeroInteiro", "Os valores mais altos fará com que o seu veículo flutuando mais profundo." }
        },
        ["tractionMultiplier"] = {
            friendlyName = "Multiplicador de tração",
            information = "Define a quantidade de aderência de seu veículo terá nas curvas.",
            syntax = { "Flutuar", "Os valores mais altos fará com que seu veículo tem mais aderência." }
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
            friendlyName = "Número de mudanças",
            information = "Define o número de engrenagens que você quer ter em seu veículo.",
            syntax = { "NúmeroInteiro", "Não tem efeito sobre a velocidade máxima ou aceleração." }
        },
        ["maxVelocity"] = {
            friendlyName = "Velocidade maxima",
            information = "Define a velocidade máxima do veículo em km / h.",
            syntax = { "Flutuar", "Afetado por outras propriedades." }
        },
        ["engineAcceleration"] = {
            friendlyName = "Aceleração",
            information = "Define a aceleração do MS ^ 2 de seu veículo.",
            syntax = { "Flutuar", "Os valores mais elevados irão aumentar a taxa do veículo acelera." }
        },
        ["engineInertia"] = {
            friendlyName = "Inércia",
            information = "Suaviza ou aguça a curva de aceleração.",
            syntax = { "Flutuar", "Valores mais altos fazem a curva de aceleração mais suave." }
        },
        ["driveType"] = {
            friendlyName = "Tipo de unidade",
            information = "Define que as rodas serão utilizados durante a condução.",
            syntax = { "Corda", "escolher 'todas as rodas' resultará em que o veículo sendo mais fácil de controlar." },
            options = { ["f"]="rodas dianteiras",["r"]="rodas traseiras",["4"]="todas as rodas" }
        },
        ["engineType"] = {
            friendlyName = "Tipo de motor",
            information = "Define o tipo de motor para o seu veículo.",
            syntax = { "Corda", "[UNKNOWN]" },
            options = { ["p"]="Gasolina",["d"]="Diesel",["e"]="Elétrico" }
        },
        ["brakeDeceleration"] = {
            friendlyName = "Desaceleração Freio",
            information = "Define sua desaceleração em MS ^ 2.",
            syntax = { "Flutuar", "Os valores mais altos fará com que o mais forte travagem, mas pode escorregar se sua tração é muito baixo." }
        },
        ["brakeBias"] = {
            friendlyName = "Viés de Freio",
            information = "Define a posição principal dos freios.",
            syntax = { "Flutuar", "Os valores mais altos vão colocar o viés mais para a frente." }
        },
        ["ABS"] = {
            friendlyName = "ABS",
            information = "Ativar ou desativar ABS em seu veículo.",
            syntax = { "Bool", "Sem efeito." },
            options = { ["Verdadeiro"]="Ativado",["Falso"]="Inválido" }
        },
        ["steeringLock"] = {
            friendlyName = "Bloqueio de direcção",
            information = "Define o ângulo máximo que o seu veículo pode dirigir.",
            syntax = { "Flutuar", "Ângulo de direção fica menor quanto mais rápido você ir." }
        },
        ["suspensionForceLevel"] = {
            friendlyName = "Suspensão nível de força",
            information = "Efeitos desconhecidos.",
            syntax = { "Flutuar", "Desconhecido." }
        },
        ["suspensionDamping"] = {
            friendlyName = "Amortecimento da suspensão",
            information = "Efeitos desconhecidos.",
            syntax = { "Flutuar", "Desconhecido." }
        },
        ["suspensionHighSpeedDamping"] = {
            friendlyName = "Suspensão de amortecimento de alta velocidade",
            information = "Define a sua suspensão mais dura vai ser quando a condução mais rápida.",
            syntax = { "Flutuar", "NãoTestado" } -- HERE
        },
        ["suspensionUpperLimit"] = {
            friendlyName = "Suspensão limite superior",
            information = "Movimento superior de rodas em metros.",
            syntax = { "Flutuar", "NãoTestado" } -- HERE
        },
        ["suspensionLowerLimit"] = {
            friendlyName = "Suspensão Limite Inferior",
            information = "A altura da sua suspensão.",
            syntax = { "Flutuar", "Os valores mais baixos vão fazer o seu veículo mais alto." }
        },
        ["suspensionFrontRearBias"] = {
            friendlyName = "Viés suspensão",
            information = "Conjuntos onde a maioria do poder suspensão vão para.",
            syntax = { "Flutuar", "Os valores mais altos vão colocar o viés mais para a frente." }
        },
        ["suspensionAntiDiveMultiplier"] = {
            friendlyName = "Suspensão Anti Multiplicador Dive",
            information = "Altera a quantidade de arremesso corpo sob frenagem e aceleração.",
            syntax = { "Flutuar", "" }
        },
        ["seatOffsetDistance"] = {
            friendlyName = "Assento Distância de offset",
            information = "Define o quanto o banco é da porta do seu veículo.",
            syntax = { "Flutuar", "" }
        },
        ["collisionDamageMultiplier"] = {
            friendlyName = "Dano colisao multiplicado",
            information = "Define o dano que seu veículo vai começar a partir de colisões.",
            syntax = { "Flutuar", "" }
        },
        ["monetary"] = {
            friendlyName = "Valor Monetário",
            information = "Define o preço exato do seu veículo.",
            syntax = { "NúmeroInteiro", "" }
        },
        ["modelFlags"] = {
            friendlyName = "Flags modelo",
            information = "Recursos de animações especiais do que pode ser ativado ou desativado.",
            syntax = { "Hexadecimal", "" },
            items = {
                {
                    ["1"] = {"IS_VAN","Permite portas duplas para a animação de trás."},
                    ["2"] = {"IS_BUS","Veículo utiliza paragens de autocarro e vai tentar levar em passageiros."},
                    ["4"] = {"IS_LOW","Motoristas e passageiros se sentar mais baixo e magro."},
                    ["8"] = {"IS_BIG","Muda a maneira que o AI dirige em torno dos cantos."}
                },
                {
                    ["1"] = {"REVERSE_BONNET","Bonnet e bota aberta na direção oposta do normal."},
                    ["2"] = {"HANGING_BOOT","Bota abre de borda superior."},
                    ["4"] = {"TAILGATE_BOOT","Bota abre de borda inferior."},
                    ["8"] = {"NOSWING_BOOT","Bota não abre."}
                },
                {
                    ["1"] = {"NO_DOORS","Porta animações de abertura e fechamento são ignorados."},
                    ["2"] = {"TANDEM_SEATS","Duas pessoas irá utilizar o banco do passageiro da frente."},
                    ["4"] = {"SIT_IN_BOAT","Usa animação barco sentado em vez de estar."},
                    ["8"] = {"CONVERTIBLE","Alterações como prostitutas atuam e outros efeitos pequenos."}
                },
                {
                    ["1"] = {"NO_EXHAUST","Remove todas as partículas de escape."},
                    ["2"] = {"DBL_EXHAUST","Adiciona uma segunda partícula escape no lado oposto ao primeiro.."},
                    ["4"] = {"NO1FPS_LOOK_BEHIND","Impede jogador usando retrovisor quando em modo de primeira pessoa."},
                    ["8"] = {"FORCE_DOOR_CHECK","precisa de testes."}
                },
                {
                    ["1"] = {"AXLE_F_NOTILT","Rodas dianteiras ficar vertical para o carro como GTA 3."},
                    ["2"] = {"AXLE_F_SOLID","As rodas da frente ficar paralelas umas às outras."},
                    ["4"] = {"AXLE_F_MCPHERSON","Rodas dianteiras tilt como GTA Vice City."},
                    ["8"] = {"AXLE_F_REVERSE","nverte a inclinação das rodas quando se utiliza suspensão AXLE_F_MCPHERSON."}
                },
                {
                    ["1"] = {"AXLE_R_NOTILT","Rodas traseiras ficar vertical para o carro como GTA 3."},
                    ["2"] = {"AXLE_R_SOLID","Rodas traseiras ficar paralelos um ao outro."},
                    ["4"] = {"AXLE_R_MCPHERSON","Rodas traseiras tilt como GTA Vice City."},
                    ["8"] = {"AXLE_R_REVERSE","Inverte a inclinação das rodas quando se utiliza eixo de suspensão MCPHERSON R."}
                },
                {
                    ["1"] = {"IS_BIKE","Use as configurações de manuseio extra na seção de bikes."},
                    ["2"] = {"IS_HELI","Use as configurações de manuseio extra na seção de voar."},
                    ["4"] = {"IS_PLANE","Use as configurações de manuseio extra na seção de voar."},
                    ["8"] = {"IS_BOAT","Use as configurações de manuseio extra na seção de voar."}
                },
                {
                    ["1"] = {"BOUNCE_PANELS","precisa de testes."},
                    ["2"] = {"DOUBLE_RWHEELS","Coloca uma segunda instância de cada roda traseira ao lado do normal."},
                    ["4"] = {"FORCE_GROUND_CLEARANCE","precisa de testes."},
                    ["8"] = {"IS_HATCHBACK","precisa de testes."}
                }
            }
        },
        ["handlingFlags"] = {
            friendlyName = "manipulação de Bandeiras",
            information = "As características especiais de desempenho.",
            syntax = { "Hexadecimal", "" },
            items = {
                {
                    ["1"] = {"1G_BOOST","Dá mais potência do motor para partidas em pé, ou melhor subidas."},
                    ["2"] = {"2G_BOOST","Dá mais potência do motor em velocidades um pouco mais altas."},
                    ["4"] = {"NPC_ANTI_ROLL","No rolo do corpo quando impulsionada por personagens AI."},
                    ["8"] = {"NPC_NEUTRAL_HANDL","Menos propensos a sair quando impulsionada por personagens AI."}
                },
                {
                    ["1"] = {"NO_HANDBRAKE","Desativa o efeito de travão de mão."},
                    ["2"] = {"STEER_REARWHEELS","Rodas traseiras orientar em vez de frente, como uma empilhadeira."},
                    ["4"] = {"HB_REARWHEEL_STEER","Handbrake faz com que as rodas traseiras orientar, bem como frente, como o monster truck"},
                    ["8"] = {"ALT_STEER_OPT","precisa de testes."}
                },
                {
                    ["1"] = {"WHEEL_F_NARROW2","Muito estreitas rodas dianteiras."},
                    ["2"] = {"WHEEL_F_NARROW","Rodas dianteiras estreitas."},
                    ["4"] = {"WHEEL_F_WIDE","Rodas dianteiras de largura."},
                    ["8"] = {"WHEEL_F_WIDE2","Rodas da frente muito larga."}
                },
                {
                    ["1"] = {"WHEEL_R_NARROW2","Rodas traseiras estreitas."},
                    ["2"] = {"WHEEL_R_NARROW","Rodas traseiras estreitas."},
                    ["4"] = {"WHEEL_R_WIDE","Rodas traseiras largas."},
                    ["8"] = {"WHEEL_R_WIDE2","Muito largas rodas traseiras."}
                },
                {
                    ["1"] = {"HYDRAULIC_GEOM","precisa de testes."},
                    ["2"] = {"HYDRAULIC_INST","Vão aparecer com sistema hidráulico instalado."},
                    ["4"] = {"HYDRAULIC_NONE","Sistema hidráulico não pode ser instalado."},
                    ["8"] = {"NOS_INST","Veículo fica automaticamente NOS instalado quando ele gera."}
                },
                {
                    ["1"] = {"OFFROAD_ABILITY","Veículo terá um desempenho melhor em superfícies soltas, como sujeira."},
                    ["2"] = {"OFFROAD_ABILITY2","Veículo terá um desempenho melhor em superfícies macias, como areia."},
                    ["4"] = {"HALOGEN_LIGHTS","Faz faróis mais brilhante e mais azul."},
                    ["8"] = {"PROC_REARWHEEL_1ST","precisa de testes."}
                },
                {
                    ["1"] = {"USE_MAXSP_LIMIT","Impede veículo indo mais rápido do que a velocidade máxima."},
                    ["2"] = {"LOW_RIDER","Permite que o veículo a ser modificado em Loco Co lojas Baixa."},
                    ["4"] = {"STREET_RACER","Quando definido, o veículo só podem ser modificados a Roda Arch Anjos."},
                    ["8"] = {"UNDEFINED","Sem efeito."}
                },
                {
                    ["1"] = {"SWINGING_CHASSIS","Permite que o movimento do corpo do carro de um lado para outro sobre a suspensão."},
                    ["2"] = {"UNDEFINED","Sem efeito."},
                    ["4"] = {"UNDEFINED","Sem efeito."},
                    ["8"] = {"UNDEFINED","Sem efeito."}
                }
            }
        },
        ["headLight"] = {
            friendlyName = "Luzes de cabeça",
            information = "Define o tipo de luzes dianteiras de seu veículo terá.",
            syntax = { "Integer", "" },
            options = { ["0"]="Longo",["1"]="Pequeno",["2"]="Grande",["3"]="Tall" }
        },
        ["tailLight"] = {
            friendlyName = "Luzes da cauda",
            information = "Define o tipo de luzes traseiras de seu veículo terá.",
            syntax = { "Integer", "" },
            options = { ["0"]="Longo",["1"]="Pequeno",["2"]="Grande",["3"]="Tall" }
        },
        ["animGroup"] = {
            friendlyName = "animação Grupo",
            information = "Define o grupo de animação de seu ped usará para ele do veículo.",
            syntax = { "Integer", "" }
        }
    }
}