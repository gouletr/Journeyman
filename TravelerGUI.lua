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
    fontString:SetFontObject(GameFontNormal)
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

function GUI:CreateEditBox(frameType, name, parent, template, id)
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
    frame.backdrop = backdrop

    local editBox = CreateFrame("EDITBOX", "EditBox", frame)
    editBox:SetPoint("TOPLEFT", backdrop, "TOPLEFT", 5, -5)
    editBox:SetPoint("BOTTOMRIGHT", backdrop, "BOTTOMRIGHT", -5, 5)
    editBox:SetFontObject(ChatFontNormal)
    editBox:SetMultiLine(false)
    editBox:SetAutoFocus(false)
    editBox:SetScript("OnEnterPressed", function(self)
        if frame.OnEnterPressed then
            frame:OnEnterPressed()
        end
        self:ClearFocus()
    end)
    editBox:SetScript("OnEscapePressed", function(self)
        if frame.OnEscapePressed then
            frame:OnEscapePressed()
        end
        self:ClearFocus()
    end)
    frame.editBox = editBox

    frame.SetText = function(self, fmt, ...) self.editBox:SetText(string.format(fmt, ...)) end
    frame.SetFontSize = function(self, size) self.editBox:SetFont(ChatFontNormal:GetFont(), size) end
    frame.SetTextColor = function(self, r, g, b, a) self.editBox:SetTextColor(r, g, b, a) end
    frame.SetJustifyH = function(self, value) self.editBox:SetJustifyH(value) end
    frame.SetJustifyV = function(self, value) self.editBox:SetJustifyV(value) end
    frame.SetWordWrap = function(self, value) self.editBox:SetWordWrap(value) end
    frame.SetMaxLines = function(self, value) self.editBox:SetMaxLines(value) end
    frame.SetNumeric = function(self, value) self.editBox:SetNumeric(value) end
    frame.SetEnabled = function(self, value) self.editBox:SetEnabled(value) end
    frame.GetText = function(self) return self.editBox:GetText() end
    frame.GetTextColor = function(self) return self.editBox:GetTextColor() end
    frame.GetNumLines = function(self) return self.editBox:GetNumLines() end
    frame.GetNumber = function(self) return self.editBox:GetNumber() end
    frame.GetNumeric = function(self) return self.editBox:GetNumeric() end

    return frame
end

function GUI:CreateDropDownMenu(frameType, name, parent, template, id)
    local frame = CreateFrame(frameType, name, parent, template, id)

    local dropDownMenu = CreateFrame("Frame", "Dropdown", frame, "UIDropDownMenuTemplate")
    dropDownMenu:SetPoint("TOPLEFT", -17, 0)
    dropDownMenu:SetPoint("BOTTOMRIGHT")
    frame.dropDownMenu = dropDownMenu

    local function _SetValue(self, arg1, arg2, checked)
        local values = frame:GetValues()
        UIDropDownMenu_SetText(dropDownMenu, values[arg1])
        if frame.OnValueChanged then
           frame:OnValueChanged(arg1)
        end
    end

    local function _Initialize(self, level, menuList)
        local info = UIDropDownMenu_CreateInfo()
        info.func = _SetValue

        local sorting
        if frame.GetSorting then
            sorting = frame:GetSorting()
        end

        local values = frame:GetValues()
        if sorting then
            for i, v in ipairs(sorting) do
                info.text, info.arg1 = values[v], v
                UIDropDownMenu_AddButton(info)
            end
        else
            for k, v in pairs(values) do
                info.text, info.arg1 = v, k
                UIDropDownMenu_AddButton(info)
            end
        end
    end

    frame.Initialize = function(self) UIDropDownMenu_Initialize(self.dropDownMenu, _Initialize) end
    frame.SetValue = function(self, value) local values = frame:GetValues() UIDropDownMenu_SetText(self.dropDownMenu, values[value]) end
    frame.SetWidth = function(self, value) UIDropDownMenu_SetWidth(self.dropDownMenu, value - 17) end
    frame.SetEnabled = function(self, value) if value then UIDropDownMenu_EnableDropDown(self.dropDownMenu) else UIDropDownMenu_DisableDropDown(self.dropDownMenu) end end

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
                self.highlightTexture:SetVertexColor(1, 1, 0)
            elseif row:IsMouseOver() then
                self.highlightTexture:SetVertexColor(.196, .388, .8)
            else
                self.highlightTexture:SetVertexColor(0, 0, 0)
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

    frame.SelectionChanged = function(self)
        self:Refresh()
        if self.OnSelectionChanged then
            self:OnSelectionChanged()
        end
    end

    frame.Refresh = function(self)
        self.content:SetSize(self.scrollFrame:GetWidth(), self.scrollFrame:GetHeight())

        local values = self.GetValues()
        local index = 1
        for i, v in ipairs(values or {}) do
            local row = self:GetRow(i)
            if row then
                row:SetValue(v)
            end
            row:Show()
            index = index + 1
        end

        -- Hide unused rows
        for i = index, #self.rows do
            self.rows[i]:Hide()
        end
    end

    return frame
end