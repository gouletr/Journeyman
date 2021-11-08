local addonName, addon = ...
local Traveler = addon.Traveler
local L = addon.Locale
local Tracker = {}
Traveler.Tracker = Tracker

local TomTom = TomTom

local HEADER_HEIGHT = 24
local TEXT_COLOR_STEP_COMPLETE = "FFA0A0A0"
local TEXT_COLOR_HIGHLIGHT = "FFFFFFFF"
local TEXT_COLOR_LOCATION = "FFFFFFFF"
local QUEST_COLOR_RED = "FFFF1A1A"
local QUEST_COLOR_ORANGE = "FFFF8040"
local QUEST_COLOR_YELLOW = "FFFFFF00"
local QUEST_COLOR_GREEN = "FF40C040"
local QUEST_COLOR_GREY = "FFC0C0C0"

function Tracker:Initialize()
    self.lines = {}

    -- Create main frame
    local frame = CreateFrame("FRAME", nil, UIParent)
    frame:SetClampedToScreen(Traveler.db.profile.window.clamped)
    frame:SetFrameStrata(Traveler.db.profile.window.strata)
    frame:SetFrameLevel(Traveler.db.profile.window.level)
    frame:SetWidth(Traveler.db.profile.window.width)
    frame:SetHeight(Traveler.db.profile.window.height)
    frame:SetPoint(Traveler.db.profile.window.relativePoint, UIParent, Traveler.db.profile.window.relativePoint, Traveler.db.profile.window.x, Traveler.db.profile.window.y)
    frame:SetMovable(true)
    frame:SetResizable(true)
    frame:SetMinResize(200, 100)
    frame:EnableMouse(true)
    frame:SetScript("OnMouseDown", function(self, button)
        if not Traveler.db.profile.window.locked and button == "LeftButton" then
            frame:StartMoving()
        end
    end)
    frame:SetScript("OnMouseUp", function(self, button)
        if not Traveler.db.profile.window.locked and button == "LeftButton" then
            frame:StopMovingOrSizing()
            local point, relativeTo, relativePoint, offsetX, offsetY = frame:GetPoint()
            Traveler.db.profile.window.relativePoint = relativePoint
            Traveler.db.profile.window.x = offsetX
            Traveler.db.profile.window.y = offsetY
            Tracker:Update(true)
        end
    end)
    frame.bg = frame:CreateTexture(nil, "BACKGROUND")
    frame.bg:SetAllPoints(frame)
    frame.bg:SetColorTexture(Traveler.db.profile.window.backgroundColor.r, Traveler.db.profile.window.backgroundColor.g, Traveler.db.profile.window.backgroundColor.b, Traveler.db.profile.window.backgroundColor.a)
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
        Traveler.db.char.window.show = false
        Tracker:Update(true)
    end)
    self.closeButton = closeButton

    -- Create lock button
    local lockButton = CreateFrame("BUTTON", nil, frame)
    lockButton:SetSize(HEADER_HEIGHT, HEADER_HEIGHT)
    lockButton:SetPoint("TOPRIGHT", closeButton, "TOPLEFT")
    lockButton:SetScript("OnClick", function()
        Traveler.db.profile.window.locked = not Traveler.db.profile.window.locked
        Tracker:Update(true)
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
        local journey = Traveler.Journey:GetActiveJourney()
        if journey ~= nil then
            if Traveler.db.char.window.chapter < #journey.chapters then
                Traveler.db.char.window.chapter = Traveler.db.char.window.chapter + 1
                Traveler.State:Reset(true)
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
        local journey = Traveler.Journey:GetActiveJourney()
        if journey ~= nil then
            if Traveler.db.char.window.chapter > 1 then
                Traveler.db.char.window.chapter = Traveler.db.char.window.chapter - 1
                Traveler.State:Reset(true)
            end
        end
    end)
    self.prevChapterButton = prevChapterButton

    -- Chapter title
    local chapterTitle = Traveler.GUI:CreateLabel("FRAME", nil, frame)
    chapterTitle:SetPoint("TOPLEFT", frame, "TOPLEFT")
    chapterTitle:SetPoint("BOTTOMRIGHT", prevChapterButton, "BOTTOMLEFT")
    chapterTitle:SetJustifyH("LEFT")
    chapterTitle:SetJustifyV("CENTER")
    chapterTitle:SetFontSize(Traveler.db.profile.window.fontSize)
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
        if not Traveler.db.profile.window.locked and button == "LeftButton" then
            frame:StartSizing("BOTTOMRIGHT")
        end
    end)
    resizeButton:SetScript("OnMouseUp", function(_, button)
        if not Traveler.db.profile.window.locked and button == "LeftButton" then
            frame:StopMovingOrSizing()
            local point, relativeTo, relativePoint, offsetX, offsetY = frame:GetPoint()
            Traveler.db.profile.window.relativePoint = relativePoint
            Traveler.db.profile.window.x = offsetX
            Traveler.db.profile.window.y = offsetY
            local width, height = frame:GetSize()
            Traveler.db.profile.window.width = width
            Traveler.db.profile.window.height = height
            Tracker:Update(true)
        end
    end)
    self.resizeButton = resizeButton

    -- Scroll frame
    local scrollFrame = CreateFrame("SCROLLFRAME", nil, frame, "UIPanelScrollFrameTemplate")
    scrollFrame:SetWidth(frame:GetWidth())
    scrollFrame:SetHeight(frame:GetHeight() - HEADER_HEIGHT)
    scrollFrame:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, -HEADER_HEIGHT)
    scrollFrame:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT")
    if Traveler.db.profile.window.showScrollBar then
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
    local journeySelectionLabel = Traveler.GUI:CreateLabel("FRAME", nil, scrollChild)
    journeySelectionLabel:SetPoint("CENTER", scrollChild, "CENTER", 0, Traveler.db.profile.window.fontSize + 4)
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
        InterfaceOptionsFrame_OpenToCategory(Traveler.generalOptions)
        InterfaceOptionsFrame_OpenToCategory(Traveler.generalOptions)
    end)
    self.journeySelectionButton = journeySelectionButton

    -- Install update ticker
    self.ticker = C_Timer.NewTicker(Traveler.db.profile.advanced.updateFrequency, function()
        if self.needUpdate then self:UpdateImmediate() end
    end)
