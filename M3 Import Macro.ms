---------------------------------------------------------------------------

global M3G_ImportInfo_Glb

struct M3S_INIdata
(
	sectionStr, keyStr, value
)

fn M3F_FormatToString str_FP items_FP =
(
	local ret_string = ""
	local split_strings = filterString str_FP "%" splitEmptyTokens:true

	for i=1 to (split_strings.count-1) do
	(
		ret_string = ret_string + split_strings[i] + (items_FP[i] as string)
	)
	ret_string = ret_string + split_strings[split_strings.count]
)

fn M3F_AccessINI ini_FP part_FP type_FP =
(
	local ini_path = case ini_FP of
	(
		#setting: "$plugcfg\\M3_Import_Settings.ini"
		#language: "$temp\\M3Import_mzp\\M3_Import_Languages.ini"
		default: "$plugcfg\\M3_Import_Settings.ini"
	)
	case type_FP of
	(
		#save:
		(setINISetting ini_path part_FP.sectionStr part_FP.keyStr (part_FP.value as string))
		#load:
		(
			local get_val = getINISetting ini_path part_FP.sectionStr part_FP.keyStr
			if(get_val.count > 0)then
			(
				local origin_class = classOf part_FP.value
				local new_value = if(origin_class == string)then(get_val)else(try(execute get_val)catch(undefined))
				if(new_value != undefined)then(try(part_FP.value = new_value as origin_class)catch())
			)
		)
	)
	part_FP.value
)

fn M3F_ReadLanguage language_FP item_FP default_FP =
(
	local string_read = M3F_AccessINI #language (M3S_INIdata language_FP item_FP default_FP) #load
)

