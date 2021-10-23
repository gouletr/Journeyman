local addonName, addon = ...
local L = addon.Locale
local Traveler = addon.Traveler
local headerHeight = 24

function Traveler:InitializeTracker()
    self:CreateTracker()
end

function Traveler:CreateTracker()
    -- Create main frame
    local frame = CreateFrame("FRAME", nil, UIParent)
    frame:SetWidth(self.db.profile.tracker.width)
    frame:SetHeight(self.db.profile.tracker.height)
    frame:SetPoint(self.db.profile.tracker.relativeTo, UIParent, self.db.profile.tracker.relativeTo, self.db.profile.tracker.x, self.db.profile.tracker.y)
    frame.bg = frame:CreateTexture(nil, "BACKGROUND")
    frame.bg:SetAllPoints(frame)
    frame.bg:SetColorTexture(0, 0, 0, self.db.profile.tracker.alpha)
    frame:SetMovable(true)
    frame:SetResizable(true)
    frame:SetMinResize(200, 200)
    frame:EnableMouse(true)
    frame:SetScript("OnMouseDown", function(f, button)
        if (not self.db.profile.tracker.locked and button == "LeftButton") then
            frame:StartMoving()
        end
    end)
    frame:SetScript("OnMouseUp", function(f, button)
        if button == "LeftButton" then
            frame:StopMovingOrSizing()
            local _
            _, _, self.db.profile.tracker.relativeTo, self.db.profile.tracker.x, self.db.profile.tracker.y = frame:GetPoint()
            self:UpdateTracker()
        end
    end)

    -- Create close button
    local closeButton = CreateFrame("BUTTON", nil, frame)
    closeButton:SetSize(headerHeight, headerHeight)
    closeButton:SetNormalTexture("Interface/Buttons/UI-Panel-MinimizeButton-Up")
    closeButton:SetHighlightTexture("Interface/Buttons/UI-Panel-MinimizeButton-Highlight")
    closeButton:SetPushedTexture("Interface/Buttons/UI-Panel-MinimizeButton-Down")
    closeButton:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 0,0)
    closeButton:SetScript("OnClick", function()
        self:HideTracker()
    end)
    frame.closeButton = closeButton

    -- Create lock button
    local lockButton = CreateFrame("BUTTON", nil, frame)
    lockButton:SetSize(headerHeight, headerHeight)
    lockButton:SetPoint("TOPRIGHT", closeButton, "TOPLEFT", 0, 0)
    lockButton:SetScript("OnClick", function()
        self.db.profile.tracker.locked = not self.db.profile.tracker.locked
        self:UpdateTrackerLockButton()
        self:UpdateTrackerResizeButton()
    end)
    frame.lockButton = lockButton

    -- Create resize button
    local resizeButton = CreateFrame("BUTTON", nil, frame)
    resizeButton:SetSize(12, 12)
    resizeButton:SetPoint("BOTTOMRIGHT")
    resizeButton:SetNormalTexture("Interface/ChatFrame/UI-ChatIM-SizeGrabber-Up")
    resizeButton:SetHighlightTexture("Interface/ChatFrame/UI-ChatIM-SizeGrabber-Highlight")
    resizeButton:SetPushedTexture("Interface/ChatFrame/UI-ChatIM-SizeGrabber-Down")
    resizeButton:SetScript("OnMouseDown", function(_, button)
        if (not self.db.profile.tracker.locked and button == "LeftButton") then
            frame:StartSizing("BOTTOMRIGHT")
        end
    end)
    resizeButton:SetScript("OnMouseUp", function(_, button)
        if button == "LeftButton" then
            frame:StopMovingOrSizing()
            local _
            _, _, self.db.profile.tracker.relativeTo, self.db.profile.tracker.x, self.db.profile.tracker.y = frame:GetPoint()
            self.db.profile.tracker.width, self.db.profile.tracker.height = frame:GetSize()
            self:UpdateTracker()
        end
    end)
    frame.resizeButton = resizeButton

    -- Scroll frame
    local scrollFrame = CreateFrame("SCROLLFRAME", nil, frame, "UIPanelScrollFrameTemplate")
    scrollFrame:SetWidth(frame:GetWidth())
    scrollFrame:SetHeight(frame:GetHeight() - headerHeight)
    scrollFrame:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, -headerHeight)
    scrollFrame:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT")
    frame.scrollFrame = scrollFrame

    -- Scroll child
    local scrollChild = CreateFrame("FRAME", nil, frame)
    scrollFrame:SetScrollChild(scrollChild)
    scrollChild:SetWidth(scrollFrame:GetWidth())
    scrollChild:SetHeight(scrollFrame:GetHeight())
    scrollChild:SetAllPoints(scrollFrame)
    frame.scrollChild = scrollChild

    -- Finished, store tracker frame
    self.tracker = frame
    self.tracker:Hide()
end

function Traveler:ShowTracker()
    self.tracker:Show()
    self.db.char.tracker.show = true
end

function Traveler:HideTracker()
    self.tracker:Hide()
    self.db.char.tracker.show = false
end

function Traveler:UpdateTracker()
    self:UpdateTrackerLockButton()
    self:UpdateTrackerResizeButton()
    self:UpdateTrackerScrollFrame()
    self:UpdateTrackerSteps()

    if self.db.char.tracker.show then
        self.tracker:Show()
    else
        self.tracker:Hide()
    end
end

