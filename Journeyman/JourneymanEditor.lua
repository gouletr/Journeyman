local addonName, addon = ...
local Editor, Private = addon:NewModule("Editor"), {}
local L = addon.Locale

local addonVersion = GetAddOnMetadata(addonName, "version")

local String = LibStub("LibCollections-1.0").String
local List = LibStub("LibCollections-1.0").List
local AceGUI = LibStub("AceGUI-3.0")
local HBD = LibStub("HereBeDragons-2.0")
local Utils, Journeys, GUI, Database

function Editor:OnInitialize()
    Utils = addon.Utils
    Journeys = addon.Journeys
    GUI = addon.GUI
    Database = addon.Database
end

function Editor:OnEnable()
    local frame = CreateFrame("FRAME", "Editor", UIParent)
    frame.name = "Editor"
    frame.parent = addonName
    frame.refresh = function() Editor:Refresh() end
    frame:Hide()
    frame:SetScript("OnShow", function(self)
        local journey = addon:GetActiveJourney()
        if journey then
            local journeyIndex = addon:GetJourneyIndex(journey)
            if journeyIndex and Editor:GetSelectedJourneyIndex() == -1 then
                Editor:SetSelectedJourneyIndex(journeyIndex)
            end

            local chapter = addon:GetActiveJourneyChapter()
            if chapter then
                local chapterIndex = addon:GetJourneyChapterIndex(journey, chapter)
                if chapterIndex and Editor:GetSelectedChapterIndex() == -1 then
                    Editor:SetSelectedChapterIndex(chapterIndex)
                end
            end
        end
        Editor:Refresh()
    end)
    self.frame = frame

    local content = CreateFrame("FRAME", "Content", frame)
    content:SetPoint("TOPLEFT", frame, "TOPLEFT", 10, -15)
    content:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -10, 10)

    local title = GUI:CreateLabel("FRAME", "Title", content)
    title:SetPoint("TOPLEFT")
    title:SetPoint("BOTTOMRIGHT", content, "TOPRIGHT", 0, -30)
    title:SetJustifyH("LEFT")
    title:SetJustifyV("TOP")
    title:SetFontSize(16)
    title:SetFormattedText("%s v%s - %s", addonName, addonVersion, frame.name)
    self.title = title

    local journeySelector = self:CreateSelector("Journeys", content)
    journeySelector:SetPoint("TOPLEFT", title, "BOTTOMLEFT")
    journeySelector:SetPoint("BOTTOMRIGHT", title, "BOTTOM", 0, -110)
    journeySelector:SetTitle(L["SELECT_JOURNEY"])
    journeySelector.list.GetValues = function(self)
        local values = {}
        for i = 1, #addon.journeys do
            values[i] = addon.journeys[i].title
        end
        return values
    end
    journeySelector.list.OnSelectionChanged = function(self)
        Editor:SetSelectedChapterIndex(-1)
        Editor:SetSelectedStepIndex(-1)
        Editor:Refresh()
    end
    self.journeySelector = journeySelector

    local chapterSelector = self:CreateSelector("Chapters", content)
    chapterSelector:SetPoint("TOPLEFT", title, "BOTTOM")
    chapterSelector:SetPoint("BOTTOMRIGHT", title, "BOTTOMRIGHT", 0, -110)
    chapterSelector:SetTitle(L["SELECT_CHAPTER"])
    chapterSelector.list.GetValues = function(self)
        local values = {}
        local journey = Editor:GetSelectedJourney()
        if journey then
            for i, v in ipairs(journey.chapters) do
                values[i] = v.title
            end
        end
        return values
    end
    chapterSelector.list.OnSelectionChanged = function(self)
        Editor:SetSelectedStepIndex(-1)
        Editor:Refresh()
    end
    self.chapterSelector = chapterSelector

    local newJourneyButton = CreateFrame("BUTTON", "NewJourney", content, "UIPanelButtonTemplate")
    newJourneyButton:SetPoint("TOPLEFT", journeySelector, "BOTTOMLEFT")
    newJourneyButton:SetPoint("BOTTOMRIGHT", journeySelector, "BOTTOM", 0, -22)
    newJourneyButton:SetText(L["NEW_JOURNEY"])
    newJourneyButton:SetScript("OnClick", function(self, button, down)
        if Journeys:AddNewJourney() then
            Editor:SetSelectedJourneyIndex(#addon.journeys)
            Editor:SetSelectedChapterIndex(-1)
            Editor:SetSelectedStepIndex(-1)
            Editor:Refresh()
        end
    end)

    StaticPopupDialogs[addonName .. "_DELETE_JOURNEY"] = {
        text = L["DELETE_JOURNEY"] .. "?",
        showAlert = true,
        button1 = ACCEPT,
        button2 = CANCEL,
        OnAccept = function()
            if Journeys:DeleteJourney(Editor:GetSelectedJourneyIndex()) then
                Editor:SetSelectedJourneyIndex(-1)
                Editor:SetSelectedChapterIndex(-1)
                Editor:SetSelectedStepIndex(-1)
                Editor:Refresh()
                addon:Reset(true)
            end
        end,
        sound = SOUNDKIT.IG_MAINMENU_OPEN,
        hideOnEscape = true,
    }
    local deleteJourneyButton = CreateFrame("BUTTON", "DeleteJourney", content, "UIPanelButtonTemplate")
    deleteJourneyButton:SetPoint("TOPLEFT", journeySelector, "BOTTOM")
    deleteJourneyButton:SetPoint("BOTTOMRIGHT", journeySelector, "BOTTOMRIGHT", 0, -22)
    deleteJourneyButton:SetText(L["DELETE_JOURNEY"])
    deleteJourneyButton:SetScript("OnClick", function(self, button, down)
        StaticPopup_Show(addonName .. "_DELETE_JOURNEY")
    end)
    self.deleteJourneyButton = deleteJourneyButton

    StaticPopupDialogs[addonName .. "_IMPORT_JOURNEY"] = {
        text = "Another journey with the same GUID already exist. Do you want to make a new journey or overwrite existing journey?",
        showAlert = true,
        button1 = "New",
        button2 = "Overwrite",
        button3 = "Cancel",
        OnAccept = function(self)
            local importingJourney = self.importingJourney
            if importingJourney then
                -- Make sure guid is unique
                importingJourney.guid = Utils:CreateGUID()
                -- Make sure title is unique
                if List:Any(addon.journeys, function(j) return j.title == importingJourney.title end) then
                    local title = importingJourney.title
                    local count = 1
                    while List:Count(addon.journeys, function(j) return j.title == title.." ("..count..")" end) > 0 do
                        count = count + 1
                    end
                    importingJourney.title = title.." ("..count..")"
                end
                -- Add journey
                List:Add(addon.journeys, importingJourney)
                Editor:SetSelectedJourneyIndex(#addon.journeys)
                Editor:SetSelectedChapterIndex(1)
                Editor:SetSelectedStepIndex(-1)
                Editor:Refresh()
            end
        end,
        OnCancel = function(self)
            local importingJourney = self.importingJourney
            if importingJourney then
                -- Update journey chapters
                local existingJourney = List:First(addon.journeys, function(j) return j.guid == importingJourney.guid end)
                if existingJourney then
                    existingJourney.title = importingJourney.title
                    existingJourney.chapters = importingJourney.chapters
                end
                Editor:Refresh()
                addon:ResetJourneyState(existingJourney)
                addon:Reset(true)
            end
        end,
        OnAlt = function(self)
            Editor:Refresh()
        end,
        sound = SOUNDKIT.IG_MAINMENU_OPEN,
        hideOnEscape = true,
    }
    local importJourneyButton = CreateFrame("BUTTON", "ImportJourney", content, "UIPanelButtonTemplate")
    importJourneyButton:SetPoint("TOPLEFT", newJourneyButton, "BOTTOMLEFT")
    importJourneyButton:SetPoint("BOTTOMRIGHT", newJourneyButton, "BOTTOMRIGHT", 0, -22)
    importJourneyButton:SetText(L["IMPORT_JOURNEY"])
    importJourneyButton:SetScript("OnClick", function(self, button, down)
        local window = AceGUI:Create("Frame")
        window:SetTitle(L["IMPORT_JOURNEY"])
        window:SetCallback("OnClose", function(widget) AceGUI:Release(widget) end)
        window:SetLayout("Fill")

        local editBox = AceGUI:Create("MultiLineEditBox")
        editBox:SetCallback("OnTextChanged", function(widget, event, text)
            local journey, status
            local trimmed = strtrim(text)
            if trimmed then
                local bom = strsub(trimmed, 1, addon.BYTE_ORDER_MARK:len())
                if bom and bom == addon.BYTE_ORDER_MARK then
                    local serialized = strsub(trimmed, addon.BYTE_ORDER_MARK:len() + 1)
                    if serialized and serialized:len() > 0 then
                        journey, status = Database:ImportJourney(serialized)
                    end
                else
                    journey = Database:ImportJourneyFromText(trimmed)
                end
            end
            if journey then
                window:Hide()
                Editor:ImportJourney(journey)
            else
                if status == nil then
                    status = L["INVALID_JOURNEY"]
                end
                window:SetStatusText(status)
                widget:SetText(trimmed)
            end
        end)
        editBox:DisableButton(true)
        editBox:SetFocus()
        editBox.label:SetText(L["PASTE_TEXT_BELOW"])
        window:AddChild(editBox)
    end)
    self.importJourneyButton = importJourneyButton

    local exportJourneyButton = GUI:CreateDropDownButton("FRAME", "ExportJourney", content)
    exportJourneyButton:SetPoint("TOPLEFT", deleteJourneyButton, "BOTTOMLEFT")
    exportJourneyButton:SetPoint("BOTTOMRIGHT", deleteJourneyButton, "BOTTOMRIGHT", 0, -22)
    exportJourneyButton:SetText(L["EXPORT_JOURNEY"])
    exportJourneyButton.GetValues = function(self)
        return {
            [addon.JOURNEY_AS_DATA] = L["JOURNEY_AS_DATA"],
            [addon.JOURNEY_AS_TEXT] = L["JOURNEY_AS_TEXT"],
        }
    end
    exportJourneyButton.GetSorting = function(self)
        return {
            addon.JOURNEY_AS_DATA,
            addon.JOURNEY_AS_TEXT,
        }
    end
    exportJourneyButton.OnValueSelected = function(self, value)
        local journey = Editor:GetSelectedJourney()
        if journey then
            local window = AceGUI:Create("Frame")
            window:SetTitle(L["EXPORT_JOURNEY"])
            window:SetCallback("OnClose", function(widget) AceGUI:Release(widget) end)
            window:SetLayout("Fill")

            local editBox = AceGUI:Create("MultiLineEditBox")
            editBox:DisableButton(true)
            editBox:SetFocus()
            editBox.label:SetText(L["COPY_TEXT_BELOW"])
            window:AddChild(editBox)

            if value == addon.JOURNEY_AS_DATA then
                local serialized, status = Database:ExportJourney(journey)
                if serialized then
                    editBox:SetText(addon.BYTE_ORDER_MARK..serialized)
                    editBox:HighlightText()
                else
                    window:SetStatusText(status)
                end
            elseif value == addon.JOURNEY_AS_TEXT then
                local export = Database:ExportJourneyAsText(journey)
                if export then
                    editBox:SetText(export)
                    editBox:HighlightText()
                end
            end
        end
    end
    self.exportJourneyButton = exportJourneyButton

    local newChapterButton = CreateFrame("BUTTON", "NewChapter", content, "UIPanelButtonTemplate")
    newChapterButton:SetPoint("TOPLEFT", chapterSelector, "BOTTOMLEFT")
    newChapterButton:SetPoint("BOTTOMRIGHT", chapterSelector, "BOTTOM", 0, -22)
    newChapterButton:SetText(L["NEW_CHAPTER"])
    newChapterButton:SetScript("OnClick", function(self, button, down)
        local journey = Editor:GetSelectedJourney()
        if journey and Journeys:AddNewChapter(journey) then
            Editor:SetSelectedChapterIndex(#journey.chapters)
            Editor:SetSelectedStepIndex(-1)
            Editor:Refresh()
            addon:Reset(true)
        end
    end)
    self.newChapterButton = newChapterButton

    StaticPopupDialogs[addonName .. "_DELETE_CHAPTER"] = {
        text = L["DELETE_CHAPTER"] .. "?",
        showAlert = true,
        button1 = ACCEPT,
        button2 = CANCEL,
        OnAccept = function()
            local journey = Editor:GetSelectedJourney()
            if journey and Journeys:DeleteChapter(journey, Editor:GetSelectedChapterIndex()) then
                Editor:SetSelectedChapterIndex(-1)
                Editor:SetSelectedStepIndex(-1)
                Editor:Refresh()
                addon:Reset(true)
            end
        end,
        sound = SOUNDKIT.IG_MAINMENU_OPEN,
        hideOnEscape = true,
    }
    local deleteChapterButton = CreateFrame("BUTTON", "DeleteChapter", content, "UIPanelButtonTemplate")
    deleteChapterButton:SetPoint("TOPLEFT", chapterSelector, "BOTTOM")
    deleteChapterButton:SetPoint("BOTTOMRIGHT", chapterSelector, "BOTTOMRIGHT", 0, -22)
    deleteChapterButton:SetText(L["DELETE_CHAPTER"])
    deleteChapterButton:SetScript("OnClick", function(self, button, down)
        StaticPopup_Show(addonName .. "_DELETE_CHAPTER")
    end)
    self.deleteChapterButton = deleteChapterButton

    local copyChapterButton = CreateFrame("BUTTON", "CopyChapter", content, "UIPanelButtonTemplate")
    copyChapterButton:SetPoint("TOPLEFT", newChapterButton, "BOTTOMLEFT")
    copyChapterButton:SetPoint("BOTTOMRIGHT", newChapterButton, "BOTTOMRIGHT", 0, -22)
    copyChapterButton:SetText(L["COPY_CHAPTER"])
    copyChapterButton:SetScript("OnClick", function(self, button, down)
        Editor.clipBoard = {
            type = "Chapter",
            data = Editor:GetSelectedChapter()
        }
        Editor:Refresh()
    end)
    self.copyChapterButton = copyChapterButton

    local pasteChapterButton = CreateFrame("BUTTON", "PasteChapter", content, "UIPanelButtonTemplate")
    pasteChapterButton:SetPoint("TOPLEFT", deleteChapterButton, "BOTTOMLEFT")
    pasteChapterButton:SetPoint("BOTTOMRIGHT", deleteChapterButton, "BOTTOMRIGHT", 0, -22)
    pasteChapterButton:SetText(L["PASTE_CHAPTER"])
    pasteChapterButton:SetScript("OnClick", function(self, button, down)
        local journey = Editor:GetSelectedJourney()
        if journey and Editor.clipBoard and Editor.clipBoard.type == "Chapter" and Editor.clipBoard.data then
            Editor.clipBoard.data.journey = nil -- prevent infinite recursion
            local chapter = Utils:Clone(Editor.clipBoard.data)
            chapter.journey = journey -- restore chapter's journey after clone
            List:Add(journey.chapters, chapter)
            Editor:SetSelectedChapterIndex(#journey.chapters)
            Editor:Refresh()
        end
    end)
    self.pasteChapterButton = pasteChapterButton

    local stepSelector = self:CreateSelector("Steps", content)
    stepSelector:SetPoint("TOPLEFT", importJourneyButton, "BOTTOMLEFT", 0, -15)
    stepSelector:SetPoint("BOTTOMRIGHT", content, "BOTTOM", 0, 22)
    stepSelector:SetTitle(L["SELECT_STEP"])
    stepSelector.list.GetValues = function(self)
        local chapter = Editor:GetSelectedChapter()
        if chapter then
            return chapter.steps
        end
    end
    stepSelector.list.CreateRow = function(self, index, parent)
        local row = GUI:CreateLabel("BUTTON", "Row" .. index, parent)
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

        row.SetValue = function(self, step)
            local prefix = self.index .. ". "
            self:SetText(prefix .. addon:GetStepText(step, true, true, function() stepSelector:Refresh() end))
            if self.list.selectedIndex == self.index then
                self.highlightTexture:SetVertexColor(1, 1, 0) -- selected
            elseif row:IsMouseOver() then
                self.highlightTexture:SetVertexColor(.196, .388, .8) -- hover
            else
                self.highlightTexture:SetVertexColor(0, 0, 0) -- none
            end
        end

        row:SetScript("OnEnter", function(self, motion)
            if self.list.selectedIndex == self.index then
                self.highlightTexture:SetVertexColor(1, 1, 0) -- selected
            else
                self.highlightTexture:SetVertexColor(.196, .388, .8) -- hover
            end
        end)

        row:SetScript("OnLeave", function(self, motion)
            if self.list.selectedIndex == self.index then
                self.highlightTexture:SetVertexColor(1, 1, 0) -- selected
            else
                self.highlightTexture:SetVertexColor(0, 0, 0) -- none
            end
        end)

        row:SetScript("OnClick", function(self, button, down)
            self.list.selectedIndex = self.index
            self.list:SelectionChanged()
        end)

        return row
    end
    stepSelector.list.OnSelectionChanged = function(self)
        Editor:Refresh()
    end
    self.stepSelector = stepSelector

    local newStepButton = CreateFrame("BUTTON", "NewStep", content, "UIPanelButtonTemplate")
    newStepButton:SetPoint("TOPLEFT", stepSelector, "BOTTOMLEFT")
    newStepButton:SetPoint("BOTTOMRIGHT", stepSelector, "BOTTOM", 0, -22)
    newStepButton:SetText(L["NEW_STEP"])
    newStepButton:SetScript("OnClick", function(self, button, down)
        local journey = Editor:GetSelectedJourney()
        local chapter = Editor:GetSelectedChapter()
        local stepIndex = Editor:GetSelectedStepIndex()
        if IsControlKeyDown() then
            stepIndex = nil
        end
        if Journeys:AddNewStep(journey, chapter, nil, nil, stepIndex) then
            Editor:Refresh()
            addon:Reset(true)
        end
    end)
    self.newStepButton = newStepButton

    StaticPopupDialogs[addonName .. "_DELETE_STEP"] = {
        text = L["DELETE_STEP"] .. "?",
        showAlert = true,
        button1 = ACCEPT,
        button2 = CANCEL,
        OnAccept = function()
            local journey = Editor:GetSelectedJourney()
            local chapter = Editor:GetSelectedChapter()
            if Journeys:DeleteStep(journey, chapter, Editor:GetSelectedStepIndex()) then
                Editor:SetSelectedStepIndex(-1)
                Editor:Refresh()
                addon:Reset(true)
            end
        end,
        sound = SOUNDKIT.IG_MAINMENU_OPEN,
        hideOnEscape = true,
    }
    local deleteStepButton = CreateFrame("BUTTON", "DeleteStep", content, "UIPanelButtonTemplate")
    deleteStepButton:SetPoint("TOPLEFT", stepSelector, "BOTTOM")
    deleteStepButton:SetPoint("BOTTOMRIGHT", stepSelector, "BOTTOMRIGHT", 0, -22)
    deleteStepButton:SetText(L["DELETE_STEP"])
    deleteStepButton:SetScript("OnClick", function(self, button, down)
        StaticPopup_Show(addonName .. "_DELETE_STEP")
    end)
    self.deleteStepButton = deleteStepButton

    local propertiesGroup = self:CreatePropertiesGroup("FRAME", "Properties", content)
    propertiesGroup:SetPoint("TOPLEFT", copyChapterButton, "BOTTOMLEFT", 0, -15)
    propertiesGroup:SetPoint("BOTTOMRIGHT", content, "BOTTOMRIGHT")
    self.propertiesGroup = propertiesGroup

    self.GetSelectedJourneyIndex = function(self) return self.journeySelector.list.selectedIndex end
    self.SetSelectedJourneyIndex = function(self, index) self.journeySelector.list.selectedIndex = index end
    self.GetSelectedJourney = function(self) return addon:GetJourney(self:GetSelectedJourneyIndex()) end
    self.ResetSelectedJourneyState = function(self) addon:ResetJourneyState(self:GetSelectedJourneyIndex()) end
    self.GetSelectedChapterIndex = function(self) return self.chapterSelector.list.selectedIndex end
    self.SetSelectedChapterIndex = function(self, index) self.chapterSelector.list.selectedIndex = index end
    self.GetSelectedChapter = function(self) return addon:GetJourneyChapter(self:GetSelectedJourney(), self:GetSelectedChapterIndex()) end
    self.ResetSelectedChapterState = function(self) addon:ResetJourneyChapterState(self:GetSelectedJourneyIndex(), self:GetSelectedChapterIndex()) end
    self.GetSelectedStepIndex = function(self) return self.stepSelector.list.selectedIndex end
    self.SetSelectedStepIndex = function(self, index) self.stepSelector.list.selectedIndex = index end
    self.GetSelectedStep = function(self) return Journeys:GetStep(self:GetSelectedChapter(), self:GetSelectedStepIndex()) end
    self.IsSelectedStepLast = function(self) return self.stepSelector.list.selectedIndex == #self:GetSelectedChapter().steps end
    self.Refresh = function(self)
        xpcall(function()
            self.journeySelector:Refresh()
            self.chapterSelector:Refresh()
            self.stepSelector:Refresh()
            self.propertiesGroup:Refresh()
            self.deleteJourneyButton:SetEnabled(self:GetSelectedJourneyIndex() > 0)
            self.exportJourneyButton:SetEnabled(self:GetSelectedJourneyIndex() > 0)
            self.newChapterButton:SetEnabled(self:GetSelectedJourneyIndex() > 0)
            self.deleteChapterButton:SetEnabled(self:GetSelectedChapterIndex() > 0)
            self.copyChapterButton:SetEnabled(self:GetSelectedChapterIndex() > 0)
            self.pasteChapterButton:SetEnabled(Editor.clipBoard and Editor.clipBoard.type == "Chapter" and Editor.clipBoard.data)
            self.newStepButton:SetEnabled(self:GetSelectedChapterIndex() > 0)
            self.deleteStepButton:SetEnabled(self:GetSelectedStepIndex() > 0)
        end, geterrorhandler())
    end
end

function Editor:OnDisable()
end

function Editor:CreateSelector(name, parent)
    local frame = CreateFrame("FRAME", name, parent)

    local title = GUI:CreateLabel("FRAME", "Title", frame)
    title:SetPoint("TOPLEFT")
    title:SetPoint("BOTTOMRIGHT", frame, "TOPRIGHT", 0, -18)
    title:SetJustifyH("LEFT")
    title:SetJustifyV("CENTER")
    title:SetFontSize(12)
    frame.title = title

    local container = GUI:CreateGroup("FRAME", "Container", frame)
    container:SetPoint("TOPLEFT", title, "BOTTOMLEFT")
    container:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT")

    local list = GUI:CreateListView("FRAME", "List", container)
    list:SetPoint("TOPLEFT", 5, -5)
    list:SetPoint("BOTTOMRIGHT", -5, 5)
    frame.list = list

    frame.SetTitle = function(self, value) title:SetText(value) end
    frame.Refresh = function(self) list:Refresh() end

    return frame
end

function Editor:CreatePropertiesGroup(frameType, name, parent, template, id)
    local frame = CreateFrame(frameType, name, parent, template, id)

    local title = GUI:CreateLabel("FRAME", "Title", frame)
    title:SetPoint("TOPLEFT")
    title:SetPoint("BOTTOMRIGHT", frame, "TOPRIGHT", 0, -18)
    title:SetJustifyH("LEFT")
    title:SetJustifyV("CENTER")
    title:SetFontSize(12)
    title:SetText("Properties")
    frame.title = title

    local group = GUI:CreateGroup("FRAME", "Group", frame)
    group:SetPoint("TOPLEFT", title, "BOTTOMLEFT")
    group:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT")
    frame.group = group

    local scrollFrame = CreateFrame("SCROLLFRAME", "ScrollFrame", group, "UIPanelScrollFrameTemplate")
    scrollFrame:SetPoint("TOPLEFT", 5, -5)
    scrollFrame:SetPoint("BOTTOMRIGHT", -27, 5)
    frame.scrollFrame = scrollFrame

    local scrollChild = CreateFrame("FRAME", "ScrollChild", scrollFrame)
    scrollFrame:SetScrollChild(scrollChild)
    frame.scrollChild = scrollChild

    local journeyTitle = self:CreateEditBoxProperty("FRAME", "JourneyTitle", scrollChild)
    journeyTitle:SetPoint("TOPLEFT")
    journeyTitle:SetPoint("BOTTOMRIGHT", scrollChild, "TOPRIGHT", 0, -40)
    journeyTitle:SetTitle(L["JOURNEY_TITLE_LABEL"])
    journeyTitle.OnEnterPressed = function(self)
        local journey = Editor:GetSelectedJourney()
        if journey then
            journey.title = self:GetText()
        end
        Editor:Refresh()
        addon:Reset(true)
    end
    frame.journeyTitle = journeyTitle

    local journeyIndex = self:CreateEditBoxProperty("FRAME", "JourneyIndex", scrollChild)
    journeyIndex:SetPoint("TOPLEFT", journeyTitle, "BOTTOMLEFT")
    journeyIndex:SetPoint("BOTTOMRIGHT", journeyTitle, "BOTTOMRIGHT", 0, -40)
    journeyIndex:SetTitle(L["JOURNEY_INDEX_LABEL"])
    journeyIndex:SetNumeric(true)
    journeyIndex.OnEnterPressed = function(self)
        local index = self:GetNumber()
        if index and Journeys:MoveJourney(Editor:GetSelectedJourneyIndex(), index) then
            Editor:SetSelectedJourneyIndex(index)
        end
        Editor:Refresh()
        addon:Reset(true)
    end
    frame.journeyIndex = journeyIndex

    local chapterTitle = self:CreateEditBoxProperty("FRAME", "ChapterTitle", scrollChild)
    chapterTitle:SetPoint("TOPLEFT", journeyIndex, "BOTTOMLEFT")
    chapterTitle:SetPoint("BOTTOMRIGHT", journeyIndex, "BOTTOMRIGHT", 0, -40)
    chapterTitle:SetTitle(L["CHAPTER_TITLE_LABEL"])
    chapterTitle.OnEnterPressed = function(self)
        local chapter = Editor:GetSelectedChapter()
        if chapter then
            chapter.title = self:GetText()
        end
        Editor:Refresh()
        addon:Reset(true)
    end
    frame.chapterTitle = chapterTitle

    local chapterIndex = self:CreateEditBoxProperty("FRAME", "ChapterIndex", scrollChild)
    chapterIndex:SetPoint("TOPLEFT", chapterTitle, "BOTTOMLEFT")
    chapterIndex:SetPoint("BOTTOMRIGHT", chapterTitle, "BOTTOMRIGHT", 0, -40)
    chapterIndex:SetTitle(L["CHAPTER_INDEX_LABEL"])
    chapterIndex:SetNumeric(true)
    chapterIndex.OnEnterPressed = function(self)
        local index = self:GetNumber()
        local journey = Editor:GetSelectedJourney()
        if index and journey and Journeys:MoveChapter(journey, Editor:GetSelectedChapterIndex(), index) then
            Editor:SetSelectedChapterIndex(index)
        end
        Editor:Refresh()
        addon:Reset(true)
    end
    frame.chapterIndex = chapterIndex

    local stepType = self:CreateDropDownMenuProperty("FRAME", "StepType", scrollChild)
    stepType:SetPoint("TOPLEFT", chapterIndex, "BOTTOMLEFT")
    stepType:SetPoint("BOTTOMRIGHT", chapterIndex, "BOTTOMRIGHT", 0, -40)
    stepType:SetTitle(L["STEP_TYPE_LABEL"])
    stepType.GetValue = function(self)
        if Editor and Editor.GetSelectedStep then
            local step = Editor:GetSelectedStep()
            if step then
                return step.type
            end
        end
    end
    stepType.GetValues = function(self)
        return {
            [addon.STEP_TYPE_UNDEFINED] = L["UNDEFINED"],
            [addon.STEP_TYPE_ACCEPT_QUEST] = L["DROPDOWN_ACCEPT_QUEST"],
            [addon.STEP_TYPE_COMPLETE_QUEST] = L["DROPDOWN_COMPLETE_QUEST"],
            [addon.STEP_TYPE_TURNIN_QUEST] = L["DROPDOWN_TURNIN_QUEST"],
            [addon.STEP_TYPE_GO_TO_COORD] = L["DROPDOWN_GO_TO_COORD"],
            [addon.STEP_TYPE_GO_TO_ZONE] = L["DROPDOWN_GO_TO_ZONE"],
--            [addon.STEP_TYPE_GO_TO_AREA] = L["DROPDOWN_GO_TO_AREA"],
            [addon.STEP_TYPE_REACH_LEVEL] = L["DROPDOWN_REACH_LEVEL"],
            [addon.STEP_TYPE_REACH_REPUTATION] = L["DROPDOWN_REACH_REPUTATION"],
            [addon.STEP_TYPE_BIND_HEARTHSTONE] = L["DROPDOWN_BIND_HEARTHSTONE"],
            [addon.STEP_TYPE_USE_HEARTHSTONE] = L["DROPDOWN_USE_HEARTHSTONE"],
            [addon.STEP_TYPE_LEARN_FLIGHT_PATH] = L["DROPDOWN_LEARN_FLIGHT_PATH"],
            [addon.STEP_TYPE_FLY_TO] = L["DROPDOWN_FLY_TO"],
            [addon.STEP_TYPE_TRAIN_CLASS] = L["DROPDOWN_TRAIN_CLASS"],
            [addon.STEP_TYPE_TRAIN_SPELLS] = L["DROPDOWN_TRAIN_SPELLS"],
            [addon.STEP_TYPE_LEARN_FIRST_AID] = L["DROPDOWN_LEARN_FIRST_AID"],
            [addon.STEP_TYPE_LEARN_COOKING] = L["DROPDOWN_LEARN_COOKING"],
            [addon.STEP_TYPE_LEARN_FISHING] = L["DROPDOWN_LEARN_FISHING"],
            [addon.STEP_TYPE_ACQUIRE_ITEMS] = L["DROPDOWN_ACQUIRE_ITEMS"],
            [addon.STEP_TYPE_DIE_AND_RES] = L["DROPDOWN_DIE_AND_RES"],
        }
    end
    stepType.GetSorting = function(self)
        return {
            addon.STEP_TYPE_UNDEFINED,
            addon.STEP_TYPE_ACCEPT_QUEST,
            addon.STEP_TYPE_COMPLETE_QUEST,
            addon.STEP_TYPE_TURNIN_QUEST,
            addon.STEP_TYPE_REACH_LEVEL,
            addon.STEP_TYPE_REACH_REPUTATION,
            addon.STEP_TYPE_GO_TO_COORD,
            addon.STEP_TYPE_GO_TO_ZONE,
--            addon.STEP_TYPE_GO_TO_AREA,
            addon.STEP_TYPE_BIND_HEARTHSTONE,
            addon.STEP_TYPE_USE_HEARTHSTONE,
            addon.STEP_TYPE_LEARN_FLIGHT_PATH,
            addon.STEP_TYPE_FLY_TO,
            addon.STEP_TYPE_TRAIN_CLASS,
            addon.STEP_TYPE_TRAIN_SPELLS,
            addon.STEP_TYPE_LEARN_FIRST_AID,
            addon.STEP_TYPE_LEARN_COOKING,
            addon.STEP_TYPE_LEARN_FISHING,
            addon.STEP_TYPE_ACQUIRE_ITEMS,
            addon.STEP_TYPE_DIE_AND_RES,
        }
    end
    stepType.OnValueChanged = function(self, value)
        local step = Editor:GetSelectedStep()
        if step then
            step.type = value
            if String:IsNilOrEmpty(step.data) then
                if step.type == addon.STEP_TYPE_GO_TO_COORD then
                    local playerX, playerY, playerMapId = HBD:GetPlayerZonePosition()
                    if playerMapId and playerX and playerY then
                        local subZoneText = GetSubZoneText()
                        if subZoneText and subZoneText:len() > 0 then
                            step.data = string.format("%d,%.2f,%.2f,%s", playerMapId, playerX * 100.0, playerY * 100.0, subZoneText)
                        else
                            step.data = string.format("%d,%.2f,%.2f", playerMapId, playerX * 100.0, playerY * 100.0)
                        end
                    end
                elseif step.type == addon.STEP_TYPE_GO_TO_ZONE then
                    local playerX, playerY, playerMapId = HBD:GetPlayerZonePosition()
                    if playerMapId and playerX and playerY then
                        step.data = string.format("%d,%.2f,%.2f", playerMapId, playerX * 100.0, playerY * 100.0)
                    end
                end
            end
        end
        if not Editor:IsSelectedStepLast() then
            Editor:ResetSelectedChapterState()
        end
        Editor:Refresh()
        addon:Reset(true)
    end
    frame.stepType = stepType

    local stepData = self:CreateEditBoxProperty("FRAME", "StepData", scrollChild)
    stepData:SetPoint("TOPLEFT", stepType, "BOTTOMLEFT")
    stepData:SetPoint("BOTTOMRIGHT", stepType, "BOTTOMRIGHT", 0, -40)
    stepData:SetTitle(L["STEP_DATA_LABEL"])
    stepData.OnEnterPressed = function(self)
        local step = Editor:GetSelectedStep()
        if step then
            step.data = self:GetText()
        end
        if not Editor:IsSelectedStepLast() then
            Editor:ResetSelectedChapterState()
        end
        Editor:Refresh()
        addon:Reset(true)
    end
    frame.stepData = stepData

    local stepIndex = self:CreateEditBoxProperty("FRAME", "StepIndex", scrollChild)
    stepIndex:SetPoint("TOPLEFT", stepData, "BOTTOMLEFT")
    stepIndex:SetPoint("BOTTOMRIGHT", stepData, "BOTTOMRIGHT", 0, -40)
    stepIndex:SetTitle(L["STEP_INDEX_LABEL"])
    stepIndex:SetNumeric(true)
    stepIndex.OnEnterPressed = function(self)
        local journey = Editor:GetSelectedJourney()
        local chapter = Editor:GetSelectedChapter()
        local index = self:GetNumber()
        if Journeys:MoveStep(journey, chapter, Editor:GetSelectedStepIndex(), index) then
            Editor:SetSelectedStepIndex(index)
        end
        Editor:Refresh()
        addon:Reset(true)
    end
    frame.stepIndex = stepIndex

    local stepRequiredRaces = self:CreateDropDownMenuProperty("FRAME", "StepRequiredRaces", scrollChild, true)
    stepRequiredRaces:SetPoint("TOPLEFT", stepIndex, "BOTTOMLEFT")
    stepRequiredRaces:SetPoint("BOTTOMRIGHT", stepIndex, "BOTTOMRIGHT", 0, -40)
    stepRequiredRaces:SetTitle(L["STEP_REQUIRED_RACES_LABEL"])
    stepRequiredRaces.GetValue = function(self)
        if Editor and Editor.GetSelectedStep then
            local step = Editor:GetSelectedStep()
            if step then
                return step.requiredRaces
            end
        end
    end
    stepRequiredRaces.GetValues = function(self)
        return addon.raceNameLocal
    end
    stepRequiredRaces.GetSorting = function(self)
        return {
            addon.RACE_HUMAN,
            addon.RACE_DWARF,
            addon.RACE_NIGHTELF,
            addon.RACE_GNOME,
            addon.RACE_ORC,
            addon.RACE_SCOURGE,
            addon.RACE_TAUREN,
            addon.RACE_TROLL,
        }
    end
    stepRequiredRaces.OnValueChanged = function(self, value)
        local step = Editor:GetSelectedStep()
        if step then
            if value > 0 then
                step.requiredRaces = value
            else
                step.requiredRaces = nil
            end
        end
        if not Editor:IsSelectedStepLast() then
            Editor:ResetSelectedChapterState()
        end
        Editor:Refresh()
        addon:Reset(true)
    end
    frame.stepRequiredRaces = stepRequiredRaces

    local stepRequiredClasses = self:CreateDropDownMenuProperty("FRAME", "StepRequiredClasses", scrollChild, true)
    stepRequiredClasses:SetPoint("TOPLEFT", stepRequiredRaces, "BOTTOMLEFT")
    stepRequiredClasses:SetPoint("BOTTOMRIGHT", stepRequiredRaces, "BOTTOMRIGHT", 0, -40)
    stepRequiredClasses:SetTitle(L["STEP_REQUIRED_CLASSES_LABEL"])
    stepRequiredClasses.GetValue = function(self)
        if Editor and Editor.GetSelectedStep then
            local step = Editor:GetSelectedStep()
            if step then
                return step.requiredClasses
            end
        end
    end
    stepRequiredClasses.GetValues = function(self)
        return addon.classNameLocal
    end
    stepRequiredClasses.GetSorting = function(self)
        return {
            addon.CLASS_DRUID,
            addon.CLASS_HUNTER,
            addon.CLASS_MAGE,
            addon.CLASS_PALADIN,
            addon.CLASS_PRIEST,
            addon.CLASS_ROGUE,
            addon.CLASS_SHAMAN,
            addon.CLASS_WARLOCK,
            addon.CLASS_WARRIOR,
        }
    end
    stepRequiredClasses.OnValueChanged = function(self, value)
        local step = Editor:GetSelectedStep()
        if step then
            if value > 0 then
                step.requiredClasses = value
            else
                step.requiredClasses = nil
            end
        end
        if not Editor:IsSelectedStepLast() then
            Editor:ResetSelectedChapterState()
        end
        Editor:Refresh()
        addon:Reset(true)
    end
    frame.stepRequiredClasses = stepRequiredClasses

    local stepNote = self:CreateEditBoxProperty("FRAME", "StepNote", scrollChild)
    stepNote:SetPoint("TOPLEFT", stepRequiredClasses, "BOTTOMLEFT")
    stepNote:SetPoint("BOTTOMRIGHT", stepRequiredClasses, "BOTTOMRIGHT", 0, -40)
    stepNote:SetTitle(L["STEP_NOTE_LABEL"])
    stepNote.OnEnterPressed = function(self)
        local step = Editor:GetSelectedStep()
        if step then
            step.note = self:GetText()
            if step.note and string.len(step.note) == 0 then
                step.note = nil
            end
        end
        Editor:Refresh()
        addon:Reset(true)
    end
    frame.stepNote = stepNote

    frame.Refresh = function(self)
        self.scrollChild:SetSize(self.scrollFrame:GetWidth(), self.scrollFrame:GetHeight())

        local journey = Editor:GetSelectedJourney()
        if journey then
            self.journeyTitle:SetEnabled(true)
            self.journeyTitle:SetText(journey.title)
            self.journeyIndex:SetEnabled(true)
            self.journeyIndex:SetText(Editor:GetSelectedJourneyIndex())
        else
            self.journeyTitle:SetEnabled(false)
            self.journeyTitle:SetText("")
            self.journeyIndex:SetEnabled(false)
            self.journeyIndex:SetText("")
        end

        local chapter = Editor:GetSelectedChapter()
        if chapter then
            self.chapterTitle:SetEnabled(true)
            self.chapterTitle:SetText(chapter.title)
            self.chapterIndex:SetEnabled(true)
            self.chapterIndex:SetText(Editor:GetSelectedChapterIndex())
        else
            self.chapterTitle:SetEnabled(false)
            self.chapterTitle:SetText("")
            self.chapterIndex:SetEnabled(false)
            self.chapterIndex:SetText("")
        end

        self.stepType:SetWidth(self.scrollFrame:GetWidth())
        self.stepRequiredRaces:SetWidth(self.scrollFrame:GetWidth())
        self.stepRequiredClasses:SetWidth(self.scrollFrame:GetWidth())
        local step = Editor:GetSelectedStep()
        if step then
            self.stepType:SetValue(step.type)
            self.stepType:SetEnabled(true)
            if step.data then
                self.stepData:SetText(step.data)
            else
                self.stepData:SetText("")
            end
            self.stepData:SetEnabled(true)
            self.stepIndex:SetText(Editor:GetSelectedStepIndex())
            self.stepIndex:SetEnabled(true)
            self.stepRequiredRaces:SetValue(step.requiredRaces)
            self.stepRequiredRaces:SetEnabled(true)
            self.stepRequiredClasses:SetValue(step.requiredClasses)
            self.stepRequiredClasses:SetEnabled(true)
            if step.note then
                self.stepNote:SetText(step.note)
            else
                self.stepNote:SetText("")
            end
            self.stepNote:SetEnabled(true)
        else
            self.stepType:SetValue("")
            self.stepType:SetEnabled(false)
            self.stepData:SetText("")
            self.stepData:SetEnabled(false)
            self.stepIndex:SetText("")
            self.stepIndex:SetEnabled(false)
            self.stepRequiredRaces:SetValue(0)
            self.stepRequiredRaces:SetEnabled(false)
            self.stepRequiredClasses:SetValue(0)
            self.stepRequiredClasses:SetEnabled(false)
            self.stepNote:SetText("")
            self.stepNote:SetEnabled(false)
        end
    end

    return frame
end

function Editor:CreateEditBoxProperty(frameType, name, parent, template, id)
    local frame = CreateFrame(frameType, name, parent, template, id)

    local label = GUI:CreateLabel("FRAME", "Label", frame)
    label:SetPoint("TOPLEFT")
    label:SetPoint("BOTTOMRIGHT", frame, "TOPRIGHT", 0, -15)
    label:SetJustifyH("LEFT")
    label:SetJustifyV("CENTER")
    label:SetFontSize(10)
    frame.label = label

    local editBox = GUI:CreateEditBox("FRAME", "EditBox", frame)
    editBox:SetPoint("TOPLEFT", label, "BOTTOMLEFT")
    editBox:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT")
    editBox:SetTextColor(1, 1, 1, 1)
    editBox.OnEnterPressed = function(self)
        if frame.OnEnterPressed then
            frame:OnEnterPressed()
        end
    end
    frame.editBox = editBox

    frame.SetTitle = function(self, value) self.label:SetText(value) end
    frame.SetText = function(self, value) self.editBox:SetText(value) end
    frame.GetText = function(self) return self.editBox:GetText() end
    frame.GetNumber = function(self) return self.editBox:GetNumber() end
    frame.SetNumeric = function(self, value) self.editBox:SetNumeric(value) end
    frame.SetEnabled = function(self, value) self.editBox:SetEnabled(value) end

    return frame
end

function Editor:CreateDropDownMenuProperty(frameType, name, parent, isBitFlag, template, id)
    local frame = CreateFrame(frameType, name, parent, template, id)

    local label = GUI:CreateLabel("FRAME", "Label", frame)
    label:SetPoint("TOPLEFT")
    label:SetPoint("BOTTOMRIGHT", frame, "TOPRIGHT", 0, -15)
    label:SetJustifyH("LEFT")
    label:SetJustifyV("CENTER")
    label:SetFontSize(10)
    frame.label = label

    local dropDownMenu = GUI:CreateDropDownMenu("FRAME", "DropDownMenu", frame, isBitFlag)
    dropDownMenu:SetPoint("TOPLEFT", label, "BOTTOMLEFT")
    dropDownMenu:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT")
    dropDownMenu.GetValue = function(self) return frame:GetValue() end
    dropDownMenu.GetValues = function(self) return frame:GetValues() end
    dropDownMenu.GetSorting = function(self) if frame.GetSorting then return frame:GetSorting() end end
    dropDownMenu.OnValueChanged = function(self, value) if frame.OnValueChanged then frame:OnValueChanged(value) end end
    frame.dropDownMenu = dropDownMenu

    frame.SetTitle = function(self, value) self.label:SetText(value) end
    frame.SetValue = function(self, value) self.dropDownMenu:SetValue(value) end
    frame.SetWidth = function(self, value) self.dropDownMenu:SetWidth(value) end
    frame.SetEnabled = function(self, value) self.dropDownMenu:SetEnabled(value) end

    return frame
end

function Editor:ImportJourney(journey)
    -- Verify if journey already exist
    if List:Any(addon.journeys, function(j) return j.guid == journey.guid end) then
        local dialog = StaticPopup_Show(addonName .. "_IMPORT_JOURNEY", nil, nil, journey)
        dialog.importingJourney = journey
        return
    end

    -- Make sure title is unique
    if List:Any(addon.journeys, function(j) return j.title == journey.title end) then
        local title = journey.title
        local count = 1
        while List:Count(addon.journeys, function(j) return j.title == title.." ("..count..")" end) > 0 do
            count = count + 1
        end
        journey.title = title.." ("..count..")"
    end

    -- Add journey
    List:Add(addon.journeys, journey)
    Editor:SetSelectedJourneyIndex(#addon.journeys)
    Editor:SetSelectedChapterIndex(1)
    Editor:SetSelectedStepIndex(-1)
    Editor:Refresh()
end
