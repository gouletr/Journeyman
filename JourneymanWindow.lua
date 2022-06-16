local addonName, addon = ...
local Journeyman = addon.Journeyman
local L = addon.Locale
local Window = {}
Journeyman.Window = Window

local List = LibStub("LibCollections-1.0").List
local TomTom = TomTom

local tinsert = table.insert
local function round(num)
  return num + (2^52 + 2^51) - (2^52 + 2^51)
end

local HEADER_HEIGHT = 24
local TEXT_COLOR_STEP_COMPLETE = "FFA0A0A0"
local TEXT_COLOR_HIGHLIGHT = "FFFFFFFF"
local QUEST_COLOR_RED = "FFFF1A1A"
local QUEST_COLOR_ORANGE = "FFFF8040"
local QUEST_COLOR_YELLOW = "FFFFFF00"
local QUEST_COLOR_GREEN = "FF40C040"
local QUEST_COLOR_GREY = "FFC0C0C0"

function Window:Initialize()
    self.lines = {}
    self.verticalScrollRange = 0

    -- Create main frame
    local frame = CreateFrame("FRAME", nil, UIParent)
    frame:SetClampedToScreen(Journeyman.db.profile.window.clamped)
    frame:SetFrameStrata(Journeyman.db.profile.window.strata)
    frame:SetFrameLevel(Journeyman.db.profile.window.level)
    frame:SetWidth(Journeyman.db.profile.window.width)
    frame:SetHeight(Journeyman.db.profile.window.height)
    frame:SetPoint(Journeyman.db.profile.window.relativePoint, UIParent, Journeyman.db.profile.window.relativePoint, Journeyman.db.profile.window.x, Journeyman.db.profile.window.y)
    frame:SetMovable(true)
    frame:SetResizable(true)
    frame:SetMinResize(200, 100)
    frame:EnableMouse(true)
    frame:SetScript("OnMouseDown", function(self, button)
        if not Journeyman.db.profile.window.locked and button == "LeftButton" then
            frame:StartMoving()
        end
    end)
    frame:SetScript("OnMouseUp", function(self, button)
        if not Journeyman.db.profile.window.locked and button == "LeftButton" then
            frame:StopMovingOrSizing()
            local point, relativeTo, relativePoint, offsetX, offsetY = frame:GetPoint()
            Journeyman.db.profile.window.relativePoint = relativePoint
            Journeyman.db.profile.window.x = offsetX
            Journeyman.db.profile.window.y = offsetY
            Window:Update(true)
        end
    end)
    -- frame:SetScript("OnEnter", function(self, motion)
        -- Window.closeButton:Show()
        -- Window.lockButton:Show()
        -- Window.nextChapterButton:Show()
        -- Window.prevChapterButton:Show()
    -- end)
    -- frame:SetScript("OnLeave", function(self, motion)
        -- Window.closeButton:Hide()
        -- Window.lockButton:Hide()
        -- Window.nextChapterButton:Hide()
        -- Window.prevChapterButton:Hide()
    -- end)
    frame.bg = frame:CreateTexture(nil, "BACKGROUND")
    frame.bg:SetAllPoints(frame)
    frame.bg:SetColorTexture(Journeyman.db.profile.window.backgroundColor.r, Journeyman.db.profile.window.backgroundColor.g, Journeyman.db.profile.window.backgroundColor.b, Journeyman.db.profile.window.backgroundColor.a)
    frame:Hide()
    self.frame = frame

    -- Create close button
    local closeButton = CreateFrame("BUTTON", nil, frame)
    closeButton:SetSize(HEADER_HEIGHT, HEADER_HEIGHT)
    closeButton:SetPoint("TOPRIGHT", frame, "TOPRIGHT")
    closeButton:SetNormalTexture("Interface/Buttons/UI-Panel-MinimizeButton-Up")
    closeButton:SetHighlightTexture("Interface/Buttons/UI-Panel-MinimizeButton-Highlight")
    closeButton:SetPushedTexture("Interface/Buttons/UI-Panel-MinimizeButton-Down")
    closeButton:SetScript("OnClick", function()
        Journeyman.db.char.window.show = false
        Window:Update(true)
    end)
    self.closeButton = closeButton

    -- Create lock button
    local lockButton = CreateFrame("BUTTON", nil, frame)
    lockButton:SetSize(HEADER_HEIGHT, HEADER_HEIGHT)
    lockButton:SetPoint("TOPRIGHT", closeButton, "TOPLEFT")
    lockButton:SetScript("OnClick", function()
        Journeyman.db.profile.window.locked = not Journeyman.db.profile.window.locked
        Window:Update(true)
    end)
    self.lockButton = lockButton

    -- Next chapter button
    local nextChapterButton = CreateFrame("BUTTON", nil, frame)
    nextChapterButton:SetSize(HEADER_HEIGHT, HEADER_HEIGHT)
    nextChapterButton:SetPoint("TOPRIGHT", lockButton, "TOPLEFT")
    nextChapterButton:SetNormalTexture("Interface/Buttons/UI-SpellbookIcon-NextPage-Up")
    nextChapterButton:SetHighlightTexture("Interface/Buttons/UI-Panel-MinimizeButton-Highlight")
    nextChapterButton:SetPushedTexture("Interface/Buttons/UI-SpellbookIcon-NextPage-Down")
    nextChapterButton:SetDisabledTexture("Interface/Buttons/UI-SpellbookIcon-NextPage-Disabled")
    nextChapterButton:SetScript("OnClick", function()
        local journey = Journeyman.Journey:GetActiveJourney()
        if journey ~= nil then
            if Journeyman.db.char.chapter < #journey.chapters then
                Journeyman.db.char.chapter = Journeyman.db.char.chapter + 1
                Journeyman:Reset(true)
            end
        end
    end)
    self.nextChapterButton = nextChapterButton

    -- Previous chapter button
    local prevChapterButton = CreateFrame("BUTTON", nil, frame)
    prevChapterButton:SetSize(HEADER_HEIGHT, HEADER_HEIGHT)
    prevChapterButton:SetPoint("TOPRIGHT", nextChapterButton, "TOPLEFT")
    prevChapterButton:SetNormalTexture("Interface/Buttons/UI-SpellbookIcon-PrevPage-Up")
    prevChapterButton:SetHighlightTexture("Interface/Buttons/UI-Panel-MinimizeButton-Highlight")
    prevChapterButton:SetPushedTexture("Interface/Buttons/UI-SpellbookIcon-PrevPage-Down")
    prevChapterButton:SetDisabledTexture("Interface/Buttons/UI-SpellbookIcon-PrevPage-Disabled")
    prevChapterButton:SetScript("OnClick", function()
        local journey = Journeyman.Journey:GetActiveJourney()
        if journey ~= nil then
            if Journeyman.db.char.chapter > 1 then
                Journeyman.db.char.chapter = Journeyman.db.char.chapter - 1
                Journeyman:Reset(true)
            end
        end
    end)
    self.prevChapterButton = prevChapterButton

    -- Chapter title
    local chapterTitle = Journeyman.GUI:CreateLabel("FRAME", nil, frame)
    chapterTitle:SetPoint("TOPLEFT", frame, "TOPLEFT")
    chapterTitle:SetPoint("BOTTOMRIGHT", prevChapterButton, "BOTTOMLEFT")
    chapterTitle:SetJustifyH("LEFT")
    chapterTitle:SetJustifyV("CENTER")
    chapterTitle:SetFontSize(Journeyman.db.profile.window.fontSize)
    self.chapterTitle = chapterTitle

    -- Create resize button
    local resizeButton = CreateFrame("BUTTON", nil, frame)
    resizeButton:SetFrameLevel(10)
    resizeButton:SetSize(12, 12)
    resizeButton:SetPoint("BOTTOMRIGHT")
    resizeButton:SetNormalTexture("Interface/ChatFrame/UI-ChatIM-SizeGrabber-Up")
    resizeButton:SetHighlightTexture("Interface/ChatFrame/UI-ChatIM-SizeGrabber-Highlight")
    resizeButton:SetPushedTexture("Interface/ChatFrame/UI-ChatIM-SizeGrabber-Down")
    resizeButton:SetScript("OnMouseDown", function(_, button)
        if not Journeyman.db.profile.window.locked and button == "LeftButton" then
            frame:StartSizing("BOTTOMRIGHT")
        end
    end)
    resizeButton:SetScript("OnMouseUp", function(_, button)
        if not Journeyman.db.profile.window.locked and button == "LeftButton" then
            frame:StopMovingOrSizing()
            local point, relativeTo, relativePoint, offsetX, offsetY = frame:GetPoint()
            Journeyman.db.profile.window.relativePoint = relativePoint
            Journeyman.db.profile.window.x = offsetX
            Journeyman.db.profile.window.y = offsetY
            local width, height = frame:GetSize()
            Journeyman.db.profile.window.width = width
            Journeyman.db.profile.window.height = height
            Window:Update(true)
        end
    end)
    self.resizeButton = resizeButton

    -- Scroll frame
    local scrollFrame = CreateFrame("SCROLLFRAME", nil, frame, "UIPanelScrollFrameTemplate")
    scrollFrame:SetWidth(frame:GetWidth())
    scrollFrame:SetHeight(frame:GetHeight() - HEADER_HEIGHT)
    scrollFrame:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, -HEADER_HEIGHT)
    scrollFrame:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT")
    if Journeyman.db.profile.window.showScrollBar then
        scrollFrame.ScrollBar:SetAlpha(1)
    else
        scrollFrame.ScrollBar:SetAlpha(0)
    end
    self.scrollFrame = scrollFrame

    -- Scroll child
    local scrollChild = CreateFrame("FRAME", nil, frame)
    scrollFrame:SetScrollChild(scrollChild)
    scrollChild:SetWidth(scrollFrame:GetWidth())
    scrollChild:SetHeight(scrollFrame:GetHeight())
    scrollChild:SetAllPoints(scrollFrame)
    self.scrollChild = scrollChild

    -- Journey Selection Label
    local journeySelectionLabel = Journeyman.GUI:CreateLabel("FRAME", nil, scrollChild)
    journeySelectionLabel:SetPoint("CENTER", scrollChild, "CENTER", 0, Journeyman.db.profile.window.fontSize + 4)
    journeySelectionLabel:SetWordWrap(true)
    journeySelectionLabel:SetMaxLines(10)
    journeySelectionLabel:SetText(L["NO_JOURNEY_SELECTED"])
    journeySelectionLabel:SetFontSize(12)
    journeySelectionLabel:SetWidth(scrollChild:GetWidth() - 48)
    journeySelectionLabel:SetHeight(12 * journeySelectionLabel:GetNumLines())
    self.journeySelectionLabel = journeySelectionLabel

    -- Journey Selection Button
    local journeySelectionButton = CreateFrame("BUTTON", nil, scrollChild, "UIPanelButtonTemplate")
    journeySelectionButton:SetPoint("TOP", journeySelectionLabel, "BOTTOM", 0, -4)
    journeySelectionButton:SetWidth(150)
    journeySelectionButton:SetHeight(22)
    journeySelectionButton:SetText(L["OPEN_OPTIONS"])
    journeySelectionButton:SetScript("OnClick", function()
        if not InterfaceOptionsFrame:IsShown() then
            InterfaceOptionsFrame:Show()
        end
        InterfaceOptionsFrame_OpenToCategory(Journeyman.generalPanel)
    end)
    self.journeySelectionButton = journeySelectionButton
