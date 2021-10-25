local addonName, addon = ...
local L = addon.Locale
local Traveler = addon.Traveler

local Tracker = {}
local HEADER_HEIGHT = 24
local STEP_COLOR_COMPLETE = "|cFFA0A0A0"
local QUEST_COLOR_RED = "|cFFFF1A1A"
local QUEST_COLOR_ORANGE = "|cFFFF8040"
local QUEST_COLOR_YELLOW = "|cFFFFFF00"
local QUEST_COLOR_GREEN = "|cFF40C040"
local QUEST_COLOR_GREY = "|cFFC0C0C0"

function Tracker:Initialize()
    -- Create main frame
    local frame = CreateFrame("FRAME", nil, UIParent)
    frame:SetWidth(Traveler.db.profile.tracker.width)
    frame:SetHeight(Traveler.db.profile.tracker.height)
    frame:SetPoint(Traveler.db.profile.tracker.relativeTo, UIParent, Traveler.db.profile.tracker.relativeTo, Traveler.db.profile.tracker.x, Traveler.db.profile.tracker.y)
    frame:SetMovable(true)
    frame:SetResizable(true)
    frame:SetMinResize(200, 200)
    frame:EnableMouse(true)
    frame:SetScript("OnMouseDown", function(self, button)
        if (not Traveler.db.profile.tracker.locked and button == "LeftButton") then
            frame:StartMoving()
        end
    end)
    frame:SetScript("OnMouseUp", function(self, button)
        if button == "LeftButton" then
            frame:StopMovingOrSizing()
            local _
            _, _, Traveler.db.profile.tracker.relativeTo, Traveler.db.profile.tracker.x, Traveler.db.profile.tracker.y = frame:GetPoint()
            Tracker:Update()
        end
    end)
    frame.bg = frame:CreateTexture(nil, "BACKGROUND")
    frame.bg:SetAllPoints(frame)
    frame.bg:SetColorTexture(0, 0, 0, Traveler.db.profile.tracker.alpha)
    frame:Hide()
    self.frame = frame

    -- Create close button
    local closeButton = CreateFrame("BUTTON", nil, frame)
    closeButton:SetSize(HEADER_HEIGHT, HEADER_HEIGHT)
    closeButton:SetNormalTexture("Interface/Buttons/UI-Panel-MinimizeButton-Up")
    closeButton:SetHighlightTexture("Interface/Buttons/UI-Panel-MinimizeButton-Highlight")
    closeButton:SetPushedTexture("Interface/Buttons/UI-Panel-MinimizeButton-Down")
    closeButton:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 0,0)
    closeButton:SetScript("OnClick", function()
        Traveler.db.char.tracker.show = false
        Tracker.frame:Hide()
    end)
    self.closeButton = closeButton

    -- Create lock button
    local lockButton = CreateFrame("BUTTON", nil, frame)
    lockButton:SetSize(HEADER_HEIGHT, HEADER_HEIGHT)
    lockButton:SetPoint("TOPRIGHT", closeButton, "TOPLEFT", 0, 0)
    lockButton:SetScript("OnClick", function()
        Traveler.db.profile.tracker.locked = not Traveler.db.profile.tracker.locked
        self:UpdateLockButton()
        self:UpdateResizeButton()
    end)
    self.lockButton = lockButton

    -- Create resize button
    local resizeButton = CreateFrame("BUTTON", nil, frame)
    resizeButton:SetSize(12, 12)
    resizeButton:SetPoint("BOTTOMRIGHT")
    resizeButton:SetNormalTexture("Interface/ChatFrame/UI-ChatIM-SizeGrabber-Up")
    resizeButton:SetHighlightTexture("Interface/ChatFrame/UI-ChatIM-SizeGrabber-Highlight")
    resizeButton:SetPushedTexture("Interface/ChatFrame/UI-ChatIM-SizeGrabber-Down")
    resizeButton:SetScript("OnMouseDown", function(_, button)
        if (not Traveler.db.profile.tracker.locked and button == "LeftButton") then
            frame:StartSizing("BOTTOMRIGHT")
        end
    end)
    resizeButton:SetScript("OnMouseUp", function(_, button)
        if button == "LeftButton" then
            frame:StopMovingOrSizing()
            local _
            _, _, Traveler.db.profile.tracker.relativeTo, Traveler.db.profile.tracker.x, Traveler.db.profile.tracker.y = frame:GetPoint()
            Traveler.db.profile.tracker.width, Traveler.db.profile.tracker.height = frame:GetSize()
            Tracker:Update()
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
end

function Tracker:Update()
    self:DelayedUpdate(function()
        self.playerLevel = UnitLevel("player")
        self.playerGreenRange = GetQuestGreenRange("player")
        self.currentQuestLog = {}
        local entriesCount, questCount = GetNumQuestLogEntries()
        for i=1,entriesCount do
            local _, _, _, isHeader, _, isComplete, _, questID = GetQuestLogTitle(i)
            if not isHeader then
                self.currentQuestLog[questID] = isComplete == 1
            end
        end

        self:UpdateLockButton()
        self:UpdateResizeButton()
        self:UpdateScrollFrame()
        self:UpdateSteps()

        if Traveler.db.char.tracker.show then
            self.frame:Show()
        else
            self.frame:Hide()
        end
    end)
end

function Tracker:DelayedUpdate(func)
    if Traveler.DataSource.IsInitialized() then func() return end
    C_Timer.After(0.25, function() self:DelayedUpdate(func) end)
end

function Tracker:UpdateLockButton()
    if Traveler.db.profile.tracker.locked then
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
    if Traveler.db.profile.tracker.locked then
        self.resizeButton:Hide()
    else
        self.resizeButton:Show()
    end
end

function Tracker:UpdateScrollFrame()
    self.scrollFrame:SetWidth(self.frame:GetWidth())
    self.scrollFrame:SetHeight(self.frame:GetHeight() - HEADER_HEIGHT)
    self.scrollChild:SetWidth(self.scrollFrame:GetWidth())
    self.scrollChild:SetHeight(self.scrollFrame:GetHeight())
end

function Tracker:UpdateSteps()
    local journey = Traveler:GetActiveJourney()
    if journey == nil then return end

    local chapter = Traveler:GetActiveChapter(journey)
    if chapter == nil then return end

    local chapterState = Traveler:GetActiveChapterState(journey)
    if chapterState == nil then return end

    self.lineIndex = 1
    for stepIndex, step in ipairs(chapter.steps) do
        local stepState = chapterState.steps[stepIndex]
        if stepState == nil then
            stepState = {
                completed = self:IsStepCompleted(step)
            }
            chapterState.steps[stepIndex] = stepState
        end

        local isStepQuest = Traveler:IsStepQuest(step)
        if isStepQuest then
            if step.type == Traveler.STEP_TYPE_ACCEPT_QUEST then
                local nearest = Traveler.DataSource:GetNearestQuestStarter(step.data)
                self:GetNextLine():SetText(self:GetColoredStepText(stepState, "Accept from "..nearest.name..":"))
            elseif step.type == Traveler.STEP_TYPE_COMPLETE_QUEST then
                self:GetNextLine():SetText(self:GetColoredStepText(stepState, "Complete:"))
            elseif step.type == Traveler.STEP_TYPE_TURNIN_QUEST then
                local nearest = Traveler.DataSource:GetNearestQuestFinisher(step.data)
                self:GetNextLine():SetText(self:GetColoredStepText(stepState, "Turn-in at "..nearest.name..":"))
            end
            self:GetNextLine():SetText("    "..self:GetColoredQuestText(step, stepState))
        end
    end

    -- Hide other lines
    for i = self.lineIndex, #self.lines do
        self.lines[i]:Hide()
    end
end

function Tracker:GetNextLine()
    if self.lines == nil then self.lines = {} end

    local line
    if self.lineIndex > #self.lines then
        line = CreateFrame("FRAME", nil, self.scrollChild)
        line:SetWidth(self.frame:GetWidth())
        line:SetHeight(Traveler.db.profile.tracker.fontSize + Traveler.db.profile.tracker.lineSpacing)
        if self.lineIndex == 1 then
            line:SetPoint("TOPLEFT", self.scrollChild, "TOPLEFT")
        else
            line:SetPoint("TOPLEFT", self.lines[self.lineIndex - 1], "BOTTOMLEFT")
        end

        local fontString = line:CreateFontString(nil, "ARTWORK", "GameFontNormal")
        fontString:SetAllPoints(line)
        fontString:SetJustifyH("LEFT")
        fontString:SetFontObject("GameFontNormal")
        fontString:SetWordWrap(true)
        fontString:SetMaxLines(1)
        line.fontString = fontString

        line.index = self.lineIndex
        line.SetText = function(self, text)
            self.fontString:SetText(text)
            local wrapLineCount = math.ceil(self.fontString:GetUnboundedStringWidth() / Tracker.frame:GetWidth())
            self:SetWidth(Tracker.frame:GetWidth())
            self:SetHeight((Traveler.db.profile.tracker.fontSize * wrapLineCount) + Traveler.db.profile.tracker.lineSpacing)
            if self.index == 1 then
                self:SetPoint("TOPLEFT", Tracker.scrollChild, "TOPLEFT")
            else
                self:SetPoint("TOPLEFT", Tracker.lines[self.index - 1], "BOTTOMLEFT")
            end
            self.fontString:SetMaxLines(wrapLineCount)
        end

        self.lines[#self.lines + 1] = line
    else
        line = self.lines[self.lineIndex]
    end
    self.lineIndex = self.lineIndex + 1
    return line
end

function Tracker:IsStepCompleted(step)
    if step.type == Traveler.STEP_TYPE_ACCEPT_QUEST then
        return self.currentQuestLog[step.data] ~= nil or C_QuestLog.IsQuestFlaggedCompleted(step.data)
    elseif step.type == Traveler.STEP_TYPE_COMPLETE_QUEST then
        return C_QuestLog.IsComplete(step.data) or C_QuestLog.IsQuestFlaggedCompleted(step.data)
    elseif step.type == Traveler.STEP_TYPE_TURNIN_QUEST then
        return C_QuestLog.IsQuestFlaggedCompleted(step.data)
    elseif step.type == Traveler.STEP_TYPE_FLY_TO then
        -- todo
        return false
    elseif step.type == Traveler.STEP_TYPE_BIND_HEARTHSTONE then
        -- todo
        return false
    end
    return false
end

function Tracker:GetColoredStepText(state, text)
    if state.completed then
        return STEP_COLOR_COMPLETE .. text .. "|r"
    else
        return text
    end
end

function Tracker:GetColoredQuestText(step, state)
    local text = Traveler.DataSource:GetQuestName(step.data)
    if state.completed then
        return STEP_COLOR_COMPLETE .. text .. "|r"
    else
        local level = Traveler.DataSource:GetQuestLevel(step.data)
        if level ~= nil then
            local levelDiff = level - self.playerLevel
            if (levelDiff >= 5) then
                return QUEST_COLOR_RED .. text .. "|r"
            elseif (levelDiff >= 3) then
                return QUEST_COLOR_ORANGE .. text .. "|r"
            elseif (levelDiff >= -2) then
                return QUEST_COLOR_YELLOW .. text .. "|r"
            elseif (-levelDiff <= self.playerGreenRange) then
                return QUEST_COLOR_GREEN .. text .. "|r"
            else
                return QUEST_COLOR_GREY .. text .. "|r"
            end
        end
    end
    return text
end

function Tracker:GetStepQuestName(step, state)
    local questName = Traveler.DataSource:GetQuestName(step.data)
    local questLevel = Traveler.DataSource:GetQuestLevel(step.data)
    return self:AddQuestColor(questId, questLevel, questName)
end

Traveler.Tracker = Tracker