end

function Tracker:Shutdown()
    self.ticker:Cancel()
end

function Tracker:Update(immediate)
    self.needUpdate = true
    if immediate then
        self:UpdateImmediate()
    end
end

function Tracker:UpdateImmediate()
    if not Traveler.DataSource.IsInitialized() then return end

    local now = GetTimePreciseSec()

    self.playerLevel = UnitLevel("player")
    self.playerGreenRange = GetQuestGreenRange("player")

    self:UpdateFrame()
    self:UpdateLockButton()
    self:UpdateNextChapterButton()
    self:UpdatePreviousChapterButton()
    self:UpdateChapterTitle()
    self:UpdateResizeButton()
    self:UpdateScrollFrame()
    self:UpdateJourneySelection()
    self:UpdateSteps()

    self.frame:SetShown(Traveler.db.char.window.show)
    self.needUpdate = false

    local elapsed = (GetTimePreciseSec() - now) * 1000
    if elapsed > 16.6667 then
        Traveler:Debug("Window update took %.2fms", elapsed)
    end
end

function Tracker:UpdateFrame()
    self.frame:SetClampedToScreen(Traveler.db.profile.window.clamped)
    self.frame:SetFrameStrata(Traveler.db.profile.window.strata)
    self.frame:SetFrameLevel(Traveler.db.profile.window.level)
    self.frame:SetSize(Traveler.db.profile.window.width, Traveler.db.profile.window.height)
    self.frame.bg:SetColorTexture(Traveler.db.profile.window.backgroundColor.r, Traveler.db.profile.window.backgroundColor.g, Traveler.db.profile.window.backgroundColor.b, Traveler.db.profile.window.backgroundColor.a)