end

function Window:Shutdown()
end

function Window:CheckForUpdate()
    local verticalScrollRange = round(self.scrollFrame:GetVerticalScrollRange())
    local verticalScrollRangeChanged = self.verticalScrollRange ~= verticalScrollRange
    if self.needUpdate or verticalScrollRangeChanged then
        self.verticalScrollRange = verticalScrollRange
        self:UpdateImmediate()
    end
end

function Window:Update(immediate)
    self.needUpdate = true
    if immediate then
        self:UpdateImmediate()
    end
end

function Window:UpdateImmediate()
    if not Journeyman.worldLoaded or not Journeyman.DataSource:IsInitialized() then return end
    local now = GetTimePreciseSec()

    self.needUpdate = false

    self:UpdateFrame()
    self:UpdateLockButton()
    self:UpdateNextChapterButton()
    self:UpdatePreviousChapterButton()
    self:UpdateChapterTitle()
    self:UpdateResizeButton()
    self:UpdateScrollFrame()
    self:UpdateJourneySelection()
    self:UpdateSteps()
    self:UpdateScrollPosition()

    self.frame:SetShown(Journeyman.db.char.window.show)

    local elapsed = (GetTimePreciseSec() - now) * 1000
    if elapsed > 20 then
        Journeyman:Debug("Window update took %.2fms", elapsed)
    end
