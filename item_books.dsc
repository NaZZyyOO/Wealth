book_opens:
    type: world
	debug: false
	events:
	    on player right clicks block with:written_book:
		  - if <player.item_in_hand.script.name||null> = null:
		    - stop
		  - determine passively cancelled
		  - if <player.locale> = uk_ua:
		    - if <script[<player.item_in_hand.script.name>]||null> != null:
		      - define book <script[<player.item_in_hand.script.name>].data_key[data.stats.book]>
			  - if <[book]||null> !=  null:
			    - adjust <player> show_book:<[book]>_ua
		  - if <player.locale> = ru_ru:
		    - if <script[<player.item_in_hand.script.name>]||null> != null:
		      - define book <script[<player.item_in_hand.script.name>].data_key[data.stats.book]>
			  - if <[book]||null> != null:
			    - adjust <player> show_book:<[book]>_ru
		  - if <player.locale> = en_es:
		    - if <script[<player.item_in_hand.script.name>]||null> != null:
		      - define book <script[<player.item_in_hand.script.name>].data_key[data.stats.book]>
			  - if <[book]||null> != null:
			    - adjust <player> show_book:<[book]>_en
item_book_beasts:
  type: item
  debug: false
  material: written_book
  display name: "Notes on Beasts"
  mechanisms:
    book_generation: COPY_OF_COPY
    unbreakable: true
  data:
    stats:
      display: "Notes on Beasts"
      rarity: common
      custom_model_data: 4
	  book: book_beasts
      lore:
        item: "<&8><&l>Item: <&r>Book"
        rare: "<&7><&l>Type: <&r>Common"
        text_01: "<n><&7><&o>Experienced hunter's notes on beasts"
        text_02: "<&7><&o>in the vicinity of Amber Castle."

item_book_undead:
  type: item
  debug: false
  material: written_book
  display name: "War Against the Undead"
  mechanisms:
    book_generation: COPY_OF_COPY
    unbreakable: true
  data:
    stats:
      display: "War Against the Undead"
      rarity: common
      custom_model_data: 3
	  book: book_undead
      lore:
        item: "<&8><&l>Item: <&r>Book"
        rare: "<&7><&l>Type: <&r>Common"
        text_01: "<n><&7><&o>Concise guide to waging war against the undead"
        text_02: "<&7><&o>in our world."

item_book_novice:
  type: item
  debug: false
  material: written_book
  display name: "Newcomer's Guide"
  mechanisms:
    book_generation: COPY_OF_COPY
    unbreakable: true
  data:
    stats:
      display: "Newcomer's Guide"
      rarity: common
      custom_model_data: 1
	  book: book_novice
      lore:
        item: "<&8><&l>Item: <&r>Note"
        rare: "<&7><&l>Type: <&r>Common"
        text_01: "<n><&7><&o>Basic instructions for newcomers"
        text_02: "<&7><&o>to navigate our world."

item_book_help:
  type: item
  debug: false
  material: written_book
  display name: "Book of Assistance"
  mechanisms:
    book_generation: COPY_OF_COPY
    unbreakable: true
  data:
    stats:
      display: "Book of Assistance"
      rarity: common
      custom_model_data: 2
	  book: book_help
      lore:
        item: "<&8><&l>Item: <&r>Book"
        rare: "<&7><&l>Type: <&r>Common"
        text_01: "<n><&7><&o>Guide to the world and"
        text_02: "<&7><&o>life advice."

item_book_malleus_maleficarum_01:
  type: item
  debug: false
  material: written_book
  display name: "Malleus Maleficarum - Volume I"
  mechanisms:
    book_generation: COPY_OF_ORIGINAL
    unbreakable: true
  data:
    stats:
      display: "Malleus Maleficarum - Volume I"
      rarity: legendary
      custom_model_data: 5
	  book: malleus_maleficarum_01
      lore:
        item: "<&8><&l>Item: <&r>Book"
        rare: "<&7><&l>Type: <&4>Legendary"
        text_01: "<n><&7><&o>About the position and activities"
        text_02: "<&7><&o>of the Inquisition in our world."

item_book_malleus_maleficarum_02:
  type: item
  debug: false
  material: written_book
  display name: "Malleus Maleficarum - Volume II"
  mechanisms:
    book_generation: COPY_OF_ORIGINAL
    unbreakable: true
  data:
    stats:
      display: "Malleus Maleficarum - Volume II"
      rarity: legendary
      custom_model_data: 5
	  book: malleus_maleficarum_02
      lore:
        item: "<&8><&l>Item: <&r>Book"
        rare: "<&7><&l>Type: <&4>Legendary"
        text: "<n><&7><&o>About heresy."

