local addonName, addon = ...
local addonVersion = GetAddOnMetadata(addonName, "version")
local Traveler = addon.Traveler
local L = addon.Locale

local STEP_TYPE_DROPDOWN_UNDEFINED = L["Undefined"]
local STEP_TYPE_DROPDOWN_ACCEPT_QUEST = L["Accept Quest"]
local STEP_TYPE_DROPDOWN_COMPLETE_QUEST = L["Complete Quest"]
local STEP_TYPE_DROPDOWN_TURNIN_QUEST = L["Turn-in Quest"]
local STEP_TYPE_DROPDOWN_FLY_TO = L["Fly To"]
local STEP_TYPE_DROPDOWN_BIND_HEARTHSTONE = L["Bind Hearthstone"]
local STEP_TYPE_DROPDOWN_USE_HEARTHSTONE = L["Use Hearthstone"]
local STEP_TYPE_DROPDOWN_REACH_LEVEL = L["Reach Level"]

local function Percent(value)
    local windowWidth = 600
    local widthMultiplier = 170
    return (value * windowWidth) / widthMultiplier
end

function Traveler:InitializeOptions()
    LibStub("AceConfig-3.0"):RegisterOptionsTable(addonName, self:GetOptionsTable(), "traveler")

    local aceConfigDialog = LibStub("AceConfigDialog-3.0")
    self.generalOptions = aceConfigDialog:AddToBlizOptions(addonName, addonName, nil, "general")
    xpcall(function()
        Traveler.editor = self:GetJourneyEditor()
        InterfaceOptions_AddCategory(Traveler.editor)
    end, geterrorhandler())
    --self.journeysOptions = aceConfigDialog:AddToBlizOptions(addonName, "Journeys (OLD)", addonName, "journeys")
    self.advancedOptions = aceConfigDialog:AddToBlizOptions(addonName, "Advanced", addonName, "advanced")
    self.profileOptions = aceConfigDialog:AddToBlizOptions(addonName, "Profiles", addonName, "profiles")
end

function Traveler:GetOptionsTable()
    return {
        type = "group",
        name = string.format("%s v%s", addonName, addonVersion),
        args = {
            general = self:GetGeneralOptionsTable(),
            journeys = self:GetJourneysOptionsTable(),
            advanced = self:GetAdvancedOptionsTable(),
            profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)
        }
    }
end

