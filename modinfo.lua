name = "Ukrainian lang"
version = "0.15.11"

author = "paxss"
description = "Пакет української локалізації \n by paxss"


icon = "modicon.tex"
icon_atlas = "modicon.xml"

api_version = 10

dont_starve_compatible = false
all_clients_require_mod = false

client_only_mod = true
server_only_mod = false
dst_compatible = true

-- mod config menu
configuration_options = {
    {
        name = "Z_PATRIOT",
        label = "Z патріоти",
        options = {
            {description = "Увімк.", data = true},
            {description = "Вимк.", data = false}
        },

        default = false,
        hover = "Встановлює для мермів діалогові фрази Z патріотів"
    },


    {
        name = "CUSTOM_FONTS",
        label = "Кастомні шрифти",
        options = {
            {description = "Увімк.", data = true},
            {description = "Вимк.", data = false}
        },
        default = false,
        hover = "[НЕ СКОРО] Кастомні шрифти від Tumaker"
    }
}