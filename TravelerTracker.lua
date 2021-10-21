local addonName, addon = ...
local L = addon.Locale
local Traveler = addon.Traveler

function Traveler:InitializeTracker()
    self:CreateTracker()
    self:UpdateTracker()
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
    frame:SetMinResize(100, 100)
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
        end
    end)

    -- Create close button
    local closeButton = CreateFrame("BUTTON", nil, frame)
    closeButton:SetSize(24, 24)
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
    lockButton:SetSize(24, 24)
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
    resizeButton:SetScript("OnMouseDown", function(f, button)
        if (not self.db.profile.tracker.locked and button == "LeftButton") then
            frame:StartSizing("BOTTOMRIGHT")
        end
    end)
    resizeButton:SetScript("OnMouseUp", function(f, button)
        if button == "LeftButton" then
            frame:StopMovingOrSizing()
            local _
            _, _, self.db.profile.tracker.relativeTo, self.db.profile.tracker.x, self.db.profile.tracker.y = frame:GetPoint()
            self.db.profile.tracker.width, self.db.profile.tracker.height = frame:GetSize()
        end
    end)
    frame.resizeButton = resizeButton

    -- Store tracker frame
    self.tracker = frame
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
    self:UpdateTrackerSteps()
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

function Traveler:UpdateTrackerSteps()
    
end
