item_grimoire_fire:
  type: item
  debug: false
  material: book
  display name: "Grimoire"
  mechanisms:
    unbreakable: true
  data:
      stats:
        display: "Grimoire"
        rarity: legendary
        custom_model_data: 5
		grimoire: fire
        lore:
          item: "<&8><&l>Item: <&5>Grimoire"
          kind: "<&7><&l>Type: <&c>Fire"
          rare: "<&7><&l>Rarity: <&5>Legendary"
          text_01: "<&6>A magical grimoire that stores"
          text_02: "<&6>scrolls of the human element of various strengths and"
          text_03: "<&6>quantities."
          ability_main_01: "<&7>On hit usage:"
          ability_01: "<&a> - Use the selected scroll."
          ability_main_02: "<&7>Usage:"
          ability_02: "<&a> - Switch the selected scroll to the next one."
          ability_main_03: "<&7>Usage with Shift held:"
          ability_03: "<&a> - Opens the inventory with magical scrolls."
item_grimoire_use:
    type: world
	debug: false
	events:
	    on player right clicks block with:item_grimoire_*:
		  - if <player.is_sneaking> = true:
			- if <player.has_flag[grimoire]> = false:
		      - flag <player> grimoire:<map[]>
		    - determine passively cancelled
		    - inventory open d:grimoire_active_inv
		    - define container <player.flag[grimoire]>
		    - wait 5t
	        - foreach <[container].keys>:
              - define c_item <[container].get[<[value]>]>
              - give <[c_item]> to:<player.open_inventory> slot:<[value]>
		  - else:
		    - determine passively cancelled
			- if <player.has_flag[active_scroll]> = false:
			  - stop
			- if <player.flag[active_scroll]> = 0:
			  - stop
		    - define scroll <player.flag[grimoire].get[<player.flag[active_scroll]>].script.name>
		    - define scroll_data <script[<[scroll]>].data_key[data.stats]>
		    - if <[scroll_data].contains[magic_scroll]> = true:
              - if <player.has_flag[gcd]> = false:
                - if <placeholder[mystery_legacy].player[<player>]> = <[scroll_data].get[magic_scroll]>:
			      - determine passively cancelled
                  - flag <player> gcd duration:1s
                  - if <player.is_sneaking> != true:
                    - if <placeholder[mystery_mana].player[<player>].is_less_than[<[scroll_data].get[mana_cost]>]> = true:
                      - actionbar  "<[player_mana_isnt_enought]> <[scroll_data].get[mana_cost]>."
                    - else:
                      - execute as_server silent "my rmmana <player.name> <[scroll_data].get[mana_cost]>"
                      - inject <[scroll_data].get[formulas]>
                      - run <[scroll_data].get[run]> def:<[scroll_data].get[def].parsed>
                - else:
                  - actionbar "<[player_cant_use_item]>"
		on player closes inventory:
          - if <player.open_inventory.script.name||null> = grimoire_active_inv:
            - define container <player.open_inventory.map_slots>
            - if <player.has_flag[grimoire]||null> = true:
              - flag <player> grimoire:<[container]>
              - playsound sound:ITEM_ARMOR_EQUIP_LEATHER <player.location>
		on player !CONTROL_DROP clicks item in grimoire_active_inv:
		  - define item <context.cursor_item.script.name||null>
		  - if <[item]> = null:
		    - stop
		  - define item <script[<[scroll]>].data_key[data.stats]>
	      - if <[scroll_data].contains[magic_scroll]> = false || <[scroll_data].contains[grimoire]> = true:
			- if <context.action> = PLACE_ALL || <context.action> = SWAP_WITH_CURSOR:
			  - determine passively cancelled
		      - inventory close
		    - if <context.action> = HOTBAR_SWAP || <context.action> = HOTBAR_MOVE_AND_READD:
		      - determine passively cancelled
		on player left clicks block with:item_grimoire_*:
		  - if <player.is_sneaking> = false:
		    - determine passively cancelled
			- if <player.has_flag[active_scroll]> = false:
			  - flag <player> active_scroll:1
		    - if <player.flag[active_scroll]> > 0 && <player.flag[active_scroll]> < 10:
			  - flag <player> active_scroll:+:1
			  - if <player.flag[active_scroll]> = 10:
			    - flag <player> active_scroll:1
			  - if <player.flag[grimoire].get[<player.flag[active_scroll]>].display||null> != null:
		        - actionbar "<player.flag[grimoire].get[<player.flag[active_scroll]>].display>" targets:<player>
			  - else:
			    - actionbar "Empty" targets:<player>
		  - else:
		    - determine passively cancelled
			- if <player.has_flag[active_scroll]> = false:
			  - flag <player> active_scroll:1
		    - if <player.flag[active_scroll]> > 0 && <player.flag[active_scroll]> < 10:
			  - flag <player> active_scroll:-:1
			  - if <player.flag[active_scroll]> = 0:
			    - flag <player> active_scroll:1
		      - if <player.flag[grimoire].get[<player.flag[active_scroll]>].display||null> != null:
		        - actionbar "<player.flag[grimoire].get[<player.flag[active_scroll]>].display>" targets:<player>
			  - else:
			    - actionbar "Empty" targets:<player>
			- if <player.flag[active_scroll]> = 1:
			  - flag <player> active_scroll:1
			  - if <player.flag[grimoire].get[<player.flag[active_scroll]>].display||null> != null:
		        - actionbar "<player.flag[grimoire].get[<player.flag[active_scroll]>].display>" targets:<player>
			  - else:
			    - actionbar "Empty" targets:<player>
grimoire_active_inv:
  type: inventory
  debug: false
  inventory: chest
  title: "<&l>Grimoire"
  size: 9
  slots:
  - [] [] [] [] [] [] [] [] []