end

function Tracker:UpdateLockButton()
    if Traveler.db.profile.window.locked then
        self.lockButton:SetNormalTexture("Interface/Buttons/LockButton-Locked-Up")
        self.lockButton:SetHighlightTexture("Interface/Buttons/LockButton-Border")
        self.lockButton:SetPushedTexture("Interface/Buttons/LockButton-Unlocked-Down")
    else
        self.lockButton:SetNormalTexture("Interface/Buttons/LockButton-Unlocked-Up")
        self.lockButton:SetHighlightTexture("Interface/Buttons/LockButton-Border")
        self.lockButton:SetPushedTexture("Interface/Buttons/LockButton-Unlocked-Down")
    end
end

function Tracker:UpdateResizeButton()
    if Traveler.db.profile.window.locked then
        self.resizeButton:Hide()
    else
        self.resizeButton:Show()
    end
end

function Tracker:UpdateNextChapterButton()
    local enabled = false
    local journey = Traveler.Journey:GetActiveJourney()
    if journey ~= nil then
        local index = Traveler:GetActiveChapterIndex()
        enabled = index >= 1 and index < #journey.chapters
    end
    self.nextChapterButton:SetEnabled(enabled)
end

function Tracker:UpdatePreviousChapterButton()
    local enabled = false
    local journey = Traveler.Journey:GetActiveJourney()
    if journey ~= nil then
        local index = Traveler:GetActiveChapterIndex()
        enabled = index > 1 and index <= #journey.chapters
    end
    self.prevChapterButton:SetEnabled(enabled)
end

function Tracker:UpdateChapterTitle()
    local journey = Traveler.Journey:GetActiveJourney()
    local chapter = Traveler:GetActiveChapter(journey)

    local title
    if chapter ~= nil then
        local index = Traveler:GetActiveChapterIndex()
        title = string.format(L["CHAPTER_TITLE"], index, chapter.title)
    else
        title = L["MISSING_CHAPTER_TITLE"]
    end

    self.chapterTitle:SetFontSize(Traveler.db.profile.window.fontSize)
    self.chapterTitle:SetText(title)
end

function Tracker:UpdateScrollFrame()
    self.scrollFrame:SetWidth(self.frame:GetWidth())
    self.scrollFrame:SetHeight(self.frame:GetHeight() - HEADER_HEIGHT)
    if Traveler.db.profile.window.showScrollBar then
        self.scrollFrame.ScrollBar:SetAlpha(1)
    else
        self.scrollFrame.ScrollBar:SetAlpha(0)
    end
    self.scrollChild:SetWidth(self.scrollFrame:GetWidth())
    self.scrollChild:SetHeight(self.scrollFrame:GetHeight())
end

function Tracker:UpdateJourneySelection()
    local shown = Traveler.Journey:GetActiveJourney() == nil
    if shown then
        self.journeySelectionLabel:SetFontSize(12)
        self.journeySelectionLabel:SetWidth(self.scrollChild:GetWidth() - 48)
        self.journeySelectionLabel:SetHeight(12 * self.journeySelectionLabel:GetNumLines())
    end
    self.journeySelectionLabel:SetShown(shown)
    self.journeySelectionButton:SetShown(shown)
end