function Traveler:GetGeneralOptionsTable()
    return {
        type = "group",
        name = "General",
        args = {
            journeyHeader = {
                order = 0,
                type = "header",
                name = L["JOURNEY_OPTIONS"]
            },
            journey = {
                order = 1,
                type = "select",
                name = L["SELECT_JOURNEY"] .. "*",
                desc = L["SELECT_JOURNEY_DESC"] .. "\n" .. L["SAVED_PER_CHARACTER"],
                width = Percent(0.5),
                values = function(info)
                    local values = {}
                    for _, v in ipairs(self.journeys) do
                        values[v.guid] = v.title
                    end
                    return values
                end,
                sorting = function(info)
                    local sorting = {}
                    for i, journey in ipairs(self.journeys) do
                        sorting[i] = journey.guid
                    end
                end,
                set = function(info, value)
                    if self.db.char.window.journey ~= value then
                        self.db.char.window.journey = value
                        self.db.char.window.chapter = 1
                        if self.db.char.updateJourney then
                            self.db.char.updateJourney = false
                            Traveler:Print(L["Disabled Update Active Journey option for this character."])
                        end
                        Traveler.updateWaypoint = true
                        Traveler:Reset(true)
                    end
                end,
                get = function(info) return self.db.char.window.journey end
            },
            reserved1 = {
                order = 2,
                type = "description",
                name = "",
                width = Percent(0.5)
            },
            autoSetWaypoint = {
                order = 3,
                type = "toggle",
                name = L["AUTO_SET_WAYPOINT"],
                desc = L["AUTO_SET_WAYPOINT_DESC"],
                width = Percent(0.5),
                get = function(info) return self.db.profile.autoSetWaypoint end,
                set = function(info, value)
                    if self.db.profile.autoSetWaypoint ~= value then
                        self.db.profile.autoSetWaypoint = value
                        Traveler:Update()
                    end
                end
            },
            autoSetWaypointMin = {
                order = 4,
                type = "range",
                name = L["AUTO_SET_WAYPOINT_MIN"],
                desc = L["AUTO_SET_WAYPOINT_MIN_DESC"],
                min = 0,
                softMin = 0,
                softMax = 100,
                step = 1,
                bigStep = 5,
                disabled = function() return not self.db.profile.autoSetWaypoint end,
                width = Percent(0.5),
                get = function(info) return self.db.profile.autoSetWaypointMin end,
                set = function(info, value)
                    if self.db.profile.autoSetWaypointMin ~= value then
                        self.db.profile.autoSetWaypointMin = value
                        Traveler:Update()
                    end
                end
            },
            windowHeader = {
                order = 20,
                type = "header",
                name = L["WINDOW_OPTIONS"]
            },
            show = {
                order = 21,
                type = "toggle",
                name = L["SHOW_WINDOW"] .. "*",
                desc = L["SHOW_WINDOW_DESC"] .. "\n" .. L["SAVED_PER_CHARACTER"],
                width = Percent(0.5),
                get = function(info) return self.db.char.window.show end,
                set = function(info, value)
                    if self.db.char.window.show ~= value then
                        self.db.char.window.show = value
                        if value then
                            Traveler.updateWaypoint = true
                            Traveler:Reset(true)
                        else
                            Traveler.Tracker:UpdateImmediate()
                        end
                    end
                end
            },
            locked = {
                order = 22,
                type = "toggle",
                name = L["LOCK_WINDOW"],
                desc = L["LOCK_WINDOW_DESC"],
                width = Percent(0.5),
                get = function(info) return self.db.profile.window.locked end,
                set = function(info, value)
                    if self.db.profile.window.locked ~= value then
                        self.db.profile.window.locked = value
                        self.Tracker:Update(true)
                    end
                end
            },
            clamped = {
                order = 23,
                type = "toggle",
                name = L["CLAMP_WINDOW"],
                desc = L["CLAMP_WINDOW_DESC"],
                width = Percent(0.5),
                get = function(info) return self.db.profile.window.clamped end,
                set = function(info, value)
                    if self.db.profile.window.clamped ~= value then
                        self.db.profile.window.clamped = value
                        self.Tracker:Update(true)
                    end
                end
            },
            resetPosition = {
                order = 24,
                type = "execute",
                name = L["RESET_POSITION"],
                desc = L["RESET_POSITION_DESC"],
                width = Percent(0.5),
                func = function()
                    self.db.profile.window.relativePoint = "CENTER"
                    self.db.profile.window.x = 0
                    self.db.profile.window.y = 0
                    self.Tracker.frame:ClearAllPoints()
                    self.Tracker.frame:SetPoint("CENTER", UIParent, "CENTER")
                    self.Tracker:Update(true)
                end
            },
            showScrollBar = {
                order = 25,
                type = "toggle",
                name = L["SHOW_SCROLL_BAR"],
                desc = L["SHOW_SCROLL_BAR_DESC"],
                width = Percent(0.5),
                get = function(info) return self.db.profile.window.showScrollBar end,
                set = function(info, value)
                    if self.db.profile.window.showScrollBar ~= value then
                        self.db.profile.window.showScrollBar = value
                        self.Tracker:Update(true)
                    end
                end
            },
            showQuestLevel = {
                order = 26,
                type = "toggle",
                name = L["SHOW_QUEST_LEVEL"],
                desc = L["SHOW_QUEST_LEVEL_DESC"],
                width = Percent(0.5),
                get = function(info) return self.db.profile.window.showQuestLevel end,
                set = function(info, value)
                    if self.db.profile.window.showQuestLevel ~= value then
                        self.db.profile.window.showQuestLevel = value
                        self.Tracker:Update(true)
                    end
                end
            },
            showCompletedSteps = {
                order = 27,
                type = "toggle",
                name = L["SHOW_COMPLETED_STEPS"],
                desc = L["SHOW_COMPLETED_STEPS_DESC"],
                width = Percent(0.5),
                get = function(info) return self.db.profile.window.showCompletedSteps end,
                set = function(info, value)
                    if self.db.profile.window.showCompletedSteps ~= value then
                        self.db.profile.window.showCompletedSteps = value
                        Traveler:Update(true)
                    end
                end
            },
            showSkippedSteps = {
                order = 28,
                type = "toggle",
                name = L["SHOW_SKIPPED_STEPS"],
                desc = L["SHOW_SKIPPED_STEPS_DESC"],
                width = Percent(0.5),
                get = function(info) return self.db.profile.window.showSkippedSteps end,
                set = function(info, value)
                    if self.db.profile.window.showSkippedSteps ~= value then
                        self.db.profile.window.showSkippedSteps = value
                        Traveler:Update(true)
                    end
                end
            },
            stepsShown = {
                order = 29,
                type = "range",
                name = L["STEPS_SHOWN"],
                desc = L["STEPS_SHOWN_DESC"],
                min = 0,
                softMin = 1,
                softMax = 25,
                step = 1,
                width = Percent(0.5),
                get = function(info) return self.db.profile.window.stepsShown end,
                set = function(info, value)
                    if self.db.profile.window.stepsShown ~= value then
                        self.db.profile.window.stepsShown = value
                        Traveler:Update(true)
                    end
                end
            },
            reserved2 = {
                order = 30,
                type = "description",
                name = "",
                width = Percent(0.004)
            },
            backgroundColor = {
                order = 31,
                type = "color",
                name = L["WINDOW_BG_COLOR"],
                desc = L["WINDOW_BG_COLOR_DESC"],
                hasAlpha = true,
                width = Percent(0.5),
                get = function(info)
                    local color = self.db.profile.window.backgroundColor
                    return color.r, color.g, color.b, color.a
                end,
                set = function(info, r, g, b, a)
                    self.db.profile.window.backgroundColor.r = r
                    self.db.profile.window.backgroundColor.g = g
                    self.db.profile.window.backgroundColor.b = b
                    self.db.profile.window.backgroundColor.a = a
                    self.Tracker:Update(true)
                end
            },
            width = {
                order = 32,
                type = "range",
                name = L["WINDOW_WIDTH"],
                desc = L["WINDOW_WIDTH_DESC"],
                min = 200,
                softMin = 200,
                softMax = 1000,
                step = 1,
                bigStep = 10,
                width = Percent(0.5),
                get = function(info) return self.db.profile.window.width end,
                set = function(info, value)
                    if self.db.profile.window.width ~= value then
                        self.db.profile.window.width = value
                        self.Tracker:Update(true)
                    end
                end
            },
            height = {
                order = 33,
                type = "range",
                name = L["WINDOW_HEIGHT"],
                desc = L["WINDOW_HEIGHT_DESC"],
                min = 100,
                softMin = 100,
                softMax = 1000,
                step = 1,
                bigStep = 10,
                width = Percent(0.5),
                get = function(info) return self.db.profile.window.height end,
                set = function(info, value)
                    if self.db.profile.window.height ~= value then
                        self.db.profile.window.height = value
                        self.Tracker:Update(true)
                    end
                end
            },
            fontSize = {
                order = 34,
                type = "range",
                name = L["FONT_SIZE"],
                desc = L["FONT_SIZE_DESC"],
                min = 8,
                max = 24,
                step = 1,
                width = Percent(0.5),
                get = function(info) return self.db.profile.window.fontSize end,
                set = function(info, value)
                    if self.db.profile.window.fontSize ~= value then
                        self.db.profile.window.fontSize = value
                        self.Tracker:Update(true)
                    end
                end
            },
            lineSpacing = {
                order = 35,
                type = "range",
                name = L["LINE_SPACING"],
                desc = L["LINE_SPACING_DESC"],
                min = 0,
                max = 24,
                step = 1,
                width = Percent(0.5),
                get = function(info) return self.db.profile.window.lineSpacing end,
                set = function(info, value)
                    if self.db.profile.window.lineSpacing ~= value then
                        self.db.profile.window.lineSpacing = value
                        self.Tracker:Update(true)
                    end
                end
            },
            windowStrata = {
                order = 36,
                type = "select",
                name = L["WINDOW_STRATA"],
                desc = L["WINDOW_STRATA_DESC"],
                width = Percent(0.5),
                values = {
                    ["BACKGROUND"] = "BACKGROUND",
                    ["LOW"] = "LOW",
                    ["MEDIUM"] = "MEDIUM",
                    ["HIGH"] = "HIGH",
                    ["DIALOG"] = "DIALOG",
                    ["FULLSCREEN"] = "FULLSCREEN",
                    ["FULLSCREEN_DIALOG"] = "FULLSCREEN_DIALOG",
                    ["TOOLTIP"] = "TOOLTIP"
                },
                sorting = {"BACKGROUND", "LOW", "MEDIUM", "HIGH", "DIALOG", "FULLSCREEN", "FULLSCREEN_DIALOG", "TOOLTIP"},
                get = function(info) return self.db.profile.window.strata end,
                set = function(info, value)
                    if self.db.profile.window.strata ~= value then
                        self.db.profile.window.strata = value
                        self.Tracker:Update(true)
                    end
                end
            },
            windowLevel = {
                order = 37,
                type = "range",
                name = L["WINDOW_LEVEL"],
                desc = L["WINDOW_LEVEL_DESC"],
                min = 0,
                max = 10000,
                step = 1,
                bigStep = 100,
                width = Percent(0.5),
                get = function(info) return self.db.profile.window.level end,
                set = function(info, value)
                    if self.db.profile.window.level ~= value then
                        self.db.profile.window.level = value
                        self.Tracker:Update(true)
                    end
                end
            }
        }
    }
