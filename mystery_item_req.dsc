mystery_lvl_item_req_mechanics_check:
    type: world
	debug: false
	events:
	    on player right clicks block with:!air:
		  - if <script[<player.item_in_hand.script.name>]||null> != null:
		    - if <script[<player.item_in_hand.script.name>].data_key[data.stats]||null> != null:
		      - if <script[<player.item_in_hand.script.name>].data_key[data.stats].keys.contains[lvl_req]> = true:
		        - define lvl_req <script[<player.item_in_hand.script.name>].data_key[data.stats.lvl_req]>
		        - if <placeholder[mystery_legacylevel].player[<player>]> < <[lvl_req]>:
			      - determine passively cancelled
	              - actionbar "<&c><&l>player_mystery_level_low <[lvl_req]>"
		on player left clicks block with:!air:
		  - if <script[<player.item_in_hand.script.name>]||null> != null:
		    - if <script[<player.item_in_hand.script.name>].data_key[data.stats]||null> != null:
		      - if <script[<player.item_in_hand.script.name>].data_key[data.stats].keys.contains[lvl_req]> = true:
		        - define lvl_req <script[<player.item_in_hand.script.name>].data_key[data.stats.lvl_req]>
		        - if <placeholder[mystery_legacylevel].player[<player>]> < <[lvl_req]>:
			      - determine passively cancelled
	              - actionbar "<&c><&l>player_mystery_level_low <[lvl_req]>"
		on player !CONTROL_DROP clicks !air in inventory:
		  - if <context.action> = PLACE_ALL:
		    - if <context.slot> = 41:
		      - if <context.cursor_item||null> != null:
		        - if <script[<context.cursor_item.script.name>]||null> != null:
		          - if <script[<context.cursor_item.script.name>].data_key[data.stats]||null> != null:
		            - if <script[<context.cursor_item.script.name>].data_key[data.stats].keys.contains[lvl_req]> = true:
		              - define lvl_req <script[<context.cursor_item.script.name>].data_key[data.stats.lvl_req]>
		              - if <placeholder[mystery_legacylevel].player[<player>]> < <[lvl_req]>:
			            - actionbar "<&c><&l>player_mystery_level_low <[lvl_req]>"
				        - drop <context.cursor_item> <player.location>
			            - determine passively cancelled
				        - inventory close
	    on player swaps items:
		  - if <context.offhand.material.name> != air && <context.main.material.name> != air:
		    - if <context.offhand||null> != null && <context.main||null> != null:
		      - if <script[<context.main.script.name>]||null> != null:
		        - if <script[<context.main.script.name>].data_key[data.stats]||null> != null:
		          - if <script[<context.main.script.name>].data_key[data.stats].keys.contains[lvl_req]> = true:
		            - define lvl_req <script[<context.main.script.name>].data_key[data.stats.lvl_req]>
		            - if <placeholder[mystery_legacylevel].player[<player>]> < <[lvl_req]>:
			          - actionbar "<&c><&l>player_mystery_level_low <[lvl_req]>"
			          - determine passively cancelled
		  - if <context.offhand.material.name> = air && <context.main.material.name> != air:
		    - if <context.main||null> != null:
		      - if <script[<context.main.script.name>]||null> != null:
		        - if <script[<context.main.script.name>].data_key[data.stats]||null> != null:
		          - if <script[<context.main.script.name>].data_key[data.stats].keys.contains[lvl_req]> = true:
		            - define lvl_req <script[<context.main.script.name>].data_key[data.stats.lvl_req]>
		            - if <placeholder[mystery_legacylevel].player[<player>]> < <[lvl_req]>:
			          - actionbar "<&c><&l>player_mystery_level_low <[lvl_req]>"
			          - determine passively cancelled
		  - if <context.offhand.material.name> != air && <context.main.material.name> = air:
		    - if <context.offhand||null> != null:
		      - if <script[<context.offhand.script.name>]||null> != null:
		        - if <script[<context.offhand.script.name>].data_key[data.stats]||null> != null:
		          - if <script[<context.offhand.script.name>].data_key[data.stats].keys.contains[lvl_req]> = true:
		            - define lvl_req <script[<context.offhand.script.name>].data_key[data.stats.lvl_req]>
		            - if <placeholder[mystery_legacylevel].player[<player>]> < <[lvl_req]>:
			          - actionbar "<&c><&l>player_mystery_level_low <[lvl_req]>"
			          - determine passively cancelled
	    on player equips item:
		  - if <script[<context.new_item.script.name>]||null> != null:
		    - if <script[<context.new_item.script.name>].data_key[data.stats]||null> != null:
		      - if <script[<context.new_item.script.name>].data_key[data.stats].keys.contains[lvl_req]> = true:
		        - define lvl_req <script[<context.new_item.script.name>].data_key[data.stats.lvl_req]>
		        - if <placeholder[mystery_legacylevel].player[<player>]> < <[lvl_req]>:
			      - actionbar "<&c><&l>player_mystery_level_low <[lvl_req]>"
			      - determine passively cancelled