end

function Window:UpdateFrame()
    self.frame:SetClampedToScreen(Journeyman.db.profile.window.clamped)
    self.frame:SetFrameStrata(Journeyman.db.profile.window.strata)
    self.frame:SetFrameLevel(Journeyman.db.profile.window.level)
    self.frame:SetSize(Journeyman.db.profile.window.width, Journeyman.db.profile.window.height)
    self.frame.bg:SetColorTexture(Journeyman.db.profile.window.backgroundColor.r, Journeyman.db.profile.window.backgroundColor.g, Journeyman.db.profile.window.backgroundColor.b, Journeyman.db.profile.window.backgroundColor.a)
end

function Window:UpdateLockButton()
    if Journeyman.db.profile.window.locked then
        self.lockButton:SetNormalTexture("Interface/Buttons/LockButton-Locked-Up")
        self.lockButton:SetHighlightTexture("Interface/Buttons/LockButton-Border")
        self.lockButton:SetPushedTexture("Interface/Buttons/LockButton-Unlocked-Down")
    else
        self.lockButton:SetNormalTexture("Interface/Buttons/LockButton-Unlocked-Up")
        self.lockButton:SetHighlightTexture("Interface/Buttons/LockButton-Border")
        self.lockButton:SetPushedTexture("Interface/Buttons/LockButton-Unlocked-Down")
    end
