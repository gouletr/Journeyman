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

function Tracker:Initialize()
    self:ResetState()

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
    closeButton:SetPoint("TOPRIGHT", frame, "TOPRIGHT")
    closeButton:SetNormalTexture("Interface/Buttons/UI-Panel-MinimizeButton-Up")
    closeButton:SetHighlightTexture("Interface/Buttons/UI-Panel-MinimizeButton-Highlight")
    closeButton:SetPushedTexture("Interface/Buttons/UI-Panel-MinimizeButton-Down")
    closeButton:SetScript("OnClick", function()
        Traveler.db.char.tracker.show = false
        Tracker.frame:Hide()
    end)
    self.closeButton = closeButton

    -- Create lock button
    local lockButton = CreateFrame("BUTTON", nil, frame)
    lockButton:SetSize(HEADER_HEIGHT, HEADER_HEIGHT)
    lockButton:SetPoint("TOPRIGHT", closeButton, "TOPLEFT")
    lockButton:SetScript("OnClick", function()
        Traveler.db.profile.tracker.locked = not Traveler.db.profile.tracker.locked
        self:UpdateLockButton()
        self:UpdateResizeButton()
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
            if Traveler.db.char.tracker.chapter < #journey.chapters then
                Traveler.db.char.tracker.chapter = Traveler.db.char.tracker.chapter + 1
                Tracker:Update()
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
            if Traveler.db.char.tracker.chapter > 1 then
                Traveler.db.char.tracker.chapter = Traveler.db.char.tracker.chapter - 1
                Tracker:Update()
            end
        end
    end)
    self.prevChapterButton = prevChapterButton

    -- Chapter title
    local chapterTitle = CreateFrame("FRAME", nil, frame)
    chapterTitle:SetPoint("TOPLEFT", frame, "TOPLEFT")
    chapterTitle:SetPoint("BOTTOMRIGHT", prevChapterButton, "BOTTOMLEFT")
    chapterTitle.fontString = chapterTitle:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    chapterTitle.fontString:SetAllPoints(chapterTitle)
    chapterTitle.fontString:SetJustifyH("LEFT")
    chapterTitle.fontString:SetJustifyV("CENTER")
    chapterTitle.fontString:SetFontObject("GameFontNormal")
    chapterTitle.SetText = function(self, text) self.fontString:SetText(text) end
    self.chapterTitle = chapterTitle

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

    -- Install update ticker
    self.ticker = C_Timer.NewTicker(Traveler.db.profile.tracker.updateFrequency, function()
        if Tracker.NeedUpdate and Traveler.DataSource.IsInitialized() then
            Tracker.playerLevel = UnitLevel("player")
            Tracker.playerGreenRange = GetQuestGreenRange("player")
            Tracker.currentQuestLog = {}
            local entriesCount, questCount = GetNumQuestLogEntries()
            for i=1,entriesCount do
                local _, _, _, isHeader, _, isComplete, _, questID = GetQuestLogTitle(i)
                if not isHeader then
                    Tracker.currentQuestLog[questID] = {
                        isComplete = isComplete == 1
                    }
                end
            end

            Tracker:UpdateLockButton()
            Tracker:UpdateNextChapterButton()
            Tracker:UpdatePreviousChapterButton()
            Tracker:UpdateChapterTitle()
            Tracker:UpdateResizeButton()
            Tracker:UpdateScrollFrame()
            Tracker:UpdateSteps()

            if Traveler.db.char.tracker.show then
                Tracker.frame:Show()
            else
                Tracker.frame:Hide()
            end

            Tracker.NeedUpdate = false
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
    local text = Traveler.DataSource:GetQuestName(step.data)
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
