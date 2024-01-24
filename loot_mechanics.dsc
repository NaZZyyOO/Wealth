server_loottable_mechanics:
    type: task
	debug: false
	definitions: loottable_name|loc|player
	script:
	# Карма ділена на 100
	- define carma <placeholder[mystery_dcarma].player[<player>]>
	# Ділимо ще на 10
    - define carma_percante <[carma].div[10]>
	- if <player[704933eb-bb82-3466-bf5c-b32cbcba7ea6].is_online> = true:
	  - if <placeholder[essentials_vanished].player[<player[704933eb-bb82-3466-bf5c-b32cbcba7ea6]>]> = no:
	    - define carma_percante <[carma_percante].add[0.01]>
	# Вплив вдачі на шанс
	- define luck_amount <element[0]>
	- if <player.has_effect[luck]> = true:
	  - define luck_amount <element[<util.random.decimal[0.001].to[0.003]>]>
	- define final_coef <[carma_percante].add[<[luck_amount]>]>
	# Предмети з таблиці
	- define script <script[<[loottable_name]>]||null>
	- if <[script]> = null:
	  - stop
	- define ench_lvl <element[0]>
	- if <[player].item_in_hand.enchantment_map.contains[looting]> = true:
	  - define ench_lvl <[player].item_in_hand.enchantment_map.get[looting]>
	- define type_random <map[]>
	- foreach <script[<[loottable_name]>].list_keys.exclude[type]>:
	  - if <[value]> = xp:
	    - define quantity <[script].data_key[<[value]>.quantity]>
		- drop xp quantity:<[quantity]> <[loc]>
	  - if <[value]> != xp:
	    - define random_item_chance <[script].data_key[<[value]>.chance]>
	    - define random_item_min_quantity <[script].data_key[<[value]>.min_quantity]>
	    - define random_item_max_quantity <[script].data_key[<[value]>.max_quantity]>
	    - define final_chance <[random_item_chance].mul[<[final_coef].add[1]>]>
		- if <[player].item_in_hand.enchantment_map.contains[looting]> = true:
		  - if <[ench_lvl]> > 0:
		    - if <[random_item_min_quantity]> > 3:
		      - define random_item_max_quantity <[random_item_max_quantity].add[<[ench_lvl]>]>
			  - define random_item_min_quantity <[random_item_min_quantity].add[<[ench_lvl]>]>
		    - define final_chance <[final_chance].mul[<[ench_lvl].div[100].add[1]>]>
	    - if <[final_chance]> > 100:
	      - define final_chance <element[100]>
	    - if <[final_chance]> <= 0:
	      - define final_chance <element[0.00001]>
		- if <[script].data_key[<[value]>].contains[weight]> = false:
	      - if <util.random.decimal[0].to[100]> < <[final_chance]>:
		    - define item <item[<[value]>]>
			- define item <[item].proc[item_generate].parsed>
			- if <[item].max_durability||null> != null: 
			  - define item <[item].with[durability=<util.random.int[1].to[<material[<[item].max_durability>]>]> 
            - drop <[item]> quantity:<util.random.int[<[random_item_min_quantity]>].to[<[random_item_max_quantity]>]> <[loc]>
		- if <[script].data_key[<[value]>].contains[weight]> = true:
          - define type_random <[type_random].with[<[value]>].as[<[final_chance]>]>
	# Випадіння лише одного предмету зі списку
	- define size <[type_random].size>
	- if <[size]> > 0:
	  - foreach <[type_random].keys.random[<[size]>]>:
	    - define random_item_min_quantity <[script].data_key[<[value]>.min_quantity]>
		- define random_item_max_quantity <[script].data_key[<[value]>.max_quantity]>
	    - define final_chance <[script].data_key[<[value]>.chance]> 
	    - if <util.random.decimal[0].to[100]> <= <[final_chance]>:
		  - define item <item[<[value]>]>
	      - define item <[item].proc[item_generate].parsed>
	      - drop <[item]> <[loc]> quantity:<util.random.int[<[random_item_min_quantity]>].to[<[random_item_max_quantity]>]>
		  - stop
custom_drop_event:
    type: world
	debug: false
	events:
	    on mythicmob mob killed by:player:
		  - if <context.mob> != null:
		    - if <context.entity.has_flag[no_drop]> = false:
		      - define loottable_name <context.mob.internal_name.as_element||null>
			  - if <[loottable_name]> = null:
			    - stop
			  - define loc <context.entity.location>
		      - if <context.entity.has_flag[raid_boss]> = false:
			    - run server_loottable_mechanics def:<[loottable_name]>|<[loc]>|<player>
			  - else:
			    - run raid_boss_drop def:<[loottable_name]>|<context.entity>
		on entity damages entity:
		  - if <context.entity> != null:
		    - if <context.entity.has_flag[raid_boss]> = true:
			  - if <context.damager.is_player> = true:
			    - if <context.entity.has_flag[damagers_top]> = false:
			      - flag <context.entity> damagers_top:<map[]>
			    - else:
			      - if <context.entity.flag[damagers_top].contains[<context.damager.name>]> = false:
                    - flag <context.entity> damagers_top:<context.entity.flag[damagers_top].as_map.with[<context.damager.name>].as[<context.damage>]>
                  - else:
				    - define damage <context.entity.flag[damagers_top].get[<context.damager.name>].add[<context.damage>]>
                    - flag <context.entity> damagers_top:<context.entity.flag[damagers_top].with[<context.damager.name>].as[<[damage]>]>	  
raid_boss_drop:
    type: task
	definitions: loottable_name|entity
	debug: false
	script:
	    # Мапа гравець=пошкодження
	    - define damagers_top <[entity].flag[damagers_top]>
		# Мапа пошкодження=гравець
		- define damage_top <[damagers_top].invert>
		# Список всіх пошкоджень
		- define places_by_numerical <[damage_top].keys.numerical>
		- define damagers_size <[places_by_numerical].size>
		- if <[damagers_size]> = 0:
		  - stop
		# Якщо дамагер був 1
		- if <[damagers_size]> = 1:
		  - define first_pos <[places_by_numerical].get[1]>
		  - define pos_1 <[damage_top].get[<[first_pos]>]>
		  - if <player[<[pos_1]>].is_online> = true:
			- narrate "<&8>[Wealth] <&7>- Вы нанесли <[first_pos]> ед. урона, заняв 1-ое место!" targets:<player[<[pos_1]>]>
	    # Якщо дамагерів було 2
		- if <[damagers_size]> = 2:
		  - define first_two_pos <[places_by_numerical]>
		  - define first_pos <[first_two_pos].get[2]>
		  - define second_pos <[first_two_pos].get[1]>
		  - define pos_1 <[damage_top].get[<[first_pos]>]>
		  - define pos_2 <[damage_top].get[<[second_pos]>]>
		  - if <player[<[pos_1]>].is_online> = true:
			- narrate "<&8>[Wealth] <&7>- Вы нанесли <[first_pos]> ед. урона, заняв 1-ое место!" targets:<player[<[pos_1]>]>
		  - if <player[<[pos_2]>].is_online> = true:
			- narrate "<&8>[Wealth] <&7>- Вы нанесли <[second_pos]> ед. урона, заняв 2-ое место!" targets:<player[<[pos_2]>]>
		# Якщо дамагерів більше 2
	    - if <[damagers_size]> > 2:
		  - define first_three_pos <[places_by_numerical].get[<[damagers_size].sub[2]>].to[last]>
		  - define first_pos <[first_three_pos].get[3]>
		  - define second_pos <[first_three_pos].get[2]>
		  - define third_pos <[first_three_pos].get[1]>
		  - define pos_1 <[damage_top].get[<[first_pos]>]>
		  - define pos_2 <[damage_top].get[<[second_pos]>]>
		  - define pos_3 <[damage_top].get[<[third_pos]>]>
		  - if <player[<[pos_1]>].is_online> = true:
			- narrate "<&8>[Wealth] <&7>- Вы нанесли <[first_pos]> ед. урона, заняв 1-ое место!" targets:<player[<[pos_1]>]>
		  - if <player[<[pos_2]>].is_online> = true:
			- narrate "<&8>[Wealth] <&7>- Вы нанесли <[second_pos]> ед. урона, заняв 2-ое место!" targets:<player[<[pos_2]>]>
		  - if <player[<[pos_3]>].is_online> = true:
			- narrate "<&8>[Wealth] <&7>- Вы нанесли <[third_pos]> ед. урона, заняв 3-ое место!" targets:<player[<[pos_3]>]>
		  # Та якщо дамагерів більше 2, перевіряємо чи їх більше 3, якщо так, надати нагороду іншим позиціям топу.
		  - if <[damagers_size]> > 3:
		    - define others_pos <[places_by_numerical].exclude[<[third_pos]>].exclude[<[second_pos]>].exclude[<[first_pos]>]>
		    - foreach <[others_pos].keys> as:damage:
		      - define other_player <[damage_top].get[<[damage]>]>
		      - if <player[<[other_player]>].is_online> = true:
			    - narrate "<&8>[Wealth] <&7>- Вы нанесли <[damage]> ед. урона, не заняв ни одного из призовых мест!" targets:<player[<[other_player]>]>
	    # Предмети в  таблиці
	    - define script <script[<[loottable_name]>]||null>
	    - if <[script]> = null:
	      - stop
		- foreach <script[<[loottable_name]>].list_keys.exclude[type].exclude[debug]>:
		  - if <[value]> = pos_1:
		    - if <[pos_1]||null> = null:
			  - foreach next
		  - if <[value]> = pos_2:
		    - if <[pos_2]||null> = null:
			  - foreach next
		  - if <[value]> = pos_3:
		    - if <[pos_3]||null> = null:
			  - foreach next
		  - if <[value]> = others_pos:
		    - if <[others_pos]||null> = null:
			  - foreach next
		  - foreach <script[<[loottable_name]>].data_key[<[value]>].keys> as:item:
	        - define random_item <[script].data_key[<[value]>.<[item]>]>
			- define random_item_chance <[script].data_key[<[value]>.<[item]>.chance]>
	        - define random_item_min_quantity <[script].data_key[<[value]>.<[item]>.min_quantity]>
	        - define random_item_max_quantity <[script].data_key[<[value]>.<[item]>.max_quantity]>
	        - if <util.random.decimal[0].to[100]> < <[random_item_chance]>:
			  - if <[value]> = pos_1:
                - give <[item]> quantity:<util.random.int[<[random_item_min_quantity]>].to[<[random_item_max_quantity]>]> to:<player[<[pos_1]>].inventory>
		      - if <[value]> = pos_2:
                - give <[item]> quantity:<util.random.int[<[random_item_min_quantity]>].to[<[random_item_max_quantity]>]> to:<player[<[pos_2]>].inventory>
		      - if <[value]> = pos_3:
                - give <[item]> quantity:<util.random.int[<[random_item_min_quantity]>].to[<[random_item_max_quantity]>]> to:<player[<[pos_3]>].inventory>
			  - if <[value]> = others_pos:
			    - foreach <[others_pos]> as:damage:
				  - define other_player <[damage_top].get[<[damage]>]>
				  - give <[item]> quantity:<util.random.int[<[random_item_min_quantity]>].to[<[random_item_max_quantity]>]> to:<player[<[other_player]>].inventory>