end

function Window:UpdateResizeButton()
    if Journeyman.db.profile.window.locked then
        self.resizeButton:Hide()
    else
        self.resizeButton:Show()
    end
end

function Window:UpdateNextChapterButton()
    local enabled = false
    local journey = Journeyman.Journey:GetActiveJourney()
    if journey ~= nil then
        local index = Journeyman.db.char.chapter
        enabled = index >= 1 and index < #journey.chapters
    end
    self.nextChapterButton:SetEnabled(enabled)
end

function Window:UpdatePreviousChapterButton()
    local enabled = false
    local journey = Journeyman.Journey:GetActiveJourney()
    if journey ~= nil then
        local index = Journeyman.db.char.chapter
        enabled = index > 1 and index <= #journey.chapters
    end
    self.prevChapterButton:SetEnabled(enabled)
end

function Window:UpdateChapterTitle()
    local journey = Journeyman.Journey:GetActiveJourney()
    local chapter = Journeyman.Journey:GetActiveChapter(journey)

    local title
    if chapter then
        local index = Journeyman.db.char.chapter
        title = string.format(L["CHAPTER_TITLE"], index, chapter.title)
    else
        title = L["MISSING_CHAPTER_TITLE"]
    end

    self.chapterTitle:SetFontSize(Journeyman.db.profile.window.fontSize)
    self.chapterTitle:SetText(title)
end

function Window:UpdateScrollFrame()
    self.scrollFrame:SetWidth(self.frame:GetWidth())
    self.scrollFrame:SetHeight(self.frame:GetHeight() - HEADER_HEIGHT)
    if Journeyman.db.profile.window.showScrollBar then
        self.scrollFrame.ScrollBar:SetAlpha(1)
    else
        self.scrollFrame.ScrollBar:SetAlpha(0)
    end
    self.scrollChild:SetWidth(self.scrollFrame:GetWidth())
    self.scrollChild:SetHeight(self.scrollFrame:GetHeight())
end

function Window:UpdateJourneySelection()
    local shown = Journeyman.Journey:GetActiveJourney() == nil
    if shown then
        self.journeySelectionLabel:SetFontSize(12)
        self.journeySelectionLabel:SetWidth(self.scrollChild:GetWidth() - 48)
        self.journeySelectionLabel:SetHeight(12 * self.journeySelectionLabel:GetNumLines())
    end
    self.journeySelectionLabel:SetShown(shown)
    self.journeySelectionButton:SetShown(shown)
end

function Window:UpdateScrollPosition()
    if Journeyman.db.profile.window.autoScroll then
        if Journeyman.db.profile.window.showCompletedSteps and self.stepsHeight then
            local scrollFrameRange = max(self.stepsHeight - self.scrollFrame:GetHeight(), 0)
            if self.currentStepPosition and self.currentStepPosition < scrollFrameRange then
                self.scrollFrame:SetVerticalScroll(self.currentStepPosition)
            else
                self.scrollFrame:SetVerticalScroll(scrollFrameRange)
            end
        else
            self.scrollFrame:SetVerticalScroll(0)
        end
    end
end

