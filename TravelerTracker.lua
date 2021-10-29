local addonName, addon = ...
local L = addon.Locale
local Traveler = addon.Traveler

local Tracker = {}
local HEADER_HEIGHT = 24
local STEP_COLOR_COMPLETE = "FFA0A0A0"
local LOCATION_COLOR = "FFFFFFFF"
local QUEST_COLOR_RED = "FFFF1A1A"
local QUEST_COLOR_ORANGE = "FFFF8040"
local QUEST_COLOR_YELLOW = "FFFFFF00"
local QUEST_COLOR_GREEN = "FF40C040"
local QUEST_COLOR_GREY = "FFC0C0C0"

local function CreateLabel(name, parent)
    local label = CreateFrame("FRAME", name, parent)
    local fontString = label:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    fontString:SetAllPoints(label)
    fontString:SetFontObject("GameFontNormal")
    label.fontString = fontString

    label.SetText = function(self, fmt, ...) self.fontString:SetFormattedText(fmt, ...) end
    label.SetSize = function(self, size) self.fontString:SetFont(GameFontNormal:GetFont(), size) end
    label.SetJustifyH = function(self, value) self.fontString:SetJustifyH(value) end
    label.SetJustifyV = function(self, value) self.fontString:SetJustifyV(value) end
    label.SetWordWrap = function(self, value) self.fontString:SetWordWrap(value) end
    label.SetMaxLines = function(self, value) self.fontString:SetMaxLines(value) end

    return label
end

function Tracker:Initialize()
    self.lines = {}

    -- Create main frame
    local frame = CreateFrame("FRAME", nil, UIParent)
    frame:SetWidth(Traveler.db.profile.window.width)
    frame:SetHeight(Traveler.db.profile.window.height)
    frame:SetPoint(Traveler.db.profile.window.relativePoint, UIParent, Traveler.db.profile.window.relativePoint, Traveler.db.profile.window.x, Traveler.db.profile.window.y)
    frame:SetMovable(true)
    frame:SetResizable(true)
    frame:SetMinResize(200, 200)
    frame:EnableMouse(true)
    frame:SetScript("OnMouseDown", function(self, button)
        if not Traveler.db.profile.window.locked and button == "LeftButton" then
            frame:StartMoving()
        end
    end)
    frame:SetScript("OnMouseUp", function(self, button)
        if button == "LeftButton" then
            frame:StopMovingOrSizing()
            local point, relativeTo, relativePoint, offsetX, offsetY = frame:GetPoint()
            Traveler.db.profile.window.relativePoint = relativePoint
            Traveler.db.profile.window.x = offsetX
            Traveler.db.profile.window.y = offsetY
            Tracker:UpdateImmediate()
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
        Tracker:UpdateImmediate()
    end)
    self.closeButton = closeButton

    -- Create lock button
    local lockButton = CreateFrame("BUTTON", nil, frame)
    lockButton:SetSize(HEADER_HEIGHT, HEADER_HEIGHT)
    lockButton:SetPoint("TOPRIGHT", closeButton, "TOPLEFT")
    lockButton:SetScript("OnClick", function()
        Traveler.db.profile.window.locked = not Traveler.db.profile.window.locked
        Tracker:UpdateImmediate()
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
        local journey = Traveler:GetActiveJourney()
        if journey ~= nil then
            if Traveler.db.char.window.chapter < #journey.chapters then
                Traveler.db.char.window.chapter = Traveler.db.char.window.chapter + 1
                Traveler.State:Reset()
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
        local journey = Traveler:GetActiveJourney()
        if journey ~= nil then
            if Traveler.db.char.window.chapter > 1 then
                Traveler.db.char.window.chapter = Traveler.db.char.window.chapter - 1
                Traveler.State:Reset()
            end
        end
    end)
    self.prevChapterButton = prevChapterButton

    -- Chapter title
    local chapterTitle = CreateLabel(nil, frame)
    chapterTitle:SetPoint("TOPLEFT", frame, "TOPLEFT")
    chapterTitle:SetPoint("BOTTOMRIGHT", prevChapterButton, "BOTTOMLEFT")
    chapterTitle:SetJustifyH("LEFT")
    chapterTitle:SetJustifyV("CENTER")
    chapterTitle:SetSize(Traveler.db.profile.window.fontSize)
    self.chapterTitle = chapterTitle

    -- Create resize button
    local resizeButton = CreateFrame("BUTTON", nil, frame)
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
        if button == "LeftButton" then
            frame:StopMovingOrSizing()
            local point, relativeTo, relativePoint, offsetX, offsetY = frame:GetPoint()
            Traveler.db.profile.window.relativePoint = relativePoint
            Traveler.db.profile.window.x = offsetX
            Traveler.db.profile.window.y = offsetY
            local width, height = frame:GetSize()
            Traveler.db.profile.window.width = width
            Traveler.db.profile.window.height = height
            Tracker:UpdateImmediate()
        end
    end)
    self.resizeButton = resizeButton

    -- Scroll frame
    local scrollFrame = CreateFrame("SCROLLFRAME", nil, frame, "UIPanelScrollFrameTemplate")
    scrollFrame:SetWidth(frame:GetWidth())
    scrollFrame:SetHeight(frame:GetHeight() - HEADER_HEIGHT)
    scrollFrame:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, -HEADER_HEIGHT)
    scrollFrame:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT")
    self.scrollFrame = scrollFrame

    -- Scroll child
    local scrollChild = CreateFrame("FRAME", nil, frame)
    scrollFrame:SetScrollChild(scrollChild)
    scrollChild:SetWidth(scrollFrame:GetWidth())
    scrollChild:SetHeight(scrollFrame:GetHeight())
    scrollChild:SetAllPoints(scrollFrame)
    self.scrollChild = scrollChild

    -- Install update ticker
    self.ticker = C_Timer.NewTicker(Traveler.db.profile.advanced.updateFrequency, function()
        if self.needUpdate then self:UpdateImmediate() end
    end)