end

function Traveler:GetJourneysOptionsTable()
    return {
        name = "Journeys",
        type = "group",
        args = {
            import = {
                type = "execute",
                name = L["IMPORT_JOURNEY"],
                desc = L["IMPORT_JOURNEY_DESC"],
                width = "full",
                func = function()
                    self:JourneyImportFromCharacter()
                end
            },
            journeys = {
                type = "select",
                name = L["SELECT_JOURNEY"],
                desc = L["SELECT_JOURNEY_DESC"],
                width = Percent(0.25),
                values = function()
                    local values = {}
                    for i,v in ipairs(self.journeys) do
                        values[i] = v.title
                    end
                    return values
                end,
                set = function(info, value) end,
                get = function(info) end
            }
        }
    }
end

function Traveler:GetAdvancedOptionsTable()
    return {
        name = "Advanced",
        type = "group",
        args = {
            journeyHeader = {
                order = 0,
                type = "header",
                name = L["Journey Options"]
            },
            updateJourney = {
                order = 1,
                type = "toggle",
                name = L["Update Active Journey"] .. "*",
                desc = L["Update active journey with new steps."] .. "\n" .. L["SAVED_PER_CHARACTER"],
                width = Percent(1.0),
                confirm = true,
                confirmText = L["Enabling this will modify active journey when playing, proceed?"],
                get = function(info) return self.db.char.updateJourney end,
                set = function(info, value)
                    if self.db.char.updateJourney ~= value then
                        self.db.char.updateJourney = value
                    end
                end
            },
            updateJourneyDesc = {
                order = 2,
                type = "description",
                name = L["Enabling this option will cause new steps to be appended into the active journey chapter. Abandoning a quest will remove all steps of that quest from all chapters. Changing active journey will disable this option."],
                width = Percent(1.0)
            },
            updateHeader = {
                order = 10,
                type = "header",
                name = L["Update Options"]
            },
            updateFrequency = {
                order = 11,
                type = "range",
                name = L["UPDATE_FREQUENCY"],
                desc = L["UPDATE_FREQUENCY_DESC"],
                min = 0.1,
                max = 5,
                step = 0.1,
                bigStep = 0.1,
                width = Percent(0.5),
                confirm = true,
                confirmText = L["Changing this setting requires a UI reload, proceed?"],
                get = function(info) return self.db.profile.advanced.updateFrequency end,
                set = function(info, value)
                    if self.db.profile.advanced.updateFrequency ~= value then
                        self.db.profile.advanced.updateFrequency = value
                        C_UI.Reload()
                    end
                end
            },
            updateFrequencyDesc = {
                order = 12,
                type = "description",
                name = L["This option controls the frequency of update checks. Decreasing the value will cause the addon to periodically check more often if any state or window updates are needed. It is recommended to not change this value."],
                width = Percent(1.0)
            },
            header = {
                order = 20,
                type = "header",
                name = L["Debugging Options"]
            },
            debug = {
                order = 21,
                type = "toggle",
                name = L["ENABLE_DEBUG"],
                desc = L["ENABLE_DEBUG_DESC"],
                width = Percent(0.25),
                get = function(info) return self.db.profile.advanced.debug end,
                set = function(info, value)
                    if self.db.profile.advanced.debug ~= value then
                        self.db.profile.advanced.debug = value
                        self.Tracker:Update(true)
                    end
                end
            },
            debugDesc = {
                order = 22,
                type = "description",
                name = L["This option controls whether or not debugging information and tools are enabled. This can add a great deal of spam in the console and should not be needed unless debugging the addon."],
                width = Percent(1.0)
            }
        }
    }
end

