item_generate:
    type: procedure
	definitions: item
	debug: false
	script:
	  - define script <script[<[item].script.name>]||null>
      - if <[script]> = null:
		- stop
	  - else:
	    - if <script[<[item].script.name>].data_key[data.stats]||null> = null:
		  - stop
	    - if <[script].data_key[data.stats].contains[custom_model_data]> = true:
		  - define custom_model_data <[script].data_key[data.stats.custom_model_data]>
		  - define item <[item].with[custom_model_data=<[custom_model_data]>]>
		- define item <[item].with[raw_nbt=<map[ItemLingo=string:<[script].name>]>]>
		- if <[item].has_flag[gemstone]> = true:
		  - if <[item].flag[gemstone]> = false:
		    - define item <[item].with[raw_nbt=<map[ItemLingo=string:<[script].name>_gemact]>]>
		  - if <[item].flag[gemstone]> != false:
		    - define item <[item].with[raw_nbt=<map[ItemLingo=string:<[script].name>_gemact_<[item].flag[gemstone]>]>]>
	    - else:
		  - if <[item].has_flag[poison]> = true:
		    - if <[item].flag[poison]> = false:
		      - define item <[item].with[raw_nbt=<map[ItemLingo=string:<[script].name>_poisonact]>]>
		    - if <[item].flag[poison]> != false:
		      - define item <[item].with[raw_nbt=<map[ItemLingo=string:<[script].name>_poisonact_<[item].flag[poison]>]>]>
	    - determine <[item]>
item_generate_event:
    type: world
	debug: false
	events:
		on player picks up item:
		  - define item <context.item.script.name||null>
		  - if <[item]> != null:
		    - if <script[<[item]>].data_key[data]||null> != null:
		      - run item_generate def:<context.item> save:item
			  - define item <entry[item].created_queue.determination.get[1]>
			  - determine passively ITEM:<[item]>
		on player crafts item:
		  - if <script[<context.item.script.name>]||null> != null:
		    - if <script[<[item]>].data_key[data]||null> != null:
		      - run item_generate def:<context.item> save:item
			  - define item <entry[item].created_queue.determination.get[1]>
			  - determine passively item:<[item]>
		on item recipe formed:
		  - if <script[<context.item.script.name>]||null> != null:
		    - if <script[<[item]>].data_key[data]||null> != null:
		      - run item_generate def:<context.item> save:item
			  - define item <entry[item].created_queue.determination.get[1]>
			  - determine passively item:<[item]>