item_book_malleus_maleficarum_03:
  type: item
  debug: false
  material: written_book
  display name: "Malleus Maleficarum - Volume III"
  mechanisms:
    book_generation: COPY_OF_ORIGINAL
    unbreakable: true
  data:
    stats:
      display: "Malleus Maleficarum - Volume III"
      rarity: legendary
      custom_model_data: 5
	  book: malleus_maleficarum_03
      lore:
        item: "<&8><&l>Item: <&r>Book"
        rare: "<&7><&l>Type: <&4>Legendary"
        text: "<n><&7><&o>About punishment and retribution."

item_book_the_last_apocrypha:
  type: item
  debug: false
  material: written_book
  display name: "The Last Apocrypha"
  mechanisms:
    book_generation: TATTERED
    unbreakable: true
  data:
    stats:
      display: "The Last Apocrypha"
      rarity: mythic
      custom_model_data: 11
	  book: book_the_last_apocrypha
      lore:
        item: "<&8><&l>Item: <&r>Book"
        rare: "<&7><&l>Type: <&6>Mythic"
        text_01: "<n><&7><&o>This book, found in the Claw of God,"
        text_02: "<&7><&o>is so old and tattered that"
        text_03: "<&7><&o>it seems like it could crumble"
        text_04: "<&7><&o>at the slightest breeze."

item_book_goblins:
  type: item
  debug: false
  material: written_book
  display name: "Goblins and Lesser Orcoids"
  mechanisms:
    book_generation: COPY_OF_COPY
    unbreakable: true
  data:
    stats:
      display: "Goblins and Lesser Orcoids"
      rarity: common
      custom_model_data: 7
	  book: book_goblins
      lore:
        item: "<&8><&l>Item: <&r>Book"
        rare: "<&7><&l>Type: <&r>Common"
        text_01: "<n><&7><&o>Observations and insights on goblins,"
        text_02: "<&7><&o>orcs, and similar creatures."
item_book_rifts_theory:
  type: item
  debug: false
  material: written_book
  display name: "Theory of Rifts"
  mechanisms:
    book_generation: COPY_OF_COPY
    unbreakable: true
  data:
    stats:
      display: "Theory of Rifts"
      rarity: rare
      custom_model_data: 8
	  book: book_rifts_theory
      lore:
        item: "<&8><&l>Item: <&r>Book"
        rare: "<&7><&l>Type: <&9>Rare"
        text_01: "<n><&7><&o>Dimensional theory of universes,"
        text_02: "<&7><&o>speculations, and recent achievements"
        text_03: "<&7><&o>in creating rifts between worlds."

item_book_myths_01:
  type: item
  debug: false
  material: written_book
  display name: "Myths of the First Epoch - Volume I"
  mechanisms:
    book_generation: TATTERED
    unbreakable: true
  data:
    stats:
      display: "Myths of the First Epoch - Volume I"
      rarity: rare
      custom_model_data: 10
	  book: book_myths_01
      lore:
        item: "<&8><&l>Item: <&r>Book"
        rare: "<&7><&l>Type: <&9>Rare"
        text_01: "<n><&7><&o>Very old book with myths of ancient times."
        text_02: "<&7><&o>It's rare to find such a book intact."

item_book_myths_02:
  type: item
  debug: false
  material: written_book
  display name: "Myths of the First Epoch - Volume II"
  mechanisms:
    book_generation: TATTERED
    unbreakable: true
  data:
    stats:
      display: "Myths of the First Epoch - Volume II"
      rarity: rare
      custom_model_data: 10
	  book: book_myths_02
      lore:
        item: "<&8><&l>Item: <&r>Book"
        rare: "<&7><&l>Type: <&9>Rare"
        text_01: "<n><&7><&o>Very old book with myths of ancient times."
        text_02: "<&7><&o>It's rare to find such a book intact."

item_book_last_god_01:
  type: item
  debug: false
  material: written_book
  display name: "Tale of the Last God of the Old World - Volume I"
  mechanisms:
    book_generation: TATTERED
    unbreakable: true
  data:
    stats:
      display: "Tale of the Last God of the Old World - Volume I"
      rarity: rare
      custom_model_data: 9
	  book: book_last_god_01
      lore:
        item: "<&8><&l>Item: <&r>Book"
        rare: "<&7><&l>Type: <&9>Rare"
        text_01: "<n><&7><&o>Ancient book written by an unknown author"
        text_02: "<&7><&o>in the first epoch."

item_book_last_god_02:
  type: item
  debug: false
  material: written_book
  display name: "<&6><&l>Tale of the Last God of the Old World - Volume II"
  mechanisms:
    book_generation: TATTERED
    unbreakable: true
  data:
    stats:
      display: "Tale of the Last God of the Old World - Volume II"
      rarity: rare
      custom_model_data: 9
	  book: book_last_god_02
      lore:
        item: "<&8><&l>Item: <&r>Book"
        rare: "<&7><&l>Type: <&9>Rare"
        text_01: "<n><&7><&o>Ancient book written by an unknown author"
        text_02: "<&7><&o>in the first epoch."