function Tracker:UpdateSteps()
    -- Group steps per chronological location
    local steps = {}
    for _, step in ipairs(Traveler.State.steps) do
        if step.location and step.type ~= Traveler.STEP_TYPE_COMPLETE_QUEST then
            local lastStep = steps[#steps]
            if lastStep == nil or lastStep.location == nil or lastStep.location.name ~= step.location.name then
                Traveler.Utils:Add(steps, { hasChildren = true, isComplete = step.isComplete, location = step.location, children = { step } })
            else
                Traveler.Utils:Add(lastStep.children, step)
                lastStep.isComplete = lastStep.isComplete and step.isComplete
            end
        else
            Traveler.Utils:Add(steps, step)
        end
    end

    -- Display steps recursively
    self.lineIndex = 1
    self.waypointSet = false
    local stepsCount = 0
    for i = 1, #steps do
        local step = steps[i]
        self:DisplayStep(steps[i])
        if not step.isComplete then -- only count incomplete steps
            stepsCount = stepsCount + 1
            if Traveler.db.profile.window.stepsShown > 0 and stepsCount >= Traveler.db.profile.window.stepsShown then
                break
            end
        end
    end

    -- Hide other lines
    for i = self.lineIndex, #self.lines do
        self.lines[i]:Hide()
    end
end

function Tracker:DisplayStep(step, depth)
    if depth == nil then
        depth = 0
    end

    if step.isComplete and not Traveler.db.profile.window.showCompletedSteps then
        return
    end

    if step.hasChildren then
        -- Display step prefix
        if step.location then
            local prefix
            if step.location.type == "NPC" then
                prefix = "Go talk to"
            else
                prefix = "Go to"
            end
            self:GetNextLine():SetStepText(step, depth, "%s %s", prefix, self:GetColoredLocationText(step.location.name, step.isComplete))
        else
            Traveler:Error("Unknown location for step %s", dump(step))
        end
        -- Display child steps
        for _, child in ipairs(step.children) do
            self:DisplayStep(child, depth + 1)
        end
    else
        -- Display step
        if step.type == Traveler.STEP_TYPE_ACCEPT_QUEST then
            self:GetNextLine():SetStepText(step, depth, "Accept %s", self:GetColoredQuestText(step.data, step.isComplete))
        elseif step.type == Traveler.STEP_TYPE_COMPLETE_QUEST then
            self:GetNextLine():SetStepText(step, depth, "Complete %s", self:GetColoredQuestText(step.data, step.isComplete))
        elseif step.type == Traveler.STEP_TYPE_TURNIN_QUEST then
            self:GetNextLine():SetStepText(step, depth, "Turn-in %s", self:GetColoredQuestText(step.data, step.isComplete))
        elseif step.type == Traveler.STEP_TYPE_FLY_TO then
            self:GetNextLine():SetStepText(step, depth, "Fly to %s", self:GetColoredLocationText(step.data, step.isComplete))
        elseif step.type == Traveler.STEP_TYPE_BIND_HEARTHSTONE then
            self:GetNextLine():SetStepText(step, depth, "Bind %s to %s", self:GetColoredItemText(step, Traveler.ITEM_HEARTHSTONE), self:GetColoredLocationText(step.data, step.isComplete))
        elseif step.type == Traveler.STEP_TYPE_USE_HEARTHSTONE then
            self:GetNextLine():SetStepText(step, depth, "Use %s to %s", self:GetColoredItemText(step, Traveler.ITEM_HEARTHSTONE), self:GetColoredLocationText(step.data, step.isComplete))
        elseif step.type == Traveler.STEP_TYPE_REACH_LEVEL then
            self:GetNextLine():SetStepText(step, depth, "Reach level %d", self:GetColoredHighlightText(step.data, step.isComplete))
        else
            Traveler:Error("Step type %s not implemented.", step.type)
        end
    end
end

function Tracker:GetNextLine()
    local line
    if self.lineIndex > #self.lines then
        line = Traveler.GUI:CreateLabel("BUTTON", "Line" .. self.lineIndex, self.scrollChild, true)
        line:SetJustifyH("LEFT")
        line:SetWordWrap(true)
        line.index = self.lineIndex
        line.SetStepText = function(self, step, depth, fmt, ...)
            self:SetPoint("LEFT", Tracker.scrollChild, "LEFT", Traveler.db.profile.window.fontSize * depth, 0)
            if self.index == 1 then
                self:SetPoint("TOP", Tracker.scrollChild, "TOP", 0, -Traveler.db.profile.window.fontSize * (self.index - 1))
            else
                self:SetPoint("TOP", Tracker.lines[self.index - 1], "BOTTOM", 0, 0)
            end

            if step.isComplete then
                self:SetText("|c%s%s|r", TEXT_COLOR_STEP_COMPLETE, string.format(fmt, ...))
            else
                self:SetText(fmt, ...)
            end

            self:SetFontSize(Traveler.db.profile.window.fontSize)
            self:SetWidth(Tracker.scrollChild:GetWidth() - (Traveler.db.profile.window.fontSize * depth))
            self:SetHeight((Traveler.db.profile.window.fontSize * self:GetNumLines()) + Traveler.db.profile.window.lineSpacing)
            self:SetScript("OnClick", function(self, button)
                if button == "LeftButton" and IsControlKeyDown() then
                    Tracker:SetWaypoint(step, true)
                end
            end)
            self:Show()
        end

        self.lines[#self.lines + 1] = line
    else
        line = self.lines[self.lineIndex]
    end

    self.lineIndex = self.lineIndex + 1
    return line
end

function Tracker:GetColoredHighlightText(text, isComplete)
    if text and not isComplete then
        return string.format("|c%s%s|r", TEXT_COLOR_HIGHLIGHT, text)
    end
    return text
end

function Tracker:GetColoredLocationText(location, isComplete)
    if location and not isComplete then
        return string.format("|c%s%s|r", TEXT_COLOR_LOCATION, location)
    end
    return location
end

function Tracker:GetColoredQuestText(questId, isComplete)
    local questName = Traveler.DataSource:GetQuestName(questId, Traveler.db.profile.window.showQuestLevel)
    if questName == nil then return string.format("quest:%s", questId) end

    if not isComplete then
        local questLevel = Traveler.DataSource:GetQuestLevel(questId)
        if questLevel ~= nil then
            local colorHex
            local levelDiff = questLevel - self.playerLevel
            if levelDiff >= 5 then
                colorHex = QUEST_COLOR_RED
            elseif levelDiff >= 3 then
                colorHex = QUEST_COLOR_ORANGE
            elseif levelDiff >= -2 then
                colorHex = QUEST_COLOR_YELLOW
            elseif -levelDiff <= self.playerGreenRange then
                colorHex = QUEST_COLOR_GREEN
            else
                colorHex = QUEST_COLOR_GREY
            end
            return string.format("|c%s%s|r", colorHex, questName)
        end
    end

    return questName
end

function Tracker:GetColoredItemText(step, itemId)
    local itemName, itemLink, itemQuality = GetItemInfo(itemId)

    if itemName == nil then
        local item = Item:CreateFromItemID(itemId)
        item:ContinueOnItemLoad(function() Tracker:Update() end)
        return string.format("item:%s", itemId)
    end

    if not step.isComplete then
        local _, _, _, colorHex = GetItemQualityColor(itemQuality)
        return string.format("|c%s%s|r", colorHex, itemName)
    end

    return itemName
end

function Tracker:SetWaypoint(step, force)
    if TomTom and TomTom.AddWaypoint then
        if Traveler.db.char.waypoint and TomTom.RemoveWaypoint then
            TomTom:RemoveWaypoint(Traveler.db.char.waypoint)
        end

        local location = step.location
        if not step.hasChildren then
            location = Traveler.State:GetStepLocation(step)
        end
        if location and (force or location.distance >= Traveler.db.profile.autoSetWaypointMin) then
            Traveler.db.char.waypoint = TomTom:AddWaypoint(location.mapId, location.x / 100.0, location.y / 100.0, { title = location.name, crazy = true })
        end
    end
end
