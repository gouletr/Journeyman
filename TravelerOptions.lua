local addonName, addon = ...
local addonVersion = GetAddOnMetadata(addonName, "version")
local Traveler = addon.Traveler
local L = addon.Locale

local function Percent(value)
    local windowWidth = 600
    local widthMultiplier = 170
    return (value * windowWidth) / widthMultiplier
end

function Traveler:InitializeOptions()
    LibStub("AceConfig-3.0"):RegisterOptionsTable(addonName, self:GetOptionsTable(), "traveler")

    local aceConfigDialog = LibStub("AceConfigDialog-3.0")
    self.generalOptions = aceConfigDialog:AddToBlizOptions(addonName, addonName, nil, "general")
    self.journeysOptions = aceConfigDialog:AddToBlizOptions(addonName, "Journeys", addonName, "journeys")
    self.advancedOptions = aceConfigDialog:AddToBlizOptions(addonName, "Advanced", addonName, "advanced")
    self.profileOptions = aceConfigDialog:AddToBlizOptions(addonName, "Profiles", addonName, "profiles")

    self.journeyEditor = self:GetJourneyEditor()
    InterfaceOptions_AddCategory(self.journeyEditor)
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
                name = L["SELECT_JOURNEY"],
                desc = L["SELECT_JOURNEY_DESC"],
                width = Percent(0.5),
                values = function()
                    local values = {}
                    for i, v in ipairs(self.journeys) do
                        values[i] = v.title
                    end
                    return values
                end,
                set = function(info, value)
                    if self.db.char.window.journey ~= value then
                        self.db.char.window.journey = value
                        self.db.char.window.chapter = 1
                        self.State:Reset(true)
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
                        self.Tracker:Update(true)
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
                        self.Tracker:Update(true)
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
                name = L["SHOW_WINDOW"],
                desc = L["SHOW_WINDOW_DESC"],
                width = Percent(0.5),
                get = function(info) return self.db.char.window.show end,
                set = function(info, value)
                    if self.db.char.window.show ~= value then
                        self.db.char.window.show = value
                        self.Tracker:Update(true)
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
                        self.State:Update(true)
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
                        self.State:Update(true)
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
                        self.State:Update(true)
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
            updateHeader = {
                order = 0,
                type = "header",
                name = L["Update Options"]
            },
            updateFrequency = {
                order = 1,
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
                order = 2,
                type = "description",
                name = L["This option controls the frequency of update checks. Decreasing the value will cause the addon to periodically check more often if any state or window updates are needed. It is recommended to not change this value."],
                width = Percent(1.0)
            },
            header = {
                order = 10,
                type = "header",
                name = L["Debugging Options"]
            },
            debug = {
                order = 11,
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
                order = 12,
                type = "description",
                name = L["This option controls whether or not debugging information and tools are enabled. This can add a great deal of spam in the console and should not be needed unless debugging the addon."],
                width = Percent(1.0)
            }
        }
    }
end

