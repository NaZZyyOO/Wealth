magic_table_items_flagged_animation:
    type: world
	debug: false
	events:
	    on player right clicks enchanting_table:
		  - if <context.location.has_flag[magic_table_01]> = true:
		    - inventory close
		    - if <context.location.flag[magic_table_01].contains[<player.name>]> = true:
			  - if <script[<player.item_in_hand.script.name>].data_key[data.stats].contains[is_magic_ingradient]> = true:
			    - determine passively cancelled
			    - define items_list <player.cursor_on.flag[magic_table_items].as_list>
				- define max_slots <context.location.flag[magic_table_01_slots]>
				- if <[items_list].size> > <[max_slots]>:
				  - actionbar "<&c><&l>magic_table_ing_too_many"
				  - stop
				- else:
				  - if <[items_list].contains[<context.item.script.name>]> = false:
				    - define loc_item <player.cursor_on.add[0,1.5,0].points_around_y[radius=2;points=100].random>
	                - flag <player.cursor_on> magic_table_items:<[items_list].include[<context.item.script.name>]>
	                - take from:<player.inventory> item:<context.item> quantity:1
	                - drop <context.item.script.name> <[loc_item]> quantity:1 delay:99999999 save:recipie_item speed:0
	                - adjust <entry[recipie_item].dropped_entity> gravity:false
	                - flag <entry[recipie_item].dropped_entity> item_recipie
				  - else:
				    - actionbar "<&6><&l>magic_table_ing_already_in"
			- else:
			  - actionbar "<&c><&l>magic_table_player_isnt_owner"
item_spellbooks_craft:
    type: world
	debug: false
	events:
	    on player right clicks !air:
		  - if <context.location||null> = null:
		    - stop
		  - if <context.location.material.name> = air:
		    - stop
		  - if <context.location.has_flag[magic_table_01]> = true:
		    - determine passively cancelled
			- if <player.is_sneaking> = false:
		      - if <context.location.has_flag[choosed_scroll]> = true:
			    - define items_list <player.cursor_on.flag[magic_table_items].as_list>
			    - define max_slots <context.location.flag[magic_table_01_slots]>
			    - if <[items_list].size> = <context.location.flag[choosed_scroll].get[n_ingradients]>
		          - define scroll <context.location.flag[choosed_scroll]>
			      - define recipie_item <script[<[scroll]>].flag[recepies]>
		          - run spellbook_tier_1_craft_mechanics def:<context.location.flag[choosed_scroll].get[scroll_def]>
				  - flag <context.location> choosed_scroll:!
			- else:
			  - inventory open d:magic_table_inventory
magic_table_choose_scroll:
    type: world
	debug: false
	events:
	    on player clicks choose_scroll in magic_table_inventory:
		  - determine passively cancelled
		  - define legacy <placeholder[mystery_legacy].player[<player>]>
		  - inventory open d:magic_table_scroll_list
		  - foreach <script[scrolls.<[legacy]>].list_keys> as:scroll:
		    - define scroll_item <script[<[scroll]>]>
			- run item_generate def:<item[<[scroll_item]>]> save:item
			- define item <entry[item].created_queue.determination.get[1]>
			- give to:<player.open_inventory> <[item]> quantity:1
		  - inject empty_fill
		on player clicks item in magic_table_scroll_list:
		  - determine passively cancelled
		  - if <context.item.script.name> != empty:
		    - inventory open d:magic_table_craft_visual
		    - define legacy <placeholder[mystery_legacy].player[<player>]>
			- define scroll_name <context.item.script.name>
		    - define recepie <script[scrolls.<[legacy]>.<[scroll_name]>.recepies.items]>
			- define slots_for_ing <list[4|6|10|17|29|35|40|42]>
			- foreach <[recepie].list_keys> as:ing:
			  - run item_generate def:<item[<[ing]>]> save:item
		      - define item <entry[item].created_queue.determination.get[1]>
			  - give <[item]> to:<player.open_inventory> slot:<[slots_for_ing].get[<[loop_index]>]>
		on player clicks item in magic_table_craft_visual:
		  - determine passively cancelled
magic_table_inventory:
  type: inventory
  debug: false
  inventory: chest
  title: "<&l>Magic table"
  size: 9
  slots:
  - [empty] [empty] [empty] [empty] [choose_scroll] [empty] [empty] [empty] [empty]
magic_table_scroll_list:
  type: inventory
  debug: false
  inventory: chest
  title: "<&l>Scrolls list"
  size: 9
  slots:
  - [] [] [] [] [] [] [] [] []
magic_table_craft_visual:
  type: inventory
  debug: false
  inventory: chest
  title: "<&l>Scrolls list"
  size: 45
  slots:
  - [] [] [] [] [] [] [] [] []
  - [] [] [] [] [] [] [] [] []
  - [] [] [] [] [magic_table_01] [] [] [] []
  - [] [] [] [] [] [] [] [] []
  - [] [] [] [] [] [] [] [] []
choose_scroll:
  type: item
  debug: false
  material: paper
  display name: "<&6><&l>Choose scroll"
  lore:
  - "<&6>Choose scroll that you want to craft."
  - "<&6>You can only craft a scroll of your legacy."
  mechanisms:
	raw_nbt: <map[ItemLingo=string:choose_scroll]>