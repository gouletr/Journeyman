local addonName, addon = ...
local L = LibStub("AceLocale-3.0"):NewLocale(addonName, "enGB")
if not L then return end

L["AUTO_SCROLL"] = "Auto Scroll"
L["AUTO_SCROLL_DESC"] = "Automatically scroll the window to the current step."
L["AUTO_SET_WAYPOINT"] = "Auto Set Waypoint Arrow"
L["AUTO_SET_WAYPOINT_DESC"] = "Automatically set TomTom waypoint arrow to next step."
L["AUTO_SET_WAYPOINT_MIN"] = "Minimum Distance"
L["AUTO_SET_WAYPOINT_MIN_DESC"] = "Minimum distance to automatically set TomTom waypoint arrow."
L["CHAPTER_INDEX_LABEL"] = "Chapter Index"
L["CHAPTER_TITLE"] = "Chapter %d: %s"
L["CHAPTER_TITLE_LABEL"] = "Chapter Title"
L["CLAMP_WINDOW"] = "Clamp Window"
L["CLAMP_WINDOW_DESC"] = "Prevent window from moving outside the screen."
L["COPY_CHAPTER"] = "Copy Chapter"
L["COPY_TEXT_BELOW"] = "Copy text below"
L["CREATE_NEW_JOURNEY"] = "Create New Journey"
L["CREATE_NEW_JOURNEY_DESC"] = "Create a new journey, make it active and open it in the journey editor."
L["DEBUGGING_OPTIONS"] = "Debugging Options"
L["DELETE_CHAPTER"] = "Delete Chapter"
L["DELETE_JOURNEY"] = "Delete Journey"
L["DELETE_STEP"] = "Delete Step"
L["DIE_AND_SPIRIT_RES"] = "You can choose to die now and use spirit healer service."
L["DROPDOWN_ACCEPT_QUEST"] = "Accept Quest"
L["DROPDOWN_ACQUIRE_ITEMS"] = "Acquire Items"
L["DROPDOWN_BIND_HEARTHSTONE"] = "Bind Hearthstone"
L["DROPDOWN_COMPLETE_QUEST"] = "Complete Quest"
L["DROPDOWN_DIE_AND_RES"] = "Die and Spirit Res"
L["DROPDOWN_FLY_TO"] = "Fly To"
L["DROPDOWN_GO_TO_AREA"] = "Go to Area"
L["DROPDOWN_GO_TO_COORD"] = "Go to Coordinates"
L["DROPDOWN_GO_TO_ZONE"] = "Travel to Zone"
L["DROPDOWN_LEARN_COOKING"] = "Learn Cooking"
L["DROPDOWN_LEARN_FIRST_AID"] = "Learn First Aid"
L["DROPDOWN_LEARN_FISHING"] = "Learn Fishing"
L["DROPDOWN_LEARN_FLIGHT_PATH"] = "Learn Flight Path"
L["DROPDOWN_REACH_LEVEL"] = "Reach Level"
L["DROPDOWN_REACH_REPUTATION"] = "Reach Reputation"
L["DROPDOWN_TRAIN_CLASS"] = "Train Class"
L["DROPDOWN_TRAIN_SPELLS"] = "Train Spells"
L["DROPDOWN_TURNIN_QUEST"] = "Turn-in Quest"
L["DROPDOWN_USE_HEARTHSTONE"] = "Use Hearthstone"
L["ENABLE_DEBUG"] = "Enable Debug"
L["ENABLE_DEBUG_DESC"] = "Toggle debugging mode."
L["ENABLE_DEBUG_TEXT"] = "This option controls whether debugging information and tools are enabled or not. This can add a lot of messages to the console, and shouldn't be necessary unless there are problems."
L["EXPORT_JOURNEY"] = "Export Journey"
L["EXPORT_JOURNEY_DESC"] = "Export journey to string."
L["FONT_SIZE"] = "Font Size"
L["FONT_SIZE_DESC"] = "Font size used in the window."
L["HARDCORE_MODE"] = "Hardcore Mode"
L["HARDCORE_MODE_DESC"] = "Enable hardcore mode. Disables die steps."
L["IMPORT_JOURNEY"] = "Import Journey"
L["IMPORT_JOURNEY_DESC"] = "Import journey from string."
L["INDENT_SIZE"] = "Indentation Size"
L["INDENT_SIZE_DESC"] = "Size of the text indentation in the window."
L["INVALID_JOURNEY"] = "Invalid journey"
L["JOURNEY_AS_DATA"] = "As Compressed Data"
L["JOURNEY_AS_TEXT"] = "As Text"
L["JOURNEY_INDEX_LABEL"] = "Journey Index"
L["JOURNEY_OPTIONS"] = "Journey Options"
L["JOURNEY_TITLE_LABEL"] = "Journey Title"
L["LINE_SPACING"] = "Line Spacing"
L["LINE_SPACING_DESC"] = "Space between lines of text in the window."
L["LOCK_WINDOW"] = "Lock Window"
L["LOCK_WINDOW_DESC"] = "Toggle window lock to prevent moving or resizing."
L["MISSING_CHAPTER_TITLE"] = "No Chapter"
L["MY_JOURNEY_ABANDONED_QUESTS"] = "Remove Abandoned Quests"
L["MY_JOURNEY_ABANDONED_QUESTS_DESC"] = "Toggle removing all steps related to quests that were abandoned."
L["MY_JOURNEY_AT_MAX_LEVEL"] = "Record At Max Level"
L["MY_JOURNEY_AT_MAX_LEVEL_DESC"] = "Toggle recording of steps after reaching max level."
L["MY_JOURNEY_ENABLE"] = "Enable Recording"
L["MY_JOURNEY_ENABLE_DESC"] = "Toggle recording of steps in your character journey."
L["MY_JOURNEY_HEADER_OPTIONS"] = "Options"
L["MY_JOURNEY_HEADER_STEP_TYPES"] = "Step Types"
L["MY_JOURNEY_STEP_ACCEPT_QUEST"] = "Accept Quest"
L["MY_JOURNEY_STEP_ACCEPT_QUEST_DESC"] = "Toggle recording of steps related to accepting quests."
L["MY_JOURNEY_STEP_BIND_HEARTHSTONE"] = "Bind Hearthstone"
L["MY_JOURNEY_STEP_BIND_HEARTHSTONE_DESC"] = "Toggle recording of steps related to binding hearthstone."
L["MY_JOURNEY_STEP_COMPLETE_QUEST"] = "Complete Quest"
L["MY_JOURNEY_STEP_COMPLETE_QUEST_DESC"] = "Toggle recording of steps related to completing quests."
L["MY_JOURNEY_STEP_DIE_AND_RES"] = "Die and Resurrect"
L["MY_JOURNEY_STEP_DIE_AND_RES_DESC"] = "Toggle recording of steps related to dying and using spirit resurrection service."
L["MY_JOURNEY_STEP_FLY_TO"] = "Fly To"
L["MY_JOURNEY_STEP_FLY_TO_DESC"] = "Toggle recording of steps related to taking a flight path."
L["MY_JOURNEY_STEP_GO_TO_ZONE"] = "Travel to Zone"
L["MY_JOURNEY_STEP_GO_TO_ZONE_DESC"] = "Toggle recording of steps related to traveling to a zone."
L["MY_JOURNEY_STEP_LEARN_FLIGHT_PATH"] = "Learn Flight Path"
L["MY_JOURNEY_STEP_LEARN_FLIGHT_PATH_DESC"] = "Toggle recording of steps related to learning new flight paths."
L["MY_JOURNEY_STEP_REACH_LEVEL"] = "Reach Level"
L["MY_JOURNEY_STEP_REACH_LEVEL_DESC"] = "Toggle recording of steps related to reaching a level."
L["MY_JOURNEY_STEP_TRAIN_CLASS"] = "Train Class"
L["MY_JOURNEY_STEP_TRAIN_CLASS_DESC"] = "Toggle recording of steps related to training your class. Mutually exclusive with Train Spells."
L["MY_JOURNEY_STEP_TRAIN_SPELLS"] = "Train Spells"
L["MY_JOURNEY_STEP_TRAIN_SPELLS_DESC"] = "Toggle recording of steps related to training spells. Mutually exclusive with Train Class."
L["MY_JOURNEY_STEP_TURNIN_QUEST"] = "Turn-in Quest"
L["MY_JOURNEY_STEP_TURNIN_QUEST_DESC"] = "Toggle recording of steps related to turning-in quests."
L["MY_JOURNEY_STEP_USE_HEARTHSTONE"] = "Use Hearthstone"
L["MY_JOURNEY_STEP_USE_HEARTHSTONE_DESC"] = "Toggle recording of steps related to using hearthstone."
L["NEW_CHAPTER"] = "New Chapter"
L["NEW_CHAPTER_TITLE"] = "New Chapter"
L["NEW_JOURNEY"] = "New Journey"
L["NEW_JOURNEY_TITLE"] = "New Journey"
L["NEW_STEP"] = "New Step"
L["NOT_A_NUMBER"] = "Not a Number"
L["NOT_A_STRING"] = "Not a String"
L["NO_JOURNEY_SELECTED"] = "No journey selected, please select a journey to continue."
L["NO_VALUE"] = "No Value"
L["NUMBER_OF_KILL"] = "%s kill"
L["OPEN_OPTIONS"] = "Open Options"
L["PASTE_CHAPTER"] = "Paste Chapter"
L["PASTE_TEXT_BELOW"] = "Paste text below"
L["RESET_POSITION"] = "Reset Position"
L["RESET_POSITION_DESC"] = "Reset the window position."
L["SAVED_PER_CHARACTER"] = "Saved per character."
L["SELECT_CHAPTER"] = "Select Chapter"
L["SELECT_JOURNEY"] = "Select Journey"
L["SELECT_JOURNEY_DESC"] = "Select which journey to use."
L["SELECT_STEP"] = "Select Step"
L["SHOW_COMPLETED_STEPS"] = "Show Completed Steps"
L["SHOW_COMPLETED_STEPS_DESC"] = "Toggle showing completed steps."
L["SHOW_QUEST_LEVEL"] = "Show Quest Level"
L["SHOW_QUEST_LEVEL_DESC"] = "Toggle showing quest level."
L["SHOW_SCROLL_BAR"] = "Show Scroll Bar"
L["SHOW_SCROLL_BAR_DESC"] = "Toggle showing scroll bar next to the window."
L["SHOW_SKIPPED_STEPS"] = "Show Skipped Steps"
L["SHOW_SKIPPED_STEPS_DESC"] = "Toggle showing skipped steps."
L["SHOW_WINDOW"] = "Show Window"
L["SHOW_WINDOW_DESC"] = "Toggle showing window."
L["STEPS_SHOWN"] = "Number of Steps"
L["STEPS_SHOWN_DESC"] = "Number of steps shown in the window."
L["STEP_DATA_LABEL"] = "Step Data"
L["STEP_INDEX_LABEL"] = "Step Index"
L["STEP_NOTE_LABEL"] = "Step Note"
L["STEP_PREFIX_GO_TALK_TO"] = "Go talk to"
L["STEP_PREFIX_GO_TO"] = "Go to"
L["STEP_REQUIRED_CLASSES_LABEL"] = "Step Required Classes"
L["STEP_REQUIRED_RACES_LABEL"] = "Step Required Races"
L["STEP_TEXT_ACCEPT_QUEST"] = "Accept %s"
L["STEP_TEXT_ACQUIRE_ITEMS"] = "Acquire items %s"
L["STEP_TEXT_BIND_HEARTHSTONE"] = "Bind %s to %s"
L["STEP_TEXT_COMPLETE_QUEST"] = "Complete %s"
L["STEP_TEXT_DIE_AND_RES"] = "Die and resurrect at the graveyard"
L["STEP_TEXT_FLY_TO"] = "Fly to %s"
L["STEP_TEXT_GAIN_REP"] = "Gain %s rep"
L["STEP_TEXT_GAIN_XP"] = "Gain %s xp"
L["STEP_TEXT_GO_TO_COORD"] = "Go to %s in %s"
L["STEP_TEXT_GO_TO_ZONE"] = "Travel to %s"
L["STEP_TEXT_LEARN_COOKING"] = "Learn cooking profession"
L["STEP_TEXT_LEARN_FIRST_AID"] = "Learn first aid profession"
L["STEP_TEXT_LEARN_FISHING"] = "Learn fishing profession"
L["STEP_TEXT_LEARN_FLIGHT_PATH"] = "Learn flight path to %s"
L["STEP_TEXT_NOTE"] = "Note: %s"
L["STEP_TEXT_REACH_LEVEL"] = "Reach level %s"
L["STEP_TEXT_REACH_REPUTATION"] = "Reach %s with %s"
L["STEP_TEXT_TRAIN_CLASS"] = "Train your class"
L["STEP_TEXT_TRAIN_SPELLS"] = "Train spells %s"
L["STEP_TEXT_TURNIN_QUEST"] = "Turn-in %s"
L["STEP_TEXT_USE_HEARTHSTONE"] = "Use %s to %s"
L["STEP_TYPE_LABEL"] = "Step Type"
L["UNDEFINED"] = "Undefined"
L["UPDATE_ACTIVE_JOURNEY"] = "Update Active Journey"
L["UPDATE_ACTIVE_JOURNEY_CONFIRM"] = "Enabling this option will add new steps to the active journey during your adventures, continue?"
L["UPDATE_ACTIVE_JOURNEY_DESC"] = "Update active journey with new steps."
L["UPDATE_ACTIVE_JOURNEY_DISABLED"] = "Option 'Update Active Journey' has been disabled for this character."
L["UPDATE_ACTIVE_JOURNEY_TEXT"] = "Enabling this option will cause new steps to be appended into the active journey chapter. Changing active journey will disable this option."
L["UPDATE_FREQUENCY"] = "Update Frequency (seconds)"
L["UPDATE_FREQUENCY_CONFIRM"] = "Changing this option requires a user interface reload, continue?"
L["UPDATE_FREQUENCY_DESC"] = "Period of time in seconds between each update check."
L["UPDATE_FREQUENCY_TEXT"] = "This option controls the frequency of updates. Decreasing the value will cause the addon to check more often if updates are needed. It is recommended not to change this value."
L["UPDATE_OPTIONS"] = "Update Options"
L["WINDOW_BG_COLOR"] = "Background Color"
L["WINDOW_BG_COLOR_DESC"] = "Background color of the window."
L["WINDOW_HEIGHT"] = "Height"
L["WINDOW_HEIGHT_DESC"] = "Height of the window."
L["WINDOW_LEVEL"] = "Level"
L["WINDOW_LEVEL_DESC"] = "Control the level (display order) of the window."
L["WINDOW_OPTIONS"] = "Window Options"
L["WINDOW_STEP_SPACING"] = "Step Spacing"
L["WINDOW_STEP_SPACING_DESC"] = "Space between steps in the window."
L["WINDOW_STRATA"] = "Strata"
L["WINDOW_STRATA_DESC"] = "Control the strata (display layer) of the window."
L["WINDOW_WIDTH"] = "Width"
L["WINDOW_WIDTH_DESC"] = "Width of the window."

if WOW_PROJECT_ID == WOW_PROJECT_CLASSIC then
    L["REGEX_COMBAT_FACTION_CHANGE"] = "Your (.+) reputation has increased by (%d+)."
    L["REGEX_COMBAT_XP_GAIN"] = "(.+) dies, you gain (%d+) experience."
elseif WOW_PROJECT_ID == WOW_PROJECT_BURNING_CRUSADE_CLASSIC then
    L["REGEX_COMBAT_FACTION_CHANGE"] = "Reputation with (.+) increased by (%d+)."
    L["REGEX_COMBAT_XP_GAIN"] = "(.+) dies, you gain (%d+) experience."
elseif WOW_PROJECT_ID == WOW_PROJECT_WRATH_CLASSIC then
    L["REGEX_COMBAT_FACTION_CHANGE"] = "Reputation with (.+) increased by (%d+)."
    L["REGEX_COMBAT_XP_GAIN"] = "(.+) dies, you gain (%d+) experience."
else
    error(string.format("Unsupported WoW version (WOW_PROJECT_ID = %s)", WOW_PROJECT_ID))
end