function Window:UpdateSteps()
    -- Group steps per chronological location
    local steps = {}
    local stepShownCount = 0
    if Journeyman.State.steps then
        for i = 1, #Journeyman.State.steps do
            local step = Journeyman.State.steps[i]
            if step.isShown then
                -- Optimization: Update step location only if we're going to show it
                -- Also, don't need location for step type complete quest, because its meaningless here
                if step.location == nil and step.type ~= Journeyman.STEP_TYPE_COMPLETE_QUEST then
                    step.location = Journeyman.State:GetStepLocation(step)
                end

                if step.type ~= Journeyman.STEP_TYPE_COMPLETE_QUEST and step.location and (step.location.type == "NPC" or step.location.type == "Object") then
                    local lastStep = steps[#steps]
                    if lastStep == nil or lastStep.location == nil or lastStep.location.name ~= step.location.name then
                        tinsert(steps, { isComplete = step.isComplete, isShown = step.isShown, location = step.location, hasChildren = true, children = { step } })
                    else
                        tinsert(lastStep.children, step)
                        lastStep.isComplete = lastStep.isComplete and step.isComplete
                    end
                else
                    tinsert(steps, step)
                end

                if not step.isComplete then
                    stepShownCount = stepShownCount + 1
                end
            end

            -- Check shown step count
            if Journeyman.db.profile.window.stepsShown > 0 and stepShownCount >= Journeyman.db.profile.window.stepsShown then
                break
            end
        end
    end

    -- Display steps recursively
    self.lineIndex = 1
    self.stepsHeight = 0
    self.currentStepPosition = nil
    for i = 1, #steps do
        self:DisplayStep(steps[i], 0)
    end

    -- Hide other lines
    for i = self.lineIndex, #self.lines do
        self.lines[i]:Hide()
    end
end

function Window:DisplayStep(step, depth)
    if step.hasChildren then
        -- Display step prefix
        if step.location then
            local prefix
            if step.location.type == "NPC" then
                prefix = L["STEP_PREFIX_GO_TALK_TO"]
            elseif step.location.type == "Object" or step.location.type == "Item" then
                prefix = L["STEP_PREFIX_GO_TO"]
            end
            if prefix then
                self:GetNextLine():SetStepText(step, depth, "%s %s", prefix, self:GetColoredHighlightText(step.location.name, step.isComplete))
            end
        else
            Journeyman:Error("Unknown location for step %s", dump(step))
        end
        -- Display child steps
        for i = 1, #step.children do
            self:DisplayStep(step.children[i], depth + 1)
        end
    else
        -- Display step
        if step.type == Journeyman.STEP_TYPE_ACCEPT_QUEST then
            self:GetNextLine():SetStepText(step, depth, L["STEP_TEXT_ACCEPT_QUEST"], self:GetColoredQuestText(step.data.questId, step.isComplete))
        elseif step.type == Journeyman.STEP_TYPE_COMPLETE_QUEST then
            self:GetNextLine():SetStepText(step, depth, L["STEP_TEXT_COMPLETE_QUEST"], self:GetColoredQuestText(step.data.questId, step.isComplete))
            self:DisplayStepObjectives(step, depth + 1)
        elseif step.type == Journeyman.STEP_TYPE_TURNIN_QUEST then
            self:GetNextLine():SetStepText(step, depth, L["STEP_TEXT_TURNIN_QUEST"], self:GetColoredQuestText(step.data.questId, step.isComplete))
        elseif step.type == Journeyman.STEP_TYPE_GO_TO_COORD then
            self:GetNextLine():SetStepText(step, depth, L["STEP_TEXT_GO_TO_COORD"], self:GetColoredHighlightText(step.data.desc, step.isComplete), self:GetColoredHighlightText(step.data.mapName, step.isComplete))
        elseif step.type == Journeyman.STEP_TYPE_GO_TO_ZONE then
            self:GetNextLine():SetStepText(step, depth, L["STEP_TEXT_GO_TO_ZONE"], self:GetColoredHighlightText(step.data.mapName, step.isComplete))
        elseif step.type == Journeyman.STEP_TYPE_GO_TO_AREA then
            self:GetNextLine():SetStepText(step, depth, L["STEP_TEXT_GO_TO_AREA"], self:GetColoredHighlightText(step.data.desc, step.isComplete), self:GetColoredHighlightText(step.data.areaName, step.isComplete))
        elseif step.type == Journeyman.STEP_TYPE_REACH_LEVEL then
            -- Step text
            local text = string.format(L["STEP_TEXT_REACH_LEVEL"], self:GetColoredHighlightText(step.data.level, step.isComplete))
            if step.data.xp then
                text = text..string.format(" +%s xp", step.data.xp)
            end
            self:GetNextLine():SetStepText(step, depth, "%s", text) -- string contains % sign
            -- Step objective text
            local gainXP = nil
            if Journeyman.player.level == step.data.level and step.data.xp then
                gainXP = max(step.data.xp - Journeyman.player.xp, 0)
            elseif Journeyman.player.level == step.data.level - 1 then
                gainXP = max(Journeyman.player.maxXP - Journeyman.player.xp, 0)
                if step.data.xp then
                    gainXP = gainXP + step.data.xp
                end
            end
            if gainXP and gainXP > 0 then
                local gainXPText = string.format(L["STEP_TEXT_GAIN_XP"], self:GetColoredHighlightText(gainXP, step.isComplete))
                if Journeyman.player.lastXP then
                    local xpGained = Journeyman.player.xp - Journeyman.player.lastXP
                    local count = math.ceil(gainXP / xpGained)
                    gainXPText = string.format("%s (%s kill)", gainXPText, count)
                end
                self:GetNextLine():SetStepText(step, depth + 1, gainXPText)
            end
        elseif step.type == Journeyman.STEP_TYPE_BIND_HEARTHSTONE then
            self:GetNextLine():SetStepText(step, depth, L["STEP_TEXT_BIND_HEARTHSTONE"], self:GetColoredItemText(Journeyman.ITEM_HEARTHSTONE), self:GetColoredAreaText(step.data.areaId, step.isComplete))
        elseif step.type == Journeyman.STEP_TYPE_USE_HEARTHSTONE then
            self:GetNextLine():SetStepText(step, depth, L["STEP_TEXT_USE_HEARTHSTONE"], self:GetColoredItemText(Journeyman.ITEM_HEARTHSTONE), self:GetColoredAreaText(step.data.areaId, step.isComplete))
        elseif step.type == Journeyman.STEP_TYPE_LEARN_FLIGHT_PATH then
            self:GetNextLine():SetStepText(step, depth, L["STEP_TEXT_LEARN_FLIGHT_PATH"], self:GetColoredTaxiNodeText(step.data.taxiNodeId, step.isComplete))
        elseif step.type == Journeyman.STEP_TYPE_FLY_TO then
            self:GetNextLine():SetStepText(step, depth, L["STEP_TEXT_FLY_TO"], self:GetColoredTaxiNodeText(step.data.taxiNodeId, step.isComplete))
        elseif step.type == Journeyman.STEP_TYPE_TRAIN_CLASS then
            self:GetNextLine():SetStepText(step, depth, L["STEP_TEXT_TRAIN_CLASS"])
        elseif step.type == Journeyman.STEP_TYPE_TRAIN_SPELLS then
            local spellNames = {}
            List:ForEach(step.data.spells, function(spellId)
                local isComplete = Journeyman:IsSpellKnown(spellId)
                if not isComplete or Journeyman.db.profile.window.showCompletedSteps then
                    List:Add(spellNames, self:GetColoredSpellText(spellId, isComplete))
                end
            end)
            self:GetNextLine():SetStepText(step, depth, L["STEP_TEXT_TRAIN_SPELLS"], Journeyman.Utils:Join(", ", spellNames))
        elseif step.type == Journeyman.STEP_TYPE_LEARN_FIRST_AID then
            self:GetNextLine():SetStepText(step, depth, L["STEP_TEXT_LEARN_FIRST_AID"])
        elseif step.type == Journeyman.STEP_TYPE_LEARN_COOKING then
            self:GetNextLine():SetStepText(step, depth, L["STEP_TEXT_LEARN_COOKING"])
        elseif step.type == Journeyman.STEP_TYPE_LEARN_FISHING then
            self:GetNextLine():SetStepText(step, depth, L["STEP_TEXT_LEARN_FISHING"])
        elseif step.type == Journeyman.STEP_TYPE_DIE_AND_RES then
            self:GetNextLine():SetStepText(step, depth, L["STEP_TEXT_DIE_AND_RES"])
        else
            Journeyman:Error("Step type %s not implemented.", step.type)
        end

        -- Display step note
        if step.note and string.len(step.note) > 0 then
            local note = Journeyman:ReplaceAllShortLinks(L[step.note], function() Window:Update() end)
            local indent = depth
            if step.type == Journeyman.STEP_TYPE_COMPLETE_QUEST or step.type == Journeyman.STEP_TYPE_GO_TO_COORD or step.type == Journeyman.STEP_TYPE_GO_TO_ZONE then
                indent = indent + 1
            end
            self:GetNextLine():SetStepText(step, indent, L["STEP_TEXT_NOTE"], self:GetColoredHighlightText(note, step.isComplete))
        end
    end
end

function Window:DisplayStepObjectives(step, depth)
    Journeyman.State:IterateStepQuestObjectives(step, function(objective, objectiveIndex)
        Window:DisplayStepObjective(step, depth, objective, objectiveIndex)
    end)
end

function Window:DisplayStepObjective(step, depth, objective, objectiveIndex)
    local isComplete = objective.finished == true or step.isComplete
    if not isComplete or Journeyman.db.profile.window.showCompletedSteps then
        local objectiveStep = { type = step.type, data = step.data, isComplete = isComplete, isShown = step.isShown, objectiveIndex = objectiveIndex }
        self:GetNextLine():SetStepText(objectiveStep, depth, self:GetColoredHighlightText(objective.text, isComplete))
    end
end

function Window:GetNextLine()
    local line
    if self.lineIndex > #self.lines then
        line = Journeyman.GUI:CreateLabel("BUTTON", "Line" .. self.lineIndex, self.scrollChild)
        line:SetJustifyH("LEFT")
        line:SetWordWrap(true)
        line:EnableHyperlinks(true)
        line.index = self.lineIndex
        line.SetStepText = function(self, step, depth, fmt, ...)
            self:SetPoint("LEFT", Window.scrollChild, "LEFT", Journeyman.db.profile.window.indentSize * depth, 0)
            if self.index == 1 then
                self:SetPoint("TOP", Window.scrollChild, "TOP", 0, -Journeyman.db.profile.window.fontSize * (self.index - 1))
            else
                self:SetPoint("TOP", Window.lines[self.index - 1], "BOTTOM", 0, 0)
            end

            if step.isComplete then
                self:SetFormattedText("|c%s%s|r", TEXT_COLOR_STEP_COMPLETE, string.format(fmt, ...))
            else
                self:SetFormattedText(fmt, ...)
            end

            self:SetFontSize(Journeyman.db.profile.window.fontSize)
            self:SetWidth(Window.scrollChild:GetWidth() - (Journeyman.db.profile.window.indentSize * depth))
            self:SetHeight(Journeyman.db.profile.window.fontSize + Journeyman.db.profile.window.lineSpacing)

            -- Recalculate height a second time, now GetNumLines will return updated value
            local lineHeight = (Journeyman.db.profile.window.fontSize * self:GetNumLines()) + Journeyman.db.profile.window.lineSpacing
            self:SetHeight(lineHeight)

            self:SetScript("OnClick", function(self, button)
                if button == "LeftButton" then
                    if not IsModifiedClick() then
                        if Journeyman:IsStepTypeQuest(step) then
                            Window:ShowQuest(step.data.questId)
                        end
                    elseif IsModifiedClick("CHATLINK") then
                        if Journeyman:IsStepTypeQuest(step) then
                            if step.objectiveIndex then
                                local objectives = Journeyman.DataSource:GetQuestObjectives(step.data.questId, { step.objectiveIndex })
                                for i = 1, #objectives do
                                    local objective = objectives[i]
                                    if objective.type == "Item" then
                                        Window:LinkItem(objective.id)
                                        break
                                    end
                                end
                            else
                                Window:LinkQuest(step.data.questId)
                            end
                        end
                    elseif IsControlKeyDown() then
                        Journeyman:SetWaypoint(step, true)
                    elseif IsAltKeyDown() and not step.hasChildren then
                        step.isComplete = true
                        step.isCompleteOverride = true
                        Journeyman.State.waypointNeedUpdate = Journeyman.db.profile.autoSetWaypoint
                        Journeyman.State.macroNeedUpdate = true
                        Journeyman:Update(true)
                    end
                end
            end)
            self:Show()

            if Window.currentStepPosition == nil and (not step.isComplete and step.isShown) then
                Window.currentStepPosition = Window.stepsHeight
            end

            Window.stepsHeight = Window.stepsHeight + lineHeight
        end

        self.lines[#self.lines + 1] = line
    else
        line = self.lines[self.lineIndex]
    end

    self.lineIndex = self.lineIndex + 1
    return line
end

function Window:GetColoredHighlightText(text, isComplete)
    if text then
        if isComplete then
            return string.format("|c%s%s|r", TEXT_COLOR_STEP_COMPLETE, text)
        else
            return string.format("|c%s%s|r", TEXT_COLOR_HIGHLIGHT, text)
        end
    end
end

function Window:GetColoredAreaText(areaId, isComplete)
    local areaName = Journeyman:GetAreaNameById(areaId)
    if areaName == nil then return string.format("area:%s", areaId) end

    if not isComplete then
        return string.format("|c%s%s|r", TEXT_COLOR_HIGHLIGHT, areaName)
    end

    return areaName
end

function Window:GetColoredTaxiNodeText(taxiNodeId, isComplete)
    local taxiNodeName = Journeyman:GetTaxiNodeName(taxiNodeId)
    if taxiNodeName == nil then return string.format("taxiNode:%s", taxiNodeId) end

    if not isComplete then
        return string.format("|c%s%s|r", TEXT_COLOR_HIGHLIGHT, taxiNodeName)
    end

    return taxiNodeName
end

function Window:GetColoredQuestText(questId, isComplete)
    local questName = Journeyman.DataSource:GetQuestName(questId, Journeyman.db.profile.window.showQuestLevel)
    if questName == nil then return string.format("quest:%s", questId) end

    if not isComplete then
        local questLevel = Journeyman.DataSource:GetQuestLevel(questId)
        if questLevel ~= nil then
            local colorHex
            local levelDiff = questLevel - Journeyman.player.level
            if levelDiff >= 5 then
                colorHex = QUEST_COLOR_RED
            elseif levelDiff >= 3 then
                colorHex = QUEST_COLOR_ORANGE
            elseif levelDiff >= -2 then
                colorHex = QUEST_COLOR_YELLOW
            elseif -levelDiff <= Journeyman.player.greenRange then
                colorHex = QUEST_COLOR_GREEN
            else
                colorHex = QUEST_COLOR_GREY
            end
            return string.format("|c%s%s|r", colorHex, questName)
        end
    end

    return questName
end

function Window:GetColoredItemText(itemId)
    if itemId and type(itemId) == "number" then
        local itemLink = Journeyman:GetItemLink(itemId, function() Window:Update() end)
        if itemLink then
            return itemLink
        end
    end
    return "item:" .. itemId
end

function Window:GetColoredSpellText(spellId, isComplete)
    if spellId and type(spellId) == "number" then
        local spellName = Journeyman:GetSpellName(spellId, function() Window:Update() end)
        return self:GetColoredHighlightText(spellName, isComplete)
    end
    return "spell:"..spellId
end

function Window:ShowQuest(questId)
    if Journeyman.State:IsQuestInQuestLog(questId) then
        local questLogIndex
        if C_QuestLog.GetLogIndexForQuestID then
            questLogIndex = C_QuestLog.GetLogIndexForQuestID(questId)
        else
            questLogIndex = GetQuestLogIndexByID(questId)
        end

        if questLogIndex then
            if C_QuestLog.SetSelectedQuest then
                C_QuestLog.SetSelectedQuest(questLogIndex)
            else
                SelectQuestLogEntry(questLogIndex)
            end

            -- Scroll to the quest in the quest log
            local scrollSteps = QuestLogListScrollFrame.ScrollBar:GetValueStep()
            QuestLogListScrollFrame.ScrollBar:SetValue(questLogIndex * scrollSteps - scrollSteps * 3)
        end

        -- Priority order first check if addon exist otherwise default to original
        local questFrame = QuestLogExFrame or ClassicQuestLog or QuestLogFrame
        if questFrame then
            if not questFrame:IsShown() then
                if not InCombatLockdown() then
                    ShowUIPanel(questFrame)
                    if QuestLogEx then
                        QuestLogEx:Maximize()
                    end
                end
            end
        end

        QuestLog_UpdateQuestDetails()
        QuestLog_Update()
    else
        Journeyman.DataSource:ShowQuestTooltip(questId)
    end
end

function Window:LinkQuest(questId)
    local questName = Journeyman.DataSource:GetQuestName(questId, Journeyman.db.profile.window.showQuestLevel)
    local questLink = string.format("[%s (%d)]", questName, questId)
    ChatEdit_InsertLink(questLink)
end

function Window:LinkItem(itemId)
    local itemLink = Journeyman:GetItemLink(itemId)
    ChatEdit_InsertLink(itemLink)
end
