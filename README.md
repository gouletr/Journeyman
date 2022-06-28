# Journeyman
### Follow, create and share in-game guides for leveling and other activities.
Journeyman serves as a foundation for writing leveling guides, attunement guides, farming routes, or any other similar activities that could be needed. I call them "journeys". It propose a new way of presenting, interacting and writing step by step guides. Give it a try and let me know if you like it!

**The addon is currently in beta stage**, meaning that it is not considered finished yet. There are most likely bugs and other annoying things that needs to be discovered and fixed! But most importantly, it is not feature complete.

Also please note that this addon **does not include any journeys**. The intention is that journeys will be made by the community. In fact, if any leveling guide authors would like to embed their guides into my addon, please contact me!

## Features

### Automatic Step Completion
Steps are automatically completed when you do them. Step types currently includes:
- **Accept Quest** `questId`: Instruct the player to accept a quest.
- **Complete Quest** `questId,[objectiveId,...]`: Instruct the player to complete a quest objectives. Objective IDs are optional, but they are useful to specify the order in which objectives must be completed, or if only specific objectives must be completed.
- **Turn-in Quest** `questId`: Instruct the player to turn-in a quest.
- **Go to Coordinates** `mapId,x,y,[description]`: Instruct the player to go to a specific location. Description is optional, coordinates will be used if not provided.
- **Travel to Zone** `mapId,[x,y]`: Instruct the player to travel to a specific zone. Player does not need to reach specific coordinates, just enter the zone. Optional coordinates can be provided to help direction.
- **Reach Level** `level,[xp]`: Instruct the player to gain xp to reach the specified level. Optional specific xp within that level can be specified.
- **Bind Hearthstone** `areaId`: Instruct the player to bind their hearthstone to the specified area ID.
- **Use Hearthstone** `areaId`: Instruct the player to use their hearthstone to the specified area ID.
- **Learn Flight Path** `taxiNodeId`: Instruct the player to learn the specified flight path node.
- **Fly To** `taxiNodeId`: Instruct the player to fly to the specified flight path node.
- **Train Class**: Instruct the player to train their class skills.
- **Train Spells** `spellId,...`: Instruct the player to train specific spells.
- **Learn Cooking**: Instruct the player to learn the Cooking secondary profession.
- **Learn First Aid**: Instruct the player to learn the First Aid secondary profession.
- **Learn Fishing**: Instruct the player to learn the Fishing secondary profession.
- **Die and Spirit Res**: Instruct the player to die and use spirit resurrection.

### In-Game Editor
You can create journeys in-game, using the integrated editor. Each journey have a list of chapters, and each chapter a list of steps. Each step has a type and data associated. There is no need to write any lengthy verbose text, all steps are a simple combination of its type and its data.

### Record Journeys While Playing
Creating journeys couldn't be made easier! Simply turn on the "Update Active Journey" option and the addon will automatically append any step you do in the game to your active journey.

### Share Journeys In-Game
Journeys can be imported and exported as compressed data, encoded as text that you can copy paste anywhere (just like WeakAuras).

### Customizable Appearance
You don't like having a background? You prefer a different text size? You want to see more steps ahead? I got you covered!

### Interactive Quest Links
Clicking a quest link will open the quest log or Questie tooltip for that quest. You can also link quest in chat channels with shift+click.

### Interactive Quest Objectives
You can shift+click a quest objective to get the item link. Useful if you need to search or buy an item on auction house.

### Interactive Item Links
Clicking an item will open its tooltip as expected. You can link that item in chat channels with shift+click. You can open dressing room with that item with ctrl+click.

### Short Links Resolve
If you need to write notes on a step, you can use short links to specify many things like npcs, items, maps, quests and spells. Simply type the short link in your text, such as `item:19019` or `spell:498`, and they will be automatically converted to text or hyperlinks.

### Automatic Waypoint Arrow
If you have this option enabled and TomTom addon, upon step completion the TomTom crazy arrow will point you to the next step automatically. You can always set the waypoint arrow manually by using ctrl+click on a step.

### Targeting Macro
Every time a new step becomes current, a macro named **Journeyman** will be created or updated with a target command of the NPCs required to complete the step. Very useful when you need to tag or search for an NPC.

## In Development
The addon is still in development, expect more step types, more interactive features, more appearance customization options, a better in-game editor, better journey sharing, and better group functionalities. Needless to say, there is still a lot to do.

## Authors
Made with love, by Erunehtar.
