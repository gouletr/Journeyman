local addonName, addon = ...
local Traveler = addon.Traveler
local L = addon.Locale
local GUI = {}
Traveler.GUI = GUI

-- Useful template:
-- BackdropTemplateMixin and "BackdropTemplate"

function GUI:CreateGroup(frameType, name, parent, template, id)
    local frame = CreateFrame(frameType, name, parent, template, id)

    local backdrop = CreateFrame("FRAME", "Backdrop", frame, BackdropTemplateMixin and "BackdropTemplate")
    backdrop:SetPoint("TOPLEFT")
    backdrop:SetPoint("BOTTOMRIGHT")
    backdrop:SetBackdrop({
        bgFile = "Interface/ChatFrame/ChatFrameBackground",
        edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
        tile = true, tileSize = 16, edgeSize = 16,
        insets = { left = 3, right = 3, top = 3, bottom = 3 }
    })
    backdrop:SetBackdropColor(0.0, 0.0, 0.0, 0.5)
    backdrop:SetBackdropBorderColor(0.4, 0.4, 0.4)

    return frame
end

function GUI:CreateLabel(frameType, name, parent, template, id)
    local frame = CreateFrame(frameType, name, parent, template, id)

    local fontString = frame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    fontString:SetPoint("TOPLEFT", 2, 0)
    fontString:SetPoint("BOTTOMRIGHT")
    fontString:SetFontObject("GameFontNormal")
    frame.fontString = fontString

    frame.SetText = function(self, fmt, ...) self.fontString:SetFormattedText(fmt, ...) end
    frame.SetFontSize = function(self, size) self.fontString:SetFont(GameFontNormal:GetFont(), size) end
    frame.SetTextColor = function(self, r, g, b, a) self.fontString:SetTextColor(r, g, b, a) end
    frame.SetJustifyH = function(self, value) self.fontString:SetJustifyH(value) end
    frame.SetJustifyV = function(self, value) self.fontString:SetJustifyV(value) end
    frame.SetWordWrap = function(self, value) self.fontString:SetWordWrap(value) end
    frame.SetMaxLines = function(self, value) self.fontString:SetMaxLines(value) end
    frame.GetTextColor = function(self) return self.fontString:GetTextColor() end
    frame.GetNumLines = function(self) return self.fontString:GetNumLines() end

    return frame
end

function GUI:CreateListView(frameType, name, parent, template, id)
    local frame = CreateFrame(frameType, name, parent, template, id)

    local scrollFrame = CreateFrame("SCROLLFRAME", "ScrollFrame", frame, "UIPanelScrollFrameTemplate")
    scrollFrame:SetPoint("TOPLEFT", frame, "TOPLEFT")
    scrollFrame:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -22, 0)
    frame.scrollFrame = scrollFrame

    local content = CreateFrame("FRAME", "Content", scrollFrame)
    scrollFrame:SetScrollChild(content)
    frame.content = content

    frame.rows = {}
    frame.rowHeight = 18
    frame.selectedIndex = -1

    frame.GetRow = function(self, index)
        local row
        if index > #self.rows then
            row = self:CreateRow(index, self.content)
            row.index = index
            row.list = self
            if index == 1 then
                row:SetPoint("TOPLEFT", self.content, "TOPLEFT")
                row:SetPoint("BOTTOMRIGHT", self.content, "TOPRIGHT", 0, -self.rowHeight)
            else
                row:SetPoint("TOPLEFT", self.rows[index - 1], "BOTTOMLEFT")
                row:SetPoint("BOTTOMRIGHT", self.rows[index - 1], "BOTTOMRIGHT", 0, -self.rowHeight)
            end
            Traveler.Utils:Add(self.rows, row)
        else
            row = self.rows[index]
        end
        return row
    end

    frame.CreateRow = function(self, index, parent)
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

        row.SetValue = function(self, value)
            self:SetText(value)
            if self.list.selectedIndex == self.index then
                row.highlightTexture:SetVertexColor(1, 1, 0)
            else
                row.highlightTexture:SetVertexColor(0, 0, 0)
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

    frame.AddListener = function(self, event, func)
        if self[event] == nil then
            self[event] = {}
        end
        Traveler.Utils:Add(self[event], func)
    end

    frame.SelectionChanged = function(self)
        self:Refresh()
        if self.OnSelectionChanged then
            for i, v in ipairs(self.OnSelectionChanged) do
                v(self)
            end
        end
    end

    frame.Refresh = function(self)
        self.content:SetSize(self.scrollFrame:GetWidth(), self.scrollFrame:GetHeight())

        local values = self.GetValues()
        for i, v in ipairs(values) do
            local row = self:GetRow(i)
            if row then
                row:SetValue(v)
            end
        end
    end

    return frame
end