local addonName, addon = ...
local Journeyman = addon.Journeyman
local L = addon.Locale

local Window = {}
Journeyman.Window = Window

local TaxiNodes = Journeyman.TaxiNodes
local GUI = Journeyman.GUI
local State = Journeyman.State
local String = LibStub("LibCollections-1.0").String
local List = LibStub("LibCollections-1.0").List
local TomTom = TomTom

local HEADER_HEIGHT = 24
local TEXT_COLOR_STEP_COMPLETE = "FFA0A0A0"
local TEXT_COLOR_HIGHLIGHT = "FFFFFFFF"

local function round(num)
  return num + (2^52 + 2^51) - (2^52 + 2^51)
end

function Window:Initialize()
    self.questLogScrollBar = QuestLogListScrollFrame.ScrollBar or QuestLogListScrollFrameScrollBar
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
        local journey = Journeyman:GetActiveJourney()
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
        local journey = Journeyman:GetActiveJourney()
        if journey ~= nil then
            if Journeyman.db.char.chapter > 1 then
                Journeyman.db.char.chapter = Journeyman.db.char.chapter - 1
                Journeyman:Reset(true)
            end
        end
    end)
    self.prevChapterButton = prevChapterButton

    -- Chapter title
    local chapterTitle = GUI:CreateLabel("FRAME", nil, frame)
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
    local journeySelectionLabel = GUI:CreateLabel("FRAME", nil, scrollChild)
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

    -- Hook OnUpdate for coroutines
    frame:HookScript("OnUpdate", function()
        if Journeyman.loadJourneyDataTask then
            local status = coroutine.status(Journeyman.loadJourneyDataTask)
            if status == "suspended" then
                coroutine.resume(Journeyman.loadJourneyDataTask)
            elseif status == "running" then
            elseif status == "normal" then
            elseif status == "dead" then
                Journeyman.loadJourneyDataTask = nil
            end
        end
    end)
end

function Window:Shutdown()
end

function Window:CheckForUpdate()
    if self.frame:IsShown() ~= Journeyman.db.char.window.show then
        self:Update()
    end

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
    local journey = Journeyman:GetActiveJourney()
    if journey ~= nil then
        local index = Journeyman.db.char.chapter
        enabled = index >= 1 and index < #journey.chapters
    end
    self.nextChapterButton:SetEnabled(enabled)
end

function Window:UpdatePreviousChapterButton()
    local enabled = false
    local journey = Journeyman:GetActiveJourney()
    if journey ~= nil then
        local index = Journeyman.db.char.chapter
        enabled = index > 1 and index <= #journey.chapters
    end
    self.prevChapterButton:SetEnabled(enabled)
end