function Traveler:GetJourneyEditor()
    local frame = CreateFrame("FRAME", "Journeys", UIParent)
    frame.name = "Journeys"
    frame.parent = addonName
    frame:Hide()
    frame:SetScript("OnShow", function(self)
        self.refresh()
    end)

    local content = CreateFrame("FRAME", "Content", frame)
    content:SetPoint("TOPLEFT", frame, "TOPLEFT", 10, -15)
    content:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -10, 10)

    local title = Traveler.GUI:CreateLabel("FRAME", "Title", content)
    title:SetPoint("TOPLEFT")
    title:SetPoint("BOTTOMRIGHT", content, "TOPRIGHT", 0, -30)
    title:SetJustifyH("LEFT")
    title:SetJustifyV("TOP")
    title:SetFontSize(16)
    title:SetText("%s v%s - Journey Editor", addonName, addonVersion)

    local journeySelector = self:CreateSelector("Journeys", content)
    journeySelector:SetPoint("TOPLEFT", title, "BOTTOMLEFT")
    journeySelector:SetPoint("BOTTOMRIGHT", title, "BOTTOM", 0, -110)
    journeySelector:SetTitle(L["SELECT_JOURNEY"])
    journeySelector.list.GetValues = function(self)
        local values = {}
        for i = 1, #Traveler.journeys do
            values[i] = Traveler.journeys[i].title
        end
        return values
    end
    frame.journeySelector = journeySelector

    local chapterSelector = self:CreateSelector("Chapters", content)
    chapterSelector:SetPoint("TOPLEFT", title, "BOTTOM")
    chapterSelector:SetPoint("BOTTOMRIGHT", title, "BOTTOMRIGHT", 0, -110)
    chapterSelector:SetTitle(L["SELECT_CHAPTER"])
    chapterSelector.list.GetValues = function(self)
        local values = {}
        local journey = Traveler.editor:GetSelectedJourney()
        if journey then
            for i, v in ipairs(journey.chapters) do
                values[i] = v.title
            end
        end
        return values
    end
    frame.chapterSelector = chapterSelector

    local newJourneyButton = CreateFrame("BUTTON", "NewJourney", content, "UIPanelButtonTemplate")
    newJourneyButton:SetPoint("TOPLEFT", journeySelector, "BOTTOMLEFT")
    newJourneyButton:SetPoint("BOTTOMRIGHT", journeySelector, "BOTTOM", 0, -22)
    newJourneyButton:SetText(L["NEW_JOURNEY"])
    newJourneyButton:SetScript("OnClick", function(self, button, down)
        if Traveler.Journey:CreateJourney(L["NEW_JOURNEY_TITLE"]) then
            Traveler.editor:SetSelectedJourneyIndex(#Traveler.journeys)
            Traveler.editor:SetSelectedChapterIndex(-1)
            Traveler.editor:SetSelectedStepIndex(-1)
            frame.refresh()
        end
    end)

    StaticPopupDialogs[addonName .. "_DELETE_JOURNEY"] = {
        text = L["DELETE_JOURNEY"] .. "?",
        showAlert = true,
        button1 = ACCEPT,
        button2 = CANCEL,
        OnAccept = function()
            if Traveler.Journey:DeleteJourney(Traveler.editor:GetSelectedJourneyIndex()) then
                Traveler.editor:SetSelectedJourneyIndex(-1)
                Traveler.editor:SetSelectedChapterIndex(-1)
                Traveler.editor:SetSelectedStepIndex(-1)
                frame.refresh()
                Traveler:Reset(true)
            end
        end,
        sound = SOUNDKIT.IG_MAINMENU_OPEN,
        hideOnEscape = true,
    }
    local deleteJourneyButton = CreateFrame("BUTTON", "DeleteJourney", content, "UIPanelButtonTemplate")
    deleteJourneyButton:SetPoint("TOPLEFT", journeySelector, "BOTTOM")
    deleteJourneyButton:SetPoint("BOTTOMRIGHT", journeySelector, "BOTTOMRIGHT", 0, -22)
    deleteJourneyButton:SetText(L["DELETE_JOURNEY"])
    deleteJourneyButton:SetScript("OnClick", function(self, button, down)
        StaticPopup_Show(addonName .. "_DELETE_JOURNEY")
    end)

    local newChapterButton = CreateFrame("BUTTON", "NewChapter", content, "UIPanelButtonTemplate")
    newChapterButton:SetPoint("TOPLEFT", chapterSelector, "BOTTOMLEFT")
    newChapterButton:SetPoint("BOTTOMRIGHT", chapterSelector, "BOTTOM", 0, -22)
    newChapterButton:SetText(L["NEW_CHAPTER"])
    newChapterButton:SetScript("OnClick", function(self, button, down)
        local journey = Traveler.editor:GetSelectedJourney()
        if journey and Traveler.Journey:CreateChapter(journey, L["NEW_CHAPTER_TITLE"]) then
            Traveler.editor:SetSelectedChapterIndex(#journey.chapters)
            Traveler.editor:SetSelectedStepIndex(-1)
            frame.refresh()
            Traveler:Reset(true)
        end
    end)

    StaticPopupDialogs[addonName .. "_DELETE_CHAPTER"] = {
        text = L["DELETE_CHAPTER"] .. "?",
        showAlert = true,
        button1 = ACCEPT,
        button2 = CANCEL,
        OnAccept = function()
            local journey = Traveler.editor:GetSelectedJourney()
            if journey and Traveler.Journey:DeleteChapter(journey, Traveler.editor:GetSelectedChapterIndex()) then
                Traveler.editor:SetSelectedChapterIndex(-1)
                Traveler.editor:SetSelectedStepIndex(-1)
                frame.refresh()
                Traveler:Reset(true)
            end
        end,
        sound = SOUNDKIT.IG_MAINMENU_OPEN,
        hideOnEscape = true,
    }
    local deleteChapterButton = CreateFrame("BUTTON", "DeleteChapter", content, "UIPanelButtonTemplate")
    deleteChapterButton:SetPoint("TOPLEFT", chapterSelector, "BOTTOM")
    deleteChapterButton:SetPoint("BOTTOMRIGHT", chapterSelector, "BOTTOMRIGHT", 0, -22)
    deleteChapterButton:SetText(L["DELETE_CHAPTER"])
    deleteChapterButton:SetScript("OnClick", function(self, button, down)
        StaticPopup_Show(addonName .. "_DELETE_CHAPTER")
    end)

    local stepSelector = self:CreateSelector("Steps", content)
    stepSelector:SetPoint("TOPLEFT", newJourneyButton, "BOTTOMLEFT", 0, -15)
    stepSelector:SetPoint("BOTTOMRIGHT", content, "BOTTOM", 0, 22)
    stepSelector:SetTitle(L["SELECT_STEP"])
    stepSelector.list.GetValues = function(self)
        local chapter = Traveler.editor:GetSelectedChapter()
        if chapter then
            return chapter.steps
        end
    end
    frame.stepSelector = stepSelector

    stepSelector.list.CreateRow = function(self, index, parent)
        local row = Traveler.GUI:CreateLabel("BUTTON", "Row" .. index, parent)
        row:SetJustifyH("LEFT")
        row:SetJustifyV("CENTER")
        row:SetFontSize(10)
        row:SetTextColor(1, 1, 1, 1)

        local highlightTexture = row:CreateTexture(nil, "BACKGROUND")
        highlightTexture:SetAllPoints(row)
        highlightTexture:SetTexture("Interface/QuestFrame/UI-QuestLogTitleHighlight")
        highlightTexture:SetBlendMode("ADD")
        highlightTexture:SetVertexColor(0, 0, 0)
        row.highlightTexture = highlightTexture

        row.SetValue = function(self, step)
            local prefix = self.index .. ". "
            self:SetText(prefix .. Traveler:GetStepText(step, true, function() stepSelector:Refresh() end))
            if self.list.selectedIndex == self.index then
                self.highlightTexture:SetVertexColor(1, 1, 0) -- selected
            elseif row:IsMouseOver() then
                self.highlightTexture:SetVertexColor(.196, .388, .8) -- hover
            else
                self.highlightTexture:SetVertexColor(0, 0, 0) -- none
            end
        end

        row:SetScript("OnEnter", function(self, motion)
            if self.list.selectedIndex == self.index then
                self.highlightTexture:SetVertexColor(1, 1, 0) -- selected
            else
                self.highlightTexture:SetVertexColor(.196, .388, .8) -- hover
            end
        end)

        row:SetScript("OnLeave", function(self, motion)
            if self.list.selectedIndex == self.index then
                self.highlightTexture:SetVertexColor(1, 1, 0) -- selected
            else
                self.highlightTexture:SetVertexColor(0, 0, 0) -- none
            end
        end)

        row:SetScript("OnClick", function(self, button, down)
            self.list.selectedIndex = self.index
            self.list:SelectionChanged()
        end)

        return row
    end

    local newStepButton = CreateFrame("BUTTON", "NewStep", content, "UIPanelButtonTemplate")
    newStepButton:SetPoint("TOPLEFT", stepSelector, "BOTTOMLEFT")
    newStepButton:SetPoint("BOTTOMRIGHT", stepSelector, "BOTTOM", 0, -22)
    newStepButton:SetText(L["NEW_STEP"])
    newStepButton:SetScript("OnClick", function(self, button, down)
        local chapter = Traveler.editor:GetSelectedChapter()
        if chapter and Traveler.Journey:CreateStep(chapter, Traveler.STEP_TYPE_UNDEFINED) then
            Traveler.editor:SetSelectedStepIndex(#chapter.steps)
            frame.refresh()
            Traveler:Reset(true)
        end
    end)

    StaticPopupDialogs[addonName .. "_DELETE_STEP"] = {
        text = L["DELETE_STEP"] .. "?",
        showAlert = true,
        button1 = ACCEPT,
        button2 = CANCEL,
        OnAccept = function()
            local chapter = Traveler.editor:GetSelectedChapter()
            if chapter and Traveler.Journey:DeleteStep(chapter, Traveler.editor:GetSelectedStepIndex()) then
                Traveler.editor:SetSelectedStepIndex(-1)
                frame.refresh()
                Traveler:Reset(true)
            end
        end,
        sound = SOUNDKIT.IG_MAINMENU_OPEN,
        hideOnEscape = true,
    }
    local deleteStepButton = CreateFrame("BUTTON", "DeleteStep", content, "UIPanelButtonTemplate")
    deleteStepButton:SetPoint("TOPLEFT", stepSelector, "BOTTOM")
    deleteStepButton:SetPoint("BOTTOMRIGHT", stepSelector, "BOTTOMRIGHT", 0, -22)
    deleteStepButton:SetText(L["DELETE_STEP"])
    deleteStepButton:SetScript("OnClick", function(self, button, down)
        StaticPopup_Show(addonName .. "_DELETE_STEP")
    end)

    local propertiesGroup = self:CreatePropertiesGroup("FRAME", "Properties", content)
    propertiesGroup:SetPoint("TOPLEFT", newChapterButton, "BOTTOMLEFT", 0, -15)
    propertiesGroup:SetPoint("BOTTOMRIGHT", content, "BOTTOMRIGHT")

    -- Setup events
    journeySelector.list.OnSelectionChanged = function(self)
        Traveler.editor:SetSelectedChapterIndex(-1)
        Traveler.editor:SetSelectedStepIndex(-1)
        frame.refresh()
    end

    chapterSelector.list.OnSelectionChanged = function(self)
        Traveler.editor:SetSelectedStepIndex(-1)
        frame.refresh()
    end

    stepSelector.list.OnSelectionChanged = function(self)
        frame.refresh()
    end

    frame.GetSelectedJourneyIndex = function(self) return self.journeySelector.list.selectedIndex end
    frame.SetSelectedJourneyIndex = function(self, index) self.journeySelector.list.selectedIndex = index end
    frame.GetSelectedJourney = function(self) return Traveler.Journey:GetJourney(self:GetSelectedJourneyIndex()) end
    frame.GetSelectedChapterIndex = function(self) return self.chapterSelector.list.selectedIndex end
    frame.SetSelectedChapterIndex = function(self, index) self.chapterSelector.list.selectedIndex = index end
    frame.GetSelectedChapter = function(self) return Traveler.Journey:GetChapter(self:GetSelectedJourney(), self:GetSelectedChapterIndex()) end
    frame.GetSelectedStepIndex = function(self) return self.stepSelector.list.selectedIndex end
    frame.SetSelectedStepIndex = function(self, index) self.stepSelector.list.selectedIndex = index end
    frame.GetSelectedStep = function(self) return Traveler.Journey:GetStep(self:GetSelectedChapter(), self:GetSelectedStepIndex()) end

    -- Refresh method
    frame.refresh = function()
        xpcall(function()
            journeySelector:Refresh()
            chapterSelector:Refresh()
            stepSelector:Refresh()
            propertiesGroup:Refresh()
            deleteJourneyButton:SetEnabled(frame:GetSelectedJourneyIndex() ~= -1)
            newChapterButton:SetEnabled(frame:GetSelectedJourneyIndex() ~= -1)
            deleteChapterButton:SetEnabled(frame:GetSelectedChapterIndex() ~= -1)
            newStepButton:SetEnabled(frame:GetSelectedChapterIndex() ~= -1)
            deleteStepButton:SetEnabled(frame:GetSelectedStepIndex() ~= -1)
        end, geterrorhandler())
    end

    return frame
end

function Traveler:CreateSelector(name, parent)
    local frame = CreateFrame("FRAME", name, parent)

    local title = Traveler.GUI:CreateLabel("FRAME", "Title", frame)
    title:SetPoint("TOPLEFT")
    title:SetPoint("BOTTOMRIGHT", frame, "TOPRIGHT", 0, -18)
    title:SetJustifyH("LEFT")
    title:SetJustifyV("CENTER")
    title:SetFontSize(12)
    frame.title = title

    local container = Traveler.GUI:CreateGroup("FRAME", "Container", frame)
    container:SetPoint("TOPLEFT", title, "BOTTOMLEFT")
    container:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT")

    local list = Traveler.GUI:CreateListView("FRAME", "List", container)
    list:SetPoint("TOPLEFT", 5, -5)
    list:SetPoint("BOTTOMRIGHT", -5, 5)
    frame.list = list

    frame.SetTitle = function(self, fmt, ...) title:SetText(fmt, ...) end
    frame.Refresh = function(self) list:Refresh() end

    return frame
end

function Traveler:CreatePropertiesGroup(frameType, name, parent, template, id)
    local frame = CreateFrame(frameType, name, parent, template, id)

    local title = Traveler.GUI:CreateLabel("FRAME", "Title", frame)
    title:SetPoint("TOPLEFT")
    title:SetPoint("BOTTOMRIGHT", frame, "TOPRIGHT", 0, -18)
    title:SetJustifyH("LEFT")
    title:SetJustifyV("CENTER")
    title:SetFontSize(12)
    title:SetText("Properties")
    frame.title = title

    local group = Traveler.GUI:CreateGroup("FRAME", "Group", frame)
    group:SetPoint("TOPLEFT", title, "BOTTOMLEFT")
    group:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT")
    frame.group = group

    local scrollFrame = CreateFrame("SCROLLFRAME", "ScrollFrame", group, "UIPanelScrollFrameTemplate")
    scrollFrame:SetPoint("TOPLEFT", 5, -5)
    scrollFrame:SetPoint("BOTTOMRIGHT", -27, 5)
    frame.scrollFrame = scrollFrame

    local scrollChild = CreateFrame("FRAME", "ScrollChild", scrollFrame)
    scrollFrame:SetScrollChild(scrollChild)
    frame.scrollChild = scrollChild

    local journeyTitle = self:CreateEditBoxProperty("FRAME", "JourneyTitle", scrollChild)
    journeyTitle:SetPoint("TOPLEFT")
    journeyTitle:SetPoint("BOTTOMRIGHT", scrollChild, "TOPRIGHT", 0, -40)
    journeyTitle:SetTitle(L["Journey Title"])
    journeyTitle.OnEnterPressed = function(self)
        local journey = Traveler.editor:GetSelectedJourney()
        if journey then
            journey.title = self:GetText()
        end
        Traveler.editor.refresh()
        Traveler:Reset(true)
    end
    frame.journeyTitle = journeyTitle

    local journeyIndex = self:CreateEditBoxProperty("FRAME", "JourneyIndex", scrollChild)
    journeyIndex:SetPoint("TOPLEFT", journeyTitle, "BOTTOMLEFT")
    journeyIndex:SetPoint("BOTTOMRIGHT", journeyTitle, "BOTTOMRIGHT", 0, -40)
    journeyIndex:SetTitle(L["Journey Index"])
    journeyIndex:SetNumeric(true)
    journeyIndex.OnEnterPressed = function(self)
        local index = self:GetNumber()
        if index and Traveler.Journey:MoveJourney(Traveler.editor:GetSelectedJourneyIndex(), index) then
            Traveler.editor:SetSelectedJourneyIndex(index)
        end
        Traveler.editor.refresh()
        Traveler:Reset(true)
    end
    frame.journeyIndex = journeyIndex

    local chapterTitle = self:CreateEditBoxProperty("FRAME", "ChapterTitle", scrollChild)
    chapterTitle:SetPoint("TOPLEFT", journeyIndex, "BOTTOMLEFT")
    chapterTitle:SetPoint("BOTTOMRIGHT", journeyIndex, "BOTTOMRIGHT", 0, -40)
    chapterTitle:SetTitle(L["Chapter Title"])
    chapterTitle.OnEnterPressed = function(self)
        local chapter = Traveler.editor:GetSelectedChapter()
        if chapter then
            chapter.title = self:GetText()
        end
        Traveler.editor.refresh()
        Traveler:Reset(true)
    end
    frame.chapterTitle = chapterTitle

    local chapterIndex = self:CreateEditBoxProperty("FRAME", "ChapterIndex", scrollChild)
    chapterIndex:SetPoint("TOPLEFT", chapterTitle, "BOTTOMLEFT")
    chapterIndex:SetPoint("BOTTOMRIGHT", chapterTitle, "BOTTOMRIGHT", 0, -40)
    chapterIndex:SetTitle(L["Chapter Index"])
    chapterIndex:SetNumeric(true)
    chapterIndex.OnEnterPressed = function(self)
        local index = self:GetNumber()
        local journey = Traveler.editor:GetSelectedJourney()
        if index and journey and Traveler.Journey:MoveChapter(journey, Traveler.editor:GetSelectedChapterIndex(), index) then
            Traveler.editor:SetSelectedChapterIndex(index)
        end
        Traveler.editor.refresh()
        Traveler:Reset(true)
    end
    frame.chapterIndex = chapterIndex

    local stepType = self:CreateDropDownMenuProperty("FRAME", "StepType", scrollChild)
    stepType:SetPoint("TOPLEFT", chapterIndex, "BOTTOMLEFT")
    stepType:SetPoint("BOTTOMRIGHT", chapterIndex, "BOTTOMRIGHT", 0, -40)
    stepType:SetTitle(L["Step Type"])
    stepType.GetValues = function(self)
        return {
            [Traveler.STEP_TYPE_UNDEFINED] = STEP_TYPE_DROPDOWN_UNDEFINED,
            [Traveler.STEP_TYPE_ACCEPT_QUEST] = STEP_TYPE_DROPDOWN_ACCEPT_QUEST,
            [Traveler.STEP_TYPE_COMPLETE_QUEST] = STEP_TYPE_DROPDOWN_COMPLETE_QUEST,
            [Traveler.STEP_TYPE_TURNIN_QUEST] = STEP_TYPE_DROPDOWN_TURNIN_QUEST,
            [Traveler.STEP_TYPE_FLY_TO] = STEP_TYPE_DROPDOWN_FLY_TO,
            [Traveler.STEP_TYPE_BIND_HEARTHSTONE] = STEP_TYPE_DROPDOWN_BIND_HEARTHSTONE,
            [Traveler.STEP_TYPE_USE_HEARTHSTONE] = STEP_TYPE_DROPDOWN_USE_HEARTHSTONE,
            [Traveler.STEP_TYPE_REACH_LEVEL] = STEP_TYPE_DROPDOWN_REACH_LEVEL,
        }
    end
    stepType.GetSorting = function(self)
        return {
            Traveler.STEP_TYPE_UNDEFINED,
            Traveler.STEP_TYPE_ACCEPT_QUEST,
            Traveler.STEP_TYPE_COMPLETE_QUEST,
            Traveler.STEP_TYPE_TURNIN_QUEST,
            Traveler.STEP_TYPE_FLY_TO,
            Traveler.STEP_TYPE_BIND_HEARTHSTONE,
            Traveler.STEP_TYPE_USE_HEARTHSTONE,
            Traveler.STEP_TYPE_REACH_LEVEL,
        }
    end
    stepType.OnValueChanged = function(self, value)
        local step = Traveler.editor:GetSelectedStep()
        if step then
            step.type = value
            if step.data then
                if Traveler:IsStepDataNumber(step) and type(step.data) ~= "number" then
                    local data = tonumber(step.data)
                    if data == nil then
                        data = 0
                    end
                    step.data = data
                elseif type(step.data) ~= "string" then
                    local data = tostring(step.data)
                    if data == nil then
                        data = ""
                    end
                    step.data = data
                end
            end
        end
        Traveler.editor.refresh()
        Traveler:Reset(true)
    end
    stepType:Initialize()
    frame.stepType = stepType

    local stepData = self:CreateEditBoxProperty("FRAME", "StepData", scrollChild)
    stepData:SetPoint("TOPLEFT", stepType, "BOTTOMLEFT")
    stepData:SetPoint("BOTTOMRIGHT", stepType, "BOTTOMRIGHT", 0, -40)
    stepData:SetTitle(L["Step Data"])
    stepData.OnEnterPressed = function(self)
        local step = Traveler.editor:GetSelectedStep()
        if step then
            if Traveler:IsStepDataNumber(step) then
                step.data = self:GetNumber()
            else
                step.data = self:GetText()
            end
        end
        Traveler.editor.refresh()
        Traveler:Reset(true)
    end
    frame.stepData = stepData

    local stepIndex = self:CreateEditBoxProperty("FRAME", "StepIndex", scrollChild)
    stepIndex:SetPoint("TOPLEFT", stepData, "BOTTOMLEFT")
    stepIndex:SetPoint("BOTTOMRIGHT", stepData, "BOTTOMRIGHT", 0, -40)
    stepIndex:SetTitle(L["Step Index"])
    stepIndex:SetNumeric(true)
    stepIndex.OnEnterPressed = function(self)
        local index = self:GetNumber()
        local chapter = Traveler.editor:GetSelectedChapter()
        if index and chapter and Traveler.Journey:MoveStep(chapter, Traveler.editor:GetSelectedStepIndex(), index) then
            Traveler.editor:SetSelectedStepIndex(index)
        end
        Traveler.editor.refresh()
        Traveler:Reset(true)
    end
    frame.stepIndex = stepIndex

    local stepNote = self:CreateEditBoxProperty("FRAME", "StepNote", scrollChild)
    stepNote:SetPoint("TOPLEFT", stepIndex, "BOTTOMLEFT")
    stepNote:SetPoint("BOTTOMRIGHT", stepIndex, "BOTTOMRIGHT", 0, -40)
    stepNote:SetTitle(L["Step Note"])
    stepNote.OnEnterPressed = function(self)
        local step = Traveler.editor:GetSelectedStep()
        if step then
            step.note = self:GetText()
            if step.note and string.len(step.note) == 0 then
                step.note = nil
            end
        end
        Traveler.editor.refresh()
        Traveler:Reset(true)
    end
    frame.stepNote = stepNote

    frame.Refresh = function(self)
        self.scrollChild:SetSize(self.scrollFrame:GetWidth(), self.scrollFrame:GetHeight())

        local journey = Traveler.editor:GetSelectedJourney()
        if journey then
            self.journeyTitle:SetEnabled(true)
            self.journeyTitle:SetText(journey.title)
            self.journeyIndex:SetEnabled(true)
            self.journeyIndex:SetText(Traveler.editor:GetSelectedJourneyIndex())
        else
            self.journeyTitle:SetEnabled(false)
            self.journeyTitle:SetText("")
            self.journeyIndex:SetEnabled(false)
            self.journeyIndex:SetText("")
        end

        local chapter = Traveler.editor:GetSelectedChapter()
        if chapter then
            self.chapterTitle:SetEnabled(true)
            self.chapterTitle:SetText(chapter.title)
            self.chapterIndex:SetEnabled(true)
            self.chapterIndex:SetText(Traveler.editor:GetSelectedChapterIndex())
        else
            self.chapterTitle:SetEnabled(false)
            self.chapterTitle:SetText("")
            self.chapterIndex:SetEnabled(false)
            self.chapterIndex:SetText("")
        end

        self.stepType:SetWidth(self.scrollFrame:GetWidth())
        local step = Traveler.editor:GetSelectedStep()
        if step then
            self.stepType:SetValue(step.type)
            self.stepType:SetEnabled(true)
            if step.data then
                self.stepData:SetText(step.data)
            else
                self.stepData:SetText("")
            end
            self.stepData:SetEnabled(true)
            self.stepIndex:SetText(Traveler.editor:GetSelectedStepIndex())
            self.stepIndex:SetEnabled(true)
            if step.note then
                self.stepNote:SetText(step.note)
            else
                self.stepNote:SetText("")
            end
            self.stepNote:SetEnabled(true)
        else
            self.stepType:SetValue("")
            self.stepType:SetEnabled(false)
            self.stepData:SetText("")
            self.stepData:SetEnabled(false)
            self.stepIndex:SetText("")
            self.stepIndex:SetEnabled(false)
            self.stepNote:SetText("")
            self.stepNote:SetEnabled(false)
        end
    end

    return frame
end

function Traveler:CreateEditBoxProperty(frameType, name, parent, template, id)
    local frame = CreateFrame(frameType, name, parent, template, id)

    local label = Traveler.GUI:CreateLabel("FRAME", "Label", frame)
    label:SetPoint("TOPLEFT")
    label:SetPoint("BOTTOMRIGHT", frame, "TOPRIGHT", 0, -15)
    label:SetJustifyH("LEFT")
    label:SetJustifyV("CENTER")
    label:SetFontSize(10)
    frame.label = label

    local editBox = Traveler.GUI:CreateEditBox("FRAME", "EditBox", frame)
    editBox:SetPoint("TOPLEFT", label, "BOTTOMLEFT")
    editBox:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT")
    editBox:SetTextColor(1, 1, 1, 1)
    editBox.OnEnterPressed = function(self)
        if frame.OnEnterPressed then
            frame:OnEnterPressed()
        end
    end
    frame.editBox = editBox

    frame.SetTitle = function(self, title, ...) self.label:SetText(title, ...) end
    frame.SetText = function(self, value, ...) self.editBox:SetText(value, ...) end
    frame.GetText = function(self) return self.editBox:GetText() end
    frame.GetNumber = function(self) return self.editBox:GetNumber() end
    frame.SetNumeric = function(self, value) self.editBox:SetNumeric(value) end
    frame.SetEnabled = function(self, value) self.editBox:SetEnabled(value) end

    return frame
end

function Traveler:CreateDropDownMenuProperty(frameType, name, parent, template, id)
    local frame = CreateFrame(frameType, name, parent, template, id)

    local label = Traveler.GUI:CreateLabel("FRAME", "Label", frame)
    label:SetPoint("TOPLEFT")
    label:SetPoint("BOTTOMRIGHT", frame, "TOPRIGHT", 0, -15)
    label:SetJustifyH("LEFT")
    label:SetJustifyV("CENTER")
    label:SetFontSize(10)
    frame.label = label

    local dropDownMenu = Traveler.GUI:CreateDropDownMenu("FRAME", "DropDownMenu", frame)
    dropDownMenu:SetPoint("TOPLEFT", label, "BOTTOMLEFT")
    dropDownMenu:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT")
    dropDownMenu.GetValues = function(self) return frame:GetValues() end
    dropDownMenu.GetSorting = function(self) if frame.GetSorting then return frame:GetSorting() end end
    dropDownMenu.OnValueChanged = function(self, value) if frame.OnValueChanged then frame:OnValueChanged(value) end end
    frame.dropDownMenu = dropDownMenu

    frame.Initialize = function(self) self.dropDownMenu:Initialize() end
    frame.SetTitle = function(self, title, ...) self.label:SetText(title, ...) end
    frame.SetValue = function(self, value) self.dropDownMenu:SetValue(value) end
    frame.SetWidth = function(self, value) self.dropDownMenu:SetWidth(value) end
    frame.SetEnabled = function(self, value) self.dropDownMenu:SetEnabled(value) end

    return frame
end