function Traveler:GetJourneyEditor()
    local frame = CreateFrame("FRAME", "Journeys Editor", UIParent)
    frame.name = "Journeys Editor"
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
        for i, v in ipairs(Traveler.journeys) do
            values[i] = v.title
        end
        return values
    end

    local chapterSelector = self:CreateSelector("Chapters", content)
    chapterSelector:SetPoint("TOPLEFT", title, "BOTTOM")
    chapterSelector:SetPoint("BOTTOMRIGHT", title, "BOTTOMRIGHT", 0, -110)
    chapterSelector:SetTitle(L["SELECT_CHAPTER"])
    chapterSelector.list.GetValues = function(self)
        local values = {}
        local journey = Traveler.Journey:GetJourney(journeySelector.list.selectedIndex)
        if journey then
            for i, v in ipairs(journey.chapters) do
                values[i] = v.title
            end
        end
        return values
    end

    local newJourneyButton = CreateFrame("BUTTON", "NewJourney", content, "UIPanelButtonTemplate")
    newJourneyButton:SetPoint("TOPLEFT", journeySelector, "BOTTOMLEFT")
    newJourneyButton:SetPoint("BOTTOMRIGHT", journeySelector, "BOTTOM", 0, -22)
    newJourneyButton:SetText(L["NEW_JOURNEY"])
    newJourneyButton:SetScript("OnClick", function(self, button, down)
        if Traveler.Journey:CreateJourney(L["NEW_JOURNEY_TITLE"]) then
            journeySelector.list.selectedIndex = #Traveler.journeys
            chapterSelector.list.selectedIndex = -1
            stepSelector.list.selectedIndex = -1
            frame.refresh()
        end
    end)

    StaticPopupDialogs[addonName .. "_DELETE_JOURNEY"] = {
        text = L["DELETE_JOURNEY"] .. "?",
        showAlert = true,
        button1 = ACCEPT,
        button2 = CANCEL,
        OnAccept = function()
            if Traveler.Journey:DeleteJourney(journeySelector.list.selectedIndex) then
                journeySelector.list.selectedIndex = -1
                chapterSelector.list.selectedIndex = -1
                stepSelector.list.selectedIndex = -1
                frame.refresh()
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
        local journey = Traveler.Journey:GetJourney(journeySelector.list.selectedIndex)
        if Traveler.Journey:CreateChapter(journey, L["NEW_CHAPTER_TITLE"]) then
            chapterSelector.list.selectedIndex = #journey.chapters
            stepSelector.list.selectedIndex = -1
            frame.refresh()
        end
    end)

    StaticPopupDialogs[addonName .. "_DELETE_CHAPTER"] = {
        text = L["DELETE_CHAPTER"] .. "?",
        showAlert = true,
        button1 = ACCEPT,
        button2 = CANCEL,
        OnAccept = function()
            local journey = Traveler.Journey:GetJourney(journeySelector.list.selectedIndex)
            if Traveler.Journey:DeleteChapter(journey, chapterSelector.list.selectedIndex) then
                chapterSelector.list.selectedIndex = -1
                stepSelector.list.selectedIndex = -1
                frame.refresh()
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
        local journey = Traveler.Journey:GetJourney(journeySelector.list.selectedIndex)
        local chapter = Traveler.Journey:GetChapter(journey, chapterSelector.list.selectedIndex)
        if chapter then
            return chapter.steps
        end
    end
    stepSelector.list.CreateRow = function(self, index, parent)
        local row = Traveler.GUI:CreateLabel("BUTTON", "Row" .. index, parent, true)
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
            if step.type == Traveler.STEP_TYPE_UNDEFINED then
                self:SetText(L["<Undefined Step>"])
            elseif step.type == Traveler.STEP_TYPE_ACCEPT_QUEST then
                self:SetText(L["Accept %s"], Traveler.DataSource:GetQuestName(step.data, true))
            elseif step.type == Traveler.STEP_TYPE_COMPLETE_QUEST then
                self:SetText(L["Complete %s"], Traveler.DataSource:GetQuestName(step.data, true))
            elseif step.type == Traveler.STEP_TYPE_TURNIN_QUEST then
                self:SetText(L["Turn-in %s"], Traveler.DataSource:GetQuestName(step.data, true))
            elseif step.type == Traveler.STEP_TYPE_FLY_TO then
                self:SetText(L["Fly to %s"], step.data)
            elseif step.type == Traveler.STEP_TYPE_BIND_HEARTHSTONE then
                self:SetText(L["Bind %s to %s"], Traveler:GetItemName(Traveler.ITEM_HEARTHSTONE, function() stepSelector:Refresh() end), step.data)
            else
                Traveler:Error("Step type %s not implemented.", step.type)
            end

            if self.list.selectedIndex == self.index then
                self.highlightTexture:SetVertexColor(1, 1, 0)
            elseif row:IsMouseOver() then
                self.highlightTexture:SetVertexColor(.196, .388, .8)
            else
                self.highlightTexture:SetVertexColor(0, 0, 0)
            end
        end

        row:SetScript("OnEnter", function(self, motion)
            if self.list.selectedIndex == self.index then
                self.highlightTexture:SetVertexColor(1, 1, 0)
            else
                self.highlightTexture:SetVertexColor(.196, .388, .8)
            end
        end)

        row:SetScript("OnLeave", function(self, motion)
            if self.list.selectedIndex == self.index then
                self.highlightTexture:SetVertexColor(1, 1, 0)
            else
                self.highlightTexture:SetVertexColor(0, 0, 0)
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
        local journey = Traveler.Journey:GetJourney(journeySelector.list.selectedIndex)
        local chapter = Traveler.Journey:GetChapter(journey, chapterSelector.list.selectedIndex)
        if Traveler.Journey:CreateStep(chapter, Traveler.STEP_TYPE_UNDEFINED) then
            stepSelector.list.selectedIndex = #chapter.steps
            frame.refresh()
        end
    end)

    StaticPopupDialogs[addonName .. "_DELETE_STEP"] = {
        text = L["DELETE_STEP"] .. "?",
        showAlert = true,
        button1 = ACCEPT,
        button2 = CANCEL,
        OnAccept = function()
            local journey = Traveler.Journey:GetJourney(journeySelector.list.selectedIndex)
            local chapter = Traveler.Journey:GetChapter(journey, chapterSelector.list.selectedIndex)
            if Traveler.Journey:DeleteStep(chapter, stepSelector.list.selectedIndex) then
                stepSelector.list.selectedIndex = -1
                frame.refresh()
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

    journeySelector.list.OnSelectionChanged = function(self)
        chapterSelector.list.selectedIndex = -1
        stepSelector.list.selectedIndex = -1
        frame.refresh()
    end

    chapterSelector.list.OnSelectionChanged = function(self)
        stepSelector.list.selectedIndex = -1
        frame.refresh()
    end

    stepSelector.list.OnSelectionChanged = function(self)
        frame.refresh()
    end

    frame.refresh = function()
        xpcall(function()
            journeySelector:Refresh()
            chapterSelector:Refresh()
            stepSelector:Refresh()

            deleteJourneyButton:SetEnabled(journeySelector.list.selectedIndex ~= -1)

            newChapterButton:SetEnabled(journeySelector.list.selectedIndex ~= -1)
            deleteChapterButton:SetEnabled(chapterSelector.list.selectedIndex ~= -1)

            newStepButton:SetEnabled(chapterSelector.list.selectedIndex ~= -1)
            deleteStepButton:SetEnabled(stepSelector.list.selectedIndex ~= -1)
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

    frame.SetTitle = function(self, fmt, ...)
        title:SetText(fmt, ...)
    end

    frame.Refresh = function(self)
        list:Refresh()
    end

    return frame
end
