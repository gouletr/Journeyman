local addonName, addon = ...
local L = addon.Locale
local Traveler = addon.Traveler

local Tracker = {}
local HEADER_HEIGHT = 24
local STEP_COLOR_COMPLETE = "|cFFA0A0A0"
local LOCATION_COLOR = "|cFFFFFFFF"
local QUEST_COLOR_RED = "|cFFFF1A1A"
local QUEST_COLOR_ORANGE = "|cFFFF8040"
local QUEST_COLOR_YELLOW = "|cFFFFFF00"
local QUEST_COLOR_GREEN = "|cFF40C040"
local QUEST_COLOR_GREY = "|cFFC0C0C0"

local function CreateLabel(name, parent)
    local label = CreateFrame("FRAME", name, parent)
    local fontString = label:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    fontString:SetAllPoints(label)
    fontString:SetFontObject("GameFontNormal")
    label.fontString = fontString

    label.SetText = function(self, ...) self.fontString:SetFormattedText(...) end
    label.SetSize = function(self, size) self.fontString:SetFont(GameFontNormal:GetFont(), size) end
    label.SetJustifyH = function(self, value) self.fontString:SetJustifyH(value) end
    label.SetJustifyV = function(self, value) self.fontString:SetJustifyV(value) end
    label.SetWordWrap = function(self, value) self.fontString:SetWordWrap(value) end
    label.SetMaxLines = function(self, value) self.fontString:SetMaxLines(value) end

    return label
end

function Tracker:Initialize()
    self:ResetState()

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
                Tracker:UpdateImmediate()
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
                Tracker:UpdateImmediate()
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
        if self.NeedUpdate then
            self:UpdateImmediate()
        end
    end)
end

function Tracker:Shutdown()
    self.ticker:Cancel()
end

function Tracker:ResetState()
    self.state = {
        steps = {}
    }
end

function Tracker:Update()
    self.NeedUpdate = true
end

