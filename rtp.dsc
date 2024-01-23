random_teleport:
    debug: false
    type: task
    definitions: biome|world_name
    script:
      - define world <element[w@<[world_name]>].as_world||null>
      - if <[world]> != null:
        - if <[world].has_flag[rtp_points]> = true:
          - if <[world].flag[rtp_points].contains[<[biome]>]> = true:
            - run rtp_search_short def:<[biome]>|<[world]>
rtp_search_short:
    debug: false
    type: task
    definitions: biome|world
    script:
      - define distance_short <element[150]>
      - define random_loc <[world].flag[rtp_points].get[<[biome]>].random.as_location>
      - define loc <[random_loc].random_offset[<[distance_short]>,0,<[distance_short]>]>
      - chunkload <[loc].chunk> duration:5t
      - define loc <[loc].highest.add[0.0,2.0,0.0]>
      - define biomename <[loc].biome.name>
      - if <[biomename]> = <[biome]>:
        - strike no_damage <player.location>
        - teleport <player> <[loc]>
        - strike no_damage <player.location>
        - flag <player> rtp_searching:!
        - narrate "<&7><&o>player_rtp_teleport [<[biomename]>], [<player.location.x.round>,<player.location.z.round>]"
      - else:
        - wait 5t
        - run rtp_search_short def:<[biome]>|<[world]>
# Меню.
rtp_menu:
    debug: false
    type: task
    script:
    - if <player.has_flag[rtp_searching]> != true:
      - define world <player.world>
      - if <[world].has_flag[rtp_points]> = true:
	    - if <player.locale> = ru_ru:
          - define name "<&l>Нестабильная червоточина"
		- if <player.locale> = en_es:
		  - define name "<&l>Unstable Wormhole"
		- if <player.locale> = uk_ua:
		  - define name "<&l>Нестабільна червоточина"
        - inventory open d:generic[size=54;title=<[name]>]
        - define biomes_all <player.world.flag[rtp_points].keys>
        - foreach <[biomes_all]>:
          # Узнаём количество сохранённых точек.
          - define biomecount <[world].flag[rtp_points].get[<[value]>].as_list.size>
          # Описание пункта меню ртп.
		  - if <player.locale> = ru_ru:
            - define b_name <[value].to_titlecase.replace_text[<element[_]>].with[<&sp>]>
            - define b_points_size "<&6>Количество точек - <[biomecount]>"
            - define b_guide_01 "<&7>Игрок будет перенесен в случайную"
            - define b_guide_02 "<&7>точку с биомом <&l><[b_name]><reset><&7>."
		  - if <player.locale> = en_es:
            - define b_name <[value].to_titlecase.replace_text[<element[_]>].with[<&sp>]>
            - define b_points_size "<&6>Amount of points - <[biomecount]>"
            - define b_guide_01 "<&7>The player will be transferred to a random"
            - define b_guide_02 "<&7>biome location <&l><[b_name]><reset><&7>."
		  - if <player.locale> = uk_ua:
            - define b_name <[value].to_titlecase.replace_text[<element[_]>].with[<&sp>]>
            - define b_points_size "<&6>Кількість точок - <[biomecount]>"
            - define b_guide_01 "<&7>Гравець буде перенесений у випадкову"
            - define b_guide_02 "<&7>точку з біомом <&l><[b_name]><reset><&7>."
          - define b_info <list[<[b_points_size]>|<&sp>|<[b_guide_01]>|<[b_guide_02]>]>
          # Кнопка меню.
          - give end_crystal[display=<reset><&6><&l><[b_name]>;lore=<[b_info]>;custom_model_data=1;flag=GUI:true] quantity:1 to:<player.open_inventory>
        - inject empty_fill
      - else:
        - actionbar "<[player_rtp_cant_teleport]>"
rtp_menu_click:
  type: world
  debug: false
  events:
      on player clicks item in inventory:
	    - if <player.locale> = ru_ru:
          - define name "<&l>Нестабильная червоточина"
		- if <player.locale> = en_es:
		  - define name "<&l>Unstable Wormhole"
		- if <player.locale> = uk_ua:
		  - define name "<&l>Нестабільна червоточина"
		- if <[name]||null> = null:
		  - stop
        - if <context.clicked_inventory.title.contains[<[name]>]> = true:
          - determine passively cancelled
          - define itemname <context.item.display.to_lowercase.replace_text[<&sp>].with[<element[_]>].strip_color||null>
          - if itemname != null:
            - if <player.world.flag[rtp_points].contains[<[itemname]>]> = true:
              - inventory close
              - flag <player> rtp_searching
              - run random_teleport def:<[itemname]>|<player.world.name>
# Поиск точек для рандомной телепортации.
rtp_search_run:
    debug: false
    type: task
    definitions: distance|world_name|count
    script:
      - define world <element[w@<[world_name]>].as_world||null>
      - if <[world]> != null:
        - announce "<&7>Запущен поиск биомов для случайной телепортации в мире <[world_name]> с радиусом поиска <[distance]> и количеством попыток <[count]>." to_console
        - repeat <[count]>:
          - run rtp_search def:<[distance]>|<[world]>
rtp_search:
    debug: false
    type: task
    definitions: distance|world
    script:
      # Узнаём биом в случайной точке.
      - define x <util.random.int[-<[distance]>].to[<[distance]>]>
      - define z <util.random.int[-<[distance]>].to[<[distance]>]>
      - chunkload <location[<[x]>,0,<[z]>,<[world].name>].chunk> duration:10t
      - define loc <location[<[x]>,0,<[z]>,<[world].name>].highest>
      - define biomename <[loc].biome.name>
      # Проверка на наличие структуры с ртп точками в мире.
      - if <[world].has_flag[rtp_points]> = false:
        - flag <[world]> rtp_points:<map[]>
      # Проверка на наличие найденного биома в структуре.
      - if <[world].flag[rtp_points].contains[<[biomename]>]> = false:
        - define biome_list <list[]>
      - else:
        - define biome_list <[world].flag[rtp_points].get[<[biomename]>].as_list>
      # Запись точки в структуру.
      - define biome_list <[biome_list].as_list.include[<[loc]>]>
      - flag <[world]> rtp_points:<[world].flag[rtp_points].with[<[biomename]>].as[<[biome_list]>]>
      - announce "<&7>Сохранена точка с биомом <[biomename]> по координатам <[x]>, <[z]> в мире <[world].name>." to_console
rtp_world_clear:
    debug: false
    type: task
    script:
    - foreach <player.world.list_flags>:
      - flag <player.world> <[value].as_element>:!