function Window:UpdateChapterTitle()
    local journey = Journeyman:GetActiveJourney()
    local chapter = Journeyman:GetActiveJourneyChapter()

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
    local shown = Journeyman:GetActiveJourney() == nil
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
    if State.steps then
        for i = 1, #State.steps do
            local step = State.steps[i]
            if step.isShown then
                -- Optimization: Update step location only if we're going to show it
                -- Also, don't need location for step type complete quest, because its meaningless here
                if step.location == nil and step.type ~= Journeyman.STEP_TYPE_COMPLETE_QUEST then
                    step.location = State:GetStepLocation(step)
                end

                if step.type ~= Journeyman.STEP_TYPE_COMPLETE_QUEST and step.location and (step.location.type == "NPC" or step.location.type == "Object") then
                    local lastStep = steps[#steps]
                    if lastStep == nil or lastStep.location == nil or lastStep.location.name ~= step.location.name then
                        List:Add(steps, { isComplete = step.isComplete, isShown = step.isShown, location = step.location, hasChildren = true, children = { step } })
                    else
                        List:Add(lastStep.children, step)
                        lastStep.isComplete = lastStep.isComplete and step.isComplete
                    end
                else
                    List:Add(steps, step)
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
    local n = #steps
    for i = 1, n do
        self:DisplayStep(steps[i], 0)

        -- Add empty line
        if i < n and Journeyman.db.profile.window.stepSpacing > 0 then
            self:GetNextLine():SetEmpty()
        end
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
            self:GetNextLine():SetStepText(step, depth, "%s %s", L["STEP_PREFIX_GO_TO"], self:GetColoredHighlightText(step.location.name, step.isComplete))
        else
            Journeyman:Error("Unknown location for step %d", step.indexInChapter)
        end
        -- Display child steps
        for i = 1, #step.children do
            self:DisplayStep(step.children[i], depth)
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
                local objectiveText = string.format(L["STEP_TEXT_GAIN_XP"], gainXP)
                if Journeyman.player.xpGained then
                    local count = math.ceil(gainXP / Journeyman.player.xpGained)
                    local countText = string.format(L["NUMBER_OF_KILL"], count)
                    objectiveText = string.format("%s (%s)", objectiveText, countText)
                end
                self:GetNextLine():SetFormattedText(depth + 1, self:GetColoredHighlightText(objectiveText, step.isComplete))
            end
        elseif step.type == Journeyman.STEP_TYPE_REACH_REPUTATION then
            -- Step text
            local factionId = step.data.factionId or 0
            local factionName = Journeyman:GetFactionName(factionId)
            local standingId = step.data.standingId or 0
            local standingLabel = Journeyman:GetStandingLabel(standingId)
            self:GetNextLine():SetStepText(step, depth, L["STEP_TEXT_REACH_REPUTATION"], self:GetColoredHighlightText(standingLabel, step.isComplete), self:GetColoredHighlightText(factionName, step.isComplete))
            -- Step objective text
            local _, _, currentStandingId, barMin, barMax, barValue = GetFactionInfoByID(factionId)
            if currentStandingId < standingId then
                local gainFaction = barMax - barValue
                local objectiveText = string.format(L["STEP_TEXT_GAIN_REP"], gainFaction)
                if Journeyman.player.factionGained[factionId] then
                    local count = math.ceil(gainFaction / Journeyman.player.factionGained[factionId])
                    local countText = string.format(L["NUMBER_OF_KILL"], count)
                    objectiveText = string.format("%s (%s)", objectiveText, countText)
                end
                self:GetNextLine():SetFormattedText(depth + 1, self:GetColoredHighlightText(objectiveText, step.isComplete))
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
            self:GetNextLine():SetStepText(step, depth, L["STEP_TEXT_TRAIN_SPELLS"], String:Join(", ", spellNames))
        elseif step.type == Journeyman.STEP_TYPE_LEARN_FIRST_AID then
            self:GetNextLine():SetStepText(step, depth, L["STEP_TEXT_LEARN_FIRST_AID"])
        elseif step.type == Journeyman.STEP_TYPE_LEARN_COOKING then
            self:GetNextLine():SetStepText(step, depth, L["STEP_TEXT_LEARN_COOKING"])
        elseif step.type == Journeyman.STEP_TYPE_LEARN_FISHING then
            self:GetNextLine():SetStepText(step, depth, L["STEP_TEXT_LEARN_FISHING"])
        elseif step.type == Journeyman.STEP_TYPE_ACQUIRE_ITEMS then
            self:GetNextLine():SetStepText(step, depth, L["STEP_TEXT_ACQUIRE_ITEMS"], "")
            List:ForEach(step.data.items, function(item)
                local isComplete = Journeyman:GetItemCountInBags(item.id) >= item.count
                if not isComplete or Journeyman.db.profile.window.showCompletedSteps then
                    local itemName = Journeyman:GetItemName(item.id, function() Window:Update() end)
                    local itemCount = math.min(Journeyman:GetItemCountInBags(item.id), item.count)
                    local objectiveStep = { type = step.type, data = step.data, isComplete = isComplete, isShown = step.isShown, itemId = item.id }
                    local objectiveText = itemName..": "..itemCount.."/"..item.count
                    self:GetNextLine():SetStepText(objectiveStep, depth + 1, self:GetColoredHighlightText(objectiveText, isComplete))
                end
            end)
        elseif step.type == Journeyman.STEP_TYPE_DIE_AND_RES then
            self:GetNextLine():SetStepText(step, depth, L["STEP_TEXT_DIE_AND_RES"])
        else
            Journeyman:Error("Step type %s not implemented.", step.type)
        end

        -- Display step note
        if step.note and string.len(step.note) > 0 then
            local note = self:ReplaceAllShortLinks(L[step.note], step.isComplete, function() Window:Update() end)
            note = note:gsub("%%", "%%%%") -- Escape percent sign
            self:GetNextLine():SetFormattedText(depth, self:GetColoredStepText(string.format(L["STEP_TEXT_NOTE"], note), step.isComplete))
        end
    end
end

function Window:DisplayStepObjectives(step, depth)
    State:IterateStepQuestObjectives(step, function(objective, objectiveIndex)
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

local function CreateLine(index, parent)
    local frame = CreateFrame("FRAME", "Line"..index, parent)
    frame.index = index

    local background = frame:CreateTexture("Background"..index, "BACKGROUND")
    background:SetAllPoints()
    background:SetColorTexture(1, 1, 1, 0)
    frame.background = background

    local checkBox = GUI:CreateCheckBox("FRAME", "CheckBox"..index, frame)
    checkBox:SetPoint("TOPLEFT", frame)
    checkBox:SetSize(Journeyman.db.profile.window.fontSize, Journeyman.db.profile.window.fontSize)
    checkBox:SetAlpha(0.6)
    frame.checkBox = checkBox

    local label = GUI:CreateLabel("BUTTON", "Label"..index, frame)
    label:SetPoint("TOP", checkBox)
    label:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 0, Journeyman.db.profile.window.lineSpacing)
    label:SetJustifyV("MIDDLE")
    label:SetJustifyH("LEFT")
    label:SetWordWrap(true)
    label:EnableHyperlinks(true)
    frame.label = label

    frame.SetStepText = function(self, step, depth, fmt, ...)
        self:SetPoint("LEFT", parent, "LEFT")
        if self.index == 1 then
            self:SetPoint("TOP", parent, "TOP", 0, -Journeyman.db.profile.window.fontSize * (self.index - 1))
        else
            self:SetPoint("TOP", Window.lines[self.index - 1], "BOTTOM")
        end
        self:SetWidth(parent:GetWidth())
        self:SetHeight(Journeyman.db.profile.window.fontSize + Journeyman.db.profile.window.lineSpacing + 1)

        self.background:SetAllPoints()
        self.background:SetColorTexture(0, 0, 0, 0)
        self.background:SetGradientAlpha("HORIZONTAL", 1, 1, 1, 1, 1, 1, 1, 1)

        self.checkBox:SetChecked(step.isComplete)
        self.checkBox:SetSize(Journeyman.db.profile.window.fontSize, Journeyman.db.profile.window.fontSize)
        self.checkBox:SetShown(not step.hasChildren and not step.objectiveIndex and not step.itemId)
        self.checkBox:SetScript("OnClick", function(self, button)
            if step.isComplete then
                State:OnStepReset(step, true)
            else
                State:OnStepSkipped(step, true)
            end
        end)

        if step.hasChildren then
            self.label:SetPoint("LEFT", self, "LEFT", depth * Journeyman.db.profile.window.indentSize, 0)
        else
            self.label:SetPoint("LEFT", self.checkBox, "RIGHT", 2 + (depth * Journeyman.db.profile.window.indentSize), 0)
        end
        self.label:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", 0, Journeyman.db.profile.window.lineSpacing)
        self.label:SetFontSize(Journeyman.db.profile.window.fontSize)
        if step.isComplete then
            self.label:SetFormattedText("|c%s%s|r", TEXT_COLOR_STEP_COMPLETE, string.format(fmt, ...))
        else
            self.label:SetFormattedText(fmt, ...)
        end
        self.label:SetScript("OnClick", function(self, button)
            if button == "LeftButton" then
                if not IsModifiedClick() then
                    if Journeyman:IsStepTypeQuest(step) then
                        Window:ShowQuest(step.data.questId)
                    elseif step.type == Journeyman.STEP_TYPE_ACQUIRE_ITEMS then
                        if step.itemId then
                            Window:ShowItem(step.itemId)
                        end
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
                    elseif step.type == Journeyman.STEP_TYPE_ACQUIRE_ITEMS then
                        if step.itemId then
                            Window:LinkItem(step.itemId)
                        end
                    end
                elseif IsControlKeyDown() then
                    Journeyman:SetWaypoint(step, true)
                elseif IsAltKeyDown() and not step.hasChildren and not step.ObjectiveIndex then
                    State:OnStepSkipped(step, true)
                end
            end
        end)

        local lineHeight = (Journeyman.db.profile.window.fontSize * self.label:GetNumLines()) + Journeyman.db.profile.window.lineSpacing + 1
        self:SetHeight(lineHeight)
        self:Show()

        if Window.currentStepPosition == nil and (not step.isComplete and step.isShown) then
            Window.currentStepPosition = Window.stepsHeight
        end

        Window.stepsHeight = Window.stepsHeight + lineHeight
    end

    frame.SetFormattedText = function(self, depth, fmt, ...)
        self:SetPoint("LEFT", parent, "LEFT")
        if self.index == 1 then
            self:SetPoint("TOP", parent, "TOP", 0, -Journeyman.db.profile.window.fontSize * (self.index - 1))
        else
            self:SetPoint("TOP", Window.lines[self.index - 1], "BOTTOM")
        end
        self:SetWidth(parent:GetWidth())
        self:SetHeight(Journeyman.db.profile.window.fontSize + Journeyman.db.profile.window.lineSpacing + 1)

        self.background:SetAllPoints()
        self.background:SetColorTexture(0, 0, 0, 0)
        self.background:SetGradientAlpha("HORIZONTAL", 1, 1, 1, 1, 1, 1, 1, 1)

        self.checkBox:SetChecked(false)
        self.checkBox:SetSize(Journeyman.db.profile.window.fontSize, Journeyman.db.profile.window.fontSize)
        self.checkBox:SetShown(false)
        self.checkBox:SetScript("OnClick", nil)

        self.label:SetPoint("LEFT", self.checkBox, "RIGHT", 2 + (depth * Journeyman.db.profile.window.indentSize), 0)
        self.label:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", 0, Journeyman.db.profile.window.lineSpacing)
        self.label:SetFontSize(Journeyman.db.profile.window.fontSize)
        self.label:SetFormattedText(fmt, ...)
        self.label:SetScript("OnClick", nil)

        local lineHeight = (Journeyman.db.profile.window.fontSize * self.label:GetNumLines()) + Journeyman.db.profile.window.lineSpacing + 1
        self:SetHeight(lineHeight)
        self:Show()
        Window.stepsHeight = Window.stepsHeight + lineHeight
    end

    frame.SetEmpty = function(self)
        self:SetPoint("LEFT", parent, "LEFT")
        self:SetPoint("TOP", Window.lines[self.index - 1], "BOTTOM")
        self:SetWidth(parent:GetWidth())
        self:SetHeight(Journeyman.db.profile.window.stepSpacing)

        self.background:ClearAllPoints()
        self.background:SetPoint("TOP", 0, -(Journeyman.db.profile.window.stepSpacing / 2) + 0.5)
        self.background:SetPoint("LEFT")
        self.background:SetPoint("BOTTOM", 0, (Journeyman.db.profile.window.stepSpacing / 2) - 0.5)
        self.background:SetPoint("RIGHT")
        self.background:SetColorTexture(1, 1, 1, 0.1)
        self.background:SetGradientAlpha("HORIZONTAL", 1, 1, 1, 1, 1, 1, 1, 0)

        self.checkBox:SetChecked(false)
        self.checkBox:SetSize(Journeyman.db.profile.window.fontSize, Journeyman.db.profile.window.fontSize)
        self.checkBox:SetShown(false)
        self.checkBox:SetScript("OnClick", nil)

        self.label:SetPoint("LEFT", self, "LEFT")
        self.label:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", 0, Journeyman.db.profile.window.lineSpacing)
        self.label:SetFontSize(Journeyman.db.profile.window.fontSize)
        self.label:SetText("   ")
        self.label:SetScript("OnClick", nil)

        self:Show()
        Window.stepsHeight = Window.stepsHeight + self:GetHeight()
    end

    return frame
end

function Window:GetNextLine()
    local line
    if self.lineIndex > #self.lines then
        line = CreateLine(self.lineIndex, self.scrollChild)
        self.lines[#self.lines + 1] = line
    else
        line = self.lines[self.lineIndex]
    end
    self.lineIndex = self.lineIndex + 1
    return line
end

function Window:GetColoredStepText(text, isComplete)
    if isComplete then
        return string.format("|c%s%s|r", TEXT_COLOR_STEP_COMPLETE, text)
    end
    return text
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
    local taxiNodeName = TaxiNodes:GetLocalizedName(taxiNodeId)
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
        local questColor = Journeyman:GetQuestColor(questId)
        return string.format("|c%s%s|r", questColor, questName)
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
    if State:IsQuestInQuestLog(questId) then
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
            local scrollSteps = self.questLogScrollBar:GetValueStep()
            self.questLogScrollBar:SetValue(questLogIndex * scrollSteps - scrollSteps * 3)
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

function Window:ShowItem(itemId)
    local itemLink = select(2, GetItemInfo(itemId))
    if String:IsNilOrEmpty(itemLink) then
        local item = Item:CreateFromItemID(itemId)
        if not item:IsItemEmpty() then
            item:ContinueOnItemLoad(function() Window:ShowItem(itemId) end)
        end
        return
    end
    ShowUIPanel(ItemRefTooltip)
    ItemRefTooltip:SetOwner(UIParent, "ANCHOR_PRESERVE");
    ItemRefTooltip:SetHyperlink(itemLink)
    ItemRefTooltip:Show()
end

function Window:LinkItem(itemId)
    local itemLink = Journeyman:GetItemLink(itemId)
    ChatEdit_InsertLink(itemLink)
end

function Window:ReplaceAllShortLinks(input, isComplete, callback)
    local result = input
    local matches = {}

    -- Get all short links
    for match, npcId in input:gmatch("(npc:(%d+))") do
        List:Add(matches, { match = match, npcId = tonumber(npcId) })
    end
    for match, itemId in input:gmatch("(item:(%d+))") do
        List:Add(matches, { match = match, itemId = tonumber(itemId) })
    end
    for match, objectId in input:gmatch("(object:(%d+))") do
        List:Add(matches, { match = match, objectId = tonumber(objectId) })
    end
    for match, spellId in input:gmatch("(spell:(%d+))") do
        List:Add(matches, { match = match, spellId = tonumber(spellId) })
    end
    for match, questId in input:gmatch("(quest:(%d+))") do
        List:Add(matches, { match = match, questId = tonumber(questId) })
    end
    for match, mapId in input:gmatch("(map:(%d+))") do
        List:Add(matches, { match = match, mapId = tonumber(mapId) })
    end
    for match, mapId in input:gmatch("(zone:(%d+))") do
        List:Add(matches, { match = match, mapId = tonumber(mapId) })
    end
    for match, areaId in input:gmatch("(area:(%d+))") do
        List:Add(matches, { match = match, areaId = tonumber(areaId) })
    end
    for match, taxiNodeId in input:gmatch("(taxi:(%d+))") do
        List:Add(matches, { match = match, taxiNodeId = tonumber(taxiNodeId) })
    end

    -- Replace all short links we found
    List:ForEach(matches, function(m)
        if m.npcId then
            local npcName = Journeyman.DataSource:GetNPCName(m.npcId)
            if not String:IsNilOrEmpty(npcName) and npcName ~= m.match then
                result = result:gsub(m.match, self:GetColoredHighlightText(npcName, isComplete))
            end
        elseif m.itemId then
            local itemLink = Journeyman:GetItemLink(m.itemId, callback)
            if not String:IsNilOrEmpty(itemLink) and itemLink ~= m.match then
                result = result:gsub(m.match, itemLink)
            end
        elseif m.objectId then
            local objectName = Journeyman.DataSource:GetObjectName(m.objectId)
            if not String:IsNilOrEmpty(objectName) and objectName ~= m.match then
                result = result:gsub(m.match, self:GetColoredHighlightText(objectName, isComplete))
            end
        elseif m.spellId then
            local spellName = Journeyman:GetSpellName(m.spellId, callback)
            if not String:IsNilOrEmpty(spellName) and spellName ~= m.match then
                result = result:gsub(m.match, self:GetColoredHighlightText(spellName, isComplete))
            end
        elseif m.questId then
            local questName = self:GetColoredQuestText(m.questId, isComplete)
            if not String:IsNilOrEmpty(questName) and questName ~= m.match then
                result = result:gsub(m.match, questName)
            end
        elseif m.mapId then
            local mapName = Journeyman:GetMapNameById(m.mapId)
            if not String:IsNilOrEmpty(mapName) and mapName ~= m.match then
                result = result:gsub(m.match, self:GetColoredHighlightText(mapName, isComplete))
            end
        elseif m.areaId then
            local areaName = Journeyman:GetAreaNameById(m.areaId)
            if not String:IsNilOrEmpty(areaName) and areaName ~= m.match then
                result = result:gsub(m.match, self:GetColoredHighlightText(areaName, isComplete))
            end
        elseif m.taxiNodeId then
            local taxiNodeName = TaxiNodes:GetLocalizedName(m.taxiNodeId)
            if not String:IsNilOrEmpty(taxiNodeName) and taxiNodeName ~= m.match then
                result = result:gsub(m.match, self:GetColoredHighlightText(taxiNodeName, isComplete))
            end
        end
    end)
    return result
end