function Tracker:UpdateImmediate()
    if not Traveler.DataSource.IsInitialized() then
        return
    end

    self.playerLevel = UnitLevel("player")
    self.playerGreenRange = GetQuestGreenRange("player")
    self.currentQuestLog = {}
    local entriesCount, questCount = GetNumQuestLogEntries()
    for i=1,entriesCount do
        local _, _, _, isHeader, _, isComplete, _, questID = GetQuestLogTitle(i)
        if not isHeader then
            self.currentQuestLog[questID] = {
                isComplete = isComplete == 1
            }
        end
    end

    self:UpdateFrame()
    self:UpdateLockButton()
    self:UpdateNextChapterButton()
    self:UpdatePreviousChapterButton()
    self:UpdateChapterTitle()
    self:UpdateResizeButton()
    self:UpdateScrollFrame()
    self:UpdateSteps()

    self.frame:SetShown(Traveler.db.char.window.show)
    self.NeedUpdate = false
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
    local journey = Traveler:GetActiveJourney()
    if journey == nil then return end

    local chapter = Traveler:GetActiveChapter(journey)
    if chapter == nil then return end

    self.lineIndex = 1
    for stepIndex, step in ipairs(chapter.steps) do
        local state = self.state or {}
        local stepState = state.steps[stepIndex]
        if stepState == nil then
            stepState = {
                isComplete = self:IsStepComplete(step)
            }
            state.steps[stepIndex] = stepState
        else
            stepState.isComplete = self:IsStepComplete(step)
        end

        local location
        local isStepQuest = Traveler:IsStepQuest(step)
        if isStepQuest then
            if step.type == Traveler.STEP_TYPE_ACCEPT_QUEST then
                location = Traveler.DataSource:GetNearestQuestStarter(step.data)
            elseif step.type == Traveler.STEP_TYPE_COMPLETE_QUEST then
                -- todo
            elseif step.type == Traveler.STEP_TYPE_TURNIN_QUEST then
                location = Traveler.DataSource:GetNearestQuestFinisher(step.data)
            end
        end
        stepState.location = location

        if location ~= nil then
            local prevLocation
            if stepIndex > 1 then
                local prevStepState = self.state.steps[stepIndex - 1]
                prevLocation = prevStepState.location
            end

            if prevLocation == nil or location.type ~= prevLocation.type or location.name ~= prevLocation.name then
                local prefix = ""
                if location.type == "NPC" then
                    prefix = "Go talk to "
                else
                    prefix = "Go to "
                end
                self:GetNextLine():SetText(self:GetColoredText(stepState, prefix) .. self:GetColoredLocationText(stepState, location.name))
            end
        end

        if step.type == Traveler.STEP_TYPE_ACCEPT_QUEST then
            self:GetNextLine():SetText(self:GetColoredText(stepState, "    Accept ") .. self:GetColoredQuestText(step, stepState))
        elseif step.type == Traveler.STEP_TYPE_COMPLETE_QUEST then
            self:GetNextLine():SetText(self:GetColoredText(stepState, "Complete ") .. self:GetColoredQuestText(step, stepState))
        elseif step.type == Traveler.STEP_TYPE_TURNIN_QUEST then
            self:GetNextLine():SetText(self:GetColoredText(stepState, "    Turn-in ") .. self:GetColoredQuestText(step, stepState))
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
        line = CreateLabel(nil, self.scrollChild)
        if self.lineIndex == 1 then
            line:SetPoint("TOPLEFT", self.scrollChild, "TOPLEFT")
        else
            line:SetPoint("TOPLEFT", self.lines[self.lineIndex - 1], "BOTTOMLEFT")
        end
        line:SetJustifyH("LEFT")
        line:SetWordWrap(true)

        line.index = self.lineIndex
        local oldSetText = line.SetText
        line.SetText = function(self, ...)
            oldSetText(self, ...)
            self:SetSize(Traveler.db.profile.window.fontSize)
            self:SetWidth(Tracker.scrollChild:GetWidth())
            self:SetHeight((Traveler.db.profile.window.fontSize * self.fontString:GetNumLines()) + Traveler.db.profile.window.lineSpacing)
        end

        self.lines[#self.lines + 1] = line
    else
        line = self.lines[self.lineIndex]
    end

    self.lineIndex = self.lineIndex + 1
    return line
end

function Tracker:IsStepComplete(step)
    if Traveler:IsStepQuest(step) then
        -- If quest is already turned-in, mark step as complete
        if C_QuestLog.IsQuestFlaggedCompleted(step.data) then
            return true
        end

        -- Exclusive quests are unobtainable, mark step as complete
        local exclusiveTo = Traveler.DataSource:GetQuestExclusiveTo(step.data)
        if exclusiveTo ~= nil then
            for _,questId in ipairs(exclusiveTo) do
                if self.currentQuestLog[questId] ~= nil or C_QuestLog.IsQuestFlaggedCompleted(questId) then
                    return true
                end
            end
        end

        -- Per step type checks
        if step.type == Traveler.STEP_TYPE_ACCEPT_QUEST then
            if self.currentQuestLog[step.data] ~= nil then
                return true -- Quest is in quest log
            end
        elseif step.type == Traveler.STEP_TYPE_COMPLETE_QUEST then
            if C_QuestLog.IsComplete(step.data) then
                return true -- Quest is in quest log and all objectives are completed
            end
        elseif step.type == Traveler.STEP_TYPE_TURNIN_QUEST then
            -- Nothing to do
        end
    else
        if step.type == Traveler.STEP_TYPE_FLY_TO then
            -- todo
            return false
        elseif step.type == Traveler.STEP_TYPE_BIND_HEARTHSTONE then
            -- todo
            return false
        end
    end
    return false
end

function Tracker:GetColoredText(state, text)
    if state.isComplete then
        return STEP_COLOR_COMPLETE .. text .. "|r"
    else
        return text
    end
end

function Tracker:GetColoredQuestText(step, state)
    local text = Traveler.DataSource:GetQuestName(step.data, Traveler.db.profile.window.showQuestLevel)
    if state.isComplete then
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

function Tracker:GetColoredLocationText(state, text)
    if state.isComplete then
        return STEP_COLOR_COMPLETE .. text .. "|r"
    else
        return LOCATION_COLOR .. text .. "|r"
    end
end

Traveler.Tracker = Tracker
