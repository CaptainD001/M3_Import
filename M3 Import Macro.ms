---------------------------------------------------------------------------

global M3G_ImportInfo_Glb

struct M3S_INIdata
(
	sectionStr, keyStr, value
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
	verison = "v1.6a",
	toolsBtn = 1,
	ExtractFileLib,
	--Misc
	Language 		= M3S_INIdata "Misc" 	"Language" 	"English",
	toolsBtnExpand 	= M3S_INIdata "Misc" 	"Expand" 	false,
	btnItem = \
		#("2|0|0|31|3|647394|M3M_FileImport`CaptainD|0|0|\"M3 file import tool.\"|\"M3-Import\"|-1|", \
		"2|0|0|31|3|647394|M3M_ExpandMiscUtil`CaptainD|0|0|\"Expand misc tools Btn.\"|\"M3-ExpandTools\"|-1|", \
		"2|0|0|31|3|647394|M3M_CollapseMiscUtil`CaptainD|0|0|\"Collapse misc tools Btn.\"|\"M3-CollapseTools\"|-1|", \
		"2|0|0|31|3|647394|M3M_TexMapFix`CaptainD|0|0|\"Fix textures path problem.\"|\"M3-TexMapFix\"|-1|"),
	
	--Import Tool
	MainUI, dialogCheck = false, progressLv = 20.0, currProgLv = 0.0,
	missingMap = #(), lastFileName = "None", lastPath = "",
	posUI 			= M3S_INIdata "Import" 				"posUI" 			[500, 100],
	heightUI		= M3S_INIdata "Import" 				"heightUI" 			880,
	showDetails 	= M3S_INIdata "Import" 				"showDetails" 		false,
	missingCheck 	= M3S_INIdata "Import" 				"missingCheck" 		true,
	impMat 			= M3S_INIdata "Import" 				"impMat" 			true,
	impSeq 			= M3S_INIdata "Import" 				"impSeq" 			true,
	impTrack 		= M3S_INIdata "Import" 				"impTrack" 			true,
	impBone 		= M3S_INIdata "Import" 				"impBone" 			true,
	impMesh 		= M3S_INIdata "Import" 				"impMesh" 			true,
	impSkin 		= M3S_INIdata "Import" 				"impSkin" 			true,
	impVol 			= M3S_INIdata "Import" 				"impVol" 			true,
	impHit 			= M3S_INIdata "Import" 				"impHit" 			true,
	impAttach 		= M3S_INIdata "Import" 				"impAttach" 		true,
	impAnim 		= M3S_INIdata "Import" 				"impAnim" 			true,
	impEvt 			= M3S_INIdata "Import" 				"impEvt" 			true,
	impLight 		= M3S_INIdata "Import" 				"impLight" 			true,
	impCam 			= M3S_INIdata "Import" 				"impCam" 			true,
	impPart 		= M3S_INIdata "Import" 				"impPart" 			true,
	impPhy 			= M3S_INIdata "Import" 				"impPhy" 			true,
	setFRate 		= M3S_INIdata "Animation Settings" 	"setFRate" 			30,
	setFBSeq		= M3S_INIdata "Animation Settings" 	"setFBSeq" 			40,
	setFCorrect		= M3S_INIdata "Animation Settings" 	"setFCorrect" 		30.0,
	setFCheckR		= M3S_INIdata "Animation Settings" 	"setFCheckR" 		1,
	setWeldSmooth	= M3S_INIdata "Mesh Settings" 		"setWeldSmooth" 	1,
	setSmoothType	= M3S_INIdata "Mesh Settings" 		"setSmoothType" 	2,
	setSmoothAngle	= M3S_INIdata "Mesh Settings" 		"setSmoothAngle" 	45.0,
	setBEntity		= M3S_INIdata "Bone Settings" 		"setBEntity" 		true,
	setBSize		= M3S_INIdata "Bone Settings" 		"setBSize" 			2.0,
	setBLens		= M3S_INIdata "Bone Settings" 		"setBLens" 			5.0,
	setBAnim		= M3S_INIdata "Bone Settings" 		"setBAnim" 			true,
	setBLink		= M3S_INIdata "Bone Settings" 		"setBLink" 			false,
	setAttSize		= M3S_INIdata "Helper Settings" 	"setAttSize" 		5,
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

	fn checkToolBarExist =
	(
		local cuiFile = cui.getConfigFile()
		local changed = false
		if(doesFileExist cuiFile)then
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
				
				if(this.toolsBtnExpand.value)then
				(
					setINISetting cuiFile #CaptainD #ItemCount ((this.toolsBtn+2) as string)
					setINISetting cuiFile #CaptainD "item0" this.btnItem[1]
					setINISetting cuiFile #CaptainD "item1" this.btnItem[3]
					for i=1 to this.toolsBtn do
					(
						setINISetting cuiFile #CaptainD ("item"+((i+1) as string)) this.btnItem[i+3]
					)
				)else
				(
					setINISetting cuiFile #CaptainD #ItemCount "2"
					setINISetting cuiFile #CaptainD "item0" this.btnItem[1]
					setINISetting cuiFile #CaptainD "item1" this.btnItem[2]
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
			messageBox "Can't create M3 Import ToolBar Item! Please add it manually."
		)
	),
	fn removeToolBar =
	(
		local cuiFile = cui.getConfigFile()
		local changed = false
		if(doesFileExist cuiFile)then
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
					if toLower ((filterstring curWindow ":")[2]) != toLower "CaptainD" do append allWindows curWindow
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
					changed = true
				)
			)
			if hasINISetting cuiFile #CaptainD do(delIniSetting cuiFile #CaptainD; changed = true)
			if(changed)then(cui.loadConfig cuiFile)
		)
	),

	fn accessMiscSettings type_FP =
	(
		M3F_AccessINI #setting this.Language type_FP
		M3F_AccessINI #setting this.toolsBtnExpand type_FP
	),

	fn accessImportUIsettings type_FP =
	(
		M3F_AccessINI #setting this.posUI type_FP
		M3F_AccessINI #setting this.heightUI type_FP
		M3F_AccessINI #setting this.showDetails type_FP
		M3F_AccessINI #setting this.missingCheck type_FP
		M3F_AccessINI #setting this.impMat type_FP
		M3F_AccessINI #setting this.impSeq type_FP
		M3F_AccessINI #setting this.impTrack type_FP
		M3F_AccessINI #setting this.impEvt type_FP
		M3F_AccessINI #setting this.impBone type_FP
		M3F_AccessINI #setting this.impMesh type_FP
		M3F_AccessINI #setting this.impSkin type_FP
		M3F_AccessINI #setting this.impVol type_FP
		M3F_AccessINI #setting this.impHit type_FP
		M3F_AccessINI #setting this.impAttach type_FP
		M3F_AccessINI #setting this.impAnim type_FP
		M3F_AccessINI #setting this.impLight type_FP
		M3F_AccessINI #setting this.impCam type_FP
		M3F_AccessINI #setting this.impPart type_FP
		M3F_AccessINI #setting this.impPhy type_FP
		
		M3F_AccessINI #setting this.setFRate type_FP
		M3F_AccessINI #setting this.setFBSeq type_FP
		M3F_AccessINI #setting this.setFCorrect type_FP
		M3F_AccessINI #setting this.setFCheckR type_FP

		M3F_AccessINI #setting this.setWeldSmooth type_FP
		M3F_AccessINI #setting this.setSmoothType type_FP
		M3F_AccessINI #setting this.setSmoothAngle type_FP
		
		M3F_AccessINI #setting this.setBEntity type_FP
		M3F_AccessINI #setting this.setBSize type_FP
		M3F_AccessINI #setting this.setBLens type_FP
		M3F_AccessINI #setting this.setBAnim type_FP
		M3F_AccessINI #setting this.setBLink type_FP

		M3F_AccessINI #setting this.setAttSize type_FP
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
		this.showDetails.value = false
		this.missingCheck.value = true
		this.impMat.value = true
		this.impSeq.value = true
		this.impTrack.value = true
		this.impEvt.value = true
		this.impBone.value = true
		this.impMesh.value = true
		this.impSkin.value = true
		this.impVol.value = true
		this.impHit.value = true
		this.impAttach.value = true
		this.impAnim.value = true
		this.impLight.value = true
		this.impCam.value = true
		this.impPart.value = true
		this.impPhy.value = true
		this.setFRate.value = 30
		this.setFBSeq.value = 40
		this.setFCorrect.value = 30.0
		this.setFCheckR.value = 1
		this.setWeldSmooth.value = 1
		this.setSmoothType.value = 2
		this.setSmoothAngle.value = 45.0
		this.setBEntity.value = true
		this.setBSize.value = 2.0
		this.setBLens.value = 5.0
		this.setBAnim.value = true
		this.setBLink.value = false
		this.setAttSize.value = 5
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
M3G_ImportInfo_Glb.checkToolBarExist()
callbacks.addScript #postSystemStartup "M3G_ImportInfo_Glb.checkToolBarExist()" id:#M3ImportStartUp
callbacks.addScript #preSystemShutdown "M3G_ImportInfo_Glb.removeToolBar()" id:#M3ImportShutDown

---------------------------------------------------------------------------
---------------------------------------------------------------------------
--------------------UI Code------------------------------------------------
---------------------------------------------------------------------------
---------------------------------------------------------------------------

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

rollout M3P_Import_UI "Import Settings" width:200 height:408
(
	groupBox grp1 "Import" pos:[8,8] width:184 height:217
	progressBar ProgressLv "" pos:[16,152] width:168 height:10 color:(color 32 168 0)
	label Progress_text "" pos:[52,164] width:132 height:17
	button Import_Btn "Import" pos:[24,112] width:152 height:32
	label File_Name "" pos:[52,48] width:132 height:17
	editText Import_Path "" pos:[16,23] width:168 height:17 ReadOnly:true labelOnTop:true
	button Select_File_Btn "Select File ..." pos:[24,72] width:152 height:32
	checkbox Show_Details_Check "" pos:[24,184] width:16 height:16
	checkbox Miss_Texture_Check "" pos:[24,200] width:16 height:16

	checkbox Materials_Check "" pos:[16,288] width:16 height:16
	checkbox Anim_Seq_Check "" pos:[16,248] width:16 height:16
	checkbox Anim_Track_Check "" pos:[16,232] width:16 height:16
	checkbox Events_Check "" pos:[96,264] width:16 height:16
	checkbox Bones_Check "" pos:[96,288] width:16 height:16
	checkbox Vol_Targets_Check "" pos:[96,328] width:16 height:16
	checkbox Hit_Tests_Check "" pos:[16,328] width:16 height:16
	checkbox Attachments_Check "" pos:[16,344] width:16 height:16
	checkbox Anim_Check "" pos:[16,264] width:16 height:16
	checkbox Lights_Check "" pos:[16,368] width:16 height:16
	checkbox Meshes_Check "" pos:[16,304] width:16 height:16
	checkbox Skin_Check "" pos:[96,304] width:16 height:16
	checkbox Cameras_Check "" pos:[96,368] width:16 height:16
	checkbox Particles_Check "" pos:[16,384] width:16 height:16
	checkbox Physics_Check "" pos:[96,384] width:16 height:16
	label lbl37 "File:" pos:[24,48] width:28 height:16
	label lbl38 "Phase:" pos:[16,164] width:32 height:16
	label lbl9 "Show Details Info" pos:[40,184] width:144 height:16
	label lbl30 "Missing Textures Info" pos:[40,200] width:144 height:16
	label lbl10 "Anim TrackSet" pos:[32,232] width:152 height:16
	label lbl11 "Anim Sequences" pos:[32,248] width:152 height:16
	label lbl12 "Animations" pos:[32,264] width:56 height:16
	label lbl24 "Events" pos:[112,264] width:72 height:16
	label lbl13 "Materials" pos:[32,288] width:56 height:16
	label lbl14 "Meshes" pos:[32,304] width:56 height:16
	label lbl15 "Bones" pos:[112,288] width:72 height:16
	label lbl16 "Skin" pos:[112,304] width:72 height:16
	label lbl17 "Hit Tests" pos:[32,328] width:56 height:16
	label lbl18 "Attachments" pos:[32,344] width:152 height:16
	label lbl19 "Volume Targets" pos:[112,328] width:80 height:16
	label lbl20 "Lights" pos:[32,368] width:56 height:16
	label lbl22 "Cameras" pos:[112,368] width:72 height:16
	label lbl21 "Particles" pos:[32,384] width:56 height:16
	label lbl23 "Physics" pos:[112,384] width:72 height:16

	fn TranslateLanguage =
	(
		local language = copy M3G_ImportInfo_Glb.Language.value

		grp1.text = \
			M3F_AccessINI #language (M3S_INIdata language "Import" "Import") #load
		Import_Btn.text = \
			M3F_AccessINI #language (M3S_INIdata language "Import_Btn" "Import") #load
		Select_File_Btn.text = \
			M3F_AccessINI #language (M3S_INIdata language "Select_Btn" "Select File ...") #load
		lbl37.text = \
			M3F_AccessINI #language (M3S_INIdata language "File" "File:") #load
		lbl38.text = \
			M3F_AccessINI #language (M3S_INIdata language "Phase" "Phase:") #load
		lbl9.text = \
			M3F_AccessINI #language (M3S_INIdata language "ShowDetailsInfo" "Show Details Info") #load
		lbl30.text = \
			M3F_AccessINI #language (M3S_INIdata language "MissingTexturesInfo" "Missing Textures Info") #load

		lbl10.text = \
			M3F_AccessINI #language (M3S_INIdata language "AnimTrackSetEnable" "Anim TrackSet") #load
		lbl11.text = \
			M3F_AccessINI #language (M3S_INIdata language "AnimSequencesEnable" "Anim Sequences") #load
		lbl12.text = \
			M3F_AccessINI #language (M3S_INIdata language "AnimationsEnable" "Animations") #load
		lbl24.text = \
			M3F_AccessINI #language (M3S_INIdata language "EventsEnable" "Events") #load
		lbl13.text = \
			M3F_AccessINI #language (M3S_INIdata language "MaterialsEnable" "Materials") #load
		lbl14.text = \
			M3F_AccessINI #language (M3S_INIdata language "MeshesEnable" "Meshes") #load
		lbl15.text = \
			M3F_AccessINI #language (M3S_INIdata language "BonesEnable" "Bones") #load
		lbl16.text = \
			M3F_AccessINI #language (M3S_INIdata language "SkinEnable" "Skin") #load
		lbl17.text = \
			M3F_AccessINI #language (M3S_INIdata language "HitTestsEnable" "Hit Tests") #load
		lbl18.text = \
			M3F_AccessINI #language (M3S_INIdata language "AttachmentsEnable" "Attachments") #load
		lbl19.text = \
			M3F_AccessINI #language (M3S_INIdata language "VolumeTargetsEnable" "Volume Targets") #load
		lbl20.text = \
			M3F_AccessINI #language (M3S_INIdata language "LightsEnable" "Lights") #load
		lbl22.text = \
			M3F_AccessINI #language (M3S_INIdata language "CamerasEnable" "Cameras") #load
		lbl21.text = \
			M3F_AccessINI #language (M3S_INIdata language "ParticlesEnable" "Particles") #load
		lbl23.text = \
			M3F_AccessINI #language (M3S_INIdata language "PhysicsEnable" "Physics") #load
	)

	fn FillProgressLv value_FP =
	(
		ProgressLv.value = (value_FP as integer)
	)

	fn ChangePhaseText str_FP =
	(
		Progress_text.Text = str_FP
	)

	fn UpdateUI =
	(
		File_Name.text = M3G_ImportInfo_Glb.lastFileName
		Import_Path.text = M3G_ImportInfo_Glb.lastPath

		Show_Details_Check.state = M3G_ImportInfo_Glb.showDetails.value
		Miss_Texture_Check.state = M3G_ImportInfo_Glb.missingCheck.value
		Materials_Check.state = M3G_ImportInfo_Glb.impMat.value
		Anim_Seq_Check.state = M3G_ImportInfo_Glb.impSeq.value
		Anim_Track_Check.state = M3G_ImportInfo_Glb.impTrack.value
		Events_Check.state = M3G_ImportInfo_Glb.impEvt.value
		Bones_Check.state = M3G_ImportInfo_Glb.impBone.value
		Vol_Targets_Check.state = M3G_ImportInfo_Glb.impVol.value
		Hit_Tests_Check.state = M3G_ImportInfo_Glb.impHit.value
		Attachments_Check.state = M3G_ImportInfo_Glb.impAttach.value
		Anim_Check.state = M3G_ImportInfo_Glb.impAnim.value
		Lights_Check.state = M3G_ImportInfo_Glb.impLight.value
		Meshes_Check.state = M3G_ImportInfo_Glb.impMesh.value
		Skin_Check.state = M3G_ImportInfo_Glb.impSkin.value
		Cameras_Check.state = M3G_ImportInfo_Glb.impCam.value
		Particles_Check.state = M3G_ImportInfo_Glb.impPart.value
		Physics_Check.state = M3G_ImportInfo_Glb.impPhy.value
	)

	on M3P_Import_UI open do
	(
		Show_Details_Check.enabled = false
		FillProgressLv 0.0
		TranslateLanguage()
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
			mapPaths.add M3G_ImportInfo_Glb.lastPath
			mapPaths.add (M3G_ImportInfo_Glb.lastPath + "\\Assets")
			mapPaths.add (M3G_ImportInfo_Glb.lastPath + "\\Assets\\Textures")
			mapPaths.add (M3G_ImportInfo_Glb.lastPath + "\\Textures")

			M3G_ImportInfo_Glb.missingMap = #()
			FillProgressLv 0.0
			ChangePhaseText "Start Import..."

        	with redraw off
        	(
        		undo off
        		(
					--try(M3F_ImportMain Import_Path.Text)catch(M3F_ImportMain Import_Path.Text)
					M3F_ImportMain import_file
        		)
        	)

			FillProgressLv 100.0
			ChangePhaseText "DONE!"
			PRINT "DONE"
			clearSelection()
			RedrawViews()
			max zoomext sel all
			local path_count = mapPaths.count()
			try(mapPaths.delete path_count)catch()
			try(mapPaths.delete (path_count-1))catch()
			try(mapPaths.delete (path_count-2))catch()
			try(mapPaths.delete (path_count-3))catch()

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
		)
		try(GC())catch()
    	enableSceneRedraw()
		setArrowCursor()
	)

	on Show_Details_Check changed state do
	(
		M3G_ImportInfo_Glb.showDetails.value = state
	)
	on Miss_Texture_Check changed state do
	(
		M3G_ImportInfo_Glb.missingCheck.value = state
	)

	on Materials_Check changed state do
	(
		M3G_ImportInfo_Glb.impMat.value = state
	)
	on Anim_Seq_Check changed state do
	(
		M3G_ImportInfo_Glb.impSeq.value = state
	)
	on Anim_Track_Check changed state do
	(
		M3G_ImportInfo_Glb.impTrack.value = state
	)
	on Events_Check changed state do
	(
		M3G_ImportInfo_Glb.impEvt.value = state
	)
	on Bones_Check changed state do
	(
		M3G_ImportInfo_Glb.impBone.value = state
	)
	on Vol_Targets_Check changed state do
	(
		M3G_ImportInfo_Glb.impVol.value = state
	)
	on Hit_Tests_Check changed state do
	(
		M3G_ImportInfo_Glb.impHit.value = state
	)
	on Attachments_Check changed state do
	(
		M3G_ImportInfo_Glb.impAttach.value = state
	)
	on Anim_Check changed state do
	(
		M3G_ImportInfo_Glb.impAnim.value = state
	)
	on Lights_Check changed state do
	(
		M3G_ImportInfo_Glb.impLight.value = state
	)
	on Meshes_Check changed state do
	(
		M3G_ImportInfo_Glb.impMesh.value = state
	)
	on Skin_Check changed state do
	(
		M3G_ImportInfo_Glb.impSkin.value = state
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

rollout M3P_AdvSettings_UI "Advance Settings" width:200 height:648
(
	groupBox grp2 "Animation" pos:[8,8] width:184 height:112
	spinner Frame_Rate "" pos:[120,24] width:64 height:16 enabled:true range:[10,10000,30] type:#integer scale:1	
	spinner Frame_Seq "" pos:[120,48] width:64 height:16 enabled:true range:[10,10000,40] type:#integer scale:1
	spinner Frame_Correct "" pos:[120,72] width:64 height:16 enabled:true range:[0,100,30]
	spinner Frame_CheckR "" pos:[120,96] width:64 height:16 enabled:true range:[0,100,1] type:#integer scale:1

	groupBox grp3 "Mesh" pos:[8,128] width:184 height:128
	radioButtons Weld_Smooth "" pos:[16,144] width:16 height:64 labels:#("", "", "", "") default:1 columns:1
	radioButtons Weld_Smooth2 "" pos:[100,192] width:16 height:64 labels:#("") default:0 columns:1
	radioButtons Smooth_Type "" pos:[16,216] width:44 height:32 labels:#("", "") default:2 columns:1
	spinner Smooth_Angle "" pos:[128,216] width:56 height:16 enabled:true range:[0,360,45]
	
	groupBox grp4 "Bone" pos:[8,264] width:184 height:88
	checkbox Bone_Show "" pos:[104,328] width:16 height:16
	checkbox Bone_Entity "" pos:[16,288] width:16 height:16 checked:true
	checkbox Bone_Anim "" pos:[16,328] width:16 height:16
	spinner Bone_Size "" pos:[136,280] width:48 height:16 enabled:true range:[0.1,100,2]
	spinner Bone_Lens "" pos:[136,304] width:48 height:16 enabled:true range:[0.1,100,5]
	
	groupBox grp5 "Helper" pos:[8,360] width:184 height:104
	spinner Att_Size "" pos:[128,384] width:56 height:16 enabled:true range:[1,100,5] type:#integer scale:1
	checkbox Coll_Att "" pos:[16,408] width:16 height:16
	checkbox Coll_Vol "" pos:[16,424] width:16 height:16
	checkbox Coll_Hit "" pos:[16,440] width:16 height:16
	
	groupBox grp7 "Light" pos:[8,472] width:184 height:56
	checkbox Light_Trans "" pos:[16,488] width:16 height:16
	checkbox Light_Par "" pos:[16,504] width:16 height:16
	
	groupBox grp8 "Camera" pos:[8,536] width:184 height:56
	checkbox Camera_Trans "" pos:[16,552] width:16 height:16
	checkbox Camera_Par "" pos:[16,568] width:16 height:16
	
	groupBox grp9 "Particle" pos:[8,600] width:184 height:56
	checkbox Part_Trans "" pos:[16,616] width:16 height:16
	checkbox Part_Par "" pos:[16,632] width:16 height:16
	
	label lbl1 "FramesBetweenSeq:" pos:[16,48] width:104 height:16
	label lbl2 "Frame Rate:" pos:[16,24] width:104 height:16
	label lbl3 "Frames Correct:   %" pos:[16,72] width:104 height:16
	label lbl4 "FramesCheckRange:" pos:[16,96] width:104 height:16
	label lbl46 "OriginImport(Slower)" pos:[40,144] width:126 height:16
	label lbl47 "Weld&&Smooth" pos:[40,160] width:126 height:16
	label lbl48 "DoNothing(Faster)" pos:[40,176] width:126 height:16
	label lbl49 "OnlyWeld" pos:[40,192] width:56 height:16
	label lbl5 "OnlySmooth" pos:[124,192] width:60 height:16
	label lbl50 "Smooth By Angle" pos:[40,216] width:88 height:16
	label lbl51 "Smooth By UV" pos:[40,232] width:88 height:16
	label lbl52 "Entity" pos:[32,288] width:48 height:16
	label lbl6 "Size:" pos:[108,280] width:28 height:16
	label lbl7 "MinLength:" pos:[80,304] width:56 height:16
	label lbl53 "Animated" pos:[32,328] width:64 height:16
	label lbl54 "Show Link" pos:[120,328] width:64 height:16
	label lbl8 "Attachment Size:" pos:[16,384] width:104 height:16
	label lbl55 "Collapse Attachment" pos:[32,408] width:152 height:16
	label lbl56 "Collapse VolTarget" pos:[32,424] width:152 height:16
	label lbl57 "Collapse HitTest" pos:[32,440] width:152 height:16
	label lbl58 "Transform Animated" pos:[32,488] width:152 height:16
	label lbl59 "Parameter Animated" pos:[32,504] width:152 height:16
	label lbl60 "Transform Animated" pos:[32,552] width:152 height:16
	label lbl61 "Parameter Animated" pos:[32,568] width:152 height:16
	label lbl62 "Transform Animated" pos:[32,616] width:152 height:16
	label lbl63 "Parameter Animated" pos:[32,632] width:152 height:16
	
	fn TranslateLanguage =
	(
		local language = copy M3G_ImportInfo_Glb.Language.value

		grp2.text = \
			M3F_AccessINI #language (M3S_INIdata language "Animation" "Animation") #load
		lbl2.text = \
			M3F_AccessINI #language (M3S_INIdata language "FrameRate" "Frame Rate:") #load
		lbl1.text = \
			M3F_AccessINI #language (M3S_INIdata language "FramesBetweenSeq" "FramesBetweenSeq:") #load
		lbl3.text = \
			M3F_AccessINI #language (M3S_INIdata language "FramesCorrect" "Frames Correct:   %") #load
		lbl4.text = \
			M3F_AccessINI #language (M3S_INIdata language "FramesCheckRange" "FramesCheckRange:") #load

		grp3.text = \
			M3F_AccessINI #language (M3S_INIdata language "Mesh" "Mesh") #load
		lbl46.text = \
			M3F_AccessINI #language (M3S_INIdata language "OriginImport" "OriginImport(Slower)") #load
		lbl47.text = \
			M3F_AccessINI #language (M3S_INIdata language "WeldSmooth" "Weld&&Smooth") #load
		lbl48.text = \
			M3F_AccessINI #language (M3S_INIdata language "DoNothing" "DoNothing(Faster)") #load
		lbl49.text = \
			M3F_AccessINI #language (M3S_INIdata language "OnlyWeld" "OnlyWeld") #load
		lbl5.text = \
			M3F_AccessINI #language (M3S_INIdata language "OnlySmooth" "OnlySmooth") #load
		lbl50.text = \
			M3F_AccessINI #language (M3S_INIdata language "SmoothByAngle" "Smooth By Angle") #load
		lbl51.text = \
			M3F_AccessINI #language (M3S_INIdata language "SmoothByUV" "Smooth By UV") #load

		grp4.text = \
			M3F_AccessINI #language (M3S_INIdata language "Bone" "Bone") #load
		lbl52.text = \
			M3F_AccessINI #language (M3S_INIdata language "EntityBone" "Entity") #load
		lbl6.text = \
			M3F_AccessINI #language (M3S_INIdata language "SizeBone" "Size:") #load
		lbl7.text = \
			M3F_AccessINI #language (M3S_INIdata language "MinLength" "MinLength:") #load
		lbl53.text = \
			M3F_AccessINI #language (M3S_INIdata language "AnimatedBone" "Animated") #load
		lbl54.text = \
			M3F_AccessINI #language (M3S_INIdata language "ShowLink" "Show Link") #load

		grp5.text = \
			M3F_AccessINI #language (M3S_INIdata language "Helper" "Helper") #load
		lbl8.text = \
			M3F_AccessINI #language (M3S_INIdata language "AttachmentSize" "Attachment Size:") #load
		lbl55.text = \
			M3F_AccessINI #language (M3S_INIdata language "CollapseAttachment" "Collapse Attachment") #load
		lbl56.text = \
			M3F_AccessINI #language (M3S_INIdata language "CollapseVolTarget" "Collapse VolTarget") #load
		lbl57.text = \
			M3F_AccessINI #language (M3S_INIdata language "CollapseHitTest" "Collapse HitTest") #load

		grp7.text = \
			M3F_AccessINI #language (M3S_INIdata language "Light" "Light") #load
		lbl58.text = \
			M3F_AccessINI #language (M3S_INIdata language "TransformAnimatedLight" "Transform Animated") #load
		lbl59.text = \
			M3F_AccessINI #language (M3S_INIdata language "ParameterAnimatedLight" "Parameter Animated") #load

		grp8.text = \
			M3F_AccessINI #language (M3S_INIdata language "Camera" "Camera") #load
		lbl60.text = \
			M3F_AccessINI #language (M3S_INIdata language "TransformAnimatedCamera" "Transform Animated") #load
		lbl61.text = \
			M3F_AccessINI #language (M3S_INIdata language "ParameterAnimatedCamera" "Parameter Animated") #load

		grp9.text = \
			M3F_AccessINI #language (M3S_INIdata language "Particle" "Particle") #load
		lbl62.text = \
			M3F_AccessINI #language (M3S_INIdata language "TransformAnimatedParticle" "Transform Animated") #load
		lbl63.text = \
			M3F_AccessINI #language (M3S_INIdata language "ParameterAnimatedParticle" "Parameter Animated") #load
	)


	fn SmoothCheck =
	(
		case M3G_ImportInfo_Glb.setWeldSmooth.value of
		(
			1:
			(
				Smooth_Type.enabled = false
				Smooth_Angle.enabled = false
				Weld_Smooth.state = 1
				Weld_Smooth2.state = 0
			)
			2:
			(
				Smooth_Type.enabled = true
				if(Smooth_Type.state == 1)then
				(
					Smooth_Angle.enabled = true
				)else
				(
					Smooth_Angle.enabled = false
				)
				Weld_Smooth.state = 2
				Weld_Smooth2.state = 0
			)
			3:
			(
				Smooth_Type.enabled = false
				Smooth_Angle.enabled = false
				Weld_Smooth.state = 3
				Weld_Smooth2.state = 0
			)
			4:
			(
				Smooth_Type.enabled = false
				Smooth_Angle.enabled = false
				Weld_Smooth.state = 4
				Weld_Smooth2.state = 0
			)
			5:
			(
				Smooth_Type.enabled = true
				if(Smooth_Type.state == 1)then
				(
					Smooth_Angle.enabled = true
				)else
				(
					Smooth_Angle.enabled = false
				)
				Weld_Smooth.state = 0
				Weld_Smooth2.state = 1
			)
			default:
			(
				case Weld_Smooth.state of
				(
					0:
					(
						Smooth_Type.enabled = true
						if(Smooth_Type.state == 1)then
						(
							Smooth_Angle.enabled = true
						)else
						(
							Smooth_Angle.enabled = false
						)
						Weld_Smooth2.state = 1
					)
					1:
					(
						Smooth_Type.enabled = false
						Smooth_Angle.enabled = false
						Weld_Smooth2.state = 0
					)
					2:
					(
						Smooth_Type.enabled = true
						if(Smooth_Type.state == 1)then
						(
							Smooth_Angle.enabled = true
						)else
						(
							Smooth_Angle.enabled = false
						)
						Weld_Smooth2.state = 0
					)
					3:
					(
						Smooth_Type.enabled = false
						Smooth_Angle.enabled = false
						Weld_Smooth2.state = 0
					)
					4:
					(
						Smooth_Type.enabled = false
						Smooth_Angle.enabled = false
						Weld_Smooth2.state = 0
					)
				)
			)
		)
	)

	fn EntityCheck =
	(
		if(Bone_Entity.state)then
		(
			Bone_Size.enabled = true
			Bone_Lens.enabled = true
			if(Bone_Show.enabled == false)then
			(Bone_Show.enabled = true)
		)else
		(
			Bone_Size.enabled = false
			Bone_Lens.enabled = false
			Bone_Show.enabled = false
			if(Bone_Show.state == false)then
			(
				Bone_Show.state = true
				M3G_ImportInfo_Glb.setBLink.value = true
			)
		)
	)

	fn UpdateUI =
	(
		Frame_Rate.value = M3G_ImportInfo_Glb.setFRate.value
		Frame_Seq.value = M3G_ImportInfo_Glb.setFBSeq.value
		Frame_Correct.value = M3G_ImportInfo_Glb.setFCorrect.value
		Frame_CheckR.value = M3G_ImportInfo_Glb.setFCheckR.value

		Weld_Smooth.state = M3G_ImportInfo_Glb.setWeldSmooth.value
		Smooth_Type.state = M3G_ImportInfo_Glb.setSmoothType.value
		Smooth_Angle.value = M3G_ImportInfo_Glb.setSmoothAngle.value


		Bone_Entity.state = M3G_ImportInfo_Glb.setBEntity.value
		Bone_Size.value = M3G_ImportInfo_Glb.setBSize.value
		Bone_Lens.value = M3G_ImportInfo_Glb.setBLens.value
		Bone_Anim.state = M3G_ImportInfo_Glb.setBAnim.value
		Bone_Show.state = M3G_ImportInfo_Glb.setBLink.value

		Att_Size.value = M3G_ImportInfo_Glb.setAttSize.value
		Coll_Att.state = M3G_ImportInfo_Glb.setAttColl.value
		Coll_Vol.state = M3G_ImportInfo_Glb.setVolColl.value
		Coll_Hit.state = M3G_ImportInfo_Glb.setHitColl.value

		Light_Trans.state = M3G_ImportInfo_Glb.setLTrans.value
		Light_Par.state = M3G_ImportInfo_Glb.setLPar.value
		Camera_Trans.state = M3G_ImportInfo_Glb.setCTrans.value
		Camera_Par.state = M3G_ImportInfo_Glb.setCPar.value
		Part_Trans.state = M3G_ImportInfo_Glb.setPTrans.value
		Part_Par.state = M3G_ImportInfo_Glb.setPPar.value

		SmoothCheck()
		EntityCheck()
	)

	on M3P_AdvSettings_UI open  do
	(
		SmoothCheck()
		EntityCheck()
		TranslateLanguage()
	)
	on M3P_AdvSettings_UI close  do
	(
	
	)
	on Frame_Rate changed val do
	(
		M3G_ImportInfo_Glb.setFRate.value = val
	)
	on Frame_Seq changed val do
	(
		M3G_ImportInfo_Glb.setFBSeq.value = val
	)
	on Frame_Correct changed val do
	(
		M3G_ImportInfo_Glb.setFCorrect.value = val
	)
	on Frame_CheckR changed val do
	(
		M3G_ImportInfo_Glb.setFCheckR.value = val
	)

	on Weld_Smooth changed stat do
	(
		M3G_ImportInfo_Glb.setWeldSmooth.value = stat
		SmoothCheck()
	)

	on Weld_Smooth2 changed stat do
	(
		M3G_ImportInfo_Glb.setWeldSmooth.value = 5
		SmoothCheck()
	)

	on Smooth_Type changed stat do
	(
		M3G_ImportInfo_Glb.setSmoothType.value = stat
		SmoothCheck()
	)
	on Smooth_Angle changed val do
	(
		M3G_ImportInfo_Glb.setSmoothAngle.value = val
	)

	on Bone_Show changed state do
	(
		M3G_ImportInfo_Glb.setBLink.value = state
	)
	on Bone_Entity changed state do
	(
		M3G_ImportInfo_Glb.setBEntity.value = state
		EntityCheck()
	)
	on Bone_Size changed val do
	(
		M3G_ImportInfo_Glb.setBSize.value = val
	)
	on Bone_Lens changed val do
	(
		M3G_ImportInfo_Glb.setBLens.value = val
	)
	on Bone_Anim changed state do
	(
		M3G_ImportInfo_Glb.setBAnim.value = state
	)

	on Att_Size changed val do
	(
		M3G_ImportInfo_Glb.setAttSize.value = val
	)
	on Coll_Att changed state do
	(
		M3G_ImportInfo_Glb.setAttColl.value = state
	)
	on Coll_Vol changed state do
	(
		M3G_ImportInfo_Glb.setVolColl.value = state
	)
	on Coll_Hit changed state do
	(
		M3G_ImportInfo_Glb.setHitColl.value = state
	)

	on Light_Trans changed state do
	(
		M3G_ImportInfo_Glb.setLTrans.value = state
	)
	on Light_Par changed state do
	(
		M3G_ImportInfo_Glb.setLPar.value = state
	)
	on Camera_Trans changed state do
	(
		M3G_ImportInfo_Glb.setCTrans.value = state
	)
	on Camera_Par changed state do
	(
		M3G_ImportInfo_Glb.setCPar.value = state
	)
	on Part_Trans changed state do
	(
		M3G_ImportInfo_Glb.setPTrans.value = state
	)
	on Part_Par changed state do
	(
		M3G_ImportInfo_Glb.setPPar.value = state
	)
)

rollout M3P_ImportPanel "M3 Import" width:214
(
	subrollout Import_subRoll align:#center width:214 height:760
	label ImporterVer_label "" align:#left
	label ImporterDate_label "" align:#left
	label lb1 "Language :" pos:[13,810] width:60 height:17
	button Default_Btn "Default" pos:[140,770] width:56 height:32
	dropdownlist Language_Drop "" pos:[116,806] width:80 height:3 items:#("English","中文")
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

macroScript M3M_ExpandMiscUtil
category:"CaptainD"
internalcategory:"CaptainD"
ButtonText:"M3-ExpandTools"
tooltip:"Expand misc tools Btn."
icon:#("VCRControls", 11)
(
	on execute do
	(
		if(M3G_ImportInfo_Glb != undefined)then
		(
			local cuiFile = cui.getConfigFile()
			if(doesFileExist cuiFile)then
			(
				setINISetting cuiFile #CaptainD #ItemCount ((M3G_ImportInfo_Glb.toolsBtn+2) as string)
				setINISetting cuiFile #CaptainD "item0" M3G_ImportInfo_Glb.btnItem[1]
				setINISetting cuiFile #CaptainD "item1" M3G_ImportInfo_Glb.btnItem[3]
				for i=1 to M3G_ImportInfo_Glb.toolsBtn do
				(
					setINISetting cuiFile #CaptainD ("item"+((i+1) as string)) M3G_ImportInfo_Glb.btnItem[i+3]
				)
				cui.loadConfig cuiFile
				M3G_ImportInfo_Glb.toolsBtnExpand.value = true
				M3G_ImportInfo_Glb.accessMiscSettings #save
			)
		)
	)
)

macroScript M3M_CollapseMiscUtil
category:"CaptainD"
internalcategory:"CaptainD"
ButtonText:"M3-CollapseTools"
tooltip:"Collapse misc tools Btn."
icon:#("VCRControls", 3)
(
	on execute do
	(
		if(M3G_ImportInfo_Glb != undefined)then
		(
			local cuiFile = cui.getConfigFile()
			if(doesFileExist cuiFile)then
			(
				setINISetting cuiFile #CaptainD #ItemCount "2"
				setINISetting cuiFile #CaptainD "item0" M3G_ImportInfo_Glb.btnItem[1]
				setINISetting cuiFile #CaptainD "item1" M3G_ImportInfo_Glb.btnItem[2]
				cui.loadConfig cuiFile
				M3G_ImportInfo_Glb.toolsBtnExpand.value = false
				M3G_ImportInfo_Glb.accessMiscSettings #save
			)
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