end

function Tracker:Shutdown()
    self.ticker:Cancel()
end

function Tracker:Update()
    self.needUpdate = true
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
    self:UpdateSteps()

    self.frame:SetShown(Traveler.db.char.window.show)
    self.needUpdate = false

    Traveler:Debug("Window update took %.2fms", (GetTimePreciseSec() - now) * 1000)
end

function Tracker:UpdateFrame()
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
    local journey = Traveler:GetActiveJourney()
    if journey ~= nil then
        local index = Traveler:GetActiveChapterIndex()
        enabled = index >= 1 and index < #journey.chapters
    end
    self.nextChapterButton:SetEnabled(enabled)
end

function Tracker:UpdatePreviousChapterButton()
    local enabled = false
    local journey = Traveler:GetActiveJourney()
    if journey ~= nil then
        local index = Traveler:GetActiveChapterIndex()
        enabled = index > 1 and index <= #journey.chapters
    end
    self.prevChapterButton:SetEnabled(enabled)
end

function Tracker:UpdateChapterTitle()
    local journey = Traveler:GetActiveJourney()
    local chapter = Traveler:GetActiveChapter(journey)
    if chapter ~= nil then
        local index = Traveler:GetActiveChapterIndex()
        self.chapterTitle:SetSize(Traveler.db.profile.window.fontSize)
        self.chapterTitle:SetText("Chapter " .. index .. ": " .. chapter.title)
    end
end

function Tracker:UpdateScrollFrame()
    self.scrollFrame:SetWidth(self.frame:GetWidth())
    self.scrollFrame:SetHeight(self.frame:GetHeight() - HEADER_HEIGHT)
    self.scrollChild:SetWidth(self.scrollFrame:GetWidth())
    self.scrollChild:SetHeight(self.scrollFrame:GetHeight())
end

function Tracker:UpdateSteps()
    -- Group steps per chronological location, and determine if they are complete
    local groups = {}
    for _, stepState in ipairs(Traveler.State.steps) do
        if stepState.location ~= nil then
            local lastGroup = groups[#groups]
            if lastGroup == nil or lastGroup.location == nil or lastGroup.location.name ~= stepState.location.name then
                groups[#groups + 1] = {
                    location = stepState.location,
                    isComplete = stepState.isComplete,
                    steps = { stepState }
                }
            else
                lastGroup.steps[#lastGroup.steps + 1] = stepState
                lastGroup.isComplete = lastGroup.isComplete and stepState.isComplete
            end
        else
            groups[#groups + 1] = {
                isComplete = stepState.isComplete,
                steps = { stepState }
            }
        end
    end

    -- Iterate steps in each group
    self.lineIndex = 1
    for _, groupState in ipairs(groups) do
        if groupState.location ~= nil then
            if not groupState.isComplete or Traveler.db.profile.window.showCompletedSteps then
                local prefix = ""
                if groupState.location.type == "NPC" then
                    prefix = "Go talk to"
                else
                    prefix = "Go to"
                end
                self:GetNextLine():SetStepText(groupState, "%s %s", prefix, self:GetColoredLocationText(groupState, groupState.location.name))
            end
        end

        for _, stepState in ipairs(groupState.steps) do
            if not stepState.isComplete or Traveler.db.profile.window.showCompletedSteps then
                if stepState.step.type == Traveler.STEP_TYPE_ACCEPT_QUEST then
                    self:GetNextLine():SetStepText(stepState, "    Accept %s", self:GetColoredQuestText(stepState, stepState.step.data))
                elseif stepState.step.type == Traveler.STEP_TYPE_COMPLETE_QUEST then
                    self:GetNextLine():SetStepText(stepState, "Complete %s", self:GetColoredQuestText(stepState, stepState.step.data))
                elseif stepState.step.type == Traveler.STEP_TYPE_TURNIN_QUEST then
                    self:GetNextLine():SetStepText(stepState, "    Turn-in %s", self:GetColoredQuestText(stepState, stepState.step.data))
                elseif stepState.step.type == Traveler.STEP_TYPE_BIND_HEARTHSTONE then
                    self:GetNextLine():SetStepText(stepState, "Bind %s to %s", self:GetColoredItemText(stepState, 6948), self:GetColoredLocationText(stepState, stepState.step.data))
                end
            end
        end
    end

    -- Hide other lines
    for i = self.lineIndex, #self.lines do
        self.lines[i]:Hide()
    end
end

function Tracker:GetNextLine()
    local line
    if self.lineIndex > #self.lines then
        line = CreateLabel(nil, self.scrollChild)
        if self.lineIndex == 1 then
            line:SetPoint("TOPLEFT", self.scrollChild, "TOPLEFT")
        else
            line:SetPoint("TOPLEFT", self.lines[self.lineIndex - 1], "BOTTOMLEFT")
        end
        line:SetJustifyH("LEFT")
        line:SetWordWrap(true)

        line.index = self.lineIndex
        line.SetStepText = function(self, state, fmt, ...)
            if state.isComplete then
                self:SetText("|c%s%s|r", STEP_COLOR_COMPLETE, string.format(fmt, ...))
            else
                self:SetText(fmt, ...)
            end
            self:SetSize(Traveler.db.profile.window.fontSize)
            self:SetWidth(Tracker.scrollChild:GetWidth())
            self:SetHeight((Traveler.db.profile.window.fontSize * self.fontString:GetNumLines()) + Traveler.db.profile.window.lineSpacing)
            self:Show()
        end

        self.lines[#self.lines + 1] = line
    else
        line = self.lines[self.lineIndex]
    end

    self.lineIndex = self.lineIndex + 1
    return line
end

function Tracker:GetColoredText(state, text)
    if state.isComplete then
        return STEP_COLOR_COMPLETE .. text .. "|r"
    else
        return text
    end
end

function Tracker:GetColoredLocationText(state, location)
    if location == nil then return "" end
    if not state.isComplete then return string.format("|c%s%s|r", LOCATION_COLOR, location) end
    return location
end

function Tracker:GetColoredQuestText(state, questId)
    local questName = Traveler.DataSource:GetQuestName(questId, Traveler.db.profile.window.showQuestLevel)
    if questName == nil then return string.format("quest:%s", questId) end

    if not state.isComplete then
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

function Tracker:GetColoredItemText(state, itemId)
    local itemName, itemLink, itemQuality = GetItemInfo(itemId)
    if itemName == nil then
        local item = Item:CreateFromItemID(itemId)
        item:ContinueOnItemLoad(function() Tracker:UpdateImmediate() end)
        return string.format("item:%s", itemId)
    end

    if not state.isComplete then
        local _, _, _, colorHex = GetItemQualityColor(itemQuality)
        return string.format("|c%s%s|r", colorHex, itemName)
    end

    return itemName
end

Traveler.Tracker = Tracker