function Traveler:UpdateTrackerLockButton()
    if self.db.profile.tracker.locked then
        self.tracker.lockButton:SetNormalTexture("Interface/Buttons/LockButton-Locked-Up")
        self.tracker.lockButton:SetHighlightTexture("Interface/Buttons/LockButton-Border")
        self.tracker.lockButton:SetPushedTexture("Interface/Buttons/LockButton-Unlocked-Down")
    else
        self.tracker.lockButton:SetNormalTexture("Interface/Buttons/LockButton-Unlocked-Up")
        self.tracker.lockButton:SetHighlightTexture("Interface/Buttons/LockButton-Border")
        self.tracker.lockButton:SetPushedTexture("Interface/Buttons/LockButton-Unlocked-Down")
    end
end

function Traveler:UpdateTrackerResizeButton()
    if self.db.profile.tracker.locked then
        self.tracker.resizeButton:Hide()
    else
        self.tracker.resizeButton:Show()
    end
end

function Traveler:UpdateTrackerScrollFrame()
    self.tracker.scrollFrame:SetWidth(self.tracker:GetWidth())
    self.tracker.scrollFrame:SetHeight(self.tracker:GetHeight() - headerHeight)
    self.tracker.scrollChild:SetWidth(self.tracker.scrollFrame:GetWidth())
    self.tracker.scrollChild:SetHeight(self.tracker.scrollFrame:GetHeight())
end

function Traveler:UpdateTrackerSteps()
    local journey = self:GetActiveJourney()
    if journey == nil then return end

    local chapter = self:GetActiveChapter(journey)
    if chapter == nil then return end

    if self.tracker.steps == nil then
        self.tracker.steps = {}
    end

    local lineIndex = 1
    local ds = self.DataSource
    for stepIndex, step in ipairs(chapter.steps) do
        local line

        if step.type == "ACCEPT" then
            line = self:GetOrCreateTrackerLine(lineIndex)
            lineIndex = lineIndex + 1
            line:SetText("Accept from <NPC Name>:")
            self:UpdateTrackerLine(line)

            line = self:GetOrCreateTrackerLine(lineIndex)
            lineIndex = lineIndex + 1
            line:SetText("    "..ds:GetColoredQuestName(step.data))
            self:UpdateTrackerLine(line)

        elseif step.type == "TURNIN" then
            line = self:GetOrCreateTrackerLine(lineIndex)
            lineIndex = lineIndex + 1
            line:SetText("Turn-in at <NPC Name>:")
            self:UpdateTrackerLine(line)

            line = self:GetOrCreateTrackerLine(lineIndex)
            lineIndex = lineIndex + 1
            line:SetText("    "..ds:GetColoredQuestName(step.data))
            self:UpdateTrackerLine(line)

        elseif step.type == "COMPLETE" then
            line = self:GetOrCreateTrackerLine(lineIndex)
            lineIndex = lineIndex + 1
            line:SetText("Complete:")
            self:UpdateTrackerLine(line)

            line = self:GetOrCreateTrackerLine(lineIndex)
            lineIndex = lineIndex + 1
            line:SetText("    "..ds:GetColoredQuestName(step.data))
            self:UpdateTrackerLine(line)

        elseif step.type == "FLYTO" then
            line = self:GetOrCreateTrackerLine(lineIndex)
            lineIndex = lineIndex + 1
            line:SetText("Fly to <Location>")
            self:UpdateTrackerLine(line)

        end
    end
end

function Traveler:GetOrCreateTrackerLine(index)
    if index > #self.tracker.steps then
        frame = CreateFrame("FRAME", nil, self.tracker.scrollChild)
        frame:SetWidth(self.tracker:GetWidth())
        frame:SetHeight(self.db.profile.tracker.fontSize)
        if index == 1 then
            frame:SetPoint("TOPLEFT", self.tracker.scrollChild, "TOPLEFT")
        else
            frame:SetPoint("TOPLEFT", self.tracker.steps[index - 1], "BOTTOMLEFT", 0, -self.db.profile.tracker.lineSpacing)
        end

        local fontString = frame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
        fontString:SetAllPoints(frame)
        fontString:SetJustifyH("LEFT")
        fontString:SetFontObject("GameFontNormal")
        fontString:SetWordWrap(true)
        fontString:SetMaxLines(1)

        frame.index = index
        frame.fontString = fontString
        frame.SetText = function(this, text) this.fontString:SetText(text) end
        frame.SetMaxLines = function(this, count) this.fontString:SetMaxLines(count) end
        frame.GetUnboundedWidth = function(this) return this.fontString:GetUnboundedStringWidth() end

        self.tracker.steps[#self.tracker.steps + 1] = frame
        return frame
    else
        return self.tracker.steps[index]
    end
end

function Traveler:UpdateTrackerLine(line)
    local requiredLineCount = math.ceil(line:GetUnboundedWidth() / self.tracker:GetWidth())
    line:SetWidth(self.tracker:GetWidth())
    line:SetHeight(self.db.profile.tracker.fontSize * requiredLineCount)
    if line.index == 1 then
        frame:SetPoint("TOPLEFT", self.tracker.scrollChild, "TOPLEFT")
    else
        frame:SetPoint("TOPLEFT", self.tracker.steps[line.index - 1], "BOTTOMLEFT", 0, -self.db.profile.tracker.lineSpacing)
    end
    line:SetMaxLines(requiredLineCount)
end
