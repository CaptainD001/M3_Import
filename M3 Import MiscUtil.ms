
rollout M3P_TexToolWaitUI "Wait" width:170 height:70
(
	label wait_label "Waiting for finished..." pos:[32,32] height:160 width:360
)

rollout M3P_TexToolUI "Textures Fix Tool" height:500 width:800
(
	local local_language = "English"
	local Splitter_dis = 400
	local texCheckAll = false
	local pathCheckAll = false
	local source_changed = false
	local searched = 0
	local tex_source = 1
	local use_m3path = true
	local root_enable = true
	local copy_enable = false
	local subfolder_enable = true
	local casc_enable = false
	local root_path = ""
	local search_paths = #("(RootPath)\\", \
						"(RootPath)\\Textures\\", \
						"(RootPath)\\Assets\\Textures\\")
	local search_path_enables = #(true, true, true)
	local copy_path = ""

	local split_container
	local def_label
	local red_label1
	local yellow_label1
	local tex_list_view
	local path_list_view
	local tex_group
	local tex_btn
	local source_radio_btn1
	local source_radio_btn2
	local use_m3path_cbox
	local source_path_text
	local source_select_btn
	local root_cbox
	local root_path_text
	local root_path_select_btn
	local path_add_btn
	local path_delete_btn
	local path_default_btn
	local path_subfolder_cbox
	local casc_cbox
	local copy_cbox
	local copy_path_text
	local copy_path_select_btn
	local language_ddl
	local search_btn
	local apply_btn

	dotNetControl panel_container "System.Windows.Forms.Panel" pos:[8,8] align:#left height:484 width:784

	fn translateLanguage =
	(
		def_label.Text = 						M3F_AccessINI #language \
			(M3S_INIdata local_language "TexTool_ColDef" "ColDefinition:") #load
		red_label1.Text = 						M3F_AccessINI #language \
			(M3S_INIdata local_language "TexTool_ColNot" "Texture not exist") #load
		yellow_label1.Text = 					M3F_AccessINI #language \
			(M3S_INIdata local_language "TexTool_ColApply" "Path not apply") #load

		tex_list_view.Columns.Item[1].Text = 	M3F_AccessINI #language \
			(M3S_INIdata local_language "TexTool_TexListTex" "Textures") #load
		tex_list_view.Columns.Item[2].Text = 	M3F_AccessINI #language \
			(M3S_INIdata local_language "TexTool_TexListPath" "Paths") #load
		tex_group.Text = 						M3F_AccessINI #language \
			(M3S_INIdata local_language "TexTool_TexGroup" "Textures") #load
		source_radio_btn1.Text = 				M3F_AccessINI #language \
			(M3S_INIdata local_language "TexTool_TexFrom1" "Textures from scene") #load
		source_radio_btn2.Text = 				M3F_AccessINI #language \
			(M3S_INIdata local_language "TexTool_TexFrom2" "Textures from file") #load
		use_m3path_cbox.Text = 					M3F_AccessINI #language \
			(M3S_INIdata local_language "TexTool_TexRootEnable" "(Use FilePath as RootPath)") #load
		source_select_btn.Text = 				M3F_AccessINI #language \
			(M3S_INIdata local_language "TexTool_TexSlt" "Select") #load

		root_cbox.Text = 						M3F_AccessINI #language \
			(M3S_INIdata local_language "TexTool_RootEnable" "Root Path:") #load
		root_path_select_btn.Text = 			M3F_AccessINI #language \
			(M3S_INIdata local_language "TexTool_RootSlt" "Select") #load

		path_subfolder_cbox.Text = 				M3F_AccessINI #language \
			(M3S_INIdata local_language "TexTool_PathSubEnable" "Search subfolders") #load
		casc_cbox.Text = 						M3F_AccessINI #language \
			(M3S_INIdata local_language "TexTool_PathCASC" "Search file from CASC") #load
		path_list_view.Columns.Item[1].Text = 	M3F_AccessINI #language \
			(M3S_INIdata local_language "TexTool_PathListPath" "Search Paths") #load

		copy_cbox.Text = 						M3F_AccessINI #language \
			(M3S_INIdata local_language "TexTool_CopyEnable" "Copy found textures to:") #load
		copy_path_select_btn.Text = 			M3F_AccessINI #language \
			(M3S_INIdata local_language "TexTool_CopySlt" "Select") #load

		search_btn.Text = 						M3F_AccessINI #language \
			(M3S_INIdata local_language "TexTool_SearchBtn" "Search") #load
		apply_btn.Text = 						M3F_AccessINI #language \
			(M3S_INIdata local_language "TexTool_ApplyBtn" "Apply") #load
	)

	fn checkCASCpathList =
	(
		if(M3G_ImportInfo_Glb.texToolUI.CASCpathList.count == 0)then
		(
			undo off
			(
				try(gc())catch()
				local time_ = timeStamp()
				local data_stream = MemStreamMgr.openFile "$plugcfg\\SC2DataIndex\\.SC2Index"

				while(not data_stream.eos())do
				(
					local data_path = data_stream.readLine()
					local data_name = toLower (filenameFromPath data_path)
					if(data_name != data_path)then
					(
						append M3G_ImportInfo_Glb.texToolUI.CASCpathList data_name
						append M3G_ImportInfo_Glb.texToolUI.CASCpathList data_path
					)
				)
				MemStreamMgr.close data_stream
				
				format "readIndex: % ms\n" (timestamp()-time_)
			)
		)
	)

	fn createCASCindex =
	(
		local i
		local idx_changed = false
		local game_dir = StarTools.Info.GetDir #localBuild
		if((doesFileExist (game_dir + "\\StarCraft II.exe")) != true)then
		(
			messageBox ("Wrong SC2 game path !!!\n" + \
						"Please select the game path first!!!\n" + \
						"Please select the folder containing the StarCraft II exe.")
			StarTools.Info.SetLocalBuildPath()

			game_dir = StarTools.Info.GetDir #localBuild
			if((doesFileExist (game_dir + "\\StarCraft II.exe")) != true)then
			(
				messageBox "Bad configuration. Operation cancelled."
				return false
			)
		)

		if((doesFileExist "$plugcfg\\SC2DataIndex\\Temp") != true)then
		(
			makeDir "$plugcfg\\SC2DataIndex\\Temp" all:true
		)
		local delete_temp = getFiles "$plugcfg\\SC2DataIndex\\Temp\\*.*"
		for i in delete_temp do(deleteFile i)
		local idx_files = getFiles (game_dir + "\\SC2Data\\data\\*.idx")
		local old_idx_files = getFiles "$plugcfg\\SC2DataIndex\\*.idx"
		for i=1 to old_idx_files.count do(old_idx_files[i] = filenameFromPath old_idx_files[i])
		for i in idx_files do
		(
			local file_name = filenameFromPath i
			local check_names = filterString (toLower file_name) "0123456789abcdef"
			local check_type = subString (toLower file_name) 11 -1
			if(check_names[1] == ".i" and check_names[2] == "x" and check_type == ".idx")then
			(
				local find = findItem old_idx_files file_name
				if(find > 0)then
				(
					local old_path = "$plugcfg\\SC2DataIndex\\" + file_name
					local old_date = getFileModDate old_path
					try(local new_date = getFileModDate i)catch
					(
						local temp_file = (i+"_copy")
						copyFile i temp_file
						local new_date = getFileModDate temp_file
						deleteFile temp_file
					)

					if(old_date != new_date)then
					(
						idx_changed = true
						deleteFile old_path
						copyFile i old_path
					)
					deleteItem old_idx_files find
				)else
				(
					idx_changed = true
					copyFile i ("$plugcfg\\SC2DataIndex\\" + file_name)
				)
			)
		)
		for i in old_idx_files do
		(
			idx_changed = true
			deleteFile ("$plugcfg\\SC2DataIndex\\" + i)
		)
		if((doesFileExist "$plugcfg\\SC2DataIndex\\.SC2Index") != true)then(idx_changed = true)

		if(idx_changed)then
		(
			deleteFile "$plugcfg\\SC2DataIndex\\.SC2Index"

			local check_select =  queryBox 	("***SC2DataIndex has changed.***\n\n" + \
											"The script needs to build the entire data index files.\n" + \
											"*Notice:It will take 1 to 2 minutes to continue.") \
											title:"Need rebuild SC2DataIndex !!!" beep:true

			if(check_select)then
			(
				undo off
				(
					local time_ = timeStamp()
					CreateDialog M3P_TexToolWaitUI style:#(#style_border) lockHeight:true lockWidth:true

					local result = M3G_ImportInfo_Glb.ExtractFileLib.WriteStorage \
						(game_dir + "\\SC2Data\\data") \
						(pathConfig.resolvePathSymbols "$plugcfg\\SC2DataIndex") \
						(pathConfig.resolvePathSymbols "$plugcfg\\SC2DataIndex\\.SC2Index")
					format "Build:% ms\n" (timestamp()-time_)

					if(result == 0)then
					(
						M3G_ImportInfo_Glb.texToolUI.CASCpathList = #()
						checkCASCpathList()
						try(destroyDialog M3P_TexToolWaitUI)catch()
						true
					)else
					(
						local delete_files = getFiles "$plugcfg\\SC2DataIndex\\*.idx"
						for i in delete_files do(deleteFile i)
						try(destroyDialog M3P_TexToolWaitUI)catch()
						false
					)
				)
			)else
			(
				local delete_files = getFiles "$plugcfg\\SC2DataIndex\\*.idx"
				for i in delete_files do(deleteFile i)
				false
			)
		)else
		(
			CreateDialog M3P_TexToolWaitUI style:#(#style_border) lockHeight:true lockWidth:true
			checkCASCpathList()
			try(destroyDialog M3P_TexToolWaitUI)catch()
			true
		)
	)

	fn expandRootPath path_FP =
	(
		local expand_path = copy path_FP
		local real_root_path = if(use_m3path and use_m3path_cbox.Enabled)then
		(
			getFilenamePath source_path_text.Text
		)else
		(
			if(root_enable and root_cbox.Enabled)then(root_path)else("")
		)
		
		if(matchPattern expand_path pattern:"(RootPath)\\*" ignoreCase:false)then
		(
			if(real_root_path.count > 0)then
			(
				expand_path = (real_root_path + (subString expand_path 12 -1))
			)else
			(
				expand_path = ""
			)
		)
		expand_path
	)

	fn checkRootPath =
	(
		local i
		local netClass = M3S_DotNetClass()
		local back_color = if(use_m3path and use_m3path_cbox.Enabled)then
		(
			if((getFilenamePath source_path_text.Text).count > 0)then(#(255,255,255))else(#(255,0,0))
		)else
		(
			if(root_enable and root_path_text.Text.count > 0)then(#(255,255,255))else(#(255,0,0))
		)

		if(matchPattern copy_path pattern:"(RootPath)\\*")then
		(
			copy_path_text.BackColor = \
				(netClass.getClass #Color).FromArgb back_color[1] back_color[2] back_color[3]
		)
		for i=0 to (path_list_view.Items.Count-1) do
		(
			if(matchPattern path_list_view.Items.Item[i].SubItems.Item[1].Text pattern:"(RootPath)\\*")then
			(
				path_list_view.Items.Item[i].BackColor = \
					(netClass.getClass #Color).FromArgb back_color[1] back_color[2] back_color[3]
			)
		)
	)

	fn findTextures tex_paths_FP =
	(
		local i, n, k
		local path_list = #()
		local ret_list = deepCopy tex_paths_FP

		if(copy_enable and copy_path.count > 0)then
		(
			local expand_path = expandRootPath copy_path
			if(expand_path.count > 0)then(appendIfUnique path_list expand_path)
		)
		for i=1 to search_paths.count do
		(
			if(search_path_enables[i])then
			(
				local expand_path = expandRootPath search_paths[i]
				if(expand_path.count > 0)then
				(
					appendIfUnique path_list expand_path
					if(subfolder_enable)then
					(
						local sub_path_list = #(expand_path)
						n = 0
						while n < sub_path_list.count do
						(
							n = n + 1
							local find_sub = getDirectories (sub_path_list[n] + "*")
							for k in find_sub do
							(
								appendIfUnique sub_path_list k
							)
						)
						for n in sub_path_list do
						(
							appendIfUnique path_list n
						)
					)
				)
			)
		)

		for i=1 to path_list.count do
		(
			mapPaths.add path_list[i]
			for n=1 to tex_paths_FP.count do
			(
				local map_name = filenameFromPath tex_paths_FP[n]
				local path_found = (mapPaths.getFullFilePath map_name)
				if(path_found != "" and (ret_list[n] == tex_paths_FP[n]))then(ret_list[n] = path_found)
			)
			try(mapPaths.delete (mapPaths.count()))catch()
		)
		ret_list
	)

	fn getBitmapName idx_FP =
	(
		local bitmap_name = #()
		case (classOf meditMaterials[idx_FP]) of
		(
			SC2_Standard_Material:
			(
				local bitmap_name = #(#Diffuse, #Decal, #Gloss, #Emissive1, #Emissive2, #Environment, \
					#EnvironmentMask, #AlphaMask, #NormalMap, #Heightmap, #Lightmap, #AmbientOcclusion, \
					#AlphaMask2, #GlossExp)
			)
			SC2_Displacement_Material:
			(
				local bitmap_name = #(#Displacement, #DisplacementStrengthTexture)
			)
			SC2_Terrain_Material:
			(
				local bitmap_name = #(#TerrainMaterial)
			)
			SC2_Volume_Material:
			(
				local bitmap_name = #(#ColorMap, #Noisy1, #Noisy2)
			)
			SC2_Creep_Material:
			(
				local bitmap_name = #(#CreepMaterial)
			)
			SC2_Volume_Noise_Material:
			(
				local bitmap_name = #(#ColorMap, #VolumeNoise1, #VolumeNoise2)
			)
			SC2_SplatTerrainBake_Material:
			(
				local bitmap_name = #(#DiffuseTexture, #NormalTexture, #SpecularTexture)
			)
		)
		bitmap_name
	)

	fn texListRefresh source_FP =
	(
		local i, n
		local tex_list = #()
		local netClass = M3S_DotNetClass()

		if(source_FP == 1)then
		(
			for i=1 to 24 do
			(
				local bitmap_name = getBitmapName i

				for n in bitmap_name do
				(
					local file_str = try((getProperty meditMaterials[i] n).FileName)catch("")
					if(file_str.count > 0)then
					(
						appendIfUnique tex_list file_str
					)
				)
			)
		)else
		(
			local streamR
			local file_path = source_path_text.Text
			local related_path = getFilenamePath file_path

			if(doesFileExist file_path)then
			(
				streamR = fOpen file_path "rb"
				local m3model = M3S_FileMain()
				local max_scene = M3S_SceneMain()

				m3model.readMaterials streamR
				fClose streamR
				max_scene.buildMaterialsData m3model

				for i=1 to max_scene.sMaterial.count do
				(
					for n=1 to max_scene.sMaterial[i].mapsData.count do
					(
						if(max_scene.sMaterial[i].mapsData[n].MapType == 1)then
						(
							local tex_file_name = try(copy max_scene.sMaterial[i].mapsData[n].FileName)catch("")
							if(tex_file_name != "")then
							(appendIfUnique tex_list tex_file_name)
						)
					)
				)
				tex_list = findTextures tex_list
			)
		)

		local items_list = #()
		tex_list_view.Items.Clear()
		for i=1 to tex_list.count do
		(
			local texture_str = filenameFromPath tex_list[i]
			local path_str = getFilenamePath tex_list[i]
			append items_list (netClass.createCtl #ListViewItem)
			items_list[items_list.count].Checked = true
			items_list[items_list.count].SubItems.Add texture_str
			items_list[items_list.count].SubItems.Add path_str

			if((doesFileExist tex_list[i]) != true)then
			(
				items_list[items_list.count].Name = "NotFound"
				items_list[items_list.count].BackColor = (netClass.getClass #Color).FromArgb 0xFFFF0000
			)
		)
		tex_list_view.Items.AddRange items_list
	)

	fn texRefreshBtn sender_FP e_FP =
	(
		texListRefresh tex_source
		source_changed = false
		searched = 0
	)

	fn texSourceRBtnSelect sender_FP e_FP =
	(
		if(sender_FP.Checked == false)then(return false)
		case sender_FP.Name of
		(
			"source_radio_btn1":
			(
				tex_source = 1
				source_path_text.Enabled = false
				source_select_btn.Enabled = false
				use_m3path_cbox.Enabled = false
				root_cbox.Enabled = true
				root_path_text.Enabled = root_enable
				root_path_select_btn.Enabled = root_enable
			)
			"source_radio_btn2":
			(
				tex_source = 2
				source_path_text.Enabled = true
				source_select_btn.Enabled = true
				use_m3path_cbox.Enabled = true
				root_cbox.Enabled = if(use_m3path)then(false)else(true)
				root_path_text.Enabled = if(use_m3path)then(false)else(root_enable)
				root_path_select_btn.Enabled = if(use_m3path)then(false)else(root_enable)
			)
		)
		source_changed = true
		checkRootPath()
	)

	fn selectPathBtn sender_FP e_FP =
	(
		if(sender_FP.Name == "copy_path_select_btn" or sender_FP.Name == "path_add_btn")then
		(
			local save_path = getSaveFileName \
				caption:"Select a path" \
				filename:".savePath" \
				types:"Folder|.savePath|" \
				historyCategory:"Star2PresetFolder"
			if(save_path != undefined)then
			(
				save_path = getFilenamePath save_path
				if(use_m3path and use_m3path_cbox.Enabled)then
				(
					local source_path = source_path_text.Text
					if(source_path.count > 0)then
					(
						source_path = getFilenamePath source_path
						if(matchPattern save_path pattern:(source_path+"*") ignoreCase:false)then
						(
							save_path = "(RootPath)\\" + (subString save_path (source_path.count+1) -1)
						)
					)
				)else
				(
					if(root_path.count > 0 and root_enable)then
					(
						if(matchPattern save_path pattern:(root_path+"*") ignoreCase:false)then
						(
							save_path = "(RootPath)\\" + (subString save_path (root_path.count+1) -1)
						)
					)
				)
			)
		)

		case sender_FP.Name of
		(
			"source_select_btn":
			(
				local file = getOpenFileName \
					caption:"StarCraftII M3 File" \
					types:("Supported Files|*.m3;*.m3a" + \
					"|Starcraft 2 & Heroes of the Storm(*.m3)|*.m3" + \
					"|Animation Files(*.m3a)|*.m3a" + \
					"|All Files|*.*|") \
					historyCategory:"Star2PresetFolder"
				if(file != undefined)then
				(
					source_path_text.Text = file
					source_changed = true
					checkRootPath()
				)
			)
			"root_path_select_btn":
			(
				local save_path = getSaveFileName \
					caption:"Select a path" \
					filename:".searchPath" \
					types:"Folder|.searchPath|" \
					historyCategory:"Star2PresetFolder"
				if(save_path != undefined)then
				(
					save_path = getFilenamePath save_path
					root_path_text.Text = save_path
					root_path = save_path
					if(searched == 1)then(searched = 2)
					checkRootPath()
				)
			)
			"copy_path_select_btn":
			(
				if(save_path != undefined)then
				(
					copy_path_text.Text = save_path
					copy_path = save_path
					if(searched == 1)then(searched = 2)
					checkRootPath()
				)
			)
			"path_add_btn":
			(
				local netClass = M3S_DotNetClass()
				if(save_path != undefined)then
				(
					if((findItem search_paths save_path) == 0)then
					(
						append search_paths save_path
						append search_path_enables true
						local sub_item = netClass.createCtl #ListViewItem
						sub_item.Checked = true
						sub_item.SubItems.Add save_path
						path_list_view.Items.Add sub_item
						if(searched == 1)then(searched = 2)
						checkRootPath()
					)
				)
			)
		)
	)

	fn pathDeleteBtn sender_FP e_FP =
	(
		local i = 0

		while i < search_paths.count do
		(
			if(path_list_view.Items.Item[i].Checked != true)then
			(
				local find = findItem search_paths path_list_view.Items.Item[i].SubItems.Item[1].Text
				deleteItem search_paths find
				deleteItem search_path_enables find
				path_list_view.Items.RemoveAt i
				if(searched == 1)then(searched = 2)
				i = i - 1
			)
			i = i + 1
		)
	)

	fn pathDefaultBtn sender_FP e_FP =
	(
		local netClass = M3S_DotNetClass()
		search_paths = #("(RootPath)\\", \
						"(RootPath)\\Textures\\", \
						"(RootPath)\\Assets\\Textures\\")
		search_path_enables = #(true, true, true)

		path_list_view.Items.Clear()
		for i=1 to search_paths.count do
		(
			local sub_item = netClass.createCtl #ListViewItem
			sub_item.Checked = search_path_enables[i]
			sub_item.SubItems.Add search_paths[i]
			path_list_view.Items.Add sub_item
		)

		if(searched == 1)then(searched = 2)
		checkRootPath()
	)

	fn enabledCBox sender_FP e_FP =
	(
		case sender_FP.Name of
		(
			"root_cbox":
			(
				if(sender_FP.Checked == true)then
				(
					root_enable = true
					root_path_text.Enabled = true
					root_path_select_btn.Enabled = true
				)else
				(
					root_enable = false
					root_path_text.Enabled = false
					root_path_select_btn.Enabled = false
				)
				if(searched == 1)then(searched = 2)
				checkRootPath()
			)
			"copy_cbox":
			(
				if(sender_FP.Checked == true)then
				(
					copy_enable = true
					copy_path_text.Enabled = true
					copy_path_select_btn.Enabled = true
				)else
				(
					copy_enable = false
					copy_path_text.Enabled = false
					copy_path_select_btn.Enabled = false
				)
				if(searched == 1)then(searched = 2)
			)
			"path_subfolder_cbox":
			(
				if(sender_FP.Checked == true)then
				(
					subfolder_enable = true
				)else
				(
					subfolder_enable = false
				)
				if(searched == 1)then(searched = 2)
			)
			"use_m3path_cbox":
			(
				if(sender_FP.Checked == true)then
				(
					use_m3path = true
					root_cbox.Enabled = false
					root_path_text.Enabled = false
					root_path_select_btn.Enabled = false
				)else
				(
					use_m3path = false
					root_cbox.Enabled = true
					root_path_text.Enabled = root_enable
					root_path_select_btn.Enabled = root_enable
				)
				if(searched == 1)then(searched = 2)
				checkRootPath()
			)
			"casc_cbox":
			(
				if(sender_FP.Checked == true)then
				(
					if(createCASCindex())then
					(
						casc_enable = true
					)else
					(
						sender_FP.Checked = false
						casc_enable = false
					)
				)else
				(
					casc_enable = false
				)
			)
		)
	)

	fn searchBtn sender_FP e_FP =
	(
		if(source_changed)then
		(
			messageBox "Please refresh textures list first!!!"
			return false
		)
		if(searched == 2)then
		(
			texListRefresh tex_source
			source_changed = false
		)
		searched = 1

		local i
		local netClass = M3S_DotNetClass()
		local index_list = #()
		local tex_list = #()
		local path_list = #()
		local expand_copy_path = if(copy_enable and copy_path.count > 0)then(expandRootPath copy_path)else("")
		local expand_search_path = ""
		for i=1 to search_paths.count do
		(
			if(search_path_enables[i] and search_paths[i].count > 0)then
			(
				expand_search_path = expandRootPath search_paths[i]
				if(expand_search_path.count > 0)then(exit)
			)
		)
		if(expand_search_path.count == 0 and expand_copy_path.count > 0)then
		(expand_search_path = copy expand_copy_path)

		for i=0 to (tex_list_view.Items.Count-1) do
		(
			if(tex_list_view.Items.Item[i].Checked and tex_list_view.Items.Item[i].Name == "NotFound")then
			(
				append index_list i
				append tex_list (copy tex_list_view.Items.Item[i].SubItems.Item[1].Text)
			)
		)
		CreateDialog M3P_TexToolWaitUI style:#(#style_border) lockHeight:true lockWidth:true
		path_list = findTextures tex_list

		local data_dir = (StarTools.Info.GetDir #localBuild) + "\\SC2Data\\data"
		local idx_dir = pathConfig.resolvePathSymbols "$plugcfg\\SC2DataIndex\\"
		for i=1 to tex_list.count do
		(
			if(tex_list[i] != path_list[i])then
			(
				local index = index_list[i]
				tex_list_view.Items.Item[index].Name = "NotApply"
				tex_list_view.Items.Item[index].SubItems.Item[2].Text = getFilenamePath path_list[i]
				tex_list_view.Items.Item[index].BackColor = (netClass.getClass #Color).FromArgb 0xFFFFFF00
			)else
			(
				if(casc_enable and expand_search_path.count > 0)then
				(
					local file_exist = false
					local file_copy_dir = idx_dir + "Temp\\" + tex_list[i]
					if(doesFileExist file_copy_dir)then
					(
						file_exist = true
					)else
					(
						local time_ = timestamp()
						local file_name = toLower tex_list[i]
						
						local find_index = findItem M3G_ImportInfo_Glb.texToolUI.CASCpathList file_name
						local find_item = if(find_index != 0)then
						(
							M3G_ImportInfo_Glb.texToolUI.CASCpathList[find_index+1]
						)else(undefined)
						
						format "findItem:% file_name:%\n" find_item file_name
						format "findItem: % ms\n" (timestamp()-time_)

						if(find_item != undefined)then
						(
							time_ = timestamp()
							local result = M3G_ImportInfo_Glb.ExtractFileLib.ExtractFile \
								data_dir idx_dir find_item file_copy_dir
							if(result == 0)then(file_exist = true)
							format "ExtractFile: % ms\n" (timestamp()-time_)
						)
					)

					if(file_exist)then
					(
						local index = index_list[i]
						tex_list_view.Items.Item[index].Name = "NotApplyCASC"
						tex_list_view.Items.Item[index].SubItems.Item[2].Text = idx_dir + "Temp\\"
						tex_list_view.Items.Item[index].BackColor = \
							(netClass.getClass #Color).FromArgb 0xFFFFFF00
					)
				)
			)
		)

		for i=0 to (tex_list_view.Items.Count-1) do
		(
			if(tex_list_view.Items.Item[i].Checked and tex_list_view.Items.Item[i].Name != "NotFound")then
			(
				if(expand_copy_path.count > 0)then
				(
					if(tex_list_view.Items.Item[i].SubItems.Item[2].Text != expand_copy_path)then
					(
						tex_list_view.Items.Item[i].Name = "NotApplyCopy"
						local origin_path = tex_list_view.Items.Item[i].SubItems.Item[2].Text
						if(tex_list_view.Items.Item[i].SubItems.Count  == 3)then
						(
							tex_list_view.Items.Item[i].SubItems.Add origin_path
						)else
						(
							tex_list_view.Items.Item[i].SubItems.Item[3].Text = origin_path
						)
						tex_list_view.Items.Item[i].SubItems.Item[2].Text = expand_copy_path
						tex_list_view.Items.Item[i].BackColor = (netClass.getClass #Color).FromArgb 0xFFFFFF00
					)
				)else if(tex_list_view.Items.Item[i].Name == "NotApplyCASC")then
				(
					local origin_path = tex_list_view.Items.Item[i].SubItems.Item[2].Text
					if(tex_list_view.Items.Item[i].SubItems.Count  == 3)then
					(
						tex_list_view.Items.Item[i].SubItems.Add origin_path
					)else
					(
						tex_list_view.Items.Item[i].SubItems.Item[3].Text = origin_path
					)
					tex_list_view.Items.Item[i].SubItems.Item[2].Text = expand_search_path
				)
			)
		)
		try(destroyDialog M3P_TexToolWaitUI)catch()
	)

	fn applyBtn sender_FP e_FP =
	(
		if(source_changed)then
		(
			messageBox "Please refresh textures list first!!!"
			return false
		)
		local i, n, k
		local netClass = M3S_DotNetClass()

		CreateDialog M3P_TexToolWaitUI style:#(#style_border) lockHeight:true lockWidth:true
		for i=0 to (tex_list_view.Items.Count-1) do
		(
			if(tex_list_view.Items.Item[i].Checked)then
			(
				local tex_type = tex_list_view.Items.Item[i].Name

				if((tex_type == "NotApplyCopy" and copy_enable) or (tex_type == "NotApplyCASC"))then
				(
					local old_file_path = tex_list_view.Items.Item[i].SubItems.Item[3].Text + \
						tex_list_view.Items.Item[i].SubItems.Item[1].Text
					local new_file_path = tex_list_view.Items.Item[i].SubItems.Item[2].Text + \
						tex_list_view.Items.Item[i].SubItems.Item[1].Text
					makeDir tex_list_view.Items.Item[i].SubItems.Item[2].Text all:true
					copyFile old_file_path new_file_path
				)

				if(tex_source == 1 and (matchPattern tex_list_view.Items.Item[i].Name pattern:"NotApply*"))then
				(
					local full_file_path = tex_list_view.Items.Item[i].SubItems.Item[2].Text + \
						tex_list_view.Items.Item[i].SubItems.Item[1].Text
					for n=1 to 24 do
					(
						local bitmap_name = getBitmapName n

						for k in bitmap_name do
						(
							local file_str = try((getProperty meditMaterials[n] k).FileName)catch("")
							if(file_str.count > 0)then
							(
								local file_name = filenameFromPath file_str
								if(file_name == tex_list_view.Items.Item[i].SubItems.Item[1].Text)then
								(
									local bitmap_obj = getProperty meditMaterials[n] k
									bitmap_obj.FileName = full_file_path
								)
							)
						)
					)
				)
			)
		)
		texListRefresh tex_source
		source_changed = false
		try(destroyDialog M3P_TexToolWaitUI)catch()
	)

	fn pathListItemCheck sender_FP e_FP =
	(
		local find = findItem search_paths path_list_view.Items.Item[e_FP.Index].SubItems.Item[1].Text
		if(e_FP.CurrentValue == e_FP.CurrentValue.Unchecked)then
		(
			search_path_enables[find] = true
		)else
		(
			search_path_enables[find] = false
		)
		if(searched == 1)then(searched = 2)
	)

	fn pathListItemDrag sender_FP e_FP =
	(
		local netClass = M3S_DotNetClass()
		sender_FP.DoDragDrop e_FP.Item ((netClass.getClass #DragDropEffects).Move)
	)

	fn pathListDragEnter sender_FP e_FP =
	(
		e_FP.Effect = e_FP.AllowedEffect
	)

	fn pathListDragOver sender_FP e_FP =
	(
		local netClass = M3S_DotNetClass()
		local point_screen = netClass.createObject #Point
		point_screen.X = e_FP.X
		point_screen.Y = e_FP.Y

		local point_client = sender_FP.PointToClient point_screen
		local index = sender_FP.InsertionMark.NearestIndex point_client

		if(index > -1)then
		(
			local item_bounds = sender_FP.GetItemRect index
			if(point_client.Y > item_bounds.Top + (item_bounds.Height / 2))then
			(
				sender_FP.InsertionMark.AppearsAfterItem = true
			)else
			(
				sender_FP.InsertionMark.AppearsAfterItem = false
			)
		)

		sender_FP.InsertionMark.Index = index
	)

	fn pathListDragLeave sender_FP e_FP =
	(
		sender_FP.InsertionMark.Index = -1;
	)

	fn pathListDragDrop sender_FP e_FP =
	(
		local netClass = M3S_DotNetClass()
		local index = sender_FP.InsertionMark.Index
		if(index > -1)then
		(
			if(sender_FP.InsertionMark.AppearsAfterItem)then(index += 1)

			local cur_item = e_FP.Data.GetData (netClass.getClass #ListViewItem)
			local old_index = cur_item.Index + 1
			sender_FP.Items.Insert index (cur_item.Clone())
			sender_FP.Items.Remove cur_item

			local move_item_string = copy search_paths[old_index]
			search_paths[old_index] = undefined
			insertItem move_item_string search_paths (index+1)
			insertItem search_path_enables[old_index] search_path_enables (index+1)

			local find = findItem search_paths undefined
			if(find > 0)then
			(
				deleteItem search_paths find
				deleteItem search_path_enables find
			)
		)
	)

	fn texListSlectAll col_FP =
	(
		local i
		if(col_FP.Column == 0)then
		(
			texCheckAll = not texCheckAll
			tex_list_view.Columns.Item[0].ImageIndex = if(texCheckAll)then(1)else(0)
			for i=0 to(tex_list_view.Items.Count-1)do
			(
				tex_list_view.Items.Item[i].Checked = texCheckAll
			)
		)
	)

	fn pathListSlectAll col_FP =
	(
		local i
		if(col_FP.Column == 0)then
		(
			pathCheckAll = not pathCheckAll
			path_list_view.Columns.Item[0].ImageIndex = if(pathCheckAll)then(1)else(0)
			for i=0 to(path_list_view.Items.Count-1)do
			(
				path_list_view.Items.Item[i].Checked = pathCheckAll
			)
		)
	)

	fn languageChanged sender_FP e_FP =
	(
		case sender_FP.SelectedIndex of
		(
			0: local_language = "English"
			1: local_language = "Chinese"
		)
		translateLanguage()
	)

	fn texToolUIinit =
	(
		local netClass = M3S_DotNetClass()
		local icon_path1 = #( \
			(symbolicPaths.expandFileName "$Temp\\M3Import_mzp\\Icons\\Check1.bmp"), \
			(symbolicPaths.expandFileName "$Temp\\M3Import_mzp\\Icons\\Check2.bmp"))
		local icon_path2 = #( \
			(symbolicPaths.expandFileName "$Temp\\M3Import_mzp\\Icons\\Refresh.png"), \
			(symbolicPaths.expandFileName "$Temp\\M3Import_mzp\\Icons\\Add.png"), \
			(symbolicPaths.expandFileName "$Temp\\M3Import_mzp\\Icons\\Delete.png"))

		split_container = netClass.createCtl #SplitContainer a:#Dock v:"Fill" w:panel_container.Width
		split_container.SplitterDistance = Splitter_dis
		panel_container.Controls.Add split_container

		--------------------------------------------------------------------------------------------------
		def_label = netClass.createCtl #Label x:4 y:2 w:80 h:17 t:"ColDefinition:"
		split_container.Panel1.Controls.Add def_label

		local red_label = netClass.createCtl #Label x:84 y:0 w:30 h:17 t:"" bc:[255,0,0]
		split_container.Panel1.Controls.Add red_label

		red_label1 = netClass.createCtl #Label x:114 y:2 w:96 h:17 t:"Texture not exist"
		split_container.Panel1.Controls.Add red_label1

		local yellow_label = netClass.createCtl #Label x:210 y:0 w:30 h:17 t:"" bc:[255,255,0]
		split_container.Panel1.Controls.Add yellow_label

		yellow_label1 = netClass.createCtl #Label x:240 y:2 w:96 h:17 t:"Path not apply"
		split_container.Panel1.Controls.Add yellow_label1
		--------------------------------------------------------------------------------------------------

		--------------------------------------------------------------------------------------------------
		tex_list_view = netClass.createCtl #ListView a:#Anchor v:"Left, Right, Top, Bottom" \
			x:0 \
			y:20 \
			w:split_container.SplitterDistance \
			h:(split_container.Height - 20)
		tex_list_view.View = (netClass.getClass #View).Details
		tex_list_view.AllowColumnReorder = true
		tex_list_view.checkBoxes = true
		tex_list_view.FullRowSelect = true
		tex_list_view.GridLines = true
		--tex_list_view.Sorting = (netClass.getClass #Sort).Ascending
		tex_list_view.HeaderStyle = (netClass.getClass #ColumnHeaderStyle).Clickable

		local image_list_small = netClass.createImageList #Bitmap icon_path1
		local image_list_large = netClass.createImageList #Bitmap icon_path1
		tex_list_view.SmallImageList = image_list_small
		tex_list_view.LargeImageList = image_list_large

		tex_list_view.Columns.Add "" 30
		tex_list_view.Columns.Item[0].ImageIndex = 0
		tex_list_view.Columns.Add "Textures" 72
		tex_list_view.Columns.Add "Paths" (split_container.SplitterDistance-110)

		dotnet.addeventhandler tex_list_view "ColumnClick" texListSlectAll
		split_container.Panel1.Controls.Add tex_list_view
		--------------------------------------------------------------------------------------------------

		--------------------------------------------------------------------------------------------------
		path_list_view = netClass.createCtl #ListView a:#Anchor v:"Left, Right, Top, Bottom" \
			x:0 \
			y:200 \
			w:(split_container.Width - split_container.SplitterDistance - 4) \
			h:(split_container.Height - 300)
		path_list_view.View = (netClass.getClass #View).Details
		path_list_view.AllowColumnReorder = true
		path_list_view.checkBoxes = true
		path_list_view.FullRowSelect = true
		path_list_view.GridLines = true
		path_list_view.AllowDrop = true
		--path_list_view.Sorting = (netClass.getClass #Sort).Ascending
		path_list_view.HeaderStyle = (netClass.getClass #ColumnHeaderStyle).Clickable

		local image_list_small1 = netClass.createImageList #Bitmap icon_path1
		local image_list_large1 = netClass.createImageList #Bitmap icon_path1
		path_list_view.SmallImageList = image_list_small1
		path_list_view.LargeImageList = image_list_large1

		path_list_view.Columns.Add "" 30
		path_list_view.Columns.Item[0].ImageIndex = 0
		path_list_view.Columns.Add "Search Paths" (path_list_view.Width - 38)

		if(search_paths.count > 0)then
		(
			local i
			local items_list = #()

			for i=1 to search_paths.count do
			(
				append items_list (netClass.createCtl #ListViewItem)
				items_list[items_list.count].Checked = search_path_enables[i]
				items_list[items_list.count].SubItems.Add search_paths[i]
				items_list[items_list.count].Name = "Created"
			)
			path_list_view.Items.AddRange items_list
		)

		split_container.Panel2.Controls.Add path_list_view
		dotnet.addeventhandler path_list_view "ColumnClick" pathListSlectAll
		dotnet.addeventhandler path_list_view "ItemCheck" pathListItemCheck
		dotnet.addeventhandler path_list_view "ItemDrag" pathListItemDrag
		dotnet.addeventhandler path_list_view "DragEnter" pathListDragEnter
		dotnet.addeventhandler path_list_view "DragOver" pathListDragOver
		dotnet.addeventhandler path_list_view "DragLeave" pathListDragLeave
		dotnet.addeventhandler path_list_view "DragDrop" pathListDragDrop
		--------------------------------------------------------------------------------------------------

		--------------------------------------------------------------------------------------------------
		tex_group = netClass.createCtl #GroupBox a:#Dock v:"Top" h:96 t:"Textures"
		split_container.Panel2.Controls.Add tex_group

		local image_list_btn = netClass.createImageList #Image icon_path2

		tex_btn = netClass.createCtl #Button x:10 y:20 w:36 h:36 t:""
		tex_btn.ImageIndex = 0
		tex_btn.ImageList = image_list_btn
		dotnet.addeventhandler tex_btn "Click" texRefreshBtn
		tex_group.Controls.Add tex_btn

		source_radio_btn1 = netClass.createCtl #RadioButton n:"source_radio_btn1" x:60 y:20 w:125 h:16 t:"Textures from scene"
		source_radio_btn1.Checked = true
		dotnet.addeventhandler source_radio_btn1 "CheckedChanged" texSourceRBtnSelect
		tex_group.Controls.Add source_radio_btn1

		source_radio_btn2 = netClass.createCtl #RadioButton n:"source_radio_btn2" x:60 y:40 w:115 h:16 t:"Textures from file"
		dotnet.addeventhandler source_radio_btn2 "CheckedChanged" texSourceRBtnSelect
		tex_group.Controls.Add source_radio_btn2

		use_m3path_cbox = netClass.createCtl #CheckBox n:"use_m3path_cbox" x:230 y:40 w:160 h:17 \
			t:"(Use FilePath as RootPath)"
		use_m3path_cbox.Checked = use_m3path
		use_m3path_cbox.Enabled = false
		dotnet.addeventhandler use_m3path_cbox "CheckedChanged" enabledCBox
		tex_group.Controls.Add use_m3path_cbox

		source_path_text = netClass.createCtl #TextBox a:#Anchor v:"Left, Right, Top" \
			x:10 y:65 w:(tex_group.Width - 80)
		source_path_text.ReadOnly = true
		source_path_text.Enabled = false
		source_path_text.BackColor = (netClass.getClass #Color).FromArgb 255 255 255
		tex_group.Controls.Add source_path_text

		source_select_btn = netClass.createCtl #Button n:"source_select_btn" a:#Anchor v:"Right, Top" \
			x:(tex_group.Width-63) y:63 w:56 h:25 t:"Select"
		source_select_btn.Enabled = false
		dotnet.addeventhandler source_select_btn "Click" selectPathBtn
		tex_group.Controls.Add source_select_btn
		--------------------------------------------------------------------------------------------------

		--------------------------------------------------------------------------------------------------
		root_cbox = netClass.createCtl #CheckBox n:"root_cbox" x:4 y:105 w:78 h:17 t:"Root Path:"
		root_cbox.Checked = root_enable
		dotnet.addeventhandler root_cbox "CheckedChanged" enabledCBox
		split_container.Panel2.Controls.Add root_cbox

		root_path_text = netClass.createCtl #TextBox a:#Anchor v:"Left, Right, Top" \
			x:4 y:125 w:(tex_group.Width-74)
		root_path_text.ReadOnly = true
		root_path_text.Text = root_path
		root_path_text.Enabled = root_enable
		root_path_text.BackColor = (netClass.getClass #Color).FromArgb 255 255 255
		split_container.Panel2.Controls.Add root_path_text

		root_path_select_btn = netClass.createCtl #Button n:"root_path_select_btn" a:#Anchor v:"Right, Top" \
			x:(split_container.Panel2.Width-63) y:123 w:56 h:25 t:"Select"
		root_path_select_btn.Enabled = root_enable
		dotnet.addeventhandler root_path_select_btn "Click" selectPathBtn
		split_container.Panel2.Controls.Add root_path_select_btn
		--------------------------------------------------------------------------------------------------

		--------------------------------------------------------------------------------------------------
		path_add_btn = netClass.createCtl #Button n:"path_add_btn" x:4 y:171 w:25 h:25 t:""
		path_add_btn.ImageIndex = 1
		path_add_btn.ImageList = image_list_btn
		dotnet.addeventhandler path_add_btn "Click" selectPathBtn
		split_container.Panel2.Controls.Add path_add_btn

		path_delete_btn = netClass.createCtl #Button x:33 y:171 w:25 h:25 t:""
		path_delete_btn.ImageIndex = 2
		path_delete_btn.ImageList = image_list_btn
		dotnet.addeventhandler path_delete_btn "Click" pathDeleteBtn
		split_container.Panel2.Controls.Add path_delete_btn

		path_default_btn = netClass.createCtl #Button x:62 y:171 w:25 h:25 t:"D"
		dotnet.addeventhandler path_default_btn "Click" pathDefaultBtn
		split_container.Panel2.Controls.Add path_default_btn

		path_subfolder_cbox = netClass.createCtl #CheckBox n:"path_subfolder_cbox" \
			x:100 y:175 w:113 h:17 t:"Search subfolders"
		path_subfolder_cbox.Checked = subfolder_enable
		dotnet.addeventhandler path_subfolder_cbox "CheckedChanged" enabledCBox
		split_container.Panel2.Controls.Add path_subfolder_cbox
		--------------------------------------------------------------------------------------------------

		--------------------------------------------------------------------------------------------------
		casc_cbox = netClass.createCtl #CheckBox n:"casc_cbox" a:#Anchor v:"Top, Right" \
			x:(split_container.Panel2.Width-140) y:175 w:140 h:17 t:"Search file from CASC"
		casc_cbox.Checked = casc_enable
		dotnet.addeventhandler casc_cbox "CheckedChanged" enabledCBox
		split_container.Panel2.Controls.Add casc_cbox
		--------------------------------------------------------------------------------------------------

		--------------------------------------------------------------------------------------------------
		copy_cbox = netClass.createCtl #CheckBox n:"copy_cbox" a:#Anchor v:"Left, Bottom" \
			x:10 y:(panel_container.Height-90) w:145 h:17 t:"Copy found textures to:"
		copy_cbox.Checked = copy_enable
		dotnet.addeventhandler copy_cbox "CheckedChanged" enabledCBox
		split_container.Panel2.Controls.Add copy_cbox

		copy_path_text = netClass.createCtl #TextBox a:#Anchor v:"Left, Right, Bottom" \
			x:4 y:(panel_container.Height-70) w:(tex_group.Width-74)
		copy_path_text.ReadOnly = true
		copy_path_text.Text = copy_path
		copy_path_text.Enabled = copy_enable
		copy_path_text.BackColor = (netClass.getClass #Color).FromArgb 255 255 255
		split_container.Panel2.Controls.Add copy_path_text

		copy_path_select_btn = netClass.createCtl #Button n:"copy_path_select_btn" a:#Anchor v:"Bottom, Right" \
			x:(split_container.Panel2.Width-63) y:(panel_container.Height-72) \
			w:56 h:25 t:"Select"
		copy_path_select_btn.Enabled = copy_enable
		dotnet.addeventhandler copy_path_select_btn "Click" selectPathBtn
		split_container.Panel2.Controls.Add copy_path_select_btn
		--------------------------------------------------------------------------------------------------

		--------------------------------------------------------------------------------------------------
		local language_label = netClass.createCtl #Label a:#Anchor v:"Left, Bottom" \
			x:10 y:(panel_container.Height-31) w:60 h:16 t:"Language:"
		split_container.Panel2.Controls.Add language_label

		language_ddl = netClass.createCtl #ComboBox a:#Anchor v:"Left, Bottom" \
			x:75 y:(panel_container.Height-34) w:100
		language_ddl.DropDownStyle = language_ddl.DropDownStyle.DropDownList
		language_ddl.Items.Add "English"
		language_ddl.Items.Add "Chinese"
		language_ddl.SelectedIndex = case local_language of
		(
			"English": 0
			"Chinese": 1
			default: 0
		)
		dotnet.addeventhandler language_ddl "SelectedIndexChanged" languageChanged
		split_container.Panel2.Controls.Add language_ddl
		--------------------------------------------------------------------------------------------------

		--------------------------------------------------------------------------------------------------
		search_btn = netClass.createCtl #Button a:#Anchor v:"Bottom, Right" \
			x:(split_container.Panel2.Width-148) y:(panel_container.Height-35) \
			w:70 h:35 t:"Search"
		dotnet.addeventhandler search_btn "Click" searchBtn
		split_container.Panel2.Controls.Add search_btn

		apply_btn = netClass.createCtl #Button a:#Anchor v:"Bottom, Right" \
			x:(split_container.Panel2.Width-74) y:(panel_container.Height-35) \
			w:70 h:35 t:"Apply"
		dotnet.addeventhandler apply_btn "Click" applyBtn
		split_container.Panel2.Controls.Add apply_btn
		--------------------------------------------------------------------------------------------------
	)

	on M3P_TexToolUI open do
	(
		panel_container.width = M3P_TexToolUI.width - 16
		panel_container.height = M3P_TexToolUI.height - 16
		Splitter_dis = M3G_ImportInfo_Glb.texToolUI.midUI.value

		local_language = M3G_ImportInfo_Glb.Language.value

		use_m3path = M3G_ImportInfo_Glb.texToolUI.m3PathEnable.value
		root_enable = M3G_ImportInfo_Glb.texToolUI.rootEnable.value
		copy_enable = M3G_ImportInfo_Glb.texToolUI.copyEnable.value
		subfolder_enable = M3G_ImportInfo_Glb.texToolUI.subFolderEnable.value
		casc_enable = M3G_ImportInfo_Glb.texToolUI.cascEnable.value

		root_path = copy M3G_ImportInfo_Glb.texToolUI.rootPath.value
		copy_path = copy M3G_ImportInfo_Glb.texToolUI.copyPath.value
		if(M3G_ImportInfo_Glb.texToolUI.searchPaths.value.count > 0)then
		(
			local i
			search_paths = #()
			search_path_enables = #()
			local string_list = filterString M3G_ImportInfo_Glb.texToolUI.searchPaths.value "{}"
			if(string_list[1] != "saved")then(insertItem "saved" string_list 1)
			for i=2 to string_list.count by 2 do
			(
				local index = (i / 2) as integer
				search_paths[index] = copy string_list[i]
				search_path_enables[index] = try(string_list[i+1] as BooleanClass)catch(true)
			)
		)

		texToolUIinit()
		translateLanguage()
		checkRootPath()
		if(casc_enable)then
		(
			if(createCASCindex() != true)then
			(
				casc_cbox.Checked = false
				casc_enable = false
			)
		)
		texListRefresh 1
	)

	on M3P_TexToolUI close do
	(
		local i
		local add_string = "saved"
		M3G_ImportInfo_Glb.texToolUI.posUI.value = GetDialogPos M3P_TexToolUI
		M3G_ImportInfo_Glb.texToolUI.widthUI.value = M3P_TexToolUI.width
		M3G_ImportInfo_Glb.texToolUI.heightUI.value = M3P_TexToolUI.height
		M3G_ImportInfo_Glb.texToolUI.midUI.value = split_container.SplitterDistance

		M3G_ImportInfo_Glb.Language.value = local_language

		M3G_ImportInfo_Glb.texToolUI.m3PathEnable.value = use_m3path
		M3G_ImportInfo_Glb.texToolUI.rootEnable.value = root_enable
		M3G_ImportInfo_Glb.texToolUI.copyEnable.value = copy_enable
		M3G_ImportInfo_Glb.texToolUI.subFolderEnable.value = subfolder_enable
		M3G_ImportInfo_Glb.texToolUI.cascEnable.value = casc_enable

		M3G_ImportInfo_Glb.texToolUI.rootPath.value = root_path
		M3G_ImportInfo_Glb.texToolUI.copyPath.value = copy_path
		for i=1 to search_paths.count do
		(
			add_string = add_string + "{" + search_paths[i] + "}{" + (search_path_enables[i] as string) + "}"
		)
		M3G_ImportInfo_Glb.texToolUI.searchPaths.value = add_string

		M3G_ImportInfo_Glb.texDialogCheck = false
		updateToolbarButtons()
		M3G_ImportInfo_Glb.accessMiscSettings #save
		M3G_ImportInfo_Glb.texToolUI.accessTexToolSettings #save
		try(gc())catch()
	)

	on M3P_TexToolUI resized rollsize do
	(
		panel_container.width = M3P_TexToolUI.width - 16
		panel_container.height = M3P_TexToolUI.height - 16
	)
)

struct M3S_TexturesFixTool
(
	mainUI,
	CASCpathList = #(),
	posUI 			= M3S_INIdata "TexturesTool" 		"posUI" 			[400, 250],
	widthUI			= M3S_INIdata "TexturesTool" 		"widthUI" 			800,
	heightUI		= M3S_INIdata "TexturesTool" 		"heightUI" 			500,
	midUI 			= M3S_INIdata "TexturesTool" 		"midUI" 			400,
	m3PathEnable 	= M3S_INIdata "TexturesTool" 		"m3PathEnable" 		true,
	rootEnable 		= M3S_INIdata "TexturesTool" 		"rootEnable" 		true,
	copyEnable 		= M3S_INIdata "TexturesTool" 		"copyEnable" 		false,
	subFolderEnable = M3S_INIdata "TexturesTool" 		"subFolderEnable" 	true,
	cascEnable 		= M3S_INIdata "TexturesTool" 		"cascEnable" 		false,
	rootPath 		= M3S_INIdata "TexturesTool" 		"rootPath" 			"",
	searchPaths 	= M3S_INIdata "TexturesTool" 		"searchPaths" 		"",
	copyPath 		= M3S_INIdata "TexturesTool" 		"copyPath" 			"",

	fn accessTexToolSettings type_FP =
	(
		M3F_AccessINI #setting this.posUI type_FP
		M3F_AccessINI #setting this.widthUI type_FP
		M3F_AccessINI #setting this.heightUI type_FP
		M3F_AccessINI #setting this.midUI type_FP

		M3F_AccessINI #setting this.m3PathEnable type_FP
		M3F_AccessINI #setting this.rootEnable type_FP
		M3F_AccessINI #setting this.copyEnable type_FP
		M3F_AccessINI #setting this.subFolderEnable type_FP
		M3F_AccessINI #setting this.cascEnable type_FP

		M3F_AccessINI #setting this.rootPath type_FP
		M3F_AccessINI #setting this.searchPaths type_FP
		M3F_AccessINI #setting this.copyPath type_FP
	),

	on create do
	(
		this.mainUI = M3P_TexToolUI
	)
)
M3G_ImportInfo_Glb.texToolUI = M3S_TexturesFixTool()