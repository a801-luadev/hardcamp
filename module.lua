local module = {
	owner = "Bolodefchoco#0095",
	map_file = 2,
	time = 6 * 60
}

local roomManagerIds = {
	-- Bolodefchoco#0095
	[7903955] = true,
	-- Mquk#0095
	[71191972] = true,
	-- Xorcist#0000
	[6727042] = true,
	-- Alarobzein#0000
	[1287093] = true
}

-- Commands
local commands = {
	keyboard = {
		checkpoint = "E",
		removeCheckpoint = "Shift + E",
		die = "G / Del",
		timeLeaderboard = "o",
		sizeMin = "J",
		sizeMid = "K",
		sizeMax = "L"
	},
	nextMap = "next",
	reloadMap = "reset",
	newMap = "map",
	time = "time",
	standardTime = "standtime",
	checkpoint = "checkpoint",
	password = "password",
	removecheese = "remcheese"
}

-- Init
system.disableChatCommandDisplay()
local disable = { "AutoShaman", "AutoScore", "AutoTimeLeft", "AutoNewGame", "PhysicalConsumables", "AfkDeath" }
for i = 1, #disable do
	tfm.exec["disable" .. disable[i]]()
end
tfm.exec.setAutoMapFlipMode(false)

-- Translations
local translations = {
	en = {
		desc = "English",
		-- Init
		welcome = "Welcome to <B>#Hardcamp</B>! Press H to check the commands.\n\tYou as admin: <I>/room *#hardcamp0%s</I>\n\tReport any issue to Hardcamp Team!",

		-- Info
		skip = "<VP>%s</VP> just skipped the map!",
		restart = "<VP>%s</VP> just restarted the current map!",
		loadmap = "<VP>%s</VP> just loaded the map %s!",
		settime = "The time has been set to %s minutes!",
		setstandtime = "The standard time of all the rounds has been set to %s minutes!",
		enabled = "enabled! Press <B>E</B> to put a checkpoint and <B>Shift+E</B> to remove it.",
		difficulty = "Difficulty",
		sizemap = "The map you are currently playing is a sizemap. You have to switch size to complete it by using the keys <VP>J</VP>, <VP>K</VP> and <VP>L</VP>.",
        errorloadintribe = "The map loaded cannot be played in this room. You have to load this in the Tribe House.",

		-- Simple words
		disabled = "disabled!",

		-- Menu
		menu = {
			[1] = {"%s", "\tThe difference between a regular Bootcamp and Hardcamp is that we accept harder maps or maps that need more thought to be completed. It's like a bit harder version of bootcamp for experienced players.\n\nIf you want to be a room admin to use some special commands, join your room: %s"},
			[2] = {"Admin Commands", {
				[1] = {"\t<J>» Maps</J>\n", {
					[1] = "<VP>!%s</VP> - Pass the map!",
					[2] = "<VP>!%s</VP> - Reloads the current map!",
					[3] = "<VP>!%s</VP> <PS>@Code</PS> <R>or</R> <VP>!np <PS>@Code</PS></VP> - Loads a map from the rotation!",
				}},
				[2] = {"\n\t<J>» Others</J>\n", {
					--[1] = "<VP>!%s</VP> <PS>Time</PS> - Set the time of the current round",
					--[2] = "<VP>!%s</VP> <PS>Time</PS> - Set the time of all the rounds",
					--[3] = "<VP>!%s</VP> <PS>[[not] cheese]</PS> - Enables/Disables the checkpoint with or without cheese",
					[1] = "<VP>!%s</VP> <PS>[Password]</PS> - Sets/Unsets a password in the room",
				}},
			}},
			[3] = {"Keyboard Commands", {
				[1] = {"\t<J>» Mouse Size</J>\n", {
				--	[1] = "<VP>Key %s</VP> - Put a checkpoint",
				--	[2] = "<VP>Key %s</VP> - Remove a checkpoint",

					[1] = "<VP>Key %s</VP> - Changes your mouse size to the first size set by the map, if any.",
					[2] = "<VP>Key %s</VP> - Changes your mouse size to the second (default) size set by the map, if any.",
					[3] = "<VP>Key %s</VP> - Changes your mouse size to the third size set by the map, if any.",
				}},
				[2] = {"\n\t<J>» Others</J>\n", {
					[1] = "<VP>Key %s</VP> - Kills you",
					[2] = "<VP>Hold Key %s</VP> - Displays the time leaderboard for the current map",
					--[3] = "<VP>!%s</VP> - Removes your cheese",
				}},
			}},
			[4] = {"Maps", "<J>Maps : %s\n\n\tAccess %s and send your map. Do not forget to read all the rules before!"},
			[5] = {"Thanks for", "<R>%s <G>- <N>Developer\n%s <G>- <N>Map evaluators"},
		},
	},
	ar = {
		desc = "عربي",
		welcome = "أهلا بك في <B>#Hardcamp</B>! أكتب !info لتري الأوامر\n\tالابلاغ عن المشاكل لـ فريق Hardcamp!",

		skip = "<VP>%s</VP> قام بتخطي الخريطة!",
		restart = "<VP>%s</VP> قام بإعادة الخريطة الحالية",
		loadmap = "<VP>%s</VP> قام بتحميل الخريطة %s!",
		settime = "تم تغيير  الوقت ل %s دقيقة!",
		setstandtime = "تم تعيين الوقت القياسي لجميع جولات ل %s دقيقة!",
		enabled = "تمكين! إضغط <B>E</B> لوضع نقطة البداية ة <B>Shift+E</B> لحذفها.",

		disabled = "تعطيل!",
	},
	br = {
		desc = "Português brasileiro",
		welcome = "Bem-vindo ao <B>#Hardcamp</B>! Digite !info para checar os comandos.\n\tVocê como admin: <I>/sala *#hardcamp0%s</I>\n\tReporte quaisquer problemas para Equipe do Hardcamp!",

		skip = "<VP>%s</VP> acabou de passar o mapa!",
		restart = "<VP>%s</VP> acabou de reiniciar o mapa atual!",
		loadmap = "<VP>%s</VP> acabou de carregar o mapa %s!",
		settime = "O tempo foi definido para %s minutos!",
		setstandtime = "O tempo padrão para todas as partidas foram definidas para %s minutos!",
		enabled = "ativado! Pressione <B>E</B> para marcar um checkpoint e <B>Shift+E</B> para remove-lo.",
		difficulty = "Dificuldade",

		disabled = "desativado!",

		menu = {
			[1] = {"%s", "\tA diferença entre o bootcamp normal e o Hardcamp é que aceitamos mapas mais difíceis que precisam de mais pensamento para serem completados. É uma versão um pouco mais dificultosa para jogadores experientes.\n\nSe você quiser ser um administrador da sala para usar alguns comandos especiais, entre na sala: %s"},
			[2] = {"Comandos de Admin", {
				[1] = {"\t<J>» Mapas</J>\n", {
					[1] = "<VP>!%s</VP> - Passa o mapa!",
					[2] = "<VP>!%s</VP> - Recarrega o mapa atual!",
					[3] = "<VP>!%s</VP> <PS>@Código</PS> <R>ou</R> <VP>!np <PS>@Código</PS></VP> - Carrega um mapa de rotação!",
				}},
				[2] = {"\n\t<J>» Outros</J>\n", {
					--[1] = "<VP>!%s</VP> <PS>Tempo</PS> - Define o tempo do mapa atual",
					--[2] = "<VP>!%s</VP> <PS>Tempo</PS> - Define o tempo para todos os rounds",
					--[3] = "<VP>!%s</VP> <PS>[[not] cheese]</PS> - Ativa/Desativa o checkpoint com ou sem queijo",
					[1] = "<VP>!%s</VP> <PS>[Senha]</PS> - Define/remove uma senha para a sala",
				}},
			}},
			[3] = {"Comandos do Teclado", {
				[1] = {"\t<J>» Tamanho do Rato</J>\n", {
				--	[1] = "<VP>Tecla %s</VP> - Por um checkpoint",
				--	[2] = "<VP>Tecla %s</VP> - Remover um checkpoint",
					[1] = "<VP>Tecla %s</VP> - Altera o tamanho do seu rato para o primeiro tamanho definido pelo mapa, se houver.",
					[2] = "<VP>Tecla %s</VP> - Altera o tamanho do seu rato para o segundo (padrão) tamanho definido pelo mapa, se houver.",
					[3] = "<VP>Tecla %s</VP> - Altera o tamanho do seu rato para o terceiro tamanho definido pelo mapa, se houver.",
				}},
				[2] = {"\n\t<J>» Outros</J>\n", {
					[1] = "<VP>Tecla %s</VP> - Se matar",
					[2] = "<VP>Pressionar Tecla %s</VP> - Mostra o ranking de tempo do mapa atual",
					--[3] = "<VP>!%s</VP> - Remove seu queijo",
				}},
			}},
			[4] = {"Mapas", "<J>Mapas : %s\n\n\tAccesse %s e envie seu mapa. Não se esqueça de ler todas as regras antes!"},
			[5] = {"Agradecimentos", "<R>%s <G>- <N>Desenvolvedor\n%s <G>- <N>Avaliadores de Mapas"},
		},
	},
	fr = {
		desc = "Français",
		welcome = "Bienvenue dans <B>#Hardcamp</B>! Ecrivez !info pour prendre connaîssance des commandes\n\tVeuillez reporter tous problèmes à l'équipe Hardcamp !",

		skip = "<VP>%s</VP> vient de passer la carte !",
		restart = "<VP>%s</VP> vient de recharger la carte actuelle !",
		loadmap = "<VP>%s</VP> vient de charger la carte %s !",
		settime = "Le temps restant à été définie à %s minutes !",
		setstandtime = "Le temps général pour toutes les cartes à été définie à %s minutes !",
		enabled = "enabled! Appuyez sur <B>E</B> pour mettre un checkpoint et sur <B>Shift+E</B> pour le supprimer.",
		difficulty = "Difficulté",
		sizemap = "La carte que vous êtes en train de jouer est une sizemap. Vous devez changer de taille pour la compléter en utilisant les touches <VP>J</VP>, <VP>K</VP> et <VP>L</VP>.",
        errorloadintribe = "Cette carte ne peut être jouée dans ce salon. Vous pouvez la jouer dans votre Maison de tribu.",

		disabled = "désactivé !",

		menu = {
			[1] = {"%s", "\tLa différentre entre le bootcamp normal et Hardcamp est que nous acceptons des cartes plus dures et qui demandent plus de réflexion pour être complétées. C'est une version plus compliquée du bootcamp pour des joueurs expérimentés.\n\nSi vous voulez être admin dans un salon et utilisé des commandes spéciales, rejoignez le salon: %s"},
			[2] = {"Commandes Admin", {
				[1] = {"\t<J>» Cartes</J>\n", {
					[1] = "<VP>!%s</VP> - Passe la carte !",
					[2] = "<VP>!%s</VP> - Recharge la carte actuelle !",
					[3] = "<VP>!%s</VP> <PS>@Code</PS> <R>ou</R> <VP>!np @Code</VP> - Charger une carte de la rotation !",
				}},
				[2] = {"\n\t<J>» Autres</J>\n", {
					--[1] = "<VP>!%s</VP> <PS>Time</PS> - Définie le temps de la carte actuelle",
					--[2] = "<VP>!%s</VP> <PS>Time</PS> - Définie le temps de toutes les cartes",
					--[3] = "<VP>!%s</VP> <PS>[[not] cheese]</PS> - Active/Désactive les checkpoints avec ou sans fromage",
					[1] = "<VP>!%s</VP> <PS>[Mot de passe]</PS> - Ajoute/supprime un mot de passe au salon",
				}},
			}},
			[3] = {"Commandes de claviers", {
				[1] = {"\t<J>» Taille de la souris</J>\n", {
					--[1] = "<VP>Touche %s</VP> - Met un checkpoint",
					--[2] = "<VP>Touche %s</VP> - Supprime un checkpoint",
					[1] = "<VP>Touche %s</VP> - Change la taille de votre souris avec la première taille disponible, si il y en a une.",
					[2] = "<VP>Touche %s</VP> - Change la taille de votre souris avec la deuxième taille disponible, si il y en a une.",
					[3] = "<VP>Touche %s</VP> - Change la taille de votre souris avec la troisième taille disponible, si il y en a une.",
				}},
				[2] = {"\n\t<J>» Autres</J>\n", {
					[1] = "<VP>Touche %s</VP> - Vous tue",
					[2] = "<VP>Maintenez la touche %s</VP> - Affiche le classement des temps sur la carte actuelle"
				}},
			}},
			[4] = {"Cartes", "<J>Cartes : %s\n\n\tCliquez sur %s et envoyez votre carte. N'oubliez pas de lire les règles avant !"},
			[5] = {"Remerciements", "<R>%s <G>- <N>Developeur\n%s <G>- <N>Evaluateurs de cartes"},
		},
	},
	pl = {
		welcome = "Witaj w <B>#Hardcamp</B>! Wpisz !info na czacie aby sprawdzić jakie są komendy\n\tZgłaszaj wszelkie błędy do Zespół Hardcamp!",

		skip = "<VP>%s</VP> pominął/-ęła mapę!",
		restart = "<VP>%s</VP> zrestartował/-a mapę!",
		loadmap = "<VP>%s</VP> załadował/-a mapę %s!",
		settime = "Czas został ustawiony na %s minut!",
		setstandtime = "Standardowy czas dla wszystkich map został ustawiony na %s minut!",
		enabled = "włączony! Kliknij <B>E</B>, aby ustawić checkpoint i <B>Shift+E</B>, aby go usunąć.",

		disabled = "wyłączony!",
	},
}
local translation = translations[tfm.get.room.community] or translations.en

table.turnTable = function(x)
	return (type(x)=="table" and x or { x })
end
table.merge = function(this, src)
	for k, v in next, src do
		if this[k] then
			if type(v) == "table" then
				this[k] = table.turnTable(this[k])
				table.merge(this[k], v)
			else
				this[k] = this[k] or v
			end
		else
			this[k] = v
		end
	end
end

for k, v in next, translations do
	if k ~= "en" then
		table.merge(v, translations.en)
	end
end

-- Functions
table.list = function(tbl, sep, f, i, j)
	local out = {}

	sep = sep or ""

	i, j = (i or 1), (j or #tbl)

	local counter = 1
	for k, v in next, tbl do
		if type(k) ~= "number" or (k >= i and k <= j) then
			if f then
				out[counter] = f(k, v)
			else
				out[counter] = tostring(v)
			end
			counter = counter + 1
		end
	end

	return table.concat(out, sep)
end
string.nick = function(player, ignoreCheck)
	if not ignoreCheck and not player:find("#") then
		player = player .. "#0000"
	end

	return string.gsub(string.lower(player), "%a", string.upper, 1)
end
string.split = function(value, pattern, f)
	local out = {}
	for v in string.gmatch(value, pattern) do
		out[#out + 1] = (not f and v or f(v))
	end
	return out
end
local concat
concat = function(k, v)
	if type(v) == "table" then
		return table.list(v, "\n", function(i, j) return concat(i, j) end)
	else
		return v
	end
end

local timer
do
	timer = {
		_timers = {
			_count = 0
		}
	}

	timer.start = function(callback, ms, times, ...)
		local t = timer._timers
		t._count = t._count + 1

		t[t._count] = {
			id = t._count,
			callback = callback,
			args = { ... },
			defaultMilliseconds = ms,
			milliseconds = ms,
			times = times
		}
		t[t._count].args[#t[t._count].args + 1] = t[t._count]

		return t._count
	end

	timer.delete = function(id)
		timer._timers[id] = nil
	end

	timer.loop = function()
		local t
		for i = 1, timer._timers._count do
			t = timer._timers[i]
			if t then
				t.milliseconds = t.milliseconds - 500
				if t.milliseconds <= 0 then
					t.milliseconds = t.defaultMilliseconds
					t.times = t.times - 1

					t.callback(table.unpack(t.args))

					if t.times == 0 then
						timer.delete(i)
					end
				end
			end
		end
	end

	timer.free = function()
		timer._timers = { _count = 0 }
	end
end

-- Encode
local encodeMaps
encodeMaps = function(list, one)
	if one then
		return "[" .. table.concat(list, ',') .. "]"
	else
		local out = { }
		for i = 1, #list do
			out[i] = encodeMaps(list[i], true)
		end
		return table.concat(out)
	end
end

local decodeMaps = function(str)
	local out = string.split(str, "%[(.-)%]")
	for i = 1, #out do
		out[i] = string.split(out[i], "[^,]+", tonumber)
	end
	return out
end

-- Maps
local maps

local loading_maps = system.loadFile(module.map_file)
local reloader
reloader = timer.start(function()
	if not loading_maps then
		system.loadFile(module.map_file)
	end
end, 1000, 0)
eventFileLoaded = function(id, data)
	timer.delete(reloader)
	reloader = nil

	maps = decodeMaps(data)
	if #maps == 0 then
		maps = {
			{ 
				7312345, 7813423, 7390999, 6458351, 7331240, 3944386, 6499717, 7887777, 7492108, 7227693, 6500075, 7399800, 7799572, 7275727, 7767666, 7424622, 7623620, 4784241, 4748429, 5525208, 4892845, 5526649, 6801791, 3085295, 3253469, 7590989, 7329789, 6974000, 7314101, 6998333, 7399290, 7573154, 7767776, 7000045, 7106057, 5159079, 4891210, 3976725, 4454308, 1719709, 7777345, 4766627, 7249205, 7700774, 5374593, 6794767, 3783671, 3558682, 7184872, 5746869, 7100750, 6834436, 7312283, 3866650, 4999420, 7404055, 7275031, 7225542, 6354614, 7700756, 7196825, 7704493, 764650, 3526517, 3636206, 6241414, 7880887, 7701092, 1586310, 6747530, 6584804, 7255000, 7440555, 4635946, 3295967, 3241030, 6927976, 3804078, 7235760, 6000056, 2423300, 3995343, 4019421, 1359620, 7440742, 7391900, 7861688, 6531399, 7744289, 7225000, 6229884, 7270727, 3024238, 6000059, 4701337, 5888889, 6550335, 7809934, 7510807, 6000053, 7784763, 2574744, 7799444, 7253986, 4605303, 7762789, 3940243, 7000026, 7060000, 7093000, 7040085, 7467428, 6509312, 6352723, 6933971, 7528270, 6245422, 7680250, 7766573, 2751700, 6914135, 2749928, 7773123, 6782978, 7688823, 7622698, 3883780, 7629226, 4993609, 7777797, 7452095, 7700777, 7462643, 4901438, 7700775, 7700776, 7063314, 6608398, 7277277, 4694197, 3937060, 7777346, 7487831, 7054821, 7076000, 7142739, 7569384, 7252052, 5588806
			},
			
			{
				2973289, 7000048, 7767676, 7803432, 7767911, 2429057, 7405764, 7382218, 5443566, 7277227, 7440577, 5865991, 7605914, 7066428, 3807588, 7333329, 7192039, 7398391, 2937562, 7767767, 7112860, 5678468, 7225493, 2545424, 6000051, 3737744, 7777790, 6367688, 7159725, 7175796, 7594493, 7333370, 7515104, 7192035, 7780188, 5819565, 7703910, 7862113, 6040706, 3999455, 7108857, 4901445, 7443061, 7799605, 7197699, 7511491, 7348525, 7399799, 4788994, 7711350, 6940207, 7416400, 3374686, 7333277, 7503502, 7018157, 7500010, 6494990, 7753256, 4834444, 4638223, 5850330, 7800015, 7819218, 3734991, 7777337, 7700079, 2781845, 7853715, 7602364, 7167539, 7368881, 4130202, 7333288, 7362743, 6219128, 6999993, 7333334, 7151000, 7400010, 6412958, 718155, 4478459, 7388889, 7606163, 4524009, 6615196, 7399501, 7481758, 7233535, 7248598, 7567477, 7219540, 7388868, 6803839, 7552876, 3684292, 4595576, 6237745, 3931358, 7194815, 4976520, 7455555, 7366541, 7889597, 7259777, 7249127, 7302686, 7769632, 6000054, 4883346, 5811698, 7333303, 6000057, 7809995, 6633990, 7667199, 6114776, 6000045, 7312300, 4890705, 5957368, 6911697, 5999098, 7192153, 7716928, 3339586, 7591019, 6000048, 7727783, 5408922, 6502657, 4808290, 7823148, 7355550, 7848484, 7326394, 7700773, 7375460, 7822361, 7096798, 7816606, 5191670, 7866108, 4074214, 7638730, 6187789, 7477677, 7288888, 3938895, 6777877, 7590990, 3386996, 7689929, 6562860, 7012500, 7795690, 7571417, 4523127, 7444343, 7799820, 6999007, 6933187, 6390810, 4212122, 6927386, 7295774, 7426666, 5983713, 7362441, 6000052, 7800436, 4390388, 7868622, 5699275, 7189842, 6813672, 7770714, 7192029, 7770222, 2451258, 7418452, 7301000, 7777333, 7597589, 7350612, 7173296, 1124529, 7245555, 7680539, 3704015, 6000058, 4160675, 7707630, 3780618, 6927717, 7344754, 4679241, 6228450, 7499994, 7528494, 7524910, 4528198, 7146500, 6799702, 7488708, 2836937, 7523286, 6000324, 7440757, 6000031, 4499335, 7233579, 7228130, 6521321, 7864529, 6793803, 7900041, 5847160, 2245734, 5485847, 4854044, 3645605, 7660753, 6051593, 6971808, 5172585, 7189846, 6252288, 7106520, 7462123, 6864581, 7843685, 3869792, 7277270, 6631702, 7208183, 4571716, 6449225, 5733227, 6501305, 6772088, 7227889, 6971808, 3809046, 5527374, 6921682, 7037760, 6038214, 7583614, 1046877, 7180403, 7474124, 7590988, 7469195, 7192034, 7372373, 7707620, 6466661, 7000003, 7274374
			},
			
			{
				7778370, 7192689, 7077000, 7688054, 7571410, 7794425, 7413360, 7603556, 5745650, 7227889, 7195382, 7333374, 4750695, 7254203, 7900000, 7344327, 7205876, 7254996, 6411817, 7329998, 7579998, 7840051, 4559481, 7633977, 7845008, 7777344, 2604643, 7820723, 5776126, 7737163, 7372300, 7240002, 7703901, 7438524, 7333345, 6970333, 7192033, 4209243, 4533719, 7844881, 7528644, 7796969, 7142063, 7543457, 6000045, 7770776, 7803690, 7480588, 6118143, 7355556, 7754154, 7767777, 7673670, 7192031, 7777347, 7091808, 7444324, 7782721, 7525222, 7493086, 7467223, 7337733, 6591698, 6538840, 7025830, 7269804, 6923967, 7372303, 7816585, 4559999
			},
			
			{
				6424348, 7152000, 7403537, 7844128, 7899996, 6974940, 6374076, 7777348, 4821321, 7417986, 7391000, 7777779, 3860496, 7833347, 6422459, 7523363, 7358578, 6205980, 6588488, 7282222, 7277272, 7480073, 7430434, 6652495
			}
		}
	end

	for i = 1, #maps do
		maps[i].queue = maps[i]
	end
	maps.queue = { 2, 3, 1, 4, 3, 1, 2, 3, 2, 1 }

	do
		local shuffle = function(list)
			local index
			for i = #list, 1, -1 do
				index = math.random(i)
				list[index], list[i] = list[i], list[index]
			end
		end
		local set = function(list)
			local out = { }
			for _, index in next, list do
				out[index] = true
			end
			return out
		end

		maps.queue._next = 1
		maps.queue._currentCat = nil
		maps.queue._len = #maps.queue
		for i = 1, #maps do
			shuffle(maps[i].queue)
			maps[i] = {
				_next = 1,
				fBefore = maps[i].fBefore,
				fAfter = maps[i].fAfter,
				queue = maps[i].queue,
				_queueLen = #maps[i].queue,
				_hashedQueue = set(maps[i].queue)
			}
		end

		maps = setmetatable(maps, {
			__call = function(this, category)
				category = tonumber(category)
				local hasCat = not not category
				if not hasCat or not this[category] then
					category = this.queue[this.queue._next]
					if type(category) == "table" then
						category = category[math.random(#category)]
					end
					this.queue._next = this.queue._next % maps.queue._len + 1
				end
				this.queue._currentCat = category

				local map
				if hasCat then
					map = this[category].queue[math.random(this[category]._queueLen)]
				else
					map = this[category].queue[this[category]._next]

					if this[category]._next == this[category]._queueLen then
						shuffle(this[category].queue)
						this[category]._next = 1
					else
						this[category]._next = this[category]._next + 1
					end
				end

				if this[category].fBefore then
					this[category].fBefore(map)
				end

				return map
			end
		})
	end
	tfm.exec.setGameTime(4)
	eventLoop(0, 0)
end

-- System
local roomManagers = { }
local roomAdmins = { }

local mapTimes = { }
local info = { }
local checkpoint = false
local respawnCheese = false
local mapAllowsChangeSize = false

local setPodium
do
	local colors = { 0xF8BA00, 0x959595, 0x763C16, 0xD7D7E6 }
	setPodium = function()
		local players, counter = { }, 0
		for k, v in next, tfm.get.room.playerList do
			counter = counter + 1
			players[counter] = { k, v.score }
		end
		table.sort(players, function(p1, p2) return p1[2] > p2[2] end)

		for i = 1, counter do
			tfm.exec.setNameColor(players[i][1], colors[(i>4 or players[i][2] < 1) and 4 or i])
		end
	end
end

local rank = function(showPos, showPoints, pointsName, lim)
	local source = #mapTimes > 0 and mapTimes or { {"?", 0} }
	local rank = ""
	local p = { }
	for i, j in next, source do
		p[#p + 1] = { name = j[1], v = j[2] }
	end
	table.sort(p, function(f, s) return f.v < s.v end)

	for o, n in next, p do
		if o <= lim then
			rank = rank .. (showPos and "<J>" .. o .. ". " or "") .. "<V>" .. n.name .. (showPoints and (" <BL>- <VP>" .. n.v .. " " .. (pointsName or "points") .. "\n") or "\n")
		end
	end
	return rank
end

local mouseSize = { }

local getTranslation = function(n)
	if not (n and info[n] and info[n].langue) then return translation end
	return translations[info[n].langue] or translation
end

-- UI
ui.menu = function(n)
	if not info[n].menu.accessing then
		info[n].menu.page = 1
		info[n].menu.accessing = true
	end

	local langue = getTranslation(n).menu

	if info[n].menu.page < 1 then
		info[n].menu.page = #langue
	elseif info[n].menu.page > #langue then
		info[n].menu.page = 1
	end

	local popupFormat = "<%s><a href='event:menu.page.%d'>%s</a>"
	local popups = {}
	for k, v in next, langue do
		popups[#popups+1] = string.format(popupFormat, (k == info[n].menu.page and "PT" or "CEP"), k, string.format(v[1], string.nick("hardcamp", true)))
	end

	local displayText = {table.unpack(langue[info[n].menu.page])}

	if info[n].menu.page == 1 then
		displayText[1] = string.format(displayText[1], string.nick("hardcamp", true))
		displayText[2] = string.format(displayText[2], "\n<p align='center'><PT><a href='event:print./room #hardcamp0"..n.."'>/room #hardcamp0" .. n)
	else
		local textFormat = nil
		if info[n].menu.page == 2 then
			displayText[2] = table.list(displayText[2], "\n", function(k, v)
				return concat(k, v)
			end)
			displayText[2] = "<font size='10'>" .. string.format(displayText[2], commands.nextMap, commands.reloadMap, commands.newMap, --[[commands.time, commands.standardTime, commands.checkpoint,]] commands.password)
		elseif info[n].menu.page == 3 then
			displayText[2] = table.list(displayText[2], "\n", function(k, v)
				return concat(k, v)
			end)
			displayText[2] = "<font size='10'>" .. string.format(displayText[2], commands.keyboard.sizeMin, commands.keyboard.sizeMid, commands.keyboard.sizeMax, --[[commands.keyboard.checkpoint, commands.keyboard.removeCheckpoint,]] commands.keyboard.die, commands.keyboard.timeLeaderboard--[[, commands.removecheese]])

		elseif info[n].menu.page == 4 then
			local m = 0
			for i = 1, #maps do
				m = m + #maps[i].queue
			end
			displayText[2] = string.format(displayText[2], m.."<N>", "<BV><a href='event:print.atelier801¬com/topic?f=6&t=850791'>#HARDCAMP MAP SUBMISSIONS</a></BV>")
		elseif info[n].menu.page == 5 then
			displayText[2] = string.format(displayText[2], "Bolodefchoco#0095", "<BV>Mquk#0095, Xorcist#0000, Auroraclears#0000</BV>")
		end
	end

	ui.addTextArea(3, "<font size='1'>\n</font><p align='center'><J><B><a href='event:menu.right'>»</a>", n, 543, 352, 40, 20, 1, 1, 1, true)
	ui.addTextArea(4, "<font size='1'>\n</font><p align='center'><J><B><a href='event:menu.left'>«</a>", n, 217, 352, 40, 20, 1, 1, 1, true)

	ui.addTextArea(5, "<font size='11'><J>"..table.concat(popups, "\n\n"), n, 546, 107, 115, 155, 0x140C07, 1, 1, true)

	ui.addTextArea(6, "<p align='center'><B><R><a href='event:menu.close'>X", n, 543, 42, 20, 20, 1, 1, 1, true)
	ui.addTextArea(7, "<p align='center'><font size='20' color='#92CF91'><B>"..string.upper(displayText[1]).."</B></V><font size='15'>\n<R>_____________\n\n<font size='11'><N><p align='left'>"..displayText[2], n, 260, 42, 280, 330, 0x1E120B, 1, 1, true)
end

local updateMapUi = function()
	local diff = maps and maps.queue and maps.queue._currentCat or 0
	ui.setMapName("<J>" .. (tfm.get.room.xmlMapInfo and tfm.get.room.xmlMapInfo.author or "?") .. " <BL>- " .. tfm.get.room.currentMap .. "   <G>|<N>   " .. translation.difficulty .. " : <V>" .. diff)
end

-- 
local nextUiUpdate
local nextMap
currentTime = 0
eventLoop = function(currentTime, leftTime)
	timer.loop()

	_G.currentTime = currentTime
	if leftTime < 500 then
		if not nextMap then
			nextMap = maps()
		end
		tfm.exec.newGame(nextMap)
	end

	for p, d in next, info do
		if d.logo then
			d.logo_timer = d.logo_timer - .5
			if d.logo_timer <= 0 then
				tfm.exec.removeImage(d.logo)
			end
		end
	end

	-- Update map info at intervals
	nextUiUpdate = nextUiUpdate or 1000
	if currentTime >= nextUiUpdate then
		nextUiUpdate = currentTime + 4400
		updateMapUi()
	end
end

eventNewPlayer = function(n)
	if not info[n] then
		info[n] = {
			shift = false,
			checkpoint = {false, 0, 0, false},
			cheese = false,
			menu = {
				accessing = false,
				page = 1,
				timer = 0,
			},
			logo = tfm.exec.addImage("15d75ac6aa9.png", "&0", 120, 100, n),
			logo_timer = 6,
			langue = tfm.get.room.community or "en"
		}
	end

	if roomManagerIds[tfm.get.room.playerList[n].id] then
		roomManagers[n] = true
		roomAdmins[n] = true
	end

	tfm.exec.respawnPlayer(n)

	for i = 1, 2 do
		system.bindKeyboard(n, 16, i==1, true) -- shift
		system.bindKeyboard(n, string.byte("O"), i == 1, true)
	end

	for k, v in next, {46, string.byte("HEGJKL", 1, -1)} do -- 46 is del
		system.bindKeyboard(n, v, true, true)
	end

	tfm.exec.chatMessage("<T>" .. string.format(getTranslation(n).welcome, n) .. "\n\t<CEP>atelier801.com/topic?f=6&t=850791", n)
	
end

local resizeEveryone = function(size)
	for k in next, tfm.get.room.playerList do
		tfm.exec.changePlayerSize(k, size)
	end
end

eventNewGame = function()
	timer.free()
	mapAllowsChangeSize = false

	if not maps or not maps.queue then return tfm.exec.setGameTime(0) end

	nextMap = nil
	nextUiUpdate = nil
	if tfm.get.room.xmlMapInfo then
		local min, mid, max = string.match(tfm.get.room.xmlMapInfo.xml, "[\" ]size=\"([^\"]-), *([^\"]-), *([^\"]-)\"")
		if not min then
			if string.find(tfm.get.room.xmlMapInfo.xml, "[\" ]size=\"") then
				min, mid, max = 0.5, 1, 3
			end
		end

		if min then
			min, mid, max = tonumber(min), tonumber(mid), tonumber(max)
			if min then
				mouseSize = {
					[string.byte(commands.keyboard.sizeMin)] = min,
					[string.byte(commands.keyboard.sizeMid)] = mid,
					[string.byte(commands.keyboard.sizeMax)] = max
				}
				mapAllowsChangeSize = true
				resizeEveryone(mid)

				for k in next, tfm.get.room.playerList do
					tfm.exec.chatMessage("<T>" .. getTranslation(k).sizemap, k)
				end
			end
		else
			resizeEveryone(1)
		end

		local code = tonumber(tfm.get.room.xmlMapInfo.mapCode)
		local diff
		for j = 1, #maps do
			if maps[j]._hashedQueue[code] then
				diff = j
				break
			end
		end
		if diff then
			maps.queue._currentCat = diff -- just to be sure
			updateMapUi()
		else
			maps.queue._currentCat = nil -- 0 points
		end
	end

	mapTimes = { }
	tfm.exec.setGameTime(module.time)
	tfm.exec.setPlayerSync("none")

	for k, v in next, info do
		v.cheese = false
		v.checkpoint = { false, 0, 0, false }
		ui.removeTextArea(1, n)
	end
	setPodium()
end

eventKeyboard = function(n, k, d, x, y)
	if k == 16 then
		info[n].shift = d
	elseif k == string.byte("E") and checkpoint and not tfm.get.room.playerList[n].isDead then
		if info[n].shift then
			info[n].checkpoint = { false, 0, 0, info[n].checkpoint[4] }
			ui.removeTextArea(1, n)
		else
			info[n].checkpoint = {true, x, y, true}
			ui.addTextArea(1, "", n, x-5, y-5, 10, 10, 0x56A75A, 0x56A75A, .5, false)
		end
	elseif k == string.byte("O") then
		if d then
			ui.addTextArea(2, rank(true, true, "s", 20), n, 5, 30, nil, 200, nil, nil, .8, true)
		else
			ui.removeTextArea(2, n)
		end
	elseif k == string.byte("H") then
		eventChatCommand(n, "h")
	elseif k == 46 or k == string.byte("G") then
		tfm.exec.killPlayer(n)
	elseif mapAllowsChangeSize and mouseSize[k] then
		tfm.exec.changePlayerSize(n, mouseSize[k])
	end
end

local toAdd, toRem, toSave = { }, { }
eventChatCommand = function(n, c)
	local p = string.split(c, "[^%s]+", string.lower)
	if p[1] == "info" or p[1] == "h" then
		if info[n].menu.accessing then
			eventTextAreaCallback(nil, n, "menu.close")
		else
			if os.time() > info[n].menu.timer then
				info[n].menu.timer = os.time() + 1e3
				ui.menu(n)
			end
		end
	elseif p[1] == "lang" or p[1] == "langue" then
		local prefer = p[2] or tfm.get.room.community
		if not translations[prefer] then
			tfm.exec.chatMessage("<T>• Paramètre invalide !", n)
		else
			info[n].langue = prefer
			tfm.exec.chatMessage("<T>• Votre langue est définie sur : " .. getTranslation(n).desc .. " (".. prefer ..")", n)
		end
	else
		if roomAdmins[n] then
			if p[1] == "next" and currentTime > 5000 then
				tfm.exec.newGame(maps())
				tfm.exec.chatMessage("<T>• " .. string.format(getTranslation(n).skip, n))
			elseif (p[1] == "reset" or p[1] == "rst" or p[1] == "again") and currentTime > 5000 then
				if tfm.get.room.currentMap then
					tfm.exec.newGame(tfm.get.room.currentMap)
					tfm.exec.chatMessage("<T>• " .. string.format(getTranslation(n).restart, n))
				end
			elseif (p[1] == "np" or p[1] == "map") and currentTime > 5000 then
				if p[2] then
					if #p[2] == 1 then
						tfm.exec.newGame(maps(tonumber(p[2])))
						for k in next, tfm.get.room.playerList do
							tfm.exec.chatMessage("<T>• " .. string.format(getTranslation(k).loadmap, n, "Level " .. p[2]), k)
						end
					else
						if not tfm.get.room.isTribeHouse and not roomManagers[n] then
							local code = tonumber(p[2]:match('%d+'))
							local diff
							for j = 1, #maps do
								if maps[j]._hashedQueue[code] then
									diff = j
									break
								end
							end
							if not diff then
								return tfm.exec.chatMessage("<R>• " .. getTranslation(n).errorloadintribe, n)
							end
						end

						tfm.exec.newGame(p[2])
						for k in next, tfm.get.room.playerList do
							tfm.exec.chatMessage("<T>• " .. string.format(getTranslation(k).loadmap, n, string.find(p[2], "@") and p[2] or "@"..p[2]), k)
						end
					end
				else
					tfm.exec.newGame(maps())
					for k in next, tfm.get.room.playerList do
						tfm.exec.chatMessage("<T>• " .. string.format(getTranslation(k).loadmap, n, "Random"), k)
					end
				end
			--[=[
			elseif p[1] == "time" then
				p[2] = p[2] and tonumber(p[2]) or 6
				tfm.exec.setGameTime(p[2] * 60)
				tfm.exec.chatMessage(string.format(translation.settime, p[2]))
			elseif p[1] == "standtime" then
				p[2] = p[2] and tonumber(p[2]) or 6
				if p[2] > 0 and p[2] < 10 then
					module.time = p[2] * 60
					tfm.exec.chatMessage(string.format(translation.setstandtime, p[2]))
				end
			]=]
			elseif p[1] == "password" or p[1] == "pw" then
				tfm.exec.setRoomPassword(p[2])
				if p[2] then
					tfm.exec.chatMessage("<CE>The password has been set to <B>" .. p[2] .. "</B>", n)
				else
					tfm.exec.chatMessage("<CE>The password has been removed", n)
				end
			end
		end
		if roomManagers[n] then
			if p[1] == "checkpoint" then
				local attribute = false
				if p[2] then
					attribute = true
					if p[2] == "not" and p[3] and p[3] == "cheese" then
						respawnCheese = false
					elseif p[2] == "cheese" then
						respawnCheese = true
					else
						attribute = false
					end
				end

				if not (checkpoint and attribute) then
					checkpoint = not checkpoint
					for k in next, tfm.get.room.playerList do
						tfm.exec.chatMessage("<T>Checkpoint " .. getTranslation(k)[checkpoint and "enabled" or "disabled"])
					end

					if not checkpoint then
						ui.removeTextArea(1, nil)
						for k, v in next, info do
							v.checkpoint = { false, 0, 0, v.checkpoint[4] }
						end
						respawnCheese = false
						for k, v in next, info do
							v.cheese = false
						end
					end
				end
			elseif p[1] == "list" then
				p[2] = tonumber(p[2])
				if not p[2] then
					return tfm.exec.chatMessage("<R>• Missing difficulty level parameter. (1 - 4)", n)
				end
				if p[2] > 0 and p[2] <= #maps then
					tfm.exec.chatMessage("\n<B>Maps with difficulty level " .. p[2] .. "</B>:\n" .. string.rep('-', 60), n)
					local out = "@" .. encodeMaps(maps[p[2]].queue, true):sub(2, -2):gsub(",", " @")
					for i = 1, #out, 901 do
						tfm.exec.chatMessage("<font size='11'><T>" .. string.sub(out, i, i + 900) .. "</T></font>", n)
					end
					tfm.exec.chatMessage(string.rep('-', 60), n)
				end
			elseif p[1] == "dump" then
				tfm.exec.chatMessage("<V>--- START DUMP ---", n)
				local encodedFile = { }
				for i = 1, #maps do
					encodedFile[i] = maps[i].queue
				end
				local msg = encodeMaps(encodedFile)
					:gsub("<", "&lt;")
					:gsub("\n", "\\n")
				local times = math.ceil(#msg/1000)
				for i = 0, times - 1 do
					tfm.exec.chatMessage(msg:sub(#msg*(i/times)+1, #msg*((i+1)/times)), n)
				end
				tfm.exec.chatMessage("<V>--- END DUMP ---", n)
			elseif p[1] == "add" then
				if not p[3] then
					return tfm.exec.chatMessage("<R>• Missing map code. Syntax: !add level map_code [map_code ...]", n)
				end
				p[2] = tonumber(p[2])
				if not p[2] then
					return tfm.exec.chatMessage("<R>• Missing difficulty level parameter. (1 - 4). Syntax: !add level map_code [map_code ...]", n)
				end
				if p[2] > 0 and p[2] <= #maps then
					for i = 3, #p do
						if string.find(p[i], "^@") then
							p[i] = tonumber(string.sub(p[i], 2))
						else
							p[i] = tonumber(p[i])
						end

						if not maps[p[2]]._hashedQueue[p[i]] then
							maps[p[2]].queue[maps[p[2]]._queueLen + 1] = p[i]
							maps[p[2]]._queueLen = maps[p[2]]._queueLen + 1
							maps[p[2]]._hashedQueue[p[i]] = true

							toAdd[#toAdd + 1] = p[i]
							tfm.exec.chatMessage("<T>• Map @" .. p[i] .. " added to the level " .. p[2] .. " map queue!")
						end
					end
				end
			elseif p[1] == "rem" then
				if not p[2] then
					return tfm.exec.chatMessage("<R>• Missing map_code.", n)
				end

				for i = 2, #p do
					if string.find(p[i], "^@") then
						p[i] = string.sub(p[i], 2)
					end
					p[i] = tonumber(p[i])
					for j = 1, #maps do
						if maps[j]._hashedQueue[p[i]] then
							maps[j]._hashedQueue[p[i]] = nil
							for k = 1, maps[j]._queueLen do
								if maps[j].queue[k] == p[i] then
									table.remove(maps[j].queue, k)
									toRem[#toRem + 1] = p[i]
									tfm.exec.chatMessage("<T>• Map @" .. p[i] .. " removed from the level " .. j .. " map queue!")
									break
								end
							end
							maps[j]._queueLen = maps[j]._queueLen - 1
						end
					end
				end
			elseif p[1] == "save" then
				if #toAdd == 0 and #toRem == 0 then
					return tfm.exec.chatMessage("<R>• No updates available.", n)
				end

				if not toSave then
					toSave = { }
					for i = 1, #maps do
						toSave[i] = maps[i].queue
					end
					toSave = encodeMaps(toSave)
					tfm.exec.chatMessage("<O>Type <B>!save</B> to save the maps.\n<O>• <B>Update stats:</B>\n\t<BL>- Size : <N>" .. #toSave .. "kb\n\t<BL>- Editions : <T>+<N>" .. #toAdd .. " <R>-<N>" .. #toRem, n)
					if #toAdd > 0 then
						tfm.exec.chatMessage("<O>To add: <T><font size='10'>@" .. table.concat(toAdd, ' @') .. "</font>", n)
					end
					if #toRem > 0 then
						tfm.exec.chatMessage("<O>To remove: <T><font size='10'>@" .. table.concat(toRem, ' @') .. "</font>", n)
					end
				else
					toAdd = { }
					toRem = { }
					system.saveFile(toSave, module.map_file)
					toSave = nil
					tfm.exec.chatMessage("<T>• Saved.", n)
				end
			elseif p[1] == "remcheese" then
				if tfm.get.room.playerList[n].hasCheese then
					info[n].cheese = false
					tfm.exec.removeCheese(n)
				end
			end
		end
	end
end

local respawn = function(n)
	tfm.exec.respawnPlayer(n)
	if mapAllowsChangeSize then
		tfm.exec.changePlayerSize(n, mouseSize[string.byte(commands.keyboard.sizeMid)])
	end
	if checkpoint and info[n].checkpoint[1] then
		tfm.exec.movePlayer(n, info[n].checkpoint[2], info[n].checkpoint[3])
		if info[n].cheese and respawnCheese then
			tfm.exec.giveCheese(n)
		end
	end
end

eventPlayerDied = function(n)
	timer.start(respawn, 1500, 1, n)
end

eventPlayerWon = function(n, t, time)
	info[n].cheese = false
	info[n].checkpoint = {false, 0, 0, info[n].checkpoint[4]}
	ui.removeTextArea(1, n)

	mapTimes[#mapTimes + 1] = {n .. (info[n].checkpoint[4] and "<R>*</R>" or ""), time/100}

	eventPlayerDied(n, true)
	if maps.queue._currentCat then
		tfm.exec.setPlayerScore(n, maps.queue._currentCat ^ 2, true)
	end

	tfm.exec.chatMessage(string.format("<ROSE>%s (%ss <PT>(%scheckpoint)</PT>)", n, time/100, info[n].checkpoint[4] and "" or "no "), n)
end

eventPlayerGetCheese = function(n)
	if checkpoint and respawnCheese then
		info[n].cheese = true
		info[n].checkpoint[4] = true
	end
end

eventTextAreaCallback = function(i, n, c)
	local p = string.split(c, "[^%.]+")
	if p[1] == "menu" and os.time() > info[n].menu.timer then
		info[n].menu.timer = os.time() + 750
		if p[2] == "page" and p[3] then
			info[n].menu.page = tonumber(p[3])
			ui.menu(n)
		elseif p[2] == "right" then
			info[n].menu.page = info[n].menu.page + 1
			ui.menu(n)
		elseif p[2] == "left" then
			info[n].menu.page = info[n].menu.page - 1
			ui.menu(n)
		elseif p[2] == "close" then
			for i = 7, 3, -1 do
				ui.removeTextArea(i, n)
			end
			info[n].menu.accessing = false
		end
	elseif p[1] == "print" then
		p[2] = string.gsub(p[2], "¬", ".")
		tfm.exec.chatMessage(string.format("<PT>[•] <BV>%s", p[2]), n)
	end
end

-- Room
if not tfm.get.room.isTribeHouse then -- Is room
	local info = string.match(tfm.get.room.name, "#hardcamp%d+(.+)")
	if info then
		local admins = string.gsub(info, "%S+", function(value)
			roomAdmins[string.nick(value)] = true
		end)
	end
end

for k, v in next, tfm.get.room.playerList do
	tfm.exec.setPlayerScore(k, 0)
	eventNewPlayer(k)
end