item_book_last_god_03:
  type: item
  debug: false
  material: written_book
  display name: "<&6><&l>Tale of the Last God of the Old World - Volume III"
  mechanisms:
    book_generation: TATTERED
    unbreakable: true
  data:
    stats:
      display: "Tale of the Last God of the Old World - Volume III"
      rarity: rare
      custom_model_data: 9
	  book: book_last_god_03
      lore:
        item: "<&8><&l>Item: <&r>Book"
        rare: "<&7><&l>Type: <&9>Rare"
        text_01: "<n><&7><&o>Ancient book written by an unknown author"
        text_02: "<&7><&o>in the first epoch."

item_book_sch_emerald:
  type: item
  debug: false
  material: written_book
  display name: "Emerald Equipment"
  mechanisms:
    book_generation: COPY_OF_COPY
    unbreakable: true
  data:
    stats:
      display: "Emerald Equipment"
      rarity: common
      custom_model_data: 6
	  book: book_sch_emerald
      lore:
        item: "<&8><&l>Item: <&r>Book"
        rare: "<&7><&l>Type: <&r>Common"
        text_01: "<n><&7><&o>General information about emerald equipment"
        text_02: "<&7><&o>and blueprints for its creation."

item_book_sch_steel:
  type: item
  debug: false
  material: written_book
  display name: "Casting and Forging Steel"
  mechanisms:
    book_generation: COPY_OF_COPY
    unbreakable: true
  data:
    stats:
      display: "Casting and Forging Steel"
      rarity: common
      custom_model_data: 6
	  book: book_sch_steel
      lore:
        item: "<&8><&l>Item: <&r>Book"
        rare: "<&7><&l>Type: <&r>Common"
        text_01: "<n><&7><&o>General information about casting and forging steel."
        text_02: "<&7><&o>Instructions for smelting steel and blueprints"
        text_03: "<&7><&o>for steel tools with modifications."

item_book_sch_titan:
  type: item
  debug: false
  material: written_book
  display name: "Creation and Forging of Titan"
  mechanisms:
    book_generation: COPY_OF_COPY
    unbreakable: true
  data:
    stats:
      display: "Creation and Forging of Titan"
      rarity: common
      custom_model_data: 6
	  book: book_sch_titan
      lore:
        item: "<&8><&l>Item: <&r>Book"
        rare: "<&7><&l>Type: <&r>Common"
        text_01: "<n><&7><&o>General information about creating and forging titan."
        text_02: "<&7><&o>Instructions for smelting titan and blueprints"
        text_03: "<&7><&o>for titan armor and weapons."

item_book_forbidden_manuscript:
  type: item
  debug: false
  material: written_book
  display name: "Forgotten Manuscript"
  mechanisms:
    book_generation: TATTERED
    unbreakable: true
  data:
    stats:
      display: "Forgotten Manuscript"
      rarity: mythic
      custom_model_data: 11
	  book: book_forbidden_manuscript
      lore:
        item: "<&8><&l>Item: <&r>Book"
        rare: "<&7><&l>Type: <&6>Mythic"
        text_01: "<n><&7><&o>Very old manuscript,"
        text_02: "<&7><&o>clearly missing many pages."
        text_03: "<&7><&o>If you look closely, you can see a badly"
        text_04: "<&7><&o>crumpled sheet of paper sticking out of it."

item_book_fish_food_recipes:
  type: item
  debug: false
  material: paper
  display name: "Sheet with Fish Recipes"
  flags:
    recipe: item_food_salted_arapaima|item_food_raw_spiced_red_perch|item_food_raw_salmon_in_cream|item_food_raw_kambala_kebab
  data:
    stats:
      display: "Sheet with Fish Recipes"
      rarity: common
      custom_model_data: 2
      lore:
        item: "<&8><&l>Item: <&r>Sheet of Text"
        rare: "<&7><&l>Type: <&r>Common"
        text_01: "<n><&7><&o>Book of a local chef who prepares"
        text_02: "<&7><&o>the best fish snacks. This book"
        text_03: "<&7><&o>contains all the recipes on how to prepare"
        text_04: "<&7><&o>fish for baking in the oven."

item_book_for_cooking_recipes:
  type: item
  debug: false
  material: paper
  display name: "Sheet with Cooking Item Recipes"
  flags:
    recipe: item_raw_clay_bowl|item_sunflower_oil
  data:
    stats:
      display: "Sheet with Cooking Item Recipes"
      rarity: common
      custom_model_data: 2
      lore:
        item: "<&8><&l>Item: <&r>Sheet of Text"
        rare: "<&7><&l>Type: <&r>Common"
        text_01: "<n><&7><&o>Recipe book for some cooking items"
        text_02: "<&7><&o>necessary for cooking."