fn M3F_CheckStarTools type_FP func: =
(
	case type_FP of
	(
		#Init:
		(
			try
			(
				local props = getPropNames starTools
				if(props != #(#Behaviors, #INI, #AssetsTracking, \
							#helpers, #menu, #AnimProps, #Utilities, \
							#info, #log, #export, #DisplaySettings))then
				(
					undefined = 1
				)
			)catch
			(messageBox "CAN'T FOUND STAR ART TOOLS!!!"; return false)
		)
		#Info:(try(starTools.Info)catch(messageBox "CAN'T FOUND STAR ART TOOLS!!!"; return false))
	)
	case func of
	(
		#gameDir:
		(
			local game_dir = StarTools.Info.GetDir #localBuild
			if(game_dir == undefined)then(game_dir = "")
			if((doesFileExist (game_dir + "\\StarCraft II.exe")) != true)then
			(
				messageBox ("Wrong SC2 game path !!!\n" + \
							"Please select the game path first!!!\n" + \
							"Please select the folder containing the StarCraft II exe.")
				StarTools.Info.SetLocalBuildPath()

				game_dir = StarTools.Info.GetDir #localBuild
				if(game_dir == undefined)then(game_dir = "")
				if((doesFileExist (game_dir + "\\StarCraft II.exe")) != true)then
				(
					messageBox "Bad configuration. Operation cancelled."
					return false
				)
			)
		)
	)
	true
)

struct M3S_ImportInfo
(
	verison = "v1.8",
	ExtractFileLib,
	--Misc
	Language 		= M3S_INIdata "Misc" 	"Language" 	"English",
	btnItem = \
		#(
			#("647394", "M3M_FileImport`CaptainD", "M3 file import tool.", "M3-Import"),
			#("647394", "M3M_TexMapFix`CaptainD", "Fix textures path problem.", "M3-TexMapFix")
		),
	
	--Import Tool
	MainUI, dialogCheck = false, progressLv = 20.0, currProgLv = 0.0,
	missingMap = #(), lastFileName = "None", lastPath = "", DetailsUI, cancelCheck = false,

	posUI 			= M3S_INIdata "Import" 				"posUI" 			[500, 100],
	heightUI		= M3S_INIdata "Import" 				"heightUI" 			880,
	showDetails 	= M3S_INIdata "Import" 				"showDetails" 		true,
	missingCheck 	= M3S_INIdata "Import" 				"missingCheck" 		true,
	mapPath 		= M3S_INIdata "Import" 				"mapPath" 			"",
	pathSelect 		= M3S_INIdata "Import" 				"pathSelect" 		2,
	impTrack 		= M3S_INIdata "Import" 				"impTrack" 			true,
	impSeq 			= M3S_INIdata "Import" 				"impSeq" 			true,
	impAnim 		= M3S_INIdata "Import" 				"impAnim" 			true,
	impEvt 			= M3S_INIdata "Import" 				"impEvt" 			true,
	impTurt			= M3S_INIdata "Import" 				"impTurt" 			true,
	impBBrd			= M3S_INIdata "Import" 				"impBBrd" 			true,
	impIK			= M3S_INIdata "Import" 				"impIK" 			true,
	impMat 			= M3S_INIdata "Import" 				"impMat" 			true,
	impBone 		= M3S_INIdata "Import" 				"impBone" 			true,
	impMesh 		= M3S_INIdata "Import" 				"impMesh" 			true,
	impSkin 		= M3S_INIdata "Import" 				"impSkin" 			true,
	impHit 			= M3S_INIdata "Import" 				"impHit" 			true,
	impVol 			= M3S_INIdata "Import" 				"impVol" 			true,
	impAttach 		= M3S_INIdata "Import" 				"impAttach" 		true,
	impBound 		= M3S_INIdata "Import" 				"impBound" 			true,
	impLight 		= M3S_INIdata "Import" 				"impLight" 			true,
	impCam 			= M3S_INIdata "Import" 				"impCam" 			true,
	impPart 		= M3S_INIdata "Import" 				"impPart" 			true,
	impPhy 			= M3S_INIdata "Import" 				"impPhy" 			true,
	setGPos			= M3S_INIdata "Global Settings" 	"setGPos" 			[0,0,0],
	setGScale		= M3S_INIdata "Global Settings" 	"setGScale" 		1.0,
	setFRate 		= M3S_INIdata "Animation Settings" 	"setFRate" 			30,
	setFBSeq		= M3S_INIdata "Animation Settings" 	"setFBSeq" 			40,
	setFCorrect		= M3S_INIdata "Animation Settings" 	"setFCorrect" 		30.0,
	setFCheckR		= M3S_INIdata "Animation Settings" 	"setFCheckR" 		1,
	setWeldSmooth	= M3S_INIdata "Mesh Settings" 		"setWeldSmooth" 	1,
	setSmoothType	= M3S_INIdata "Mesh Settings" 		"setSmoothType" 	2,
	setSmoothAngle	= M3S_INIdata "Mesh Settings" 		"setSmoothAngle" 	45.0,
	setBEntity		= M3S_INIdata "Bone Settings" 		"setBEntity" 		1,
	setBSize1		= M3S_INIdata "Bone Settings" 		"setBSize1" 		2.0,
	setBSize2		= M3S_INIdata "Bone Settings" 		"setBSize2" 		5.0,
	setBSize3		= M3S_INIdata "Bone Settings" 		"setBSize3" 		1.0,
	setBAnim		= M3S_INIdata "Bone Settings" 		"setBAnim" 			true,
	setBLink		= M3S_INIdata "Bone Settings" 		"setBLink" 			false,
	setBFix			= M3S_INIdata "Bone Settings" 		"setBFix" 			false,
	setBPosCtl		= M3S_INIdata "Bone Settings" 		"setBPosCtl" 		1,
	setBRotCtl		= M3S_INIdata "Bone Settings" 		"setBRotCtl" 		1,
	setBScaleCtl	= M3S_INIdata "Bone Settings" 		"setBScaleCtl" 		2,
	setAttSize		= M3S_INIdata "Helper Settings" 	"setAttSize" 		5,
	setAttScale		= M3S_INIdata "Helper Settings" 	"setAttScale" 		false,
	setBoundColl	= M3S_INIdata "Helper Settings" 	"setBoundColl" 		true,
	setAttColl		= M3S_INIdata "Helper Settings" 	"setAttColl" 		false,
	setVolColl		= M3S_INIdata "Helper Settings" 	"setVolColl" 		true,
	setHitColl		= M3S_INIdata "Helper Settings" 	"setHitColl" 		true,
	setLTrans		= M3S_INIdata "Light Settings" 		"setLTrans" 		true,
	setLPar			= M3S_INIdata "Light Settings" 		"setLPar" 			true,
	setCTrans		= M3S_INIdata "Camera Settings" 	"setCTrans" 		true,
	setCPar			= M3S_INIdata "Camera Settings" 	"setCPar" 			true,
	setPTrans		= M3S_INIdata "Particle Settings" 	"setPTrans" 		true,
	setPPar			= M3S_INIdata "Particle Settings" 	"setPPar" 			true,
	--Textures tool
	texToolUI, texDialogCheck = false,

	fn getToolsBarItems idx_FP =
	(
		local item_str = "2|0|0|31|3|" + this.btnItem[idx_FP][1] + "|" + this.btnItem[idx_FP][2] + \
			"|0|0|\"" + this.btnItem[idx_FP][3] + "\"|\"" + this.btnItem[idx_FP][4] + "\"|-1|"
	),

	fn checkToolBarExist =
	(
		local cuiFile = cui.getConfigFile()
		local changed = false
		if(toLower (getFilenameType cuiFile) == ".cui")then
		(
			if (hasINISetting cuiFile #CUIData #WindowCount) and (hasINISetting cuiFile #CUIWindows)do
			(
				local itemsCount = (getINISetting cuiFile #CUIData #WindowCount) as integer
				local allWindows = for n in 1 to itemsCount collect
				(
					local pad_num = "000"+((n - 1)as string)
					local curItem = "F" + (substring pad_num (pad_num.count-2) -1)
					local curWindow = getINISetting cuiFile #CUIWindows curItem
					(filterstring curWindow ":")[2]
				)
				if (FindItem allWindows "CaptainD") == 0 do
				(
					local pad_num1 = "000"+(itemsCount as string)
					local newItem = "F" + (substring pad_num1 (pad_num1.count-2) -1)
					setINISetting cuiFile #CUIData #WindowCount ((itemsCount + 1) as string)
					setINISetting cuiFile #CUIWindows newItem "T:CaptainD"
					changed = true
				)
			)
			if not (hasINISetting cuiFile #CaptainD) do
			(
				setINISetting cuiFile #CaptainD #Rank "0"
				setINISetting cuiFile #CaptainD #SubRank "2"
				setINISetting cuiFile #CaptainD #Hidden "0"
				setINISetting cuiFile #CaptainD #DPanel "1"
				setINISetting cuiFile #CaptainD #Tabbed "0"
				setINISetting cuiFile #CaptainD #TabCt "0"
				setINISetting cuiFile #CaptainD #CurTab "-1"
				setINISetting cuiFile #CaptainD #CType "1"
				setINISetting cuiFile #CaptainD #ToolbarRows "1"
				setINISetting cuiFile #CaptainD #ToolbarType "3"
				setINISetting cuiFile #CaptainD #CurPos "1 278 349 358 418"
				
				setINISetting cuiFile #CaptainD #ItemCount (this.btnItem.count as string)
				for i=1 to this.btnItem.count do
				(
					setINISetting cuiFile #CaptainD ("item"+((i-1) as string)) (getToolsBarItems i)
				)
				changed = true
			)
			if(changed)then
			(
				cui.loadConfig cuiFile
				cui.saveConfig()
			)
		)else
		(
			if(doesFileExist cuiFile)then
			(
				local XmlDoc = dotNetObject "system.xml.xmlDocument"
				XmlDoc.load cuiFile
				local docElement = try(XmlDoc.documentElement) catch(undefined)
				if docElement != undefined then
				(
					local CUIWindowsElement = docElement.SelectSingleNode "//ADSK_CUI//CUIWindows"
					if CUIWindowsElement != undefined then
					(
						local toolbarElement = docElement.SelectSingleNode \
							"//ADSK_CUI//CUIWindows//Window[@name='CaptainD']"
						if toolbarElement == undefined do
						(
							local posAttributeNames = #("FRect", "DRect", "DRectPref", "CurPos")
							local posAttributeValues = \
							#(
								#("698", "542", "764", "611"),
								#("1235", "53", "1280", "92"),
								#("2147483647", "2147483647","-2147483648", "-2147483648"),
								#("1235", "53", "1280", "92", "0", "1")
							)
							toolbarElement = XmlDoc.CreateElement "Window"
							toolbarElement.SetAttribute "name" "CaptainD"
							toolbarElement.SetAttribute "type" "T"
							toolbarElement.SetAttribute "rank" "0"
							toolbarElement.SetAttribute "subRank" "2"
							toolbarElement.SetAttribute "hidden" "0"
							toolbarElement.SetAttribute "dPanel" "1"
							toolbarElement.SetAttribute "tabbed" "0"
							toolbarElement.SetAttribute "curTab" "-1"
							toolbarElement.SetAttribute "cType" "1"
							toolbarElement.SetAttribute "toolbarRows" "1"
							toolbarElement.SetAttribute "toolbarType" "3"
							CUIWindowsElement.AppendChild toolbarElement
							local counter = 1
							for curAttributeName in posAttributeNames do
							(
								local newElement = XmlDoc.CreateElement curAttributeName
								local curAttributeValues = posAttributeValues[counter]
								newElement.SetAttribute "left" curAttributeValues[1]
								newElement.SetAttribute "top" curAttributeValues[2]
								newElement.SetAttribute "right" curAttributeValues[3]
								newElement.SetAttribute "bottom" curAttributeValues[4]
								if curAttributeValues.count > 4 do
								(
									newElement.SetAttribute "floating" curAttributeValues[5]
									newElement.SetAttribute "panelID" curAttributeValues[6]
								)
								toolbarElement.AppendChild newElement
								counter += 1
							)
							toolbarElement.AppendChild (XmlDoc.CreateElement "Items")
							changed = true
						)
					)
					local itemsElement = docElement.SelectSingleNode \
						"//ADSK_CUI//CUIWindows//Window[@name='CaptainD']//Items"
					if itemsElement != undefined do
					(
						local ToolbarItemsToAdd = #()

						for i=this.btnItem.count to 1 by -1 do
						(
							append ToolbarItemsToAdd this.btnItem[i]
						)

						for curItem in ToolbarItemsToAdd do
						(
							local actionTableID = curItem[1]
							local actionId = curItem[2]
							if((docElement.SelectSingleNode \
								("//ADSK_CUI//CUIWindows//Window[@name='CaptainD']//" + \
									"Items/Item[@actionTableID='" + actionTableID + \
									"' and @actionID='" + actionId + "']")) == undefined)do
							(
								local newElement = XmlDoc.CreateElement "Item"
								newElement.SetAttribute "typeID" "2"
								newElement.SetAttribute "type" "CTB_MACROBUTTON"
								newElement.SetAttribute  "width" "0"
								newElement.SetAttribute "height" "0"
								newElement.SetAttribute "controlID" "0"
								newElement.SetAttribute "macroTypeID" "3"
								newElement.SetAttribute "macroType" "MB_TYPE_ACTION"
								newElement.SetAttribute "actionTableID" actionTableID
								newElement.SetAttribute "imageID" "-1"
								newElement.SetAttribute "imageName" ""
								newElement.SetAttribute "actionID" actionId
								newElement.SetAttribute "tip" curItem[3]
								newElement.SetAttribute "label" curItem[4]
								itemsElement.PrependChild  newElement
								changed = true
							)
						)
					)
					if(changed)then
					(
						XmlDoc.save cuiFile
						cui.loadConfig cuiFile
					)
				)else
				(
					messageBox "Can't create M3 Import ToolBar Item! Please add it manually."
				)
			)else
			(
				messageBox "Can't create M3 Import ToolBar Item! Please add it manually."
			)
		)
	),
	
	fn removeToolBar =
	(
		local cuiFile = cui.getConfigFile()
		--local changed = false
		if(toLower (getFilenameType cuiFile) == ".cui")then
		(
			if (hasINISetting cuiFile #CUIData #WindowCount) and (hasINISetting cuiFile #CUIWindows)do
			(
				local itemsCount = (getINISetting cuiFile #CUIData #WindowCount) as integer
				local allWindows = #()
				for n in 1 to itemsCount do
				(
					local pad_num = "000"+((n - 1)as string)
					local curItem = "F" + (substring pad_num (pad_num.count-2) -1)
					local curWindow = getINISetting cuiFile #CUIWindows curItem
					if toLower ((filterstring curWindow ":")[2]) != toLower "CaptainD" do
					(
						append allWindows curWindow
					)
				)
				local allWindowsCount = allWindows.count
				if itemsCount != allWindowsCount do
				(
					setINISetting cuiFile #CUIData #WindowCount (allWindowsCount as string)
					for n in 1 to itemsCount do
					(
						local pad_num = "000"+((n - 1)as string)
						local curItem = "F" + (substring pad_num (pad_num.count-2) -1)
						if n <= allWindowsCount then
						(
							setINISetting cuiFile #CUIWindows curItem allWindows[n]
						)
						else
						(
							delIniSetting cuiFile #CUIWindows curItem
						)
					)
					--changed = true
				)
			)
			if hasINISetting cuiFile #CaptainD do(delIniSetting cuiFile #CaptainD)
			--if(changed)then(cui.loadConfig cuiFile)
		)else
		(
			if(doesFileExist cuiFile)then
			(
				local XmlDoc = dotNetObject "system.xml.xmlDocument"
				XmlDoc.load cuiFile
				local docElement = try(XmlDoc.documentElement) catch(undefined)
				if(docElement != undefined)then
				(
					local CUIWindowsElement = docElement.SelectSingleNode "//ADSK_CUI//CUIWindows"
					if CUIWindowsElement != undefined then
					(
						local toolbarElement = docElement.SelectSingleNode \
							"//ADSK_CUI//CUIWindows//Window[@name='CaptainD']"
						if toolbarElement != undefined do
						(
							local toolbarItemsToRemove = #()

							for i=1 to this.btnItem.count do
							(
								append toolbarItemsToRemove this.btnItem[i]
							)

							local itemsElement = docElement.SelectSingleNode \
								"//ADSK_CUI//CUIWindows//Window[@name='CaptainD']//Items"
							if itemsElement != undefined do
							(
								for curItem in toolbarItemsToRemove do
								(
									local actionTableID = curItem[1]
									local actionId = curItem[2]
									local curItemToRemove = docElement.SelectSingleNode \
										("//ADSK_CUI//CUIWindows//Window[@name='CaptainD']//" + \
											"Items//Item[@actionTableID='" + actionTableID + \
											"' and @actionID='" + actionId + "']")
									if curItemToRemove != undefined do
									(
										itemsElement.RemoveChild curItemToRemove
									)
								)
								if not (itemsElement.HasChildNodes) do
								(
									CUIWindowsElement.RemoveChild toolbarElement
								)
							)
							--changed = true
						)
					)
					XmlDoc.save cuiFile
					--if(changed)then(cui.loadConfig cuiFile)
				)
			)
		)
	),

	fn accessMiscSettings type_FP =
	(
		M3F_AccessINI #setting this.Language type_FP
	),

	fn accessImportUIsettings type_FP =
	(
		M3F_AccessINI #setting this.posUI type_FP
		M3F_AccessINI #setting this.heightUI type_FP
		M3F_AccessINI #setting this.showDetails type_FP
		M3F_AccessINI #setting this.missingCheck type_FP
		M3F_AccessINI #setting this.mapPath type_FP
		M3F_AccessINI #setting this.pathSelect type_FP
		M3F_AccessINI #setting this.impTrack type_FP
		M3F_AccessINI #setting this.impSeq type_FP
		M3F_AccessINI #setting this.impAnim type_FP
		M3F_AccessINI #setting this.impEvt type_FP
		M3F_AccessINI #setting this.impTurt type_FP
		M3F_AccessINI #setting this.impBBrd type_FP
		M3F_AccessINI #setting this.impIK type_FP
		M3F_AccessINI #setting this.impMat type_FP
		M3F_AccessINI #setting this.impBone type_FP
		M3F_AccessINI #setting this.impMesh type_FP
		M3F_AccessINI #setting this.impSkin type_FP
		M3F_AccessINI #setting this.impHit type_FP
		M3F_AccessINI #setting this.impVol type_FP
		M3F_AccessINI #setting this.impAttach type_FP
		M3F_AccessINI #setting this.impBound type_FP
		M3F_AccessINI #setting this.impLight type_FP
		M3F_AccessINI #setting this.impCam type_FP
		M3F_AccessINI #setting this.impPart type_FP
		M3F_AccessINI #setting this.impPhy type_FP
		
		M3F_AccessINI #setting this.setGPos type_FP
		M3F_AccessINI #setting this.setGScale type_FP

		M3F_AccessINI #setting this.setFRate type_FP
		M3F_AccessINI #setting this.setFBSeq type_FP
		M3F_AccessINI #setting this.setFCorrect type_FP
		M3F_AccessINI #setting this.setFCheckR type_FP

		M3F_AccessINI #setting this.setWeldSmooth type_FP
		M3F_AccessINI #setting this.setSmoothType type_FP
		M3F_AccessINI #setting this.setSmoothAngle type_FP
		
		M3F_AccessINI #setting this.setBEntity type_FP
		M3F_AccessINI #setting this.setBSize1 type_FP
		M3F_AccessINI #setting this.setBSize2 type_FP
		M3F_AccessINI #setting this.setBSize3 type_FP
		M3F_AccessINI #setting this.setBAnim type_FP
		M3F_AccessINI #setting this.setBLink type_FP
		M3F_AccessINI #setting this.setBFix type_FP
		M3F_AccessINI #setting this.setBPosCtl type_FP
		M3F_AccessINI #setting this.setBRotCtl type_FP
		M3F_AccessINI #setting this.setBScaleCtl type_FP

		M3F_AccessINI #setting this.setAttSize type_FP
		M3F_AccessINI #setting this.setAttScale type_FP
		M3F_AccessINI #setting this.setBoundColl type_FP
		M3F_AccessINI #setting this.setAttColl type_FP
		M3F_AccessINI #setting this.setVolColl type_FP
		M3F_AccessINI #setting this.setHitColl type_FP
		
		M3F_AccessINI #setting this.setLTrans type_FP
		M3F_AccessINI #setting this.setLPar type_FP
		M3F_AccessINI #setting this.setCTrans type_FP
		M3F_AccessINI #setting this.setCPar type_FP
		M3F_AccessINI #setting this.setPTrans type_FP
		M3F_AccessINI #setting this.setPPar type_FP
	),

	fn defaultImportUIsettings =
	(
		this.showDetails.value = true
		this.missingCheck.value = true
		this.mapPath.value = ""
		this.pathSelect.value = 2
		this.impTrack.value = true
		this.impSeq.value = true
		this.impAnim.value = true
		this.impEvt.value = true
		this.impTurt.value = true
		this.impBBrd.value = true
		this.impIK.value = true
		this.impMat.value = true
		this.impBone.value = true
		this.impMesh.value = true
		this.impSkin.value = true
		this.impHit.value = true
		this.impVol.value = true
		this.impAttach.value = true
		this.impBound.value = true
		this.impLight.value = true
		this.impCam.value = true
		this.impPart.value = true
		this.impPhy.value = true

		this.setGPos.value = [0,0,0]
		this.setGScale.value = 1.0

		this.setFRate.value = 30
		this.setFBSeq.value = 40
		this.setFCorrect.value = 30.0
		this.setFCheckR.value = 1
		this.setWeldSmooth.value = 1
		this.setSmoothType.value = 2
		this.setSmoothAngle.value = 45.0
		this.setBEntity.value = 1
		this.setBSize1.value = 2.0
		this.setBSize2.value = 5.0
		this.setBSize3.value = 1.0
		this.setBAnim.value = true
		this.setBLink.value = false
		this.setBFix.value = false
		this.setBPosCtl.value = 1
		this.setBRotCtl.value = 1
		this.setBScaleCtl.value = 2
		this.setAttSize.value = 5
		this.setAttScale.value = false
		this.setBoundColl.value = true
		this.setAttColl.value = false
		this.setVolColl.value = true
		this.setHitColl.value = true
		this.setLTrans.value = true
		this.setLPar.value = true
		this.setCTrans.value = true
		this.setCPar.value = true
		this.setPTrans.value = true
		this.setPPar.value = true
	),

	on create do
	(
		M3F_CheckStarTools #Init
		this.accessMiscSettings #load
		local assembly = dotnet.loadAssembly @"$Temp\M3Import_mzp\ExtractFile_M3Lib.dll"
		this.ExtractFileLib = dotNetObject (assembly.GetExportedTypes())[1].FullName
		if(heapSize < 150000000)then
		(
			heapSize = 150000000
		)
	)
)
M3G_ImportInfo_Glb = M3S_ImportInfo()

---------------------------------------------------------------------------
--include Files------------------------------------------------------------
---------------------------------------------------------------------------
include "M3 Import DotNetHelper.ms"
include "M3 Import M3DataStruct.ms"
include "M3 Import MiscUtil.ms"
---------------------------------------------------------------------------
---------------------------------------------------------------------------
M3G_ImportInfo_Glb.removeToolBar()
M3G_ImportInfo_Glb.checkToolBarExist()
callbacks.addScript #postSystemStartup "M3G_ImportInfo_Glb.checkToolBarExist()" id:#M3ImportStartUp
callbacks.addScript #preSystemShutdown "M3G_ImportInfo_Glb.removeToolBar()" id:#M3ImportShutDown

---------------------------------------------------------------------------
---------------------------------------------------------------------------
--------------------UI Code------------------------------------------------
---------------------------------------------------------------------------
---------------------------------------------------------------------------



struct M3S_DetailsForm
(
	parentHwnd, mainForm, showed = false, showLogCheck = false, stepCnt = 0, warningCnt = 0, errorCnt = 0,
	lastErrorLabel, progressCtl, cancelBtn, showLogBtn, warningsLabel, errorsLabel, logsList,
	posUI 			= M3S_INIdata "DetailsForm" 		"posUI" 			[500, 100],
	widthUI			= M3S_INIdata "DetailsForm" 		"widthUI" 			800,
	heightUI		= M3S_INIdata "DetailsForm" 		"heightUI" 			240,

	fn accessSettings type_FP =
	(
		M3F_AccessINI #setting this.posUI type_FP
		M3F_AccessINI #setting this.widthUI type_FP
		M3F_AccessINI #setting this.heightUI type_FP
	),

	fn cancelEnabled state_FP =
	(
		try(this.cancelBtn.Enabled = state_FP)catch()
	),

	fn updateCount =
	(
		try
		(
			this.warningsLabel.Text = "Warnings:" + (this.warningCnt as string)
			this.errorsLabel.Text = "Errors:" + (this.errorCnt as string)
		)catch()
	),

	fn setProgress val_FP =
	(
		local progress_value = if(val_FP > 100)then(100)else if(val_FP < 0)then(0)else(val_FP)
		try(this.progressCtl.Value = progress_value)catch()
	),

	fn setLogInfo info_FP type: =
	(
		if(M3G_ImportInfo_Glb.showDetails.value != true)then
		(
			case type of
			(
				#Warning:
				(
					this.warningCnt += 1
					try(this.lastErrorLabel.Text = info_FP)catch()
					this.updateCount()
				)
				#Error:
				(
					this.errorCnt += 1
					try(this.lastErrorLabel.Text = info_FP)catch()
					this.updateCount()
				)
				#Finished:
				(
					try(if(this.lastErrorLabel.Text == "")then(this.lastErrorLabel.Text = info_FP))catch()
				)
			)
			return false
		)

		local netClass = M3S_DotNetClass()
		local add_item = netClass.createCtl #ListViewItem
		if(type != unsupplied)then
		(
			add_item.Text = this.stepCnt as string
			this.stepCnt += 1
		)

		case type of
		(
			#Info:
			(
				add_item.ImageIndex = 0
				add_item.SubItems.Add "Info"
			)
			#Warning:
			(
				add_item.ImageIndex = 1
				add_item.SubItems.Add "Warning"
				this.warningCnt += 1
				try(this.lastErrorLabel.Text = info_FP)catch()
			)
			#Error:
			(
				add_item.ImageIndex = 2
				add_item.SubItems.Add "Error"
				this.errorCnt += 1
				try(this.lastErrorLabel.Text = info_FP)catch()
			)
			#Finished:
			(
				add_item.ImageIndex = 0
				add_item.SubItems.Add "Info"
				try(if(this.lastErrorLabel.Text == "")then(this.lastErrorLabel.Text = info_FP))catch()
			)
			default: add_item.SubItems.Add ""
		)
		add_item.SubItems.Add info_FP
		this.updateCount()
		try
		(
			this.logsList.Items.Add add_item
			this.logsList.Items.Item[this.logsList.Items.Count-1].EnsureVisible()
		)catch()
	),

	fn clearLogInfo =
	(
		this.stepCnt = 0
		this.warningCnt = 0
		this.errorCnt = 0
		this.updateCount()
		try
		(
			this.logsList.Items.Clear()
			this.progressCtl.Value = 0
			this.lastErrorLabel.Text = ""
		)catch()
	),

	fn showUI =
	(
		if(this.showed == false)then
		(
			local netClass = M3S_DotNetClass()
			this.accessSettings #load
			if(this.mainForm.IsDisposed)then(this.createUI())
			this.mainForm.Size = netClass.createObject #Size d1:this.widthUI.value d2:this.heightUI.value
			this.showed = true
			this.mainForm.Show this.parentHwnd
			this.mainForm.Location = netClass.createObject #Point d1:this.posUI.value[1] d2:this.posUI.value[2]
		)else
		(
			this.mainForm.topMost = true
			this.mainForm.topMost = false
		)
	),

	fn hideUI =
	(
		try(M3G_ImportInfo_Glb.MainUI.Import_subRoll.rollouts[1].Show_Details_Btn.state = false)catch()
		this.posUI.value = [this.mainForm.Location.X, this.mainForm.Location.Y]
		this.widthUI.value = this.mainForm.Width
		this.heightUI.value = this.mainForm.Height
		this.accessSettings #save
		this.showed = false
		this.mainForm.Hide()
	),

	fn cancelClickEvent sender_FP e_FP =
	(
		M3G_ImportInfo_Glb.cancelCheck = true
	),

	fn showLogEvent sender_FP e_FP =
	(
		if(sender_FP.Tag.Value.showLogCheck)then(return true)
		sender_FP.Tag.Value.showLogCheck = true
		local netClass = M3S_DotNetClass()
		if(sender_FP.Checked == true)then
		(
			sender_FP.Tag.Value.mainForm.Size = \
				netClass.createObject #Size d1:sender_FP.Tag.Value.mainForm.Size.Width d2:500
		)else
		(
			sender_FP.Tag.Value.mainForm.Size = \
				netClass.createObject #Size d1:sender_FP.Tag.Value.mainForm.Size.Width d2:151
		)
		sender_FP.Tag.Value.showLogCheck = false
	),

	fn sizeChangedEvent sender_FP e_FP =
	(
		sender_FP.Tag.Value.logsList.Columns.Item[2].Width = sender_FP.Size.Width - 152
	),

	fn sizeChangedEndEvent sender_FP e_FP =
	(
		if(sender_FP.Tag.Value.showLogCheck)then(return true)
		sender_FP.Tag.Value.showLogCheck = true
		if(sender_FP.Size.Height == 151)then
		(
			sender_FP.Tag.Value.showLogBtn.Checked = false
		)else
		(
			sender_FP.Tag.Value.showLogBtn.Checked = true
		)
		sender_FP.Tag.Value.showLogCheck = false
	),

	fn closeUIevent sender_FP e_FP =
	(
		e_FP.Cancel = true
		sender_FP.Tag.Value.hideUI()
	),

	fn columnWidthChangingEvent sender_FP e_FP =
	(
		e_FP.Cancel = true
		e_FP.NewWidth = sender_FP.Columns.Item[e_FP.ColumnIndex].Width
	),

	fn createUI =
	(
		local netClass = M3S_DotNetClass()
		local icon_path = \
		#(
			(symbolicPaths.expandFileName @"$Temp\M3Import_mzp\Icons\Info.png"),
			(symbolicPaths.expandFileName @"$Temp\M3Import_mzp\Icons\Warning.png"),
			(symbolicPaths.expandFileName @"$Temp\M3Import_mzp\Icons\Error.png")
		)
		local form_icon_path = symbolicPaths.expandFileName @"$Temp\M3Import_mzp\Icons\max.ico"
		this.parentHwnd = netClass.createObject #Handle d1:(windows.getMAXHWND())
		-----------------------------------------------------------------------------------------
		this.mainForm = netClass.createCtl #Form w:800 h:240 t:"Importer Details Output"
		this.mainForm.Icon = netClass.createObject #Icon d1:form_icon_path d2:16
		this.mainForm.MinimumSize = netClass.createObject #Size d1:400 d2:151
		this.mainForm.Font = netClass.createObject #Font
		this.mainForm.ShowInTaskbar = false
		this.mainForm.Tag = dotNetMXSValue this
		dotnet.addeventhandler this.mainForm "Resize" sizeChangedEvent
		dotnet.addeventhandler this.mainForm "ResizeEnd" sizeChangedEndEvent
		dotnet.addeventhandler this.mainForm "FormClosing" closeUIevent
		-----------------------------------------------------------------------------------------
		this.lastErrorLabel = netClass.createCtl #Label x:10 y:6 w:700 h:16 t:""
		this.mainForm.Controls.Add this.lastErrorLabel
		this.progressCtl = netClass.createCtl #ProgressBar a:#Anchor v:"Left, Right, Top" x:10 y:35 w:672 h:20
		this.mainForm.Controls.Add this.progressCtl
		-----------------------------------------------------------------------------------------
		this.cancelBtn = netClass.createCtl #Button a:#Anchor v:"Right, Top" \
			x:690 y:35 w:78 h:28 t:"Cancel"
		this.cancelBtn.Enabled = false
		this.mainForm.Controls.Add this.cancelBtn
		dotnet.addeventhandler this.cancelBtn "Click" cancelClickEvent

		this.showLogBtn = netClass.createCtl #CheckBox a:#Anchor v:"Right, Top" \
			x:690 y:64 w:78 h:28 t:"Show Logs" ta:#MiddleCenter
		this.showLogBtn.Appearance = (netClass.getClass #Appearance).Button
		this.showLogBtn.Tag = dotNetMXSValue this
		this.mainForm.Controls.Add this.showLogBtn
		dotnet.addeventhandler this.showLogBtn "CheckedChanged" showLogEvent
		-----------------------------------------------------------------------------------------
		this.warningsLabel = netClass.createCtl #Label x:10 y:64 w:100 h:16 t:"Warnings:0"
		this.mainForm.Controls.Add this.warningsLabel
		this.errorsLabel = netClass.createCtl #Label x:110 y:64 w:100 h:16 t:"Errors:0"
		this.mainForm.Controls.Add this.errorsLabel
		-----------------------------------------------------------------------------------------
		this.logsList = netClass.createCtl #ListView a:#Anchor v:"Left, Right, Top, Bottom" x:0 y:112 w:784 h:108
		this.logsList.View = (netClass.getClass #View).Details
		this.logsList.AllowColumnReorder = false
		this.logsList.FullRowSelect = true
		this.logsList.HeaderStyle = (netClass.getClass #ColumnHeaderStyle).Nonclickable

		local image_list_small = netClass.createImageList #Image icon_path
		local image_list_large = netClass.createImageList #Image icon_path
		this.logsList.SmallImageList = image_list_small
		this.logsList.LargeImageList = image_list_large

		this.logsList.Columns.Add "Steps" 60
		this.logsList.Columns.Add "Type" 72
		this.logsList.Columns.Add "Message" 668

		this.mainForm.Controls.Add this.logsList
		dotnet.addeventhandler this.logsList "ColumnWidthChanging" columnWidthChangingEvent
	),

	on create do
	(
		this.createUI()
	)
)
M3G_ImportInfo_Glb.DetailsUI = M3S_DetailsForm()

rollout M3P_About_UI "About" width:450 height:240
(
	label lbl1 "Thanks" pos:[32,32] width:450 height:408

	on M3P_About_UI open do
	(
		lbl1.text = "Big thanks to :\n" + \
			"    Taylormouse,      (The M3 file's data structure is based on his script.)\n" + \
			"    Delphinium(Frog), (My first 3dsMax's teacher.)\n" + \
			"    一叶尽书繁华,      (He helped build the DLL libraries for Textures Fix Tool,\n" + \
			"                       and helped me tested the script.)\n" + \
			"    werd,             (Helped me tested the script.)\n" + \
			"\n" + \
			"Scripted by CaptainD,Thank you for using it!"
	)
	on M3P_About_UI close do
	(

	)
)

rollout M3P_Missing_Map "Missing TextureMaps!" width:528 height:440
(
	label lbl1 "Following textures are MISSING !!!" pos:[32,32] width:464 height:408

	on M3P_Missing_Map open do
	(
		local text_show = ""

		for i=1 to M3G_ImportInfo_Glb.missingMap.count do
		(
			append text_show (M3G_ImportInfo_Glb.missingMap[i] + ",\n")
		)
		lbl1.text = lbl1.text + "\n" + text_show + \
		"Please put the textures in 3dsmax's textures path or \"(your model file path)/Assets/Textures\""
	)

	on M3P_Missing_Map close do
	(
		lbl1.text = "Following textures are MISSING !!!"
	)
)

rollout M3P_Import_UI "Import Settings" width:200 height:504
(
	groupBox Import_Grp "Import" pos:[8,8] width:184 height:272
	editText Import_Path "" pos:[16,23] width:168 height:17 ReadOnly:true labelOnTop:true
	label File_Name "None" pos:[44,48] width:140 height:17
	button Select_File_Btn "Select File ..." pos:[24,72] width:152 height:32
	button Import_Btn "Import" pos:[24,112] width:152 height:32
	progressBar ProgressLv "" pos:[16,152] width:168 height:10 color:(color 32 168 0)
	label Progress_text "" pos:[52,164] width:132 height:17
	checkbox Show_Details_Check "" pos:[24,184] width:16 height:16
	checkbox Miss_Texture_Check "" pos:[24,200] width:16 height:16 checked:true
	checkButton Show_Details_Btn "Info" pos:[152,184] width:32 height:32
	editText Map_Path "" pos:[16,224] width:168 height:17 ReadOnly:true labelOnTop:true
	dropDownList Map_Source "" pos:[16,248] width:104 height:22 \
		items:#("(m3Path)", "\\Texutures", "\\Assets\\Textures", "User Select") selection:2
	button Select_MapPath_Btn "Select" pos:[128,248] width:56 height:24

	checkbox Anim_Track_Check "" pos:[16,288] width:16 height:16 checked:true
	checkbox Anim_Seq_Check "" pos:[16,304] width:16 height:16 checked:true
	checkbox Anim_Check "" pos:[16,320] width:16 height:16 checked:true
	checkbox Events_Check "" pos:[16,344] width:16 height:16 checked:true
	checkbox Turret_Check "" pos:[96,344] width:16 height:16 checked:true
	checkbox BBoard_Check "" pos:[16,360] width:16 height:16 checked:true
	checkbox IK_Check "" pos:[96,360] width:16 height:16 checked:true
	checkbox Materials_Check "" pos:[16,384] width:16 height:16 checked:true
	checkbox Bones_Check "" pos:[96,384] width:16 height:16 checked:true
	checkbox Meshes_Check "" pos:[16,400] width:16 height:16 checked:true
	checkbox Skin_Check "" pos:[96,400] width:16 height:16 checked:true
	checkbox Hit_Tests_Check "" pos:[16,424] width:16 height:16 checked:true
	checkbox Vol_Targets_Check "" pos:[96,424] width:16 height:16 checked:true
	checkbox Attachments_Check "" pos:[16,440] width:16 height:16 checked:true
	checkbox Bounds_Check "" pos:[96,440] width:16 height:16 checked:true
	checkbox Lights_Check "" pos:[16,464] width:16 height:16 checked:true
	checkbox Cameras_Check "" pos:[96,464] width:16 height:16 enabled:true checked:true
	checkbox Particles_Check "" pos:[16,480] width:16 height:16 checked:true
	checkbox Physics_Check "" pos:[96,480] width:16 height:16 checked:true
	
	label Import_Lbl_1 "File:" pos:[16,48] width:28 height:16
	label Import_Lbl_2 "Phase:" pos:[16,164] width:32 height:16
	label Import_Lbl_3 "Show Details Info" pos:[40,184] width:112 height:16
	label Import_Lbl_4 "Missing Textures Info" pos:[40,200] width:112 height:16
	label Import_Lbl_5 "Anim TrackSet" pos:[32,288] width:152 height:16
	label Import_Lbl_6 "Anim Sequences" pos:[32,304] width:152 height:16
	label Import_Lbl_7 "Animations" pos:[32,320] width:152 height:16
	label Import_Lbl_8 "Events" pos:[32,344] width:64 height:16
	label Import_Lbl_9 "Turrets" pos:[112,344] width:72 height:16
	label Import_Lbl_10 "Billboards" pos:[32,360] width:64 height:16
	label Import_Lbl_11 "IK Legs" pos:[112,360] width:72 height:16
	label Import_Lbl_12 "Materials" pos:[32,384] width:64 height:16
	label Import_Lbl_13 "Bones" pos:[112,384] width:72 height:16
	label Import_Lbl_14 "Meshes" pos:[32,400] width:64 height:16
	label Import_Lbl_15 "Skin" pos:[112,400] width:72 height:16
	label Import_Lbl_16 "Hit Tests" pos:[32,424] width:64 height:16
	label Import_Lbl_17 "Volume Targets" pos:[112,424] width:72 height:16
	label Import_Lbl_18 "Attachments" pos:[32,440] width:64 height:16
	label Import_Lbl_19 "Bounds" pos:[112,440] width:72 height:16
	label Import_Lbl_20 "Lights" pos:[32,464] width:64 height:16
	label Import_Lbl_21 "Cameras" pos:[112,464] width:72 height:16
	label Import_Lbl_22 "Particles" pos:[32,480] width:64 height:16
	label Import_Lbl_23 "Physics Sys" pos:[112,480] width:72 height:16

	fn TranslateLanguage =
	(
		local language = copy M3G_ImportInfo_Glb.Language.value

		Import_Grp.text =		M3F_ReadLanguage language "Import"				"Import"
		Select_File_Btn.text = 	M3F_ReadLanguage language "Select_Btn"			"Select File ..."
		Import_Btn.text = 		M3F_ReadLanguage language "Import_Btn"			"Import"

		Import_Lbl_1.text = 	M3F_ReadLanguage language "File"				"File:"
		Import_Lbl_2.text = 	M3F_ReadLanguage language "Phase"				"Phase:"
		Import_Lbl_3.text = 	M3F_ReadLanguage language "ShowDetailsInfo"		"Show Details Info"
		Import_Lbl_4.text = 	M3F_ReadLanguage language "MissingTexturesInfo"	"Missing Textures Info"
		Show_Details_Btn.text = M3F_ReadLanguage language "ShowDetails_Btn"		"Info"
		Select_MapPath_Btn.text = M3F_ReadLanguage language "Select_MapPath_Btn" "PathSelect"

		Import_Lbl_5.text = 	M3F_ReadLanguage language "AnimTrackSetEnable"	"Anim TrackSet"
		Import_Lbl_6.text = 	M3F_ReadLanguage language "AnimSequencesEnable"	"Anim Sequences"
		Import_Lbl_7.text = 	M3F_ReadLanguage language "AnimationsEnable"	"Animations"

		Import_Lbl_8.text = 	M3F_ReadLanguage language "EventsEnable"		"Events"
		Import_Lbl_9.text = 	M3F_ReadLanguage language "TurretsEnable"		"Turrets"
		Import_Lbl_10.text = 	M3F_ReadLanguage language "BillboardsEnable"	"Billboards"
		Import_Lbl_11.text = 	M3F_ReadLanguage language "IKLegsEnable"		"IK Legs"

		Import_Lbl_12.text = 	M3F_ReadLanguage language "MaterialsEnable"		"Materials"
		Import_Lbl_13.text = 	M3F_ReadLanguage language "BonesEnable"			"Bones"
		Import_Lbl_14.text = 	M3F_ReadLanguage language "MeshesEnable"		"Meshes"
		Import_Lbl_15.text = 	M3F_ReadLanguage language "SkinEnable"			"Skin"

		Import_Lbl_16.text = 	M3F_ReadLanguage language "HitTestsEnable"		"Hit Tests"
		Import_Lbl_17.text = 	M3F_ReadLanguage language "VolumeTargetsEnable"	"Volume Targets"
		Import_Lbl_18.text = 	M3F_ReadLanguage language "AttachmentsEnable"	"Attachments"
		Import_Lbl_19.text = 	M3F_ReadLanguage language "BonudsEnable"		"Bounds"

		Import_Lbl_20.text = 	M3F_ReadLanguage language "LightsEnable"		"Lights"
		Import_Lbl_21.text = 	M3F_ReadLanguage language "CamerasEnable"		"Cameras"
		Import_Lbl_22.text = 	M3F_ReadLanguage language "ParticlesEnable"		"Particles"
		Import_Lbl_23.text = 	M3F_ReadLanguage language "PhysicsEnable"		"Physics Sys"
	)

	fn FillProgressLv value_FP =
	(
		ProgressLv.value = (value_FP as integer)
		M3G_ImportInfo_Glb.DetailsUI.setProgress value_FP
	)

	fn ChangePhaseText str_FP =
	(
		Progress_text.Text = str_FP
	)

	fn MapPathCheck =
	(
		case Map_Source.selection of
		(
			1:(Select_MapPath_Btn.enabled = false; Map_Path.enabled = false)
			2:(Select_MapPath_Btn.enabled = false; Map_Path.enabled = false)
			3:(Select_MapPath_Btn.enabled = false; Map_Path.enabled = false)
			4:(Select_MapPath_Btn.enabled = true; Map_Path.enabled = true)
		)
	)

	fn UpdateUI =
	(
		File_Name.text = M3G_ImportInfo_Glb.lastFileName
		Import_Path.text = M3G_ImportInfo_Glb.lastPath

		Show_Details_Check.state = M3G_ImportInfo_Glb.showDetails.value
		Miss_Texture_Check.state = M3G_ImportInfo_Glb.missingCheck.value
		Map_Path.text = M3G_ImportInfo_Glb.mapPath.value
		Map_Source.selection = M3G_ImportInfo_Glb.pathSelect.value
		
		Anim_Track_Check.state = M3G_ImportInfo_Glb.impTrack.value
		Anim_Seq_Check.state = M3G_ImportInfo_Glb.impSeq.value
		Anim_Check.state = M3G_ImportInfo_Glb.impAnim.value

		Events_Check.state = M3G_ImportInfo_Glb.impEvt.value
		Turret_Check.state = M3G_ImportInfo_Glb.impTurt.value
		BBoard_Check.state = M3G_ImportInfo_Glb.impBBrd.value
		IK_Check.state = M3G_ImportInfo_Glb.impIK.value

		Materials_Check.state = M3G_ImportInfo_Glb.impMat.value
		Bones_Check.state = M3G_ImportInfo_Glb.impBone.value
		Meshes_Check.state = M3G_ImportInfo_Glb.impMesh.value
		Skin_Check.state = M3G_ImportInfo_Glb.impSkin.value

		Hit_Tests_Check.state = M3G_ImportInfo_Glb.impHit.value
		Vol_Targets_Check.state = M3G_ImportInfo_Glb.impVol.value
		Attachments_Check.state = M3G_ImportInfo_Glb.impAttach.value
		Bounds_Check.state = M3G_ImportInfo_Glb.impBound.value

		Lights_Check.state = M3G_ImportInfo_Glb.impLight.value
		Cameras_Check.state = M3G_ImportInfo_Glb.impCam.value
		Particles_Check.state = M3G_ImportInfo_Glb.impPart.value
		Physics_Check.state = M3G_ImportInfo_Glb.impPhy.value

		MapPathCheck()
	)

	on M3P_Import_UI open do
	(
		FillProgressLv 0.0
		TranslateLanguage()
		if(M3G_ImportInfo_Glb.DetailsUI.showed)then
		(
			Show_Details_Btn.state = true
		)
		else
		(
			Show_Details_Btn.state = false
		)
	)
	on M3P_Import_UI close do
	(
		
	)

	on Select_File_Btn pressed do
	(
		local file = getOpenFileName \
		caption:"StarCraftII M3 File" \
		types:("Supported Files|*.m3;*.m3a" + \
		"|Starcraft 2 & Heroes of the Storm(*.m3)|*.m3" + \
		"|Animation Files(*.m3a)|*.m3a" + \
		"|All Files|*.*") \
		historyCategory:"Star2PresetFolder"

		if(file != undefined)then
		(
			local f_name = filterString file "\\"
			M3G_ImportInfo_Glb.lastFileName = copy f_name[f_name.count]
			File_Name.Text = f_name[f_name.count]

			local path_str = substituteString file f_name[f_name.count] ""
			M3G_ImportInfo_Glb.lastPath = substring path_str 1 (path_str.count-1)
			Import_Path.Text = M3G_ImportInfo_Glb.lastPath

			FillProgressLv 0.0
			ChangePhaseText ""
		)
	)

	on Import_Btn pressed do
	(
		setWaitCursor()
		try(GC())catch()
		local import_file = Import_Path.Text + "\\" + File_Name.Text
		if(import_file != undefined and (DoesFileExist import_file))then
		(
			ClearListener()
			local delete_path = false
			case M3G_ImportInfo_Glb.pathSelect.value of
			(
				1:(mapPaths.add M3G_ImportInfo_Glb.lastPath; delete_path = true)
				2:(mapPaths.add (M3G_ImportInfo_Glb.lastPath + "\\Textures"); delete_path = true)
				3:(mapPaths.add (M3G_ImportInfo_Glb.lastPath + "\\Assets\\Textures"); delete_path = true)
				4:
				(
					if(M3G_ImportInfo_Glb.mapPath.value.count > 0)then
					(mapPaths.add M3G_ImportInfo_Glb.mapPath.value; delete_path = true)
				)
			)
			
			M3G_ImportInfo_Glb.missingMap = #()
			M3G_ImportInfo_Glb.DetailsUI.clearLogInfo()
			M3G_ImportInfo_Glb.DetailsUI.cancelEnabled true
			M3G_ImportInfo_Glb.cancelCheck = false
			if(M3G_ImportInfo_Glb.showDetails.value)then
			(
				M3G_ImportInfo_Glb.DetailsUI.showUI()
				Show_Details_Btn.state = true
			)
			FillProgressLv 0.0
			local start_time = timeStamp()
			ChangePhaseText "Start Import..."
			M3G_ImportInfo_Glb.DetailsUI.setLogInfo \
				(M3F_FormatToString "*****    Start Import ...    File:%    *****" #(import_file)) \
				type:#Info

			with redraw off(undo off(M3F_ImportMain import_file))

			FillProgressLv 100.0
			start_time = (timeStamp() - start_time) / 1000
			local min_time = (start_time / 60) as integer
			local sec_time = (mod start_time  60) as integer
			local min_text = if(min_time != 0)then((min_time as string) + "min")else("")
			local time_text = min_text + (sec_time as string) + "s"
			ChangePhaseText "DONE!"
			M3G_ImportInfo_Glb.DetailsUI.setLogInfo ("*****    DONE! Completed in "+time_text+"    *****") \
				type:#Finished
			PRINT "DONE"
			clearSelection()
			RedrawViews()
			max zoomext sel all
			if(delete_path)then
			(
				local path_count = mapPaths.count()
				try(mapPaths.delete path_count)catch()
			)

			if(M3G_ImportInfo_Glb.missingCheck.value != false)then
			(
				if(M3G_ImportInfo_Glb.missingMap.count != 0)then
				(
					sort M3G_ImportInfo_Glb.missingMap
					createDialog M3P_Missing_Map \
					style:#(#style_titlebar, #style_sysmenu, #style_minimizebox, #style_resizing) \
					lockHeight:false lockWidth:true
				)
			)
			M3G_ImportInfo_Glb.cancelCheck = false
			M3G_ImportInfo_Glb.DetailsUI.cancelEnabled false
		)
		try(GC())catch()
    	enableSceneRedraw()
		setArrowCursor()
	)
	--------------------------------------------------------------------
	on Show_Details_Check changed state do
	(
		M3G_ImportInfo_Glb.showDetails.value = state
	)
	on Miss_Texture_Check changed state do
	(
		M3G_ImportInfo_Glb.missingCheck.value = state
	)
	on Show_Details_Btn changed state do
	(
		if(state)then(M3G_ImportInfo_Glb.DetailsUI.showUI())else(M3G_ImportInfo_Glb.DetailsUI.hideUI())
	)
	on Map_Source selected val do
	(
		M3G_ImportInfo_Glb.pathSelect.value = val
		MapPathCheck()
	)
	on Select_MapPath_Btn pressed do
	(
		local save_path = getSaveFileName \
				caption:"Select a path" \
				filename:".searchPath" \
				types:"Folder|.searchPath|" \
				historyCategory:"Star2PresetFolder"

		if(save_path != undefined)then
		(
			save_path = getFilenamePath save_path
			M3G_ImportInfo_Glb.mapPath.value = save_path
			Map_Path.text = M3G_ImportInfo_Glb.mapPath.value
		)
	)
	--------------------------------------------------------------------
	on Anim_Track_Check changed state do
	(
		M3G_ImportInfo_Glb.impTrack.value = state
	)
	on Anim_Seq_Check changed state do
	(
		M3G_ImportInfo_Glb.impSeq.value = state
	)
	on Anim_Check changed state do
	(
		M3G_ImportInfo_Glb.impAnim.value = state
	)
	--------------------------------------------------------------------
	on Events_Check changed state do
	(
		M3G_ImportInfo_Glb.impEvt.value = state
	)
	on Turret_Check changed state do
	(
		M3G_ImportInfo_Glb.impTurt.value = state
	)
	on BBoard_Check changed state do
	(
		M3G_ImportInfo_Glb.impBBrd.value = state
	)
	on IK_Check changed state do
	(
		M3G_ImportInfo_Glb.impIK.value = state
	)
	--------------------------------------------------------------------
	on Materials_Check changed state do
	(
		M3G_ImportInfo_Glb.impMat.value = state
	)
	on Bones_Check changed state do
	(
		M3G_ImportInfo_Glb.impBone.value = state
	)
	on Meshes_Check changed state do
	(
		M3G_ImportInfo_Glb.impMesh.value = state
	)
	on Skin_Check changed state do
	(
		M3G_ImportInfo_Glb.impSkin.value = state
	)
	--------------------------------------------------------------------
	on Hit_Tests_Check changed state do
	(
		M3G_ImportInfo_Glb.impHit.value = state
	)
	on Vol_Targets_Check changed state do
	(
		M3G_ImportInfo_Glb.impVol.value = state
	)
	on Attachments_Check changed state do
	(
		M3G_ImportInfo_Glb.impAttach.value = state
	)
	on Bounds_Check changed state do
	(
		M3G_ImportInfo_Glb.impBound.value = state
	)
	--------------------------------------------------------------------
	on Lights_Check changed state do
	(
		M3G_ImportInfo_Glb.impLight.value = state
	)
	on Cameras_Check changed state do
	(
		M3G_ImportInfo_Glb.impCam.value = state
	)
	on Particles_Check changed state do
	(
		M3G_ImportInfo_Glb.impPart.value = state
	)
	on Physics_Check changed state do
	(
		M3G_ImportInfo_Glb.impPhy.value = state
	)
)

rollout M3P_AdvSettings_UI "Advance Settings" width:200 height:912
(
	groupBox grp1 "Global" pos:[8,8] width:184 height:80
	spinner Glb_PosX "" pos:[24,40] width:48 height:16 range:[-10000,10000,0] type:#float scale:0.01
	spinner Glb_PosY "" pos:[80,40] width:48 height:16 range:[-10000,10000,0] type:#float scale:0.01
	spinner Glb_PosZ "" pos:[136,40] width:48 height:16 range:[-10000,10000,0] type:#float scale:0.01
	spinner Glb_Scale "" pos:[119,64] width:64 height:16 range:[0.01,100,1] type:#float scale:0.01
	label Glb_Lbl_1 "Position:" pos:[16,24] width:168 height:16
	label Glb_Lbl_2 "Scale:" pos:[16,64] width:104 height:16

	groupBox grp2 "Animation" pos:[8,96] width:184 height:112
	spinner Anim_Rate "" pos:[120,112] width:64 height:16 range:[10,10000,30] type:#integer scale:1
	spinner Anim_Seq "" pos:[120,136] width:64 height:16 range:[10,10000,40] type:#integer scale:1
	spinner Anim_Correct "" pos:[120,160] width:64 height:16 range:[0,100,30] type:#float scale:0.1
	spinner Anim_CheckR "" pos:[120,184] width:64 height:16 range:[0,100,1] type:#integer scale:1
	label Anim_Lbl_1 "Frame Rate:" pos:[16,112] width:104 height:16
	label Anim_Lbl_2 "FramesBetweenSeq:" pos:[16,136] width:104 height:16
	label Anim_Lbl_3 "Frames Correct:   " pos:[16,160] width:104 height:16
	label Anim_Lbl_4 "FramesCheckRange:" pos:[16,184] width:104 height:16

	groupBox grp3 "Mesh" pos:[8,216] width:184 height:88
	dropDownList Mesh_Option "" pos:[88,232] width:96 height:22 \
		items:#("OriginImport(Slower)", "Weld&&Smooth", "DoNothing(Faster)", "OnlyWeld", "OnlySmooth")
	radioButtons Mesh_Smooth_Type "" pos:[16,264] width:23 height:32 labels:#("", "") default:2 columns:1
	spinner Mesh_Smooth_Angle "" pos:[128,264] width:56 height:16 range:[0,360,45] type:#float scale:0.1
	label Mesh_Lbl_1 "Option:" pos:[16,232] width:72 height:16
	label Mesh_Lbl_2 "Smooth By Angle" pos:[40,264] width:88 height:16
	label Mesh_Lbl_3 "Smooth By UV" pos:[40,280] width:88 height:16
	
	groupBox grp4 "Bone" pos:[8,312] width:184 height:256
	dropDownList Bone_Type "" pos:[88,328] width:96 height:22 \
		items:#("OriginBone", "Dummy", "Box", "Pyramid", "NoneEntity")
	spinner Bone_Size_1 "" pos:[128,360] width:56 height:16 range:[0.1,100,2] type:#float scale:0.1
	spinner Bone_Size_2 "" pos:[128,384] width:56 height:16 range:[0.1,100,5] type:#float scale:0.1
	spinner Bone_Size_3 "" pos:[128,408] width:56 height:16 range:[0.1,100,1] type:#float scale:0.1
	checkbox Bone_Anim "" pos:[16,432] width:16 height:16 checked:true
	checkbox Bone_Link "" pos:[104,432] width:16 height:16
	checkbox Bone_Fix "" pos:[16,448] width:16 height:16
	dropDownList Bone_Ctl_1 "" pos:[96,472] width:88 height:22 items:#("EulerXYZ", "Bezier")
	dropDownList Bone_Ctl_2 "" pos:[96,504] width:88 height:22 items:#("EulerXYZ", "Bezier")
	dropDownList Bone_Ctl_3 "" pos:[96,536] width:88 height:22 items:#("EulerXYZ", "Bezier")
	label Bone_Lbl_1 "Type:" pos:[16,332] width:72 height:16
	--------------------------------------------------------------
	label Bone_Lbl_2 "NotUsed" pos:[16,360] width:112 height:16 visible:false
	label Bone_Lbl_3 "NotUsed" pos:[16,384] width:112 height:16 visible:false
	label Bone_Lbl_4 "NotUsed" pos:[16,408] width:112 height:16
	--OriginBone
	label Bone_Lbl_2_0 "Size:" pos:[16,360] width:112 height:16
	label Bone_Lbl_3_0 "MinLength:" pos:[16,384] width:112 height:16
	--Dummy
	label Bone_Lbl_2_1 "MinLength:" pos:[16,360] width:112 height:16 visible:false
	label Bone_Lbl_3_1 "MinWidth:" pos:[16,384] width:112 height:16 visible:false
	label Bone_Lbl_4_1 "MinHeight:" pos:[16,408] width:112 height:16 visible:false
	--Box
	label Bone_Lbl_2_2 "MinLength:" pos:[16,360] width:112 height:16 visible:false
	label Bone_Lbl_3_2 "MinWidth:" pos:[16,384] width:112 height:16 visible:false
	label Bone_Lbl_4_2 "MinHeight:" pos:[16,408] width:112 height:16 visible:false
	--Pyramid
	label Bone_Lbl_2_3 "Length:" pos:[16,360] width:112 height:16 visible:false
	label Bone_Lbl_3_3 "Width:" pos:[16,384] width:112 height:16 visible:false
	label Bone_Lbl_4_3 "MinHeight:" pos:[16,408] width:112 height:16 visible:false
	--------------------------------------------------------------
	label Bone_Lbl_5 "Animated" pos:[32,432] width:64 height:16
	label Bone_Lbl_6 "Show Link" pos:[120,432] width:64 height:16
	label Bone_Lbl_7 "Fix Bone Orientation" pos:[32,448] width:152 height:16
	label Bone_Lbl_8 "PosController:" pos:[16,476] width:80 height:16
	label Bone_Lbl_9 "RotController:" pos:[16,508] width:80 height:16
	label Bone_Lbl_10 "ScaleController:" pos:[16,540] width:80 height:16
	
	groupBox grp5 "Helper" pos:[8,576] width:184 height:136
	spinner Helper_Att_Size "" pos:[128,592] width:56 height:16 range:[1,100,5] type:#integer scale:1
	checkbox Helper_Att_Scale "" pos:[16,616] width:16 height:16
	checkbox Helper_Coll_0 "" pos:[16,640] width:16 height:16
	checkbox Helper_Coll_1 "" pos:[16,656] width:16 height:16
	checkbox Helper_Coll_2 "" pos:[16,672] width:16 height:16
	checkbox Helper_Coll_3 "" pos:[16,688] width:16 height:16
	label Helper_Lbl_1 "Attachment Size:" pos:[16,592] width:112 height:16
	label Helper_Lbl_2 "Attachment Scale" pos:[32,616] width:152 height:16
	label Helper_Lbl_3 "Collapse Bounds" pos:[32,640] width:152 height:16
	label Helper_Lbl_4 "Collapse Attachment" pos:[32,656] width:152 height:16
	label Helper_Lbl_5 "Collapse VolTarget" pos:[32,672] width:152 height:16
	label Helper_Lbl_6 "Collapse HitTest" pos:[32,688] width:152 height:16
	
	groupBox grp6 "Light" pos:[8,720] width:184 height:56
	checkbox Light_Trans "" pos:[16,736] width:16 height:16
	checkbox Light_Par "" pos:[16,752] width:16 height:16
	label Light_Lbl_1 "TransForm Animated" pos:[32,736] width:152 height:16
	label Light_Lbl_2 "Parameter Animated" pos:[32,752] width:152 height:16
	
	groupBox grp7 "Camera" pos:[8,784] width:184 height:56
	checkbox Camera_Trans "" pos:[16,800] width:16 height:16
	checkbox Camera_Par "" pos:[16,816] width:16 height:16
	label Camera_Lbl_1 "TransForm Animated" pos:[32,800] width:152 height:16
	label Camera_Lbl_2 "Parameter Animated" pos:[32,816] width:152 height:16
	
	groupBox grp8 "Particle" pos:[8,848] width:184 height:56
	checkbox Part_Trans "" pos:[16,864] width:16 height:16
	checkbox Part_Par "" pos:[16,880] width:16 height:16
	label Part_Lbl_1 "TransForm Animated" pos:[32,864] width:152 height:16
	label Part_Lbl_2 "Parameter Animated" pos:[32,880] width:152 height:16
	
	fn TranslateLanguage =
	(
		local language = copy M3G_ImportInfo_Glb.Language.value

		grp1.text = 		M3F_ReadLanguage language "Global"		"Global"
		Glb_Lbl_1.text = 	M3F_ReadLanguage language "Position"	"Position:"
		Glb_Lbl_2.text = 	M3F_ReadLanguage language "Scale"		"Scale:"

		grp2.text = 		M3F_ReadLanguage language "Animation"			"Animation"
		Anim_Lbl_1.text = 	M3F_ReadLanguage language "FrameRate"			"Frame Rate:"
		Anim_Lbl_2.text = 	M3F_ReadLanguage language "FramesBetweenSeq"	"FramesBetweenSeq:"
		Anim_Lbl_3.text = 	M3F_ReadLanguage language "FramesCorrect"		"Frames Correct:   %"
		Anim_Lbl_4.text = 	M3F_ReadLanguage language "FramesCheckRange"	"FramesCheckRange:"

		grp3.text = 			M3F_ReadLanguage language "Mesh"			"Mesh"
		local name_string = #()
		append name_string (	M3F_ReadLanguage language "OriginImport"	"OriginImport(Slower)")
		append name_string (	M3F_ReadLanguage language "WeldSmooth"		"Weld&&Smooth")
		append name_string (	M3F_ReadLanguage language "DoNothing"		"DoNothing(Faster)")
		append name_string (	M3F_ReadLanguage language "OnlyWeld"		"OnlyWeld")
		append name_string (	M3F_ReadLanguage language "OnlySmooth"		"OnlySmooth")
		Mesh_Option.items = name_string
		Mesh_Lbl_1.text = 		M3F_ReadLanguage language "MeshOption"		"Option:"
		Mesh_Lbl_2.text = 		M3F_ReadLanguage language "SmoothByAngle"	"Smooth By Angle"
		Mesh_Lbl_3.text = 		M3F_ReadLanguage language "SmoothByUV"		"Smooth By UV"

		grp4.text = 			M3F_ReadLanguage language "Bone" 			"Bone"
		local name_string = #()
		append name_string (	M3F_ReadLanguage language "BoneOrigin"		"OriginBone")
		append name_string (	M3F_ReadLanguage language "BoneDummy"		"Dummy")
		append name_string (	M3F_ReadLanguage language "BoneBox"			"Box")
		append name_string (	M3F_ReadLanguage language "BonePyramid"		"Pyramid")
		append name_string (	M3F_ReadLanguage language "BoneNoneEntity"	"NoneEntity")
		Bone_Type.items = name_string
		Bone_Lbl_1.text = 		M3F_ReadLanguage language "BoneType"		"Type:"
		Bone_Lbl_2.text = 		M3F_ReadLanguage language "BoneNotUsed"		"NotUsed"
		Bone_Lbl_3.text = 		M3F_ReadLanguage language "BoneNotUsed"		"NotUsed"
		Bone_Lbl_4.text = 		M3F_ReadLanguage language "BoneNotUsed"		"NotUsed"
		Bone_Lbl_2_0.text = 	M3F_ReadLanguage language "BoneSize1"		"Size:"
		Bone_Lbl_3_0.text = 	M3F_ReadLanguage language "BoneSize2"		"MinLength:"
		Bone_Lbl_2_1.text = 	M3F_ReadLanguage language "BoneSize2"		"MinLength:"
		Bone_Lbl_3_1.text = 	M3F_ReadLanguage language "BoneSize3"		"MinWidth:"
		Bone_Lbl_4_1.text = 	M3F_ReadLanguage language "BoneSize4"		"MinHeight:"
		Bone_Lbl_2_2.text = 	M3F_ReadLanguage language "BoneSize2"		"MinLength:"
		Bone_Lbl_3_2.text = 	M3F_ReadLanguage language "BoneSize3"		"MinWidth:"
		Bone_Lbl_4_2.text = 	M3F_ReadLanguage language "BoneSize4"		"MinHeight:"
		Bone_Lbl_2_3.text = 	M3F_ReadLanguage language "BoneSize5"		"Length:"
		Bone_Lbl_3_3.text = 	M3F_ReadLanguage language "BoneSize6"		"Width:"
		Bone_Lbl_4_3.text = 	M3F_ReadLanguage language "BoneSize4"		"MinHeight:"
		Bone_Lbl_5.text = 		M3F_ReadLanguage language "BoneAnimated"	"Animated"
		Bone_Lbl_6.text = 		M3F_ReadLanguage language "ShowLink"		"Show Link"
		Bone_Lbl_7.text = 		M3F_ReadLanguage language "FixBone"			"Fix Bone Orientation"
		Bone_Lbl_8.text = 		M3F_ReadLanguage language "PosController"	"PosController:"
		Bone_Lbl_9.text = 		M3F_ReadLanguage language "RotController"	"RotController:"
		Bone_Lbl_10.text = 		M3F_ReadLanguage language "ScaleController"	"ScaleController:"

		grp5.text = 		M3F_ReadLanguage language "Helper" 				"Helper"
		Helper_Lbl_1.text = M3F_ReadLanguage language "AttachmentSize"		"Attachment Size:"
		Helper_Lbl_2.text = M3F_ReadLanguage language "AttachmentScale"		"Attachment Scale"
		Helper_Lbl_3.text = M3F_ReadLanguage language "CollapseBounds"		"Collapse Bounds"
		Helper_Lbl_4.text = M3F_ReadLanguage language "CollapseAttachment"	"Collapse Attachment"
		Helper_Lbl_5.text = M3F_ReadLanguage language "CollapseVolTarget"	"Collapse VolTarget"
		Helper_Lbl_6.text = M3F_ReadLanguage language "CollapseHitTest"		"Collapse HitTest"

		grp6.text = 		M3F_ReadLanguage language "Light" 				"Light"
		Light_Lbl_1.text = 	M3F_ReadLanguage language "LightTransform"		"Transform Animated"
		Light_Lbl_2.text = 	M3F_ReadLanguage language "LightParameter"		"Parameter Animated"

		grp7.text = 		M3F_ReadLanguage language "Camera" 				"Camera"
		Camera_Lbl_1.text = M3F_ReadLanguage language "CameraTransform"		"Transform Animated"
		Camera_Lbl_2.text = M3F_ReadLanguage language "CameraParameter"		"Parameter Animated"

		grp8.text = 		M3F_ReadLanguage language "Particle" 			"Particle"
		Part_Lbl_1.text = 	M3F_ReadLanguage language "PartTransform"		"Transform Animated"
		Part_Lbl_2.text = 	M3F_ReadLanguage language "PartParameter"		"Parameter Animated"
	)

	fn SmoothCheck =
	(
		case Mesh_Option.selection of
		(
			1: Mesh_Smooth_Type.enabled = false
			2: Mesh_Smooth_Type.enabled = true
			3: Mesh_Smooth_Type.enabled = false
			4: Mesh_Smooth_Type.enabled = false
			5: Mesh_Smooth_Type.enabled = true
		)

		if(Mesh_Smooth_Type.enabled == true and Mesh_Smooth_Type.state == 1)then
		(
			Mesh_Smooth_Angle.enabled = true
		)else
		(
			Mesh_Smooth_Angle.enabled = false
		)
	)

	fn EntityCheck =
	(
		Bone_Lbl_2.visible = false
		Bone_Lbl_3.visible = false
		Bone_Lbl_4.visible = false
		Bone_Lbl_2_0.visible = false
		Bone_Lbl_3_0.visible = false
		Bone_Lbl_2_1.visible = false
		Bone_Lbl_3_1.visible = false
		Bone_Lbl_4_1.visible = false
		Bone_Lbl_2_2.visible = false
		Bone_Lbl_3_2.visible = false
		Bone_Lbl_4_2.visible = false
		Bone_Lbl_2_3.visible = false
		Bone_Lbl_3_3.visible = false
		Bone_Lbl_4_3.visible = false

		if(Bone_Type.selection != 5)then
		(
			Bone_Link.enabled = true
			Bone_Fix.enabled = true
		)

		case Bone_Type.selection of
		(
			1:
			(
				Bone_Size_1.enabled = true
				Bone_Size_2.enabled = true
				Bone_Size_3.enabled = false

				Bone_Lbl_2_0.visible = true
				Bone_Lbl_3_0.visible = true
				Bone_Lbl_4.visible = true
			)
			2:
			(
				Bone_Size_1.enabled = true
				Bone_Size_2.enabled = true
				Bone_Size_3.enabled = true

				Bone_Lbl_2_1.visible = true
				Bone_Lbl_3_1.visible = true
				Bone_Lbl_4_1.visible = true
			)
			3:
			(
				Bone_Size_1.enabled = true
				Bone_Size_2.enabled = true
				Bone_Size_3.enabled = true

				Bone_Lbl_2_2.visible = true
				Bone_Lbl_3_2.visible = true
				Bone_Lbl_4_2.visible = true
			)
			4:
			(
				Bone_Size_1.enabled = true
				Bone_Size_2.enabled = true
				Bone_Size_3.enabled = true

				Bone_Lbl_2_3.visible = true
				Bone_Lbl_3_3.visible = true
				Bone_Lbl_4_3.visible = true
			)
			5:
			(
				Bone_Size_1.enabled = false
				Bone_Size_2.enabled = false
				Bone_Size_3.enabled = false

				Bone_Lbl_2.visible = true
				Bone_Lbl_3.visible = true
				Bone_Lbl_4.visible = true

				Bone_Link.enabled = false
				Bone_Link.state = true
				M3G_ImportInfo_Glb.setBLink.value = true
				Bone_Fix.enabled = false
				Bone_Fix.state = false
				M3G_ImportInfo_Glb.setBFix.value = false
			)
		)
	)

	fn UpdateUI =
	(
		Glb_PosX.value = M3G_ImportInfo_Glb.setGPos.value[1]
		Glb_PosY.value = M3G_ImportInfo_Glb.setGPos.value[2]
		Glb_PosZ.value = M3G_ImportInfo_Glb.setGPos.value[3]
		Glb_Scale.value = M3G_ImportInfo_Glb.setGScale.value

		Anim_Rate.value = M3G_ImportInfo_Glb.setFRate.value
		Anim_Seq.value = M3G_ImportInfo_Glb.setFBSeq.value
		Anim_Correct.value = M3G_ImportInfo_Glb.setFCorrect.value
		Anim_CheckR.value = M3G_ImportInfo_Glb.setFCheckR.value

		Mesh_Option.selection = M3G_ImportInfo_Glb.setWeldSmooth.value
		Mesh_Smooth_Type.state = M3G_ImportInfo_Glb.setSmoothType.value
		Mesh_Smooth_Angle.value = M3G_ImportInfo_Glb.setSmoothAngle.value

		Bone_Type.selection = M3G_ImportInfo_Glb.setBEntity.value
		Bone_Size_1.value = M3G_ImportInfo_Glb.setBSize1.value
		Bone_Size_2.value = M3G_ImportInfo_Glb.setBSize2.value
		Bone_Size_3.value = M3G_ImportInfo_Glb.setBSize3.value
		Bone_Anim.state = M3G_ImportInfo_Glb.setBAnim.value
		Bone_Link.state = M3G_ImportInfo_Glb.setBLink.value
		Bone_Fix.state = M3G_ImportInfo_Glb.setBFix.value
		Bone_Ctl_1.selection = M3G_ImportInfo_Glb.setBPosCtl.value
		Bone_Ctl_2.selection = M3G_ImportInfo_Glb.setBRotCtl.value
		Bone_Ctl_3.selection = M3G_ImportInfo_Glb.setBScaleCtl.value

		Helper_Att_Size.value = M3G_ImportInfo_Glb.setAttSize.value
		Helper_Att_Scale.state = M3G_ImportInfo_Glb.setAttScale.value
		Helper_Coll_0.state = M3G_ImportInfo_Glb.setBoundColl.value
		Helper_Coll_1.state = M3G_ImportInfo_Glb.setAttColl.value
		Helper_Coll_2.state = M3G_ImportInfo_Glb.setVolColl.value
		Helper_Coll_3.state = M3G_ImportInfo_Glb.setHitColl.value

		Light_Trans.state = M3G_ImportInfo_Glb.setLTrans.value
		Light_Par.state = M3G_ImportInfo_Glb.setLPar.value
		Camera_Trans.state = M3G_ImportInfo_Glb.setCTrans.value
		Camera_Par.state = M3G_ImportInfo_Glb.setCPar.value
		Part_Trans.state = M3G_ImportInfo_Glb.setPTrans.value
		Part_Par.state = M3G_ImportInfo_Glb.setPPar.value

		SmoothCheck()
		EntityCheck()
	)
	------------------------------------------------------
	on M3P_AdvSettings_UI open  do
	(
		TranslateLanguage()
	)
	on M3P_AdvSettings_UI close  do
	(
	
	)
	------------------------------------------------------
	on Glb_PosX changed val do
	(
		M3G_ImportInfo_Glb.setGPos.value[1] = val
	)
	on Glb_PosY changed val do
	(
		M3G_ImportInfo_Glb.setGPos.value[2] = val
	)
	on Glb_PosZ changed val do
	(
		M3G_ImportInfo_Glb.setGPos.value[3] = val
	)
	on Glb_Scale changed val do
	(
		M3G_ImportInfo_Glb.setGScale.value = val
	)
	------------------------------------------------------
	on Anim_Rate changed val do
	(
		M3G_ImportInfo_Glb.setFRate.value = val
	)
	on Anim_Seq changed val do
	(
		M3G_ImportInfo_Glb.setFBSeq.value = val
	)
	on Anim_Correct changed val do
	(
		M3G_ImportInfo_Glb.setFCorrect.value = val
	)
	on Anim_CheckR changed val do
	(
		M3G_ImportInfo_Glb.setFCheckR.value = val
	)
	------------------------------------------------------
	on Mesh_Option selected val do
	(
		M3G_ImportInfo_Glb.setWeldSmooth.value = val
		SmoothCheck()
	)
	on Mesh_Smooth_Type changed stat do
	(
		M3G_ImportInfo_Glb.setSmoothType.value = stat
		SmoothCheck()
	)
	on Mesh_Smooth_Angle changed val do
	(
		M3G_ImportInfo_Glb.setSmoothAngle.value = val
	)
	------------------------------------------------------
	on Bone_Type selected val do
	(
		M3G_ImportInfo_Glb.setBEntity.value = val
		EntityCheck()
	)
	on Bone_Size_1 changed val do
	(
		M3G_ImportInfo_Glb.setBSize1.value = val
	)
	on Bone_Size_2 changed val do
	(
		M3G_ImportInfo_Glb.setBSize2.value = val
	)
	on Bone_Size_3 changed val do
	(
		M3G_ImportInfo_Glb.setBSize3.value = val
	)
	on Bone_Anim changed state do
	(
		M3G_ImportInfo_Glb.setBAnim.value = state
	)
	on Bone_Link changed state do
	(
		M3G_ImportInfo_Glb.setBLink.value = state
	)
	on Bone_Fix changed state do
	(
		M3G_ImportInfo_Glb.setBFix.value = state
	)
	on Bone_Ctl_1 selected val do
	(
		M3G_ImportInfo_Glb.setBPosCtl.value = val
	)
	on Bone_Ctl_2 selected val do
	(
		M3G_ImportInfo_Glb.setBRotCtl.value = val
	)
	on Bone_Ctl_3 selected val do
	(
		M3G_ImportInfo_Glb.setBScaleCtl.value = val
	)
	------------------------------------------------------
	on Helper_Att_Size changed val do
	(
		M3G_ImportInfo_Glb.setAttSize.value = val
	)
	on Helper_Att_Scale changed state do
	(
		M3G_ImportInfo_Glb.setAttScale.value = state
	)
	on Helper_Coll_0 changed state do
	(
		M3G_ImportInfo_Glb.setBoundColl.value = state
	)
	on Helper_Coll_1 changed state do
	(
		M3G_ImportInfo_Glb.setAttColl.value = state
	)
	on Helper_Coll_2 changed state do
	(
		M3G_ImportInfo_Glb.setVolColl.value = state
	)
	on Helper_Coll_3 changed state do
	(
		M3G_ImportInfo_Glb.setHitColl.value = state
	)
	------------------------------------------------------
	on Light_Trans changed state do
	(
		M3G_ImportInfo_Glb.setLTrans.value = state
	)
	on Light_Par changed state do
	(
		M3G_ImportInfo_Glb.setLPar.value = state
	)
	------------------------------------------------------
	on Camera_Trans changed state do
	(
		M3G_ImportInfo_Glb.setCTrans.value = state
	)
	on Camera_Par changed state do
	(
		M3G_ImportInfo_Glb.setCPar.value = state
	)
	------------------------------------------------------
	on Part_Trans changed state do
	(
		M3G_ImportInfo_Glb.setPTrans.value = state
	)
	on Part_Par changed state do
	(
		M3G_ImportInfo_Glb.setPPar.value = state
	)
	------------------------------------------------------
)

rollout M3P_ImportPanel "M3 Import" width:214
(
	subrollout Import_subRoll align:#center width:214 height:760
	label ImporterVer_label "" align:#left
	label ImporterDate_label "" align:#left
	label lb1 "Language :" pos:[13,810] width:60 height:17
	button Default_Btn "Default" pos:[140,770] width:56 height:32
	dropdownlist Language_Drop "" pos:[116,806] width:80 height:3 items:#("English","Chinese")
	button About_Btn "About" pos:[59,845] width:96 height:20

	fn InitRollout =
	(
		addSubRollout Import_subRoll M3P_Import_UI
		addSubRollout Import_subRoll M3P_AdvSettings_UI
	)

	fn ImporterDate =
	(
		try
		(
			local mzp_files = getFiles "$startupScripts\\CaptainD-M3Import-v*.mzp"
			local localImporterDate = getFileModDate mzp_files[1]
			local ImporterDate = filterString localImporterDate " "
			ImporterDate[1]
		)catch(undefined)
	)

	fn UpdateUI =
	(
		Import_subRoll.M3P_Import_UI.UpdateUI()
		Import_subRoll.M3P_AdvSettings_UI.UpdateUI()
		case M3G_ImportInfo_Glb.Language.value of
		(
			"English":(Language_Drop.selection = 1; Default_Btn.text = "Default")
			"Chinese":(Language_Drop.selection = 2; Default_Btn.text = "默认")
			default:(Language_Drop.selection = 1; Default_Btn.text = "Default")
		)
	)

	fn TranslateLanguage =
	(
		Import_subRoll.rollouts[1].TranslateLanguage()
		Import_subRoll.rollouts[2].TranslateLanguage()
	)

	fn ResizeUI =
	(
		Import_subRoll.height = M3P_ImportPanel.height - 120
		ImporterVer_label.pos.y = Import_subRoll.height + 16
		ImporterDate_label.pos.y = Import_subRoll.height + 32
		lb1.pos.y = Import_subRoll.height + 50
		Default_Btn.pos.y = Import_subRoll.height + 10
		Language_Drop.pos.y = Import_subRoll.height + 46
		About_Btn.pos.y = Import_subRoll.height + 85
	)

	on M3P_ImportPanel open do
	(
		ResizeUI()
		InitRollout()
		UpdateUI()
		ImporterVer_label.text =  "Importer Version: " + M3G_ImportInfo_Glb.verison
		ImporterDate_label.text = ("Date: " + ImporterDate() as String)
	)
	on M3P_ImportPanel close do
	(
		M3G_ImportInfo_Glb.posUI.value = GetDialogPos M3P_ImportPanel
		M3G_ImportInfo_Glb.heightUI.value = M3P_ImportPanel.height
		M3G_ImportInfo_Glb.dialogCheck = false
		updateToolbarButtons()
		M3G_ImportInfo_Glb.accessMiscSettings #save
		M3G_ImportInfo_Glb.accessImportUIsettings #save
	)

	on M3P_ImportPanel resized rollsize do
	(
		ResizeUI()
	)

	on Default_Btn pressed do
	(
		M3G_ImportInfo_Glb.defaultImportUIsettings()
		UpdateUI()
	)

	on Language_Drop selected litem do
	(
		case litem of
		(
			1: M3G_ImportInfo_Glb.Language.value = "English"
			2: M3G_ImportInfo_Glb.Language.value = "Chinese"
		)
		TranslateLanguage()
		UpdateUI()
	)

	on About_Btn pressed do
	(
		createDialog M3P_About_UI \
			style:#(#style_titlebar, #style_sysmenu, #style_minimizebox, #style_resizing) \
			lockHeight:true lockWidth:true
	)
)
M3G_ImportInfo_Glb.MainUI = M3P_ImportPanel


macroScript M3M_FileImport
category:"CaptainD"
internalcategory:"CaptainD"
ButtonText:"M3-Import"
tooltip:"M3 file import tool."
icon:#("BlizzExport", 3)
(
	on isChecked return
	(
		if(M3G_ImportInfo_Glb != undefined)then(M3G_ImportInfo_Glb.dialogCheck)else(false)
	)
	on execute do
	(
		if(M3G_ImportInfo_Glb != undefined)then
		(
			if(M3G_ImportInfo_Glb.dialogCheck != true)then
			(
				M3G_ImportInfo_Glb.accessMiscSettings #load
				M3G_ImportInfo_Glb.accessImportUIsettings #load
				try (destroyDialog M3G_ImportInfo_Glb.MainUI) catch()
				createDialog M3G_ImportInfo_Glb.MainUI \
					style:#(#style_titlebar, #style_sysmenu, #style_minimizebox, #style_resizing) \
					lockHeight:false lockWidth:true \
					pos:M3G_ImportInfo_Glb.posUI.value \
					height:M3G_ImportInfo_Glb.heightUI.value
				M3G_ImportInfo_Glb.dialogCheck = true
			)else
			(
				try (destroyDialog M3G_ImportInfo_Glb.MainUI) catch()
				M3G_ImportInfo_Glb.dialogCheck = false
			)
		)
	)
	on closeDialogs do
	(
		if(M3G_ImportInfo_Glb != undefined)then
		(
			try (destroyDialog M3G_ImportInfo_Glb.MainUI) catch()
			M3G_ImportInfo_Glb.dialogCheck = false
		)
	)
)

macroScript M3M_TexMapFix
category:"CaptainD"
internalcategory:"CaptainD"
ButtonText:"M3-TexMapFix"
tooltip:"Fix textures path problem."
icon:#("ShowIcon", 1)
(
	on isChecked return
	(
		if(M3G_ImportInfo_Glb != undefined)then(M3G_ImportInfo_Glb.texDialogCheck)else(false)
	)
	on execute do
	(
		if(M3G_ImportInfo_Glb != undefined)then
		(
			if(M3G_ImportInfo_Glb.texDialogCheck != true)then
			(
				M3G_ImportInfo_Glb.accessMiscSettings #load
				M3G_ImportInfo_Glb.texToolUI.accessTexToolSettings #load
				try (destroyDialog M3G_ImportInfo_Glb.texToolUI.mainUI) catch()
				createDialog M3G_ImportInfo_Glb.texToolUI.mainUI \
					style:#(#style_titlebar, #style_sysmenu, #style_minimizebox, #style_resizing) \
					lockHeight:false lockWidth:false \
					pos:M3G_ImportInfo_Glb.texToolUI.posUI.value \
					width:M3G_ImportInfo_Glb.texToolUI.widthUI.value \
					height:M3G_ImportInfo_Glb.texToolUI.heightUI.value
				M3G_ImportInfo_Glb.texDialogCheck = true
			)else
			(
				try (destroyDialog M3G_ImportInfo_Glb.texToolUI.mainUI) catch()
				M3G_ImportInfo_Glb.texDialogCheck = false
			)
		)
	)
	on closeDialogs do
	(
		if(M3G_ImportInfo_Glb != undefined)then
		(
			try (destroyDialog M3G_ImportInfo_Glb.texToolUI.mainUI) catch()
			M3G_ImportInfo_Glb.texDialogCheck = false
		)
	)
)
---End Script--------------------------------------------------