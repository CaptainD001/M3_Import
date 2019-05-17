---------------------------------------------------------------------------
---------------------------------------------------------------------------
--M3G--------------------M3 GLOBAL
--M3S--------------------M3 MAIN STRUCT
--M3SD-------------------M3 DATA STRUCT
--M3F--------------------M3 FUNCTION
--M3P--------------------M3 PANEL


/* Global */
M3G_CustAttributes_Glb = #()
M3G_InfoScene_Glb=#()
M3G_InfoFile_Glb=#()
--Declares------------------------------------------------
struct M3SD_RefAnim
(
	iptType, flags, animID, initState, nullState,
	--Build Items
	idx,
	fn init d1:0 d2:0 d3:0 s: t: =(),
	fn read stream_FP type_FP =()
)
struct M3SD_RefData
(
	ref,data,
	fn init type_FP d1:0 d2: s: t: =(),
	fn readRef stream_FP f:#index =(),
	fn readData stream_FP tags_FP f:#null =()
)

fn M3F_TempFunc left right =()
----------------------------------------------------------
/* Helper Functions */
fn M3F_FillProgressLv step:1.0 flag:#null =
(
	case flag of
	(
		#clear:
		(
			M3G_ImportInfo_Glb.currProgLv = 0.0
			M3G_ImportInfo_Glb.progressLv = 0.0
		)
		#execute:
		(
			M3G_ImportInfo_Glb.currProgLv += step
			local value = (M3G_ImportInfo_Glb.currProgLv / M3G_ImportInfo_Glb.progressLv) * 100.0
			if(value > 100)then(value = 100.0)
			M3G_ImportInfo_Glb.MainUI.Import_subRoll.rollouts[1].FillProgressLv value
		)
		#current:
		(
			M3G_ImportInfo_Glb.currProgLv += step
			local value = M3G_ImportInfo_Glb.currProgLv
			if(value > 100)then(value = 100.0)
			M3G_ImportInfo_Glb.MainUI.Import_subRoll.rollouts[1].FillProgressLv value
		)
		#buildfinished:
		(
			M3G_ImportInfo_Glb.currProgLv = M3G_ImportInfo_Glb.progressLv / 4.0
			M3G_ImportInfo_Glb.progressLv = M3G_ImportInfo_Glb.progressLv / 0.8
		)
		default:
		(
			M3G_ImportInfo_Glb.progressLv += step
		)
	)
)

fn M3F_ShowPhase str_FP =
(
	M3G_ImportInfo_Glb.MainUI.Import_subRoll.rollouts[1].ChangePhaseText str_FP
)

fn M3F_MissingMap str_FP =
(
	appendIfUnique M3G_ImportInfo_Glb.missingMap str_FP
)

fn M3F_GetGlobalSettings type_FP =
(
	local ret
	case type_FP of
	(
		#MatEnable: ret = M3G_ImportInfo_Glb.impMat.value
		#SeqEnable: ret = M3G_ImportInfo_Glb.impSeq.value
		#TrackEnable: ret = M3G_ImportInfo_Glb.impTrack.value
		#AnimEnable: ret = M3G_ImportInfo_Glb.impAnim.value
		#EventEnable: ret = M3G_ImportInfo_Glb.impEvt.value
		#BoneEnable: ret = M3G_ImportInfo_Glb.impBone.value
		#MeshEnable: ret = M3G_ImportInfo_Glb.impMesh.value
		#SkinEnable: ret = M3G_ImportInfo_Glb.impSkin.value
		#VolEnable: ret = M3G_ImportInfo_Glb.impVol.value
		#HitEnable: ret = M3G_ImportInfo_Glb.impHit.value
		#AttEnable: ret = M3G_ImportInfo_Glb.impAttach.value
		#LightEnable: ret = M3G_ImportInfo_Glb.impLight.value
		#CamEnable: ret = M3G_ImportInfo_Glb.impCam.value
		#ParEnable: ret = M3G_ImportInfo_Glb.impPart.value
		#PhyEnable: ret = M3G_ImportInfo_Glb.impPhy.value
		#FrameRate: ret = M3G_ImportInfo_Glb.setFRate.value
		#FramesBetweenSeq: ret = M3G_ImportInfo_Glb.setFBSeq.value
		#FrameCorrect: ret = M3G_ImportInfo_Glb.setFCorrect.value
		#FrameCheckRange: ret = M3G_ImportInfo_Glb.setFCheckR.value
		#MeshWeldEnable:
		(
			case M3G_ImportInfo_Glb.setWeldSmooth.value of
			(
				3: ret = false
				5: ret = false
				default: ret = true
			)
		)
		#MeshSmoothEnable:
		(
			case M3G_ImportInfo_Glb.setWeldSmooth.value of
			(
				3: ret = false
				4: ret = false
				default: ret = true
			)
		)
		#MeshWeldType:
		(
			case M3G_ImportInfo_Glb.setWeldSmooth.value of
			(
				2: ret = 2
				4: ret = 2
				default: ret = 1
			)
		)
		#MeshSmoothType:
		(
			ret = M3G_ImportInfo_Glb.setSmoothType.value
			case M3G_ImportInfo_Glb.setWeldSmooth.value of
			(
				2:()
				5:()
				default: ret = 3
			)
		)
		#MeshSmoothAngle: ret = M3G_ImportInfo_Glb.setSmoothAngle.value
		#BoneEntity: ret = M3G_ImportInfo_Glb.setBEntity.value
		#BoneSize: ret = M3G_ImportInfo_Glb.setBSize.value
		#BoneLens:
		(
			if(M3G_ImportInfo_Glb.setBEntity.value == true)then
			(
				ret = M3G_ImportInfo_Glb.setBLens.value
			)else(ret = 0.05)
		)
		#BoneAnim: ret = M3G_ImportInfo_Glb.setBAnim.value
		#BoneLink: ret = M3G_ImportInfo_Glb.setBLink.value
		#AttSize: ret = M3G_ImportInfo_Glb.setAttSize.value
		#AttColl: ret = M3G_ImportInfo_Glb.setAttColl.value
		#VolColl: ret = M3G_ImportInfo_Glb.setVolColl.value
		#HitColl: ret = M3G_ImportInfo_Glb.setHitColl.value
		#LightTrans: ret = M3G_ImportInfo_Glb.setLTrans.value
		#LightParm: ret = M3G_ImportInfo_Glb.setLPar.value
		#CameraTrans: ret = M3G_ImportInfo_Glb.setCTrans.value
		#CameraParm: ret = M3G_ImportInfo_Glb.setCPar.value
		#PartTrans: ret = M3G_ImportInfo_Glb.setPTrans.value
		#PartParm: ret = M3G_ImportInfo_Glb.setPPar.value
	)
	ret
)

fn M3F_Star2CustAttrInit =
(
	local names = #()
	local notfind = false

	local trackset_id = 0	--#(2065408834, 1381447041)
	try(trackset_id = M3G_CustAttributes_Glb[1].classID[1])
	catch(trackset_id = 0)
	if(trackset_id != 2065408834)then
	(
		notfind = true
		append names "SC2BehHolder_Temp"
	)

	if(notfind == true)then
	(
	 	mergeMAXFile ((getdir #temp) + "\\M3Import_mzp\\SC2ObjIn.max") names

		local cust_attr = custAttributes.getSceneDefs()
		for i=1 to cust_attr.count do
		(
			case cust_attr[i].classID[1] of
			(
				2065408834: M3G_CustAttributes_Glb[1] = cust_attr[i]
			)
		)

		for i=1 to names.count do
	 	(
	 		try(delete (getNodebyName names[i] exact:true))catch()
	 	)
	)
)

fn M3F_GetCustAttr type_FP =
(
	local copys
	case type_FP of
	(
		#trackset: copys = (startools.behaviors.GetBehaviorDef #TrackSet)
		#turret: copys = (startools.behaviors.GetBehaviorDef #Turret_Behavior)
		#IKleg: copys = (startools.behaviors.GetBehaviorDef #IK_Leg_Behavior)
		#billboard: copys = (startools.behaviors.GetBehaviorDef #Billboard_behavior)
		#joint: copys = (startools.behaviors.GetBehaviorDef #PhysicsJoint_Behavior)
	)
	return copys
)

fn M3F_SkipBytes stream_FP lens_FP =
(
	if(lens_FP == 0)then(return undefined)
	local ret_pos = fTell stream_FP
	fSeek stream_FP (ret_pos+lens_FP) #seek_set
)

fn M3F_Try data_FP init_FP =
(
	if data_FP != unsupplied and data_FP != undefined then return data_FP
	return init_FP
)

fn M3F_GetSize name_FP f:0 =
(
	local ret

	ret = case name_FP of
	(
		"MODL": case f of(0x17: 784;	0x1A: 832;	0x1D: 864)
		"SEQS": case f of(0x01: 96;		0x02: 92)
		"STC_": case f of(0x04: 204)
		"STG_": case f of(0x00: 24)
		"STS_": case f of(0x00: 28)
		"BONE": case f of(0x01: 160)
		"REGN": case f of(0x03: 36;		0x04: 40;	0x05: 48)
		"DIV_": case f of(0x02: 52)
		"IREF": case f of(0x00: 64)
		"ATT_": case f of(0x01: 20)
		"LITE": case f of(0x07: 212)
		"CAM_": case f of(0x03: 180)
		"MATM": case f of(0x00: 8)
		"MAT_": case f of(0x0F: 268;	0x10: 280;	0x11: 280;	0x12: 280;	0x13: 340;	0x14: 352)
		"LAYR": case f of(0x16: 356;	0x19: 468;	0x1A: 464)
		"DIS_": case f of(0x04: 68)
		"CMP_": case f of(0x02: 28)
		"TER_": case f of(0x01: 28)
		"VOL_": case f of(0x00: 84)
		"CREP": case f of(0x01: 28)
		"VON_": case f of(0x00: 268)
		"STBM": case f of(0x00: 48)
		"LFLR": case f of(0x02: 80;		0x03: 152)
		"PAR_": case f of(0x0C: 1316;	0x12: 1464;	0x15: 1464;	0x16: 1484; 0x17: 1492;	0x18: 1496)
		"RIB_": case f of(0x06: 748; 	0x08: 756;	0x09: 760)
		"PROJ": case f of(0x04: 388;	0x05: 388)
		"FOR_": case f of(0x01: 104;	0x02: 104)
		"WRP_": case f of(0x01: 132)
		"PHRB": case f of(0x04: 80)
		"PHYJ": case f of(0x00: 180)

		"EVNT": case f of(0x01: 104;	0x02: 108)
		"PHSH": case f of(0x03: 300)
		"DMSE": case f of(0x00: 4)
	)
	if ret == undefined then ret = 0

	return ret
)

fn M3F_FindRefType str_FP flag_FP =
(
	local ret

	ret = case str_FP of
	(
		"SDEV": "SDXX"
		"SD2V": "SDXX"
		"SD3V": "SDXX"
		"SD4Q": "SDXX"
		"SDCC": "SDXX"
		"SDR3": "SDXX"
		--"SDXX"unknown
		"SDS6": "SDXX"
		"SDU6": "SDXX"
		--"SDXX"unknown
		"SDU3": "SDXX"
		"SDFG": "SDXX"
		"SDMB": "SDXX"
		--Special
		"U32_": case flag_FP of(#U16_: "U16D")
	)
	if ret == undefined then ret = str_FP
	return ret
)

fn M3F_FindStart stream_FP tags_FP idx_FP nbr_FP =
(
	local size = M3F_GetSize tags_FP.nameStr[idx_FP] f:tags_FP.tags[idx_FP].flag
	return (tags_FP.tags[idx_FP].ofsData + (nbr_FP-1)*size)
)

fn M3F_ReadString stream_FP lens_FP f:#tag =
(
	local i
	local ret = ""

	if lens_FP == 4 and f == #tag then
	(
		for i=1 to 4 do
		(
			ret = bit.IntAsChar(ReadByte stream_FP) + ret
		)
	)else
	(
		if lens_FP > 0 then
		(
			for i=1 to lens_FP do
			(
				ret += bit.IntAsChar(ReadByte stream_FP)
			)
		)
	)

	return ret
)

fn M3F_CreateRawData d1:0 d2:0 d3:0 d4:0 t:#v3d =
(
	local ret
	ret = case t of
	(
		#uint16: d1
		#uint32: d1
		#float: d1
		#v2d: [d1, d2]
		#v3d: [d1, d2, d3]
		#v4d: [d1, d2, d3, d4]
		#quat: quat d1 d2 d3 d4
		#bgr: [d1, d2, d3]
		#bgra: [d1, d2, d3, d4]
		#matrix:
		(
			#(M3F_CreateRawData t:#v4d, M3F_CreateRawData t:#v4d,
			M3F_CreateRawData t:#v4d, M3F_CreateRawData t:#v4d)
		)
		#sphere:
		(
			#(M3F_CreateRawData(), M3F_CreateRawData(), d1)
		)
		default: #()
	)
	return ret
)

fn M3F_ReadRawData stream_FP type_FP =
(
	local ret
	ret = case type_FP of
	(
		#uint16: readShort stream_FP #unsigned
		#uint32: readLong stream_FP #unsigned
		#float: readFloat stream_FP
		#v2d: [readFloat stream_FP, readFloat stream_FP]
		#v3d: [readFloat stream_FP, readFloat stream_FP, readFloat stream_FP]
		#v4d: [readFloat stream_FP, readFloat stream_FP, readFloat stream_FP, readFloat stream_FP]
		#quat:(quat (readFloat stream_FP) (readFloat stream_FP) \
					(readFloat stream_FP) (readFloat stream_FP))
		#bgr: [	ReadByte stream_FP #unsigned, ReadByte stream_FP #unsigned,\
				ReadByte stream_FP #unsigned]
		#bgra: [ReadByte stream_FP #unsigned, ReadByte stream_FP #unsigned, \
				ReadByte stream_FP #unsigned, ReadByte stream_FP #unsigned]
		#matrix:
		(
			#(M3F_ReadRawData stream_FP #v4d, M3F_ReadRawData stream_FP #v4d,
			M3F_ReadRawData stream_FP #v4d, M3F_ReadRawData stream_FP #v4d)
		)
		#sphere:
		(
			#(M3F_ReadRawData stream_FP #v3d, M3F_ReadRawData stream_FP #v3d, readFloat stream_FP)
		)
		default: #()
	)
	return ret
)

/* ---------------------Structs------------------------------------ */

--M3 File Structs---------------------------------------------
struct M3SD_Flag
(
	bits = #{},

	fn bitSet bit_FP =
	(
		append this.bits bit_FP
	),
	fn bitReset bit_FP =
	(
		deleteItem this.bits bit_FP
	),
	fn valSet val_FP =
	(
		local i
		this.bits = #{}
		for i=1 to 32 do
		(
			this.bits[i] = bit.get val_FP i
		)
	),
	fn bitGet bit_FP =
	(
		return this.bits[bit_FP]
	),
	fn valGet =
	(
		local i
		local value = 0
		for i=1 to 32 do
		(
			value = bit.set value i this.bits[i]
		)
		return value
	)
)

----M3 DATA STRUCT--------------------------------------------
struct M3SD_BndSphere
(
	eMax,eMin,rad
)
struct M3SD_TagData
(
	ofsData, nbr, flag
)
struct M3SD_VertData
(
	pos, weight, boneIdx, normal, uv = #(), vColor
	--faceref, origvertindx, origtvertindx, -- for script purposes only
)
struct M3SD_AttachData
(
	rfdName = M3SD_RefData(), nbrBone
)

struct M3SD_HitTest
(
	bone1, bone2, nbrBone, matrix, type, size0, size1, size2,

	fn init d1:0 d2:0 d3:0 d4:(M3F_CreateRawData t:#matrix) d5:0 d6:0 d7:0 d8:0 s: f: =
	(
		local hit_test
		try(hit_test = this)catch(hit_test = M3SD_HitTest())
		try(hit_test.read s f:f)catch
		(
			hit_test.bone1 = d1
			hit_test.bone2 = d2
			hit_test.nbrBone = d3
			hit_test.matrix = d4
			hit_test.type = d5
			hit_test.size0 = d6
			hit_test.size1 = d7
			hit_test.size2 = d8
		)
		return hit_test
	),

	fn read stream_FP f:#normal =
	(
		if(stream_FP == unsupplied)then(throw "unsupplied")
		if f == #attachvol then
		(
			this.bone1 = readLong stream_FP #unsigned
			this.bone2 = readLong stream_FP #unsigned
		)
		this.type = readLong stream_FP #unsigned
		this.nbrBone = readShort stream_FP #unsigned
		M3F_SkipBytes stream_FP 2
		this.matrix = M3F_ReadRawData stream_FP #matrix
		M3F_SkipBytes stream_FP 24
		this.size0 = readFloat stream_FP
		this.size1 = readFloat stream_FP
		this.size2 = readFloat stream_FP
	)
)

struct M3SD_Event
(
	rfdName = M3SD_RefData(), nbrBone, matrix, type, rfdOptionStr = M3SD_RefData(),

	fn init d1:(M3SD_RefData.init "") d2:(M3F_CreateRawData t:#matrix) s: t: i: =
	(
		local event
		try(event = this)catch(event = M3SD_Event())
		try(event.read s t i)catch
		(
			event.rfdName = d1
			event.matrix = d2
		)
		return event
	),

	fn read stream_FP tags_FP idx_FP =
	(
		if(stream_FP == unsupplied)then(throw "unsupplied")
		this.rfdName.readRef stream_FP
		this.rfdName.readData stream_FP tags_FP
		M3F_SkipBytes stream_FP 4
		this.nbrBone = readShort stream_FP #unsigned
		M3F_SkipBytes stream_FP 2
		this.matrix =  M3F_ReadRawData stream_FP #matrix
		this.type = readLong stream_FP #unsigned
		this.rfdOptionStr.readRef stream_FP
		this.rfdOptionStr.readData stream_FP tags_FP
		M3F_SkipBytes stream_FP ((M3F_GetSize "EVNT" f:tags_FP.tags[idx_FP].flag) - 100)
	)
)

struct M3SD_AnimBlock
(
	rfdFrames = M3SD_RefData(), flags, fEnd, rfdKeys = M3SD_RefData(),
	--Build Items
	animID,

	fn init d1:(M3SD_RefData.init #(0)) d2:0 d3:1 d4:(M3SD_RefData.init #(0)) s: t: =
	(
		local anim
		try(anim = this)catch(anim = M3SD_AnimBlock())
		try(anim.read s t)catch
		(
			anim.rfdFrames = d1
			anim.flags = d2
			anim.fEnd = d3
			anim.rfdKeys = d4
		)
		return anim
	),

	fn read stream_FP tags_FP =
	(
		if(stream_FP == unsupplied)then(throw "unsupplied")
		this.rfdFrames.readRef stream_FP
		this.rfdFrames.readData stream_FP tags_FP
		this.flags = readLong stream_FP #unsigned
		this.fEnd = readLong stream_FP #unsigned
		this.rfdKeys.readRef stream_FP
		this.rfdKeys.readData stream_FP tags_FP
	)
)

struct M3SD_Region
(
	firstVert, nbrVert, firstFace, nbrFace, firstBonelu, nbrBonelu,
	boneWeightPair, boneIdxPair, rootBone, uvwMult, uvwOffset,
	--verts, faces, vertsList, facesList, skinBones, maxMesh, maxSkin,-- maxscript holders

	fn init d1:0 d2:0 d3:0 d4:0 d5:0 d6:0 d7:0 d8:0 d9:0 d10:(M3F_CreateRawData t:#v2d) s: t: i: =
	(
		local region
		try(region = this)catch(region = M3SD_Region())
		try(region.read s t i)catch
		(
			region.firstVert = d1
			region.nbrVert = d2
			region.firstFace = d3
			region.nbrFace = d4
			region.firstBonelu = d5
			region.nbrBonelu = d6
			region.boneWeightPair = d7
			region.boneIdxPair = d8
			region.rootBone = d9
			region.vec2 = d10
		)
		return region
	),

	fn read stream_FP tags_FP idx_FP =
	(
		if(stream_FP == unsupplied)then(throw "unsupplied")
		local flag = tags_FP.tags[idx_FP].flag

		M3F_SkipBytes stream_FP 8
		this.firstVert = readLong stream_FP #unsigned
		this.nbrVert = readLong stream_FP #unsigned
		this.firstFace = readLong stream_FP #unsigned
		this.nbrFace = readLong stream_FP #unsigned
		M3F_SkipBytes stream_FP 2
		this.firstBonelu = readShort stream_FP #unsigned
		this.nbrBonelu = readShort stream_FP #unsigned
		M3F_SkipBytes stream_FP 2
		this.boneWeightPair = ReadByte stream_FP #unsigned
		this.boneIdxPair = ReadByte stream_FP #unsigned
		this.rootBone = readShort stream_FP #unsigned
		case flag of
		(
			4:
			(
				M3F_SkipBytes stream_FP 4
				this.uvwMult = 16.0
				this.uvwOffset = 0
			)
			5:
			(
				M3F_SkipBytes stream_FP 4
				this.uvwMult = readFloat stream_FP
				this.uvwOffset = readFloat stream_FP
			)
			default:
			(
				this.uvwMult = 16.0
				this.uvwOffset = 0
			)
		)
	)
)

struct M3SD_MeshMat
(
	meshID, matID,

	fn init d1:0 d2:0 s: =
	(
		local meshmat
		try(meshmat = this)catch(meshmat = M3SD_MeshMat())
		try(meshmat.read s)catch
		(
			meshmat.meshID = d1
			meshmat.matID = d2
		)
		return meshmat
	),

	fn read stream_FP =
	(
		if(stream_FP == unsupplied)then(throw "unsupplied")
		M3F_SkipBytes stream_FP 4
		this.meshID = readShort stream_FP #unsigned
		M3F_SkipBytes stream_FP 4
		this.matID = readShort stream_FP #unsigned
		M3F_SkipBytes stream_FP 2
	)
)

struct M3SD_MapLayer
(
	rfdName = M3SD_RefData(),
	rfaColor = M3SD_RefAnim(), flags = M3SD_Flag(), mapping, colorType,
	rfaRGBmult = M3SD_RefAnim(), rfaRGBadd = M3SD_RefAnim(),
	pocTexture, noiseAmp, noiseFreq,
	texSource, aviFrameRate, aviStart, aviStop, aviLoop, aviSync,
	rfaAVIplay = M3SD_RefAnim(), rfaAVIrestart = M3SD_RefAnim(),
	rows, columns, rfaCurFrame = M3SD_RefAnim(),
	rfaUVoffset = M3SD_RefAnim(), rfaAngle = M3SD_RefAnim(), rfaUVtill = M3SD_RefAnim(),
	rfaWoffset = M3SD_RefAnim(), rfaWtill = M3SD_RefAnim(), rfaMapAlpha = M3SD_RefAnim(),
	rfaTriOffset = M3SD_RefAnim(), rfaTriScale = M3SD_RefAnim(),
	fresnelMode, fresnelExponent, fresnelMin, fresnelMax, fresnelMask, fresnelRot,

	fn init d1:(M3SD_RefData.init "") s: t: i: =
	(
		local maplayer
		try(maplayer = this)catch(maplayer = M3SD_MapLayer())
		try(maplayer.read s t i)catch
		(
			maplayer.rfdName = d1
			maplayer.rfaColor.init t:#bgra
			maplayer.flags.valSet 0
			maplayer.mapping = 0
			maplayer.colorType = 0
			maplayer.rfaRGBmult.init t:#float
			maplayer.rfaRGBadd.init t:#float
			maplayer.pocTexture = 0
			maplayer.noiseAmp = 0.8
			maplayer.noiseFreq = 0.5
			maplayer.texSource = 0
			maplayer.aviFrameRate = 0
			maplayer.aviStart = 0
			maplayer.aviStop = 0
			maplayer.aviLoop = 0
			maplayer.aviSync = 0
			maplayer.rfaAVIplay.init t:#uint32
			maplayer.rfaAVIrestart.init t:#uint32
			maplayer.rows = 0
			maplayer.columns = 0
			maplayer.rfaCurFrame.init t:#uint16
			maplayer.rfaUVoffset.init t:#v2d
			maplayer.rfaAngle.init t:#v3d
			maplayer.rfaUVtill.init t:#v2d
			maplayer.rfaWoffset.init t:#float
			maplayer.rfaWtill.init t:#float
			maplayer.rfaMapAlpha.init t:#float
			maplayer.rfaTriOffset.init t:#v3d
			maplayer.rfaTriScale.init t:#v3d
			maplayer.fresnelMode = 0
			maplayer.fresnelExponent = 0
			maplayer.fresnelMin = 0
			maplayer.fresnelMax = 0
			maplayer.fresnelMask = M3F_CreateRawData()
			maplayer.fresnelRot = M3F_CreateRawData t:#v2d
		)
		return maplayer
	),

	fn read stream_FP tags_FP idx_FP = 
	(
		if(stream_FP == unsupplied)then(throw "unsupplied")
		local flag = tags_FP.tags[idx_FP].flag

		M3F_SkipBytes stream_FP 4
		this.rfdName.readRef stream_FP
		this.rfdName.readData stream_FP tags_FP
		this.rfaColor.read stream_FP #bgra
		this.flags.valSet (readLong stream_FP #unsigned)
		this.mapping = readLong stream_FP #unsigned
		this.colorType = readLong stream_FP #unsigned
		this.rfaRGBmult.read stream_FP #float
		this.rfaRGBadd.read stream_FP #float
		this.pocTexture = readLong stream_FP #unsigned

		if(flag == 0x16)then
		(
			this.noiseAmp = 0
			this.noiseFreq = 0
		)else
		(
			this.noiseAmp = readFloat stream_FP
			this.noiseFreq = readFloat stream_FP
		)

		this.texSource = readLong stream_FP #unsigned
		this.aviFrameRate = readLong stream_FP #unsigned
		this.aviStart = readLong stream_FP #unsigned
		this.aviStop = readLong stream_FP #unsigned
		this.aviLoop = readLong stream_FP #unsigned
		this.aviSync = readLong stream_FP #unsigned
		this.rfaAVIplay.read stream_FP #uint32
		this.rfaAVIrestart.read stream_FP #uint32
		this.rows = readLong stream_FP #unsigned
		this.columns = readLong stream_FP #unsigned
		this.rfaCurFrame.read stream_FP #uint16
		this.rfaUVoffset.read stream_FP #v2d
		this.rfaAngle.read stream_FP #v3d
		this.rfaUVtill.read stream_FP #v2d
		this.rfaWoffset.read stream_FP #float
		this.rfaWtill.read stream_FP #float
		this.rfaMapAlpha.read stream_FP #float
		if(flag == 0x16)then
		(
			this.rfaTriOffset.init t:#v3d
			this.rfaTriScale.init t:#v3d
			this.fresnelMode = 0
			this.fresnelExponent = 0
			this.fresnelMin = 0
			this.fresnelMax = 0
			this.fresnelMask = M3F_CreateRawData t:#v3d
			this.fresnelRot = M3F_CreateRawData t:#v2d
		)else
		(
			this.rfaTriOffset.read stream_FP #v3d
			this.rfaTriScale.read stream_FP #v3d
			M3F_SkipBytes stream_FP 4
			this.fresnelMode = readLong stream_FP #unsigned
			this.fresnelExponent = readFloat stream_FP
			this.fresnelMin = readFloat stream_FP
			this.fresnelMax = readFloat stream_FP
			M3F_SkipBytes stream_FP 12
			this.fresnelMask = M3F_ReadRawData stream_FP #v3d
			this.fresnelRot = M3F_ReadRawData stream_FP #v2d
		)
		--22 25 26
		--M3F_SkipBytes stream_FP 4
	)
)

struct M3SD_CompMaps
(
	index, rfaMapMult = M3SD_RefAnim(),

	fn init d1:0 d2:(M3SD_RefAnim.init t:#float) s: =
	(
		local comp_map
		try(comp_map = this)catch(comp_map = M3SD_CompMaps())
		try(comp_map.read s)catch
		(
			comp_map.index = d1
			comp_map.rfaMapMult = d2
		)
		return comp_map
	),

	fn read stream_FP = 
	(
		if(stream_FP == unsupplied)then(throw "unsupplied")
		this.index = readLong stream_FP #unsigned
		this.rfaMapMult.read stream_FP #float
	)
)

struct M3SD_SubFlares
(
	index, radius, size, intensity, decay, colorAlpha, offset,

	fn init d1:0 d2:1 d3:(M3F_CreateRawData t:#v4d) \
	d4:0.9 d5:10 d6:(M3F_CreateRawData t:#bgra) d7:(M3F_CreateRawData t:#v3d) s: =
	(
		local sub_flare
		try(sub_flare = this)catch(sub_flare = M3SD_SubFlares())
		try(sub_flare.read s)catch
		(
			sub_flare.index = d1
			sub_flare.radius = d2
			sub_flare.size = d3
			sub_flare.intensity = d4
			sub_flare.decay = d5
			sub_flare.colorAlpha = d6
			sub_flare.offset = d7
		)
		return sub_flare
	),

	fn read stream_FP = 
	(
		if(stream_FP == unsupplied)then(throw "unsupplied")
		this.index = readLong stream_FP #unsigned
		this.radius = readFloat stream_FP
		this.size = M3F_ReadRawData stream_FP #v4d
		M3F_SkipBytes stream_FP 8
		this.intensity = readFloat stream_FP
		this.decay = readFloat stream_FP
		this.colorAlpha = M3F_ReadRawData stream_FP #bgra
		this.offset = M3F_ReadRawData stream_FP #v3d
	)
)

struct M3SD_SubRibbon
(
	ribSpeed, subRibSpeed, nbrBone, yawType, pitchType, speedType,

	rfaYaw = 		M3SD_RefAnim(), rfaPitch = 		M3SD_RefAnim(),
	rfaYawAmp = 	M3SD_RefAnim(), rfaYawFreq = 	M3SD_RefAnim(),
	rfaPitchAmp = 	M3SD_RefAnim(), rfaPitchFreq = 	M3SD_RefAnim(),
	rfaSpeedAmp = 	M3SD_RefAnim(), rfaSpeedFreq = 	M3SD_RefAnim(),

	fn init d1:0 d2:0 d3:0 \
	d4:(M3SD_RefAnim.init t:#float) d5:(M3SD_RefAnim.init t:#float) s: =
	(
		local sub_ribbon
		try(sub_ribbon = this)catch(sub_ribbon = M3SD_SubRibbon())
		try(sub_ribbon.read s)catch
		(
			sub_ribbon.ribSpeed = d1
			sub_ribbon.subRibSpeed = d2
			sub_ribbon.nbrBone = d3
			sub_ribbon.yawType = 0
			sub_ribbon.pitchType = 0
			sub_ribbon.speedType = 0
			sub_ribbon.rfaYaw = d4
			sub_ribbon.rfaPitch = d5
			sub_ribbon.rfaYawAmp.init t:#float
			sub_ribbon.rfaYawFreq.init t:#float
			sub_ribbon.rfaPitchAmp.init t:#float
			sub_ribbon.rfaPitchFreq.init t:#float
			sub_ribbon.rfaSpeedAmp.init t:#float
			sub_ribbon.rfaSpeedFreq.init t:#float
		)
		return sub_ribbon
	),

	fn read stream_FP =
	(
		if(stream_FP == unsupplied)then(throw "unsupplied")
		M3F_SkipBytes stream_FP 20
		this.ribSpeed = readFloat stream_FP
		M3F_SkipBytes stream_FP 8
		this.subRibSpeed = readFloat stream_FP
		M3F_SkipBytes stream_FP 12
		this.nbrBone = readLong stream_FP #unsigned
		M3F_SkipBytes stream_FP 40
		this.yawType = 			readLong stream_FP #unsigned
		this.rfaYawAmp.read 	stream_FP #float
		this.rfaYawFreq.read 	stream_FP #float
		this.pitchType = 		readLong stream_FP #unsigned
		this.rfaPitchAmp.read 	stream_FP #float
		this.rfaPitchFreq.read 	stream_FP #float
		this.speedType = 		readLong stream_FP #unsigned
		this.rfaSpeedAmp.read 	stream_FP #float
		this.rfaSpeedFreq.read 	stream_FP #float
		this.rfaYaw.read 		stream_FP #float
		this.rfaPitch.read 		stream_FP #float
	)
)

struct M3SD_RigedBody
(
	matrix, shapeType, size0, size1, size2,
	rfdVertPos = M3SD_RefData(), rfdFaceNorm = M3SD_RefData(),
	rfdVertFace = M3SD_RefData(), rfdNormIdx = M3SD_RefData(),
	vertNbr, faceNbr, pairNbr,

	fn init d1:(M3F_CreateRawData t:#matrix) d2:0 d3:0.25 d4:0.25 d5:0.25 \
	d6:(M3SD_RefData.init #()) d7:(M3SD_RefData.init #()) \
	d8:(M3SD_RefData.init #()) d9:(M3SD_RefData.init #()) d10:0 d11:0 d12:0 s: t: =
	(
		local riged_body
		try(riged_body = this)catch(riged_body = M3SD_RigedBody())
		try(riged_body.read s t)catch
		(
			riged_body.matrix = d1
			riged_body.shapeType = d2
			riged_body.size0 = d3
			riged_body.size1 = d4
			riged_body.size2 = d5
			riged_body.rfdVertPos = d6
			riged_body.rfdFaceNorm = d7
			riged_body.rfdVertFace = d8
			riged_body.rfdNormIdx = d9
			riged_body.vertNbr = d10
			riged_body.faceNbr = d11
			riged_body.pairNbr = d12
		)
		return riged_body
	),

	fn read stream_FP tags_FP =
	(
		if(stream_FP == unsupplied)then(throw "unsupplied")

		this.matrix = M3F_ReadRawData stream_FP #matrix
		this.shapeType = readByte stream_FP #unsigned
		M3F_SkipBytes stream_FP 27
		this.size0 = readFloat stream_FP
		this.size1 = readFloat stream_FP
		this.size2 = readFloat stream_FP
		this.rfdVertPos.readRef stream_FP
		this.rfdVertPos.readData stream_FP tags_FP
		this.rfdFaceNorm.readRef stream_FP
		this.rfdFaceNorm.readData stream_FP tags_FP
		this.rfdVertFace.readRef stream_FP
		this.rfdVertFace.readData stream_FP tags_FP
		this.rfdNormIdx.readRef stream_FP
		this.rfdNormIdx.readData stream_FP tags_FP
		M3F_SkipBytes stream_FP 12
		this.vertNbr = readLong stream_FP #unsigned
		this.faceNbr = readLong stream_FP #unsigned
		this.pairNbr = readLong stream_FP #unsigned
		--M3F_SkipBytes stream_FP 124
	)
)

struct M3SD_RefAnim
(
	iptType, flags, animID, initState, nullState, idx,

	fn init d1:0 d2:0 d3:0 d4:-1 s: t: =
	(
		local ref_anim
		try(ref_anim = this)catch(ref_anim = M3SD_RefAnim())
		try(ref_anim.read s t)catch
		(
			ref_anim.iptType = d1
			ref_anim.flags = d2
			ref_anim.animID = d3
			ref_anim.initState = M3F_CreateRawData t:t
			ref_anim.nullState = M3F_CreateRawData t:t
			ref_anim.idx = d4
		)
		return ref_anim
	),

	fn read stream_FP type_FP =
	(
		if(stream_FP == unsupplied)then(throw "unsupplied")
		this.iptType = readShort stream_FP #unsigned
		this.flags = readShort stream_FP #unsigned
		this.animID = readLong stream_FP #unsigned
		this.initState = M3F_ReadRawData stream_FP type_FP
		this.nullState = M3F_ReadRawData stream_FP type_FP
		this.idx = readLong stream_FP
	)
)

struct M3SD_RefData
(
	ref, data,

	fn init type_FP d1:0 d2: s: t: =
	(
		local ref_data
		try(ref_data = this)catch(ref_data = M3SD_RefData())
		try(ref_data.readRef s;ref_data.readData s t)catch
		(
			ref_data.ref = d1
			ref_data.data = M3F_Try d2 type_FP
		)
		return ref_data
	),

	fn readRef stream_FP f:#index =
	(
		if(stream_FP == unsupplied)then(throw "unsupplied")
		local info = #()
		info[1] = readLong stream_FP #unsigned
		info[2] = readLong stream_FP #unsigned + 1
		info[3] = readLong stream_FP #unsigned

		if info[1] != 0 then(this.ref = info[2])
						else(this.ref = 0)
		return
		(
			case f of
			(
				#all: info
				#lens: info[1]
				#index: info[2]
				#flag: info[3]
				default: info[2]
			)
		)
	),

	fn readData stream_FP tags_FP f:#null =
	(
		if(stream_FP == unsupplied)then(throw "unsupplied")
		try(local str = tags_FP.nameStr[this.ref])catch(return undefined)
		local i
		local ret_pos =  fTell stream_FP
		--if this.ref == 10 then print str
		this.data = #()
		str = M3F_FindRefType str f
		fSeek stream_FP tags_FP.tags[this.ref].ofsData #seek_set
		--if this.ref == 10 then print str
		for i=1 to tags_FP.tags[this.ref].nbr do
		(
			case str of
			(
				--Base Types
				"CHAR":(this.data = (M3F_ReadString stream_FP tags_FP.tags[this.ref].nbr f:#string);exit)
				"U8__": append this.data (readByte stream_FP #unsigned)
				"I16_": append this.data (readShort stream_FP #signed)
				"U16_": append this.data (readShort stream_FP #unsigned)
				"U16D": append this.data #(readShort stream_FP #unsigned,readShort stream_FP #unsigned)
				"I32_": append this.data (readLong stream_FP #signed)
				"U32_": append this.data (readLong stream_FP #unsigned)
				"VEC2": append this.data (M3F_ReadRawData stream_FP #v2d)
				"VEC3": append this.data (M3F_ReadRawData stream_FP #v3d)
				"VEC4": append this.data (M3F_ReadRawData stream_FP #v4d)
				"QUAT": append this.data (M3F_ReadRawData stream_FP #quat)
				"REAL": append this.data (readFloat stream_FP)
				"SVC3": append this.data (M3SD_RefAnim.init s:stream_FP t:#v3d)
				"COL":  append this.data (M3F_ReadRawData stream_FP #bgra)
				"DMSE": append this.data (M3F_ReadRawData stream_FP #bgra)
				"FLAG": append this.data (readLong stream_FP #unsigned)
				--Extern Types
				"SSGS": append this.data (M3SD_HitTest.init s:stream_FP)
				"ATVL": append this.data (M3SD_HitTest.init s:stream_FP f:#attachvol)
				"EVNT": append this.data (M3SD_Event.init s:stream_FP t:tags_FP i:this.ref)
				"SDXX": append this.data (M3SD_AnimBlock.init s:stream_FP t:tags_FP)
				"REGN": append this.data (M3SD_Region.init s:stream_FP t:tags_FP i:this.ref)
				"MSEC":
				(
					M3F_SkipBytes stream_FP 4
					this.data = (M3SD_RefAnim.init s:stream_FP t:#sphere)
					exit
				)
				"BAT_": append this.data (M3SD_MeshMat.init s:stream_FP)
				"LAYR":(this.data = (M3SD_MapLayer.init s:stream_FP t:tags_FP i:this.ref);exit)
				"CMS_": append this.data (M3SD_CompMaps.init s:stream_FP)
				"LFSB": append this.data (M3SD_SubFlares.init s:stream_FP)
				"SRIB":(this.data = (M3SD_SubRibbon.init s:stream_FP);exit)
				"SCHR": append this.data (M3SD_RefData.init #() s:stream_FP t:tags_FP)
				"PHSH":(this.data = (M3SD_RigedBody.init s:stream_FP t:tags_FP);exit)
				default:()
			)
		)
		fSeek stream_FP ret_pos #seek_set
	)
)

----M3 MAIN STRUCT--------------------------------------------
struct M3S_Tag
(
	entry, nameStr = #(), tags = #(),

	fn init s: n: =
	(
		local this_item
		try(this_item = this)catch(this_item = M3S_Tag())
		try(this_item.read s n)catch(this_item.entry = 0)
		return this_item
	),

	fn read stream_FP nbr_FP =
	(
		if(stream_FP == unsupplied)then(throw "unsupplied")
		local i
		if this.entry == 0 then(return undefined)
		fSeek stream_FP (this.entry) #seek_set
		
		this.nameStr = #()
		this.tags = #()
		for i = 1 to nbr_FP do
		(
			local str
			local tag = M3SD_TagData()

			str = M3F_ReadString stream_FP 4
			tag.ofsData = readLong stream_FP #unsigned
			tag.nbr = readLong stream_FP #unsigned
			tag.flag = readLong stream_FP #unsigned

			append this.nameStr str
			append this.tags tag
		)
	),
	fn write =()
)

struct M3S_Header
(
	nameStr, ofsTag, nbrTag,
	--Build Items
	refMODL,
	
	fn init s: =
	(
		local this_item
		try(this_item = this)catch(this_item = M3S_Header())
		try(this_item.read s)catch()
		return this_item
	),

	fn read stream_FP =
	(
		if(stream_FP == unsupplied)then(throw "unsupplied")
		fseek stream_FP 0 #seek_set

		this.nameStr = M3F_ReadString stream_FP 4
		this.ofsTag = readLong stream_FP #unsigned
		this.nbrTag = readLong stream_FP #unsigned
		this.refMODL = (M3SD_RefData.init #() s:stream_FP).ref
	),

	fn write stream_FP =
	(

	)
)

struct M3S_MODL
(
	rfdName = M3SD_RefData(),
	versID, nSkinBones, vFlags,
	bndSphere = M3SD_BndSphere(), tightTest = M3SD_HitTest(), rfdSSGS = M3SD_RefData(),
	rfdATVL = M3SD_RefData(), rfdATVLlu1 = M3SD_RefData(), rfdATVLlu2 = M3SD_RefData(),
	--Build Items
	refSEQS, refSTC, refSTG, refSTS,
	refBONE, refVERT, refDIV,refBones,
	refMATM, refMAT, refDIS, refTER, refVOL, refLFLR,
	refATT, refATTlu, refLITE, refCAM,
	refPAR, refPARC, refRIB,
	refIREF,
	--force,

	fn init s: t: i: =
	(
		local this_item
		try(this_item = this)catch(this_item = M3S_MODL())
		try(this_item.read s t i)catch()
		return this_item
	),

	fn read stream_FP tags_FP idx_FP f:#MD34 =
	(
		if(stream_FP == unsupplied)then(throw "unsupplied")
		fSeek stream_FP (M3F_FindStart stream_FP tags_FP idx_FP 1) #seek_set
		local flag = tags_FP.tags[idx_FP].flag

		this.rfdName.readRef stream_FP
		this.rfdName.readData stream_FP tags_FP
		this.versID = readLong stream_FP #unsigned
		M3F_SkipBytes stream_FP 36
		--this.refSEQS = M3F_ReadRef stream_FP flag:#index
		--this.refSTC = M3F_ReadRef stream_FP flag:#index
		--this.refSTG = M3F_ReadRef stream_FP flag:#index
		M3F_ReadRawData stream_FP #v4d
		M3F_SkipBytes stream_FP 24
		--this.refSTS = M3F_ReadRef stream_FP flag:#index
		--this.refBONE = M3F_ReadRef stream_FP flag:#index
		this.nSkinBones = readLong stream_FP #unsigned
		this.vFlags = readLong stream_FP #unsigned
		this.refVERT = M3SD_RefData.init #() s:stream_FP
		M3F_SkipBytes stream_FP 24
		--this.refDIV = M3F_ReadRef stream_FP flag:#index
		--this.rfdBones.ref = M3F_ReadRef stream_FP flag:#index
		--this.rfdBones.data = M3F_ReadRefData stream_FP tags_FP this.rfdName.ref
		this.bndSphere.eMin = M3F_ReadRawData stream_FP #v3d
		this.bndSphere.eMax = M3F_ReadRawData stream_FP #v3d
		this.bndSphere.rad = readFloat stream_FP
		M3F_SkipBytes stream_FP 4
		--M3F_SkipBytes stream_FP 60
		--this.refATT = M3F_ReadRef stream_FP flag:#index
		--this.refATTlu = M3F_ReadRef stream_FP flag:#index
		--this.refLITE = M3F_ReadRef stream_FP flag:#index
		M3F_SkipBytes stream_FP (12*12)
		M3F_SkipBytes stream_FP (flag*12)
		this.tightTest.read stream_FP
		this.rfdSSGS.readRef stream_FP
		this.rfdSSGS.readData stream_FP tags_FP
		this.rfdATVL.readRef stream_FP
		this.rfdATVL.readData stream_FP tags_FP
		this.rfdATVLlu1.readRef stream_FP
		this.rfdATVLlu1.readData stream_FP tags_FP
		this.rfdATVLlu2.readRef stream_FP
		this.rfdATVLlu2.readData stream_FP tags_FP
	),
	fn write =()
)
--Animation STRUCT---------------------------------------------
struct M3S_SEQS
(
	rfdName = M3SD_RefData(), animStart, maxFrames, moveSpeed, seqFlags = M3SD_Flag(),
	frequency, replayStart, replayEnd,
	--Build Items
	--bndSphere = M3SD_BndSphere(),

	fn init s: t: i: n: =
	(
		local this_item
		try(this_item = this)catch(this_item = M3S_SEQS())
		try(this_item.read s t i n)catch()
		return this_item
	),
	fn read stream_FP tags_FP idx_FP nbr_FP =
	(
		if(stream_FP == unsupplied)then(throw "unsupplied")
		fSeek stream_FP (M3F_FindStart stream_FP tags_FP idx_FP nbr_FP) #seek_set

		M3F_SkipBytes stream_FP 8
		this.rfdName.readRef stream_FP
		this.rfdName.readData stream_FP tags_FP
		this.animStart = readLong stream_FP #unsigned
		this.maxFrames = readLong stream_FP #unsigned
		this.moveSpeed = readFloat stream_FP
		this.seqFlags.valSet (readLong stream_FP #unsigned)
		this.frequency = readLong stream_FP #unsigned
		this.replayStart = readLong stream_FP #unsigned
		this.replayEnd = readLong stream_FP #unsigned
	),
	fn write =()
)

struct M3S_STC
(
	rfdName = M3SD_RefData(), runsConcurrent, animPriority,
	idxSTS, idxSTG, rfdAnimID = M3SD_RefData(), rfdAnimRef = M3SD_RefData(),
	rfdAnimDatas,

	fn init s: t: i: n: =
	(
		local this_item
		try(this_item = this)catch(this_item = M3S_STC())
		try(this_item.read s t i n)catch()
		return this_item
	),
	fn read stream_FP tags_FP idx_FP nbr_FP =
	(
		if(stream_FP == unsupplied)then(throw "unsupplied")
		local i
		fSeek stream_FP (M3F_FindStart stream_FP tags_FP idx_FP nbr_FP) #seek_set

		this.rfdName.readRef stream_FP
		this.rfdName.readData stream_FP tags_FP
		this.runsConcurrent = readShort stream_FP #unsigned
		this.animPriority = readShort stream_FP #unsigned
		this.idxSTS = readShort stream_FP #unsigned
		this.idxSTG = readShort stream_FP #unsigned
		this.rfdAnimID.readRef stream_FP
		this.rfdAnimID.readData stream_FP tags_FP
		this.rfdAnimRef.readRef stream_FP
		this.rfdAnimRef.readData stream_FP tags_FP f:#U16_
		M3F_SkipBytes stream_FP 4

		this.rfdAnimDatas = #()
		for i=1 to 13 do
		(
			append this.rfdAnimDatas (M3SD_RefData.init #() s:stream_FP t:tags_FP)
		)
	),
	fn write =()
)

struct M3S_STG
(
	rfdName = M3SD_RefData(), rfdSTCidx = M3SD_RefData(),

	fn init s: t: i: n: =
	(
		local this_item
		try(this_item = this)catch(this_item = M3S_STG())
		try(this_item.read s t i n)catch()
		return this_item
	),
	fn read stream_FP tags_FP idx_FP nbr_FP =
	(
		if(stream_FP == unsupplied)then(throw "unsupplied")
		fSeek stream_FP (M3F_FindStart stream_FP tags_FP idx_FP nbr_FP) #seek_set

		this.rfdName.readRef stream_FP
		this.rfdName.readData stream_FP tags_FP
		this.rfdSTCidx.readRef stream_FP
		this.rfdSTCidx.readData stream_FP tags_FP
	),
	fn write =()
)

struct M3S_STS
(
	rfdAnimID = M3SD_RefData(),

	fn init s: t: i: n: =
	(
		local this_item
		try(this_item = this)catch(this_item = M3S_STS())
		try(this_item.read s t i n)catch()
		return this_item
	),
	fn read stream_FP tags_FP idx_FP nbr_FP =
	(
		if(stream_FP == unsupplied)then(throw "unsupplied")
		fSeek stream_FP (M3F_FindStart stream_FP tags_FP idx_FP nbr_FP) #seek_set

		this.rfdAnimID.readRef stream_FP
		this.rfdAnimID.readData stream_FP tags_FP
	),
	fn write =()
)
--Bone,SubMesh STRUCT--------------------------------------------
struct M3S_BONE
(
	rfdName = M3SD_RefData(), bFlags = M3SD_Flag(), parent,
	rfaPos = M3SD_RefAnim(), rfaRot = M3SD_RefAnim(), rfaScale = M3SD_RefAnim(),
	rfaVisibility = M3SD_RefAnim(),
	--Build Items
	iref,

	fn init s: t: i: n: =
	(
		local this_item
		try(this_item = this)catch(this_item = M3S_BONE())
		try(this_item.read s t i n)catch()
		return this_item
	),
	fn read stream_FP tags_FP idx_FP nbr_FP =
	(
		if(stream_FP == unsupplied)then(throw "unsupplied")
		fSeek stream_FP (M3F_FindStart stream_FP tags_FP idx_FP nbr_FP) #seek_set

		M3F_SkipBytes stream_FP 4
		this.rfdName.readRef stream_FP
		this.rfdName.readData stream_FP tags_FP
		this.bFlags.valSet (readLong stream_FP #unsigned)
		this.parent = readShort stream_FP #unsigned
		M3F_SkipBytes stream_FP 2
		this.rfaPos.read stream_FP #v3d
		this.rfaRot.read stream_FP #quat
		this.rfaScale.read stream_FP #v3d
		this.rfaVisibility.read stream_FP #uint32
	),
	fn write =()
)

struct M3S_VERT
(
	vFlags = M3SD_Flag(), vertexs = #(),
	--Build Items
	nbrUVs,

	fn init s: t: i: =
	(
		local this_item
		try(this_item = this)catch(this_item = M3S_VERT())
		try(this_item.read s t i)catch()
		return this_item
	),
	fn read stream_FP tags_FP idx_FP =
	(
		if(stream_FP == unsupplied)then(throw "unsupplied")
		local i,m,size,nbr

		if((this.vFlags.valGet()) == 0)then
		(
			fSeek stream_FP 128 #seek_set
			this.vFlags.valSet (readLong stream_FP #unsigned)
		)

		fSeek stream_FP (M3F_FindStart stream_FP tags_FP idx_FP 1) #seek_set

		this.nbrUVs = 0
		if(this.vFlags.bitGet 10)then(this.nbrUVs += 1)
		if(this.vFlags.bitGet 18)then(this.nbrUVs += 1)
		if(this.vFlags.bitGet 19)then(this.nbrUVs += 1)
		if(this.vFlags.bitGet 20)then(this.nbrUVs += 1)
		if(this.vFlags.bitGet 21)then(this.nbrUVs += 1)
		if(this.vFlags.bitGet 30)then(this.nbrUVs += 1)
		size = 28 + this.nbrUVs*4
		nbr = tags_FP.tags[idx_FP].nbr / size

		this.vertexs = #()
		for i=1 to nbr do
		(
			local vert = M3SD_VertData()

			vert.pos = M3F_ReadRawData stream_FP #v3d
			vert.weight = M3F_ReadRawData stream_FP #bgra
			vert.boneIdx = M3F_ReadRawData stream_FP #bgra
			vert.normal = [ReadByte stream_FP #signed, ReadByte stream_FP #signed, ReadByte stream_FP #signed]
			M3F_SkipBytes stream_FP 1

			for m=1 to this.nbrUVs do
			(
				append vert.uv [ReadShort stream_FP, ReadShort stream_FP]
			)
			vert.vColor = M3F_ReadRawData stream_FP #bgra

			append this.vertexs vert
		)
	),
	fn write =()
)

struct M3S_DIV
(
	rfdFace = M3SD_RefData(), rfdREGN = M3SD_RefData(),
	rfdBAT = M3SD_RefData(), rfdMSEC = M3SD_RefData(), rfdBonelu = M3SD_RefData(),

	fn init s: t: i: =
	(
		local this_item
		try(this_item = this)catch(this_item = M3S_DIV())
		try(this_item.read s t i)catch()
		return this_item
	),
	fn read stream_FP tags_FP idx_FP =
	(
		if(stream_FP == unsupplied)then(throw "unsupplied")
		fSeek stream_FP (M3F_FindStart stream_FP tags_FP idx_FP 1) #seek_set

		this.rfdFace.readRef stream_FP
		this.rfdFace.readData stream_FP tags_FP
		this.rfdREGN.readRef stream_FP
		this.rfdREGN.readData stream_FP tags_FP
		this.rfdBAT.readRef stream_FP
		this.rfdBAT.readData stream_FP tags_FP
		this.rfdMSEC.readRef stream_FP
		this.rfdMSEC.readData stream_FP tags_FP

		fSeek stream_FP 156 #seek_set
		this.rfdBonelu.readRef stream_FP
		this.rfdBonelu.readData stream_FP tags_FP
	),
	fn write =()
)

struct M3S_IREF
(
	matrix,

	fn init s: t: i: n: =
	(
		local this_item
		try(this_item = this)catch(this_item = M3S_IREF())
		try(this_item.read s t i n)catch()
		return this_item
	),
	fn read stream_FP tags_FP idx_FP nbr_FP =
	(
		if(stream_FP == unsupplied)then(throw "unsupplied")
		fSeek stream_FP (M3F_FindStart stream_FP tags_FP idx_FP nbr_FP) #seek_set

		this.matrix = M3F_ReadRawData stream_FP #matrix
	),
	fn write =()
)
--Helper STRUCT--------------------------------------------
struct M3S_ATT
(
	rfdAttachlu = M3SD_RefData(), attachments = #(),

	fn init s: t: i: =
	(
		local this_item
		try(this_item = this)catch(this_item = M3S_ATT())
		try(this_item.read s t i)catch()
		return this_item
	),
	fn read stream_FP tags_FP idx_FP =
	(
		if(stream_FP == unsupplied)then(throw "unsupplied")
		local i
		fSeek stream_FP (M3F_FindStart stream_FP tags_FP idx_FP 1) #seek_set

		this.attachments = #()
		for i=1 to tags_FP.tags[idx_FP].nbr do
		(
			local att = M3SD_AttachData()
			M3F_SkipBytes stream_FP 4
			att.rfdName.readRef stream_FP
			att.rfdName.readData stream_FP tags_FP
			att.nbrBone = readLong stream_FP #unsigned

			append this.attachments att
		)

		fSeek stream_FP 272 #seek_set
		this.rfdAttachlu.readRef stream_FP
		this.rfdAttachlu.readData stream_FP tags_FP
	),
	fn write =()
)
--Light,Camrera STRUCT--------------------------------------------
struct M3S_LITE
(
	lTypes, nbrBone, lFlags = M3SD_Flag(), attenEnd, lLODcut, lsLODcut,
	rfaDiffColor = M3SD_RefAnim(), rfaIntensMult = M3SD_RefAnim(),
	rfaSpecColor = M3SD_RefAnim(), rfaSpecMult = M3SD_RefAnim(),
	rfaDecay = M3SD_RefAnim(), rfaAttenStart = M3SD_RefAnim(),
	rfaHotSpot = M3SD_RefAnim(), rfaFalloff = M3SD_RefAnim(),

	fn init s: t: i: n: =
	(
		local this_item
		try(this_item = this)catch(this_item = M3S_LITE())
		try(this_item.read s t i n)catch()
		return this_item
	),
	fn read stream_FP tags_FP idx_FP nbr_FP  =
	(
		if(stream_FP == unsupplied)then(throw "unsupplied")
		fSeek stream_FP (M3F_FindStart stream_FP tags_FP idx_FP nbr_FP) #seek_set

		this.lTypes = readShort stream_FP #unsigned
		this.nbrBone = readShort stream_FP #unsigned
		this.lFlags.valSet (readLong stream_FP #unsigned)
		this.lLODcut = readLong stream_FP #unsigned
		this.lsLODcut = readLong stream_FP #unsigned
		this.rfaDiffColor.read stream_FP #v3d
		this.rfaIntensMult.read stream_FP #float
		this.rfaSpecColor.read stream_FP #v3d
		this.rfaSpecMult.read stream_FP #float
		this.rfaDecay.read stream_FP #float
		this.attenEnd = readFloat stream_FP
		this.rfaAttenStart.read stream_FP #float
		this.rfaHotSpot.read stream_FP #float
		this.rfaFalloff.read stream_FP #float
	),
	fn write =()
)
struct M3S_CAM
(
	nbrBone, rfdName = M3SD_RefData(), useVertFOV,
	rfaFOV = M3SD_RefAnim(), rfaFarClip = M3SD_RefAnim(),
	rfaNearClip = M3SD_RefAnim(), rfaSClipDis = M3SD_RefAnim(),
	rfaFocusDis = M3SD_RefAnim(), rfaFFocusRange = M3SD_RefAnim(),
	rfaNFocusRange = M3SD_RefAnim(), rfaDOFamount = M3SD_RefAnim(),

	fn init s: t: i: n: =
	(
		local this_item
		try(this_item = this)catch(this_item = M3S_CAM())
		try(this_item.read s t i n)catch()
		return this_item
	),
	fn read stream_FP tags_FP idx_FP nbr_FP  =
	(
		if(stream_FP == unsupplied)then(throw "unsupplied")
		fSeek stream_FP (M3F_FindStart stream_FP tags_FP idx_FP nbr_FP) #seek_set

		this.nbrBone = readLong stream_FP #unsigned
		this.rfdName.readRef stream_FP
		this.rfdName.readData stream_FP tags_FP
		this.rfaFOV.read stream_FP #float
		this.useVertFOV = readLong stream_FP #unsigned
		this.rfaFarClip.read stream_FP #float
		this.rfaNearClip.read stream_FP #float
		this.rfaSClipDis.read stream_FP #float
		this.rfaFocusDis.read stream_FP #float
		this.rfaFFocusRange.read stream_FP #float
		this.rfaNFocusRange.read stream_FP #float
		this.rfaDOFamount.read stream_FP #float
	),
	fn write =()
)
--Material STRUCT--------------------------------------------
struct M3S_MATM
(
	matTypes, matIdx,

	fn init s: t: i: n: =
	(
		local this_item
		try(this_item = this)catch(this_item = M3S_MATM())
		try(this_item.read s t i n)catch()
		return this_item
	),
	fn read stream_FP tags_FP idx_FP nbr_FP =
	(
		if(stream_FP == unsupplied)then(throw "unsupplied")
		fSeek stream_FP (M3F_FindStart stream_FP tags_FP idx_FP nbr_FP) #seek_set

		this.matTypes = readLong stream_FP #unsigned
		this.matIdx = readLong stream_FP #unsigned
	),
	fn write =()
)

struct M3S_MAT
(
	rfdName = M3SD_RefData(), aFlags = M3SD_Flag(), bFlags = M3SD_Flag(),
	blendMode, mPriority, RTTchannels, spec, depthBlendFallOff, cutOutTreshold,
	specMult, emisMult, EnvBlendType, emisBlendType1, emisBlendType2, GlossType,
	rfdMapLayrs = #(), rfaParallaxHeight = M3SD_RefAnim(), ar2 = M3SD_RefAnim(),
	version,

	fn init s: t: i: n: =
	(
		local this_item
		try(this_item = this)catch(this_item = M3S_MAT())
		try(this_item.read s t i n)catch()
		return this_item
	),
	fn read stream_FP tags_FP idx_FP nbr_FP =
	(
		if(stream_FP == unsupplied)then(throw "unsupplied")
		local nbr_layer
		this.version = tags_FP.tags[idx_FP].flag
		fSeek stream_FP (M3F_FindStart stream_FP tags_FP idx_FP nbr_FP) #seek_set

		this.rfdName.readRef stream_FP
		this.rfdName.readData stream_FP tags_FP
		this.aFlags.valSet (readLong stream_FP #unsigned)
		this.bFlags.valSet (readLong stream_FP #unsigned)
		this.blendMode = readLong stream_FP #unsigned
		this.mPriority = readLong stream_FP #unsigned
		this.RTTchannels = readLong stream_FP #unsigned
		this.spec = readFloat stream_FP
		this.depthBlendFallOff = readFloat stream_FP
		this.cutOutTreshold = readLong stream_FP #unsigned
		this.specMult = readFloat stream_FP
		this.emisMult = readFloat stream_FP

		nbr_layer = case this.version of
		(
			15: 13
			16: 14
			17: 14
			18: 14
			19: 18
			20: 18
			default: 14
		)

		if(this.version == 20)then(M3F_SkipBytes stream_FP 12)

		for i=1 to nbr_layer do
		(
			local layer = M3SD_RefData.init #() s:stream_FP t:tags_FP
			append this.rfdMapLayrs layer
			if(this.version == 15 and i == 3)then
			(
				append this.rfdMapLayrs (M3SD_RefData.init #())
			)
		)
		M3F_SkipBytes stream_FP 4
		this.EnvBlendType = readLong stream_FP #unsigned
		this.emisBlendType1 = readLong stream_FP #unsigned
		this.emisBlendType2 = readLong stream_FP #unsigned
		this.GlossType = readLong stream_FP #unsigned
		this.rfaParallaxHeight.read stream_FP #uint32
		this.ar2.read stream_FP #uint32
	),
	fn write =()
)
struct M3S_DIS
(
	disFlags = M3SD_Flag(), disPriority,
	rfdName = M3SD_RefData(), rfaStrength = M3SD_RefAnim(),
	rfdNormMap = M3SD_RefData(), rfdStrgMap = M3SD_RefData(),

	fn init s: t: i: n: =
	(
		local this_item
		try(this_item = this)catch(this_item = M3S_DIS())
		try(this_item.read s t i n)catch()
		return this_item
	),
	fn read stream_FP tags_FP idx_FP nbr_FP =
	(
		if(stream_FP == unsupplied)then(throw "unsupplied")
		fSeek stream_FP (M3F_FindStart stream_FP tags_FP idx_FP nbr_FP) #seek_set

		this.rfdName.readRef stream_FP
		this.rfdName.readData stream_FP tags_FP
		M3F_SkipBytes stream_FP 4
		this.rfaStrength.read stream_FP #float
		this.rfdNormMap.readRef stream_FP
		this.rfdNormMap.readData stream_FP tags_FP
		this.rfdStrgMap.readRef stream_FP
		this.rfdStrgMap.readData stream_FP tags_FP
		this.disFlags.valSet (readLong stream_FP #unsigned)
		this.disPriority = readLong stream_FP #unsigned
	),
	fn write =()
)
struct M3S_CMP
(
	rfdName = M3SD_RefData(), cmpPriority, rfdCMS = M3SD_RefData(),

	fn init s: t: i: n: =
	(
		local this_item
		try(this_item = this)catch(this_item = M3S_CMP())
		try(this_item.read s t i n)catch()
		return this_item
	),
	fn read stream_FP tags_FP idx_FP nbr_FP =
	(
		if(stream_FP == unsupplied)then(throw "unsupplied")
		fSeek stream_FP (M3F_FindStart stream_FP tags_FP idx_FP nbr_FP) #seek_set

		this.rfdName.readRef stream_FP
		this.rfdName.readData stream_FP tags_FP
		this.cmpPriority = readLong stream_FP #unsigned
		this.rfdCMS.readRef stream_FP
		this.rfdCMS.readData stream_FP tags_FP
	),
	fn write =()
)
struct M3S_TER
(
	rfdName = M3SD_RefData(), rfdTerrainMap = M3SD_RefData(),

	fn init s: t: i: n: =
	(
		local this_item
		try(this_item = this)catch(this_item = M3S_TER())
		try(this_item.read s t i n)catch()
		return this_item
	),
	fn read stream_FP tags_FP idx_FP nbr_FP =
	(
		if(stream_FP == unsupplied)then(throw "unsupplied")
		fSeek stream_FP (M3F_FindStart stream_FP tags_FP idx_FP nbr_FP) #seek_set

		this.rfdName.readRef stream_FP
		this.rfdName.readData stream_FP tags_FP
		this.rfdTerrainMap.readRef stream_FP
		this.rfdTerrainMap.readData stream_FP tags_FP
	),
	fn write =()
)
struct M3S_VOL
(
	rfdName = M3SD_RefData(), blendMode, falloffType, rfaDensity = M3SD_RefAnim(),
	rfdColorMap = M3SD_RefData(), rfdNoisyMap1 = M3SD_RefData(),
	rfdNoisyMap2 = M3SD_RefData(), AlphaThreshold, volFlags = M3SD_Flag(),

	fn init s: t: i: n: =
	(
		local this_item
		try(this_item = this)catch(this_item = M3S_VOL())
		try(this_item.read s t i n)catch()
		return this_item
	),
	fn read stream_FP tags_FP idx_FP nbr_FP =
	(
		if(stream_FP == unsupplied)then(throw "unsupplied")
		fSeek stream_FP (M3F_FindStart stream_FP tags_FP idx_FP nbr_FP) #seek_set

		this.rfdName.readRef stream_FP
		this.rfdName.readData stream_FP tags_FP
		this.blendMode = readLong stream_FP #unsigned
		this.falloffType = readLong stream_FP #unsigned
		this.rfaDensity.read stream_FP #float
		this.rfdColorMap.readRef stream_FP
		this.rfdColorMap.readData stream_FP tags_FP
		this.rfdNoisyMap1.readRef stream_FP
		this.rfdNoisyMap1.readData stream_FP tags_FP
		this.rfdNoisyMap2.readRef stream_FP
		this.rfdNoisyMap2.readData stream_FP tags_FP
		this.AlphaThreshold = readLong stream_FP #unsigned
		this.volFlags.valSet (readLong stream_FP #unsigned)
	),
	fn write =()
)
struct M3S_CREP
(
	rfdName = M3SD_RefData(), rfdMaskMap = M3SD_RefData(), CreepLow,

	fn init s: t: i: n: =
	(
		local this_item
		try(this_item = this)catch(this_item = M3S_CREP())
		try(this_item.read s t i n)catch()
		return this_item
	),
	fn read stream_FP tags_FP idx_FP nbr_FP =
	(
		if(stream_FP == unsupplied)then(throw "unsupplied")
		fSeek stream_FP (M3F_FindStart stream_FP tags_FP idx_FP nbr_FP) #seek_set

		this.rfdName.readRef stream_FP
		this.rfdName.readData stream_FP tags_FP
		this.rfdMaskMap.readRef stream_FP
		this.rfdMaskMap.readData stream_FP tags_FP
		this.CreepLow = readLong stream_FP #unsigned
	),
	fn write =()
)
struct M3S_VON
(
	rfdName = M3SD_RefData(), falloffType, DrawTrans, rfaDensity = M3SD_RefAnim(),
	rfaNearPlane = M3SD_RefAnim(), rfaFalloff = M3SD_RefAnim(),
	rfdColorMap = M3SD_RefData(), rfdNoiseMap1 = M3SD_RefData(),
	rfdNoiseMap2 = M3SD_RefData(), rfaScrollRate = M3SD_RefAnim(),
	rfaPos = M3SD_RefAnim(), rfaScale = M3SD_RefAnim(), rfaRot = M3SD_RefAnim(),
	AlphaThreshold, vonFlags = M3SD_Flag(),

	fn init s: t: i: n: =
	(
		local this_item
		try(this_item = this)catch(this_item = M3S_VON())
		try(this_item.read s t i n)catch()
		return this_item
	),
	fn read stream_FP tags_FP idx_FP nbr_FP =
	(
		if(stream_FP == unsupplied)then(throw "unsupplied")
		fSeek stream_FP (M3F_FindStart stream_FP tags_FP idx_FP nbr_FP) #seek_set

		this.rfdName.readRef stream_FP
		this.rfdName.readData stream_FP tags_FP
		this.falloffType = readLong stream_FP #unsigned
		this.DrawTrans = readLong stream_FP #unsigned
		this.rfaDensity.read stream_FP #float
		this.rfaNearPlane.read stream_FP #float
		this.rfaFalloff.read stream_FP #float
		this.rfdColorMap.readRef stream_FP
		this.rfdColorMap.readData stream_FP tags_FP
		this.rfdNoiseMap1.readRef stream_FP
		this.rfdNoiseMap1.readData stream_FP tags_FP
		this.rfdNoiseMap2.readRef stream_FP
		this.rfdNoiseMap2.readData stream_FP tags_FP
		this.rfaScrollRate.read stream_FP #v3d
		this.rfaPos.read stream_FP #v3d
		this.rfaScale.read stream_FP #v3d
		this.rfaRot.read stream_FP #v3d
		this.AlphaThreshold = readLong stream_FP #unsigned
		this.vonFlags.valSet (readLong stream_FP #unsigned)
	),
	fn write =()
)
struct M3S_STBM
(
	rfdName = M3SD_RefData(), rfdDiffMap = M3SD_RefData(),
	rfdNormMap = M3SD_RefData(), rfdSpecMap = M3SD_RefData(),

	fn init s: t: i: n: =
	(
		local this_item
		try(this_item = this)catch(this_item = M3S_STBM())
		try(this_item.read s t i n)catch()
		return this_item
	),
	fn read stream_FP tags_FP idx_FP nbr_FP =
	(
		if(stream_FP == unsupplied)then(throw "unsupplied")
		fSeek stream_FP (M3F_FindStart stream_FP tags_FP idx_FP nbr_FP) #seek_set

		this.rfdName.readRef stream_FP
		this.rfdName.readData stream_FP tags_FP
		this.rfdDiffMap.readRef stream_FP
		this.rfdDiffMap.readData stream_FP tags_FP
		this.rfdNormMap.readRef stream_FP
		this.rfdNormMap.readData stream_FP tags_FP
		this.rfdSpecMap.readRef stream_FP
		this.rfdSpecMap.readData stream_FP tags_FP
	),
	fn write =()
)
struct M3S_LFLR
(
	rfdName = M3SD_RefData(), rfdFlareMap = M3SD_RefData(),
	rfdStrengthMap = M3SD_RefData(), rfdSubFlares = M3SD_RefData(),
	Columns, Rows, flareMuti, rfdEnd = M3SD_RefData(),
	rfaParam1 = M3SD_RefAnim(), rfaParam2 = M3SD_RefAnim(),
	rfaParam3 = M3SD_RefAnim(), rfaParam4 = M3SD_RefAnim(),

	fn init s: t: i: n: =
	(
		local this_item
		try(this_item = this)catch(this_item = M3S_LFLR())
		try(this_item.read s t i n)catch()
		return this_item
	),
	fn read stream_FP tags_FP idx_FP nbr_FP =
	(
		if(stream_FP == unsupplied)then(throw "unsupplied")
		fSeek stream_FP (M3F_FindStart stream_FP tags_FP idx_FP nbr_FP) #seek_set

		this.rfdName.readRef stream_FP
		this.rfdName.readData stream_FP tags_FP
		this.rfdFlareMap.readRef stream_FP
		this.rfdFlareMap.readData stream_FP tags_FP
		this.rfdStrengthMap.readRef stream_FP
		this.rfdStrengthMap.readData stream_FP tags_FP
		this.rfdSubFlares.readRef stream_FP
		this.rfdSubFlares.readData stream_FP tags_FP
		this.Columns = readLong stream_FP #unsigned
		this.Rows = readLong stream_FP #unsigned
		this.flareMuti = readFloat stream_FP

		case tags_FP.tags[idx_FP].flag of
		(
			2:
			(
				this.rfaParam1.read stream_FP #float
			)
			3:
			(
				this.rfdEnd.readRef stream_FP
				this.rfdEnd.readData stream_FP tags_FP
				this.rfaParam1.read stream_FP #float
				this.rfaParam2.read stream_FP #bgra
				this.rfaParam3.read stream_FP #float
				this.rfaParam4.read stream_FP #float
			)
		)
	),
	fn write =()
)
--Particle STRUCT--------------------------------------------
struct M3S_PAR
(
	nbrBone, matIdx,
	parFlags = M3SD_Flag(), parFlags1 = M3SD_Flag(), parFlags2 = M3SD_Flag(),
	--Emittion
	emissShape, maxPart, ivType, instType, tailLens, killRadius,
	instAngle, endScale, trailChance, trailLinkIdx,
	yawType, pitchType, speedType, vertType, horzType,

	rfdEmissMesh = 	M3SD_RefData(),
	rfdModel = 		M3SD_RefData(),
	rfaSquirtAmount=M3SD_RefAnim(), rfaPtVelocity = 	M3SD_RefAnim(),
	rfaLowBound = 	M3SD_RefAnim(), rfaUpBound = 		M3SD_RefAnim(),
	rfaEmissRate = 	M3SD_RefAnim(), rfaTrailEmissRate = M3SD_RefAnim(),
	rfaShapeOuter = M3SD_RefAnim(), rfaShapeInner = 	M3SD_RefAnim(),
	rfaOutRadius = 	M3SD_RefAnim(), rfaInRadius = 		M3SD_RefAnim(),
	rfaIVspeed = 	M3SD_RefAnim(), rfaIVspeedR = 		M3SD_RefAnim(),
	rfaIVyaw = 		M3SD_RefAnim(), rfaIVpitch = 		M3SD_RefAnim(),
	rfaIVvert = 	M3SD_RefAnim(), rfaIVHorz = 		M3SD_RefAnim(),
	rfaLifeTime = 	M3SD_RefAnim(), rfaLifeTimeR = 		M3SD_RefAnim(),
	rfaYawAmp = 	M3SD_RefAnim(), rfaYawFreq = 		M3SD_RefAnim(),
	rfaPitchAmp = 	M3SD_RefAnim(), rfaPitchFreq = 		M3SD_RefAnim(),
	rfaSpeedAmp = 	M3SD_RefAnim(), rfaSpeedFreq = 		M3SD_RefAnim(),
	rfaVertAmp = 	M3SD_RefAnim(), rfaVertFreq = 		M3SD_RefAnim(),
	rfaHorzAmp = 	M3SD_RefAnim(), rfaHorzFreq = 		M3SD_RefAnim(),

	--Noise
	noiseAmp, noiseFreq, noiseCoh, noiseEdge,

	--Collision
	splatProjIdx, bounce, friction, colSpawnMin, colSpawnMax, colSpawnChance,
	colSpawnEnergy, colDieBounce, splatChance, colSpawnIdx,

	rfdSplatLine = M3SD_RefData(),

	--Per-particle Parameters
	sizeEnableR, colorEnableR, alphaEnableR, rotEnableR,
	sizeMTime, colorMTime, alphaMTime, rotMTime,
	sizeMHTime, colorMHTime, alphaMHTime, rotMHTime,
	sizeSmootying, colorSmootying, rotSmootying,
	filpBookPlay, filpBookMT, filpBookColumn, filpBookRow,
	sizeType, rotType, alphaType,

	rfaSizePlay = 	M3SD_RefAnim(), rfaRotPlay = 	M3SD_RefAnim(),
	rfaColorStart = M3SD_RefAnim(), rfaColorMid = 	M3SD_RefAnim(),
	rfaColorEnd = 	M3SD_RefAnim(),
	rfaSizePlayR = 	M3SD_RefAnim(), rfaRotPlayR = 	M3SD_RefAnim(),
	rfaColorStartR= M3SD_RefAnim(), rfaColorMidR = 	M3SD_RefAnim(),
	rfaColorEndR = 	M3SD_RefAnim(),
	rfaSizeAmp = 	M3SD_RefAnim(), rfaSizeFreq = 	M3SD_RefAnim(),
	rfaRotAmp = 	M3SD_RefAnim(), rfaRotFreq = 	M3SD_RefAnim(),
	rfaAlphaAmp = 	M3SD_RefAnim(), rfaAlphaFreq = 	M3SD_RefAnim(),
	
	--Physics
	pGravity, pDrag, pMass, pMassR, pMassMult, pLocalChns,
	pWindMult, pLODreduce, pLODcut,

	--Screen Space
	rfaAlphaThold = M3SD_RefAnim(), rfaUVoffset = 	M3SD_RefAnim(),
	rfaAngle = 		M3SD_RefAnim(), rfaUVtill = 	M3SD_RefAnim(),
	rfaOverlay = 	M3SD_RefAnim(),

	fn init s: t: i: n: =
	(
		local this_item
		try(this_item = this)catch(this_item = M3S_PAR())
		try(this_item.read s t i n)catch()
		return this_item
	),
	fn read stream_FP tags_FP idx_FP nbr_FP =
	(
		if(stream_FP == unsupplied)then(throw "unsupplied")
		fSeek stream_FP (M3F_FindStart stream_FP tags_FP idx_FP nbr_FP) #seek_set
		local flag = tags_FP.tags[idx_FP].flag

		this.nbrBone = 				readLong stream_FP #unsigned
		this.matIdx = 				readLong stream_FP #unsigned
		if(flag != 0x0C)then
		(
			this.parFlags.valSet	(readLong stream_FP #unsigned)
		)
		this.rfaIVspeed.read 		stream_FP #float
		this.rfaIVspeedR.read 		stream_FP #float

		if(flag == 0x0C)then
		(
			this.parFlags.valSet	(readLong stream_FP #unsigned)
		)
		this.rfaIVyaw.read 			stream_FP #float
		this.rfaIVpitch.read 		stream_FP #float
		this.rfaIVvert.read 		stream_FP #float
		this.rfaIVHorz.read 		stream_FP #float
		this.rfaLifeTime.read 		stream_FP #float
		this.rfaLifeTimeR.read 		stream_FP #float

		if(flag == 0x0C)then
		(
			local life_time_range = readLong stream_FP #unsigned
			if(life_time_range != 0)then(this.parFlags.bits[2] = true)
		)

		this.killRadius = 			readFloat stream_FP
		M3F_SkipBytes stream_FP 8

		--46*4 = 184 , 0xB8
		this.pGravity = 			readFloat stream_FP
		this.sizeMTime = 			readFloat stream_FP
		this.colorMTime = 			readFloat stream_FP
		this.alphaMTime = 			readFloat stream_FP
		this.rotMTime = 			readFloat stream_FP

		if(flag == 0x0C)then
		(
			this.sizeMHTime = 		0
			this.colorMHTime = 		0
			this.alphaMHTime = 		0
			this.rotMHTime = 		0
		)else
		(
			this.sizeMHTime = 		readFloat stream_FP
			this.colorMHTime = 		readFloat stream_FP
			this.alphaMHTime = 		readFloat stream_FP
			this.rotMHTime = 		readFloat stream_FP
		)

		this.rfaSizePlay.read 		stream_FP #v3d
		this.rfaRotPlay.read 		stream_FP #v3d
		this.rfaColorStart.read 	stream_FP #bgra
		this.rfaColorMid.read 		stream_FP #bgra
		this.rfaColorEnd.read 		stream_FP #bgra
		
		this.pDrag = 				readFloat stream_FP
		if(flag == 0x0C)then
		(
			this.pMassR = 			readFloat stream_FP
			this.pMass = 			readFloat stream_FP
		)else
		(
			this.pMass = 			readFloat stream_FP
			this.pMassR = 			readFloat stream_FP
		)
		this.pMassMult = 			readFloat stream_FP

		if(flag == 0x0C)then
		(
			M3F_SkipBytes stream_FP 4
		)
		this.pLocalChns = 			readLong stream_FP #unsigned
		
		case flag of
		(
			0x0C: M3F_SkipBytes stream_FP 8
			0x18: M3F_SkipBytes stream_FP 8
			default: M3F_SkipBytes stream_FP 4
		)
		
		this.noiseAmp = 			readFloat stream_FP
		this.noiseFreq = 			readFloat stream_FP
		this.noiseCoh = 			readFloat stream_FP
		this.noiseEdge = 			readFloat stream_FP
		M3F_SkipBytes stream_FP 4
		this.maxPart = 				readLong stream_FP #unsigned
		this.rfaEmissRate.read 		stream_FP #float
		this.emissShape = 			readLong stream_FP #unsigned
		this.rfaShapeOuter.read 	stream_FP #v3d
		this.rfaShapeInner.read 	stream_FP #v3d
		this.rfaOutRadius.read 		stream_FP #float
		this.rfaInRadius.read 		stream_FP #float

		if(flag == 0x0C)then
		(
			this.rfdEmissMesh.init undefined
		)else
		(
			this.rfdEmissMesh.readRef 	stream_FP
			this.rfdEmissMesh.readData 	stream_FP tags_FP
		)

		this.ivType = 				readLong stream_FP #unsigned
		this.sizeEnableR = 			readLong stream_FP #unsigned
		this.rfaSizePlayR.read 		stream_FP #v3d
		this.rotEnableR = 			readLong stream_FP #unsigned
		this.rfaRotPlayR.read 		stream_FP #v3d
		this.colorEnableR = 		readLong stream_FP #unsigned
		this.rfaColorStartR.read 	stream_FP #bgra
		this.rfaColorMidR.read 		stream_FP #bgra
		this.rfaColorEndR.read 		stream_FP #bgra
		this.alphaEnableR = 		readLong stream_FP #unsigned
		this.rfaSquirtAmount.read 	stream_FP #uint16
		this.filpBookPlay = 		M3F_ReadRawData stream_FP #bgr
		M3F_SkipBytes stream_FP 1
		this.filpBookMT = 			readFloat stream_FP
		this.filpBookColumn = 		readShort stream_FP #unsigned
		this.filpBookRow = 			readShort stream_FP #unsigned
		M3F_SkipBytes stream_FP 8
		this.bounce = 				readFloat stream_FP
		this.friction = 			readFloat stream_FP
		this.colSpawnIdx = 			readLong stream_FP #unsigned
		this.colSpawnMin = 			readFloat stream_FP
		this.colSpawnMax = 			readFloat stream_FP
		this.colSpawnChance = 		readFloat stream_FP
		this.colSpawnEnergy = 		readFloat stream_FP
		this.colDieBounce = 		readLong stream_FP #unsigned
		this.instType = 			readLong stream_FP #unsigned
		this.tailLens = 			readFloat stream_FP
		this.instAngle = 			M3F_ReadRawData stream_FP #v3d

		if(flag == 0x0C)then
		(
			this.endScale = 		0
		)else
		(
			this.endScale = 		readFloat stream_FP
		)
		
		this.yawType = 				readLong stream_FP #unsigned
		this.rfaYawAmp.read 		stream_FP #float
		this.rfaYawFreq.read 		stream_FP #float
		this.pitchType = 			readLong stream_FP #unsigned
		this.rfaPitchAmp.read 		stream_FP #float
		this.rfaPitchFreq.read 		stream_FP #float
		this.speedType = 			readLong stream_FP #unsigned
		this.rfaSpeedAmp.read 		stream_FP #float
		this.rfaSpeedFreq.read 		stream_FP #float
		this.sizeType = 			readLong stream_FP #unsigned
		this.rfaSizeAmp.read 		stream_FP #float
		this.rfaSizeFreq.read 		stream_FP #float
		this.alphaType = 			readLong stream_FP #unsigned
		this.rfaAlphaAmp.read 		stream_FP #float
		this.rfaAlphaFreq.read 		stream_FP #float
		M3F_SkipBytes stream_FP 44
		this.rotType = 				readLong stream_FP #unsigned
		this.rfaRotAmp.read 		stream_FP #float
		this.rfaRotFreq.read 		stream_FP #float
		this.horzType = 			readLong stream_FP #unsigned
		this.rfaHorzAmp.read 		stream_FP #float
		this.rfaHorzFreq.read 		stream_FP #float
		this.vertType = 			readLong stream_FP #unsigned
		this.rfaVertAmp.read 		stream_FP #float
		this.rfaVertFreq.read 		stream_FP #float

		this.rfaPtVelocity.read 	stream_FP #float

		if(flag == 0x0C or flag == 0x12 or flag == 0x15)then
		(
			this.rfaOverlay.init 	t:#float
		)else
		(
			this.rfaOverlay.read 	stream_FP #float
		)
		
		this.parFlags1.valSet		(readLong stream_FP #unsigned)
		this.parFlags2.valSet		(readLong stream_FP #unsigned)
		if(flag == 0x0C)then
		(
			M3F_SkipBytes stream_FP 8
		)
		this.colorSmootying = 		readLong stream_FP #unsigned
		this.sizeSmootying = 		readLong stream_FP #unsigned
		this.rotSmootying = 		readLong stream_FP #unsigned
		if(flag == 0x0C)then
		(
			this.rfaAlphaThold.init t:#float
			this.rfaUVoffset.init 	t:#v2d
			this.rfaAngle.init 		t:#v3d
			this.rfaUVtill.init 	t:#v2d
			this.rfdSplatLine.init 	undefined
			this.pWindMult = 		0
			this.pLODreduce = 		0
			this.pLODcut = 			0
		)else
		(
			this.rfaAlphaThold.read 	stream_FP #float
			this.rfaUVoffset.read 		stream_FP #v2d
			this.rfaAngle.read 			stream_FP #v3d
			this.rfaUVtill.read 		stream_FP #v2d
			this.rfdSplatLine.readRef 	stream_FP
			this.rfdSplatLine.readData 	stream_FP tags_FP
			this.pWindMult = 			readFloat stream_FP
			this.pLODreduce = 			readLong stream_FP #unsigned
			this.pLODcut = 				readLong stream_FP #unsigned
		)

		this.rfaLowBound.read 		stream_FP #float
		this.rfaUpBound.read 		stream_FP #float
		this.trailLinkIdx = 		readLong stream_FP
		this.trailChance = 			readFloat stream_FP
		this.rfaTrailEmissRate.read stream_FP #float
		this.splatProjIdx = 		readLong stream_FP #unsigned
		this.splatChance = 			readFloat stream_FP
		this.rfdModel.readRef 		stream_FP
		this.rfdModel.readData 		stream_FP tags_FP
	),
	fn write =()
)
struct M3S_RIB
(
	version,
	nbrBone, matIdx, ribFlags = M3SD_Flag(), ribFlags1 = M3SD_Flag(),
	--Emittion
	emissShape, basedSrc, maxSegs, edges, innerRadius,
	yawType, pitchType, speedType,

	rfdSubRib = 	M3SD_RefData(),
	rfaIVspeed = 	M3SD_RefAnim(), rfaPtVelocity = M3SD_RefAnim(),
	rfaIVyaw = 		M3SD_RefAnim(), rfaIVpitch = 	M3SD_RefAnim(),
	rfaLifeTime = 	M3SD_RefAnim(),
	rfaMaxLen = 	M3SD_RefAnim(), rfaActive = 	M3SD_RefAnim(),
	rfaYawAmp = 	M3SD_RefAnim(), rfaYawFreq = 	M3SD_RefAnim(),
	rfaPitchAmp = 	M3SD_RefAnim(), rfaPitchFreq = 	M3SD_RefAnim(),
	rfaSpeedAmp = 	M3SD_RefAnim(), rfaSpeedFreq = 	M3SD_RefAnim(),

	--Noise
	noiseAmp, noiseFreq, noiseSpeed, noiseEdge,

	--Collision
	friction, bounce,

	--Per-particle Parameters
	sizeMTime, colorMTime, alphaMTime, rotMTime,
	sizeMHTime, colorMHTime, alphaMHTime, rotMHTime,
	sizeSmootying, colorSmootying,
	sizeType, alphaType,

	rfaSizePlay = 	M3SD_RefAnim(), rfaRotPlay = 	M3SD_RefAnim(),
	rfaColorStart = M3SD_RefAnim(), rfaColorMid = 	M3SD_RefAnim(),
	rfaColorEnd = 	M3SD_RefAnim(),
	rfaSizeAmp = 	M3SD_RefAnim(), rfaSizeFreq = 	M3SD_RefAnim(),
	rfaAlphaAmp = 	M3SD_RefAnim(), rfaAlphaFreq = 	M3SD_RefAnim(),
	
	--Physics
	pGravity, pDrag, pMass, pMassR, pMassMult, pLocalChns,
	pLODreduce, pLODcut,

	--Screen Space
	rfaOverlay = 	M3SD_RefAnim(),

	fn init s: t: i: n: =
	(
		local this_item
		try(this_item = this)catch(this_item = M3S_RIB())
		try(this_item.read s t i n)catch()
		return this_item
	),
	fn read stream_FP tags_FP idx_FP nbr_FP =
	(
		if(stream_FP == unsupplied)then(throw "unsupplied")
		fSeek stream_FP (M3F_FindStart stream_FP tags_FP idx_FP nbr_FP) #seek_set
		local flag = tags_FP.tags[idx_FP].flag
		this.version = flag

		this.nbrBone = 			readLong stream_FP #unsigned
		this.matIdx = 			readLong stream_FP #unsigned

		if(flag != 0x06)then
		(
			this.ribFlags.valSet (readLong stream_FP #unsigned)
		)

		this.rfaIVspeed.read 	stream_FP #float
		M3F_SkipBytes stream_FP 20

		if(flag == 0x06)then
		(
			M3F_SkipBytes stream_FP 4
		)
		
		if(flag == 0x06)then
		(
			this.rfaIVpitch.read 	stream_FP #float
			this.rfaIVyaw.read 		stream_FP #float
		)else
		(
			this.rfaIVyaw.read 		stream_FP #float
			this.rfaIVpitch.read 	stream_FP #float
		)

		M3F_SkipBytes stream_FP 40
		this.rfaLifeTime.read 	stream_FP #float

		if(flag == 0x06)then
		(
			M3F_SkipBytes stream_FP 36
		)else
		(
			M3F_SkipBytes stream_FP 32
		)
		
		this.pGravity = 		readFloat stream_FP
		this.sizeMTime = 		readFloat stream_FP
		this.colorMTime = 		readFloat stream_FP
		this.alphaMTime = 		readFloat stream_FP
		this.rotMTime = 		readFloat stream_FP

		if(flag != 0x06)then
		(
			this.sizeMHTime = 	readFloat stream_FP
			this.colorMHTime = 	readFloat stream_FP
			this.alphaMHTime = 	readFloat stream_FP
			this.rotMHTime = 	readFloat stream_FP
		)else
		(
			this.sizeMHTime = 	0
			this.colorMHTime = 	0
			this.alphaMHTime = 	0
			this.rotMHTime = 	0
		)

		this.rfaSizePlay.read 	stream_FP #v3d
		this.rfaRotPlay.read 	stream_FP #v3d
		this.rfaColorStart.read stream_FP #bgra
		this.rfaColorMid.read 	stream_FP #bgra
		this.rfaColorEnd.read 	stream_FP #bgra
		this.pDrag = 			readFloat stream_FP
		if(flag == 0x06)then
		(
			this.pMassR = 		readFloat stream_FP
			this.pMass = 		readFloat stream_FP
		)else
		(
			this.pMass = 		readFloat stream_FP
			this.pMassR = 		readFloat stream_FP
		)

		this.pMassMult = 		readFloat stream_FP

		if(flag == 0x06)then
		(
			M3F_SkipBytes stream_FP 4
			this.ribFlags.valSet (readLong stream_FP #unsigned)
		)

		this.pLocalChns = 		readLong stream_FP #unsigned
		case flag of
		(
			0x09: M3F_SkipBytes stream_FP 8
			default: M3F_SkipBytes stream_FP 4
		)

		this.noiseAmp = 		readFloat stream_FP
		this.noiseFreq = 		readFloat stream_FP
		this.noiseSpeed = 		readFloat stream_FP
		this.noiseEdge = 		readFloat stream_FP
		M3F_SkipBytes stream_FP 4
		this.emissShape = 		readLong stream_FP #unsigned
		this.basedSrc = 		readLong stream_FP #unsigned
		this.maxSegs = 			readLong stream_FP #unsigned
		this.edges = 			readLong stream_FP #unsigned
		this.innerRadius = 		readFloat stream_FP
		this.rfaMaxLen.read 	stream_FP #float
		
		if(flag == 0x06)then
		(
			M3F_SkipBytes stream_FP 4
		)

		this.rfdSubRib.readRef 	stream_FP
		this.rfdSubRib.readData stream_FP tags_FP
		this.rfaActive.read 	stream_FP #uint32
		this.ribFlags1.valSet	(readLong stream_FP #unsigned)
		this.sizeSmootying = 	readLong stream_FP #unsigned
		this.colorSmootying = 	readLong stream_FP #unsigned

		if(flag == 0x06)then
		(
			this.friction = 	1.0
			this.bounce = 		0
		)else
		(
			this.friction = 	readFloat stream_FP
			this.bounce = 		readFloat stream_FP
		)

		this.pLODreduce = 		readLong stream_FP #unsigned
		this.pLODcut = 			readLong stream_FP #unsigned

		if(flag == 0x06)then
		(
			this.pitchType = 		readLong stream_FP #unsigned
			this.rfaPitchAmp.read 	stream_FP #float
			this.rfaPitchFreq.read 	stream_FP #float
			this.yawType = 			readLong stream_FP #unsigned
			this.rfaYawAmp.read 	stream_FP #float
			this.rfaYawFreq.read 	stream_FP #float
		)else
		(
			this.yawType = 			readLong stream_FP #unsigned
			this.rfaYawAmp.read 	stream_FP #float
			this.rfaYawFreq.read 	stream_FP #float
			this.pitchType = 		readLong stream_FP #unsigned
			this.rfaPitchAmp.read 	stream_FP #float
			this.rfaPitchFreq.read 	stream_FP #float
		)
		
		this.speedType = 		readLong stream_FP #unsigned
		this.rfaSpeedAmp.read 	stream_FP #float
		this.rfaSpeedFreq.read 	stream_FP #float
		this.sizeType = 		readLong stream_FP #unsigned
		this.rfaSizeAmp.read 	stream_FP #float
		this.rfaSizeFreq.read 	stream_FP #float
		this.alphaType = 		readLong stream_FP #unsigned
		this.rfaAlphaAmp.read 	stream_FP #float
		this.rfaAlphaFreq.read 	stream_FP #float
		this.rfaPtVelocity.read stream_FP #float
		this.rfaOverlay.read 	stream_FP #float
	),
	fn write =()
)
struct M3S_PROJ
(
	projType, nbrBone, matIdx,
	alphaPlay, attack, hold, decay, splatAtt,
	layer, LODreduce, LODcut, staticPos,

	rfaFOV = 	M3SD_RefAnim(), rfaAsRatio = M3SD_RefAnim(),
	rfaNear = 	M3SD_RefAnim(), rfaFar = 	M3SD_RefAnim(),
	rfaMinusZ = M3SD_RefAnim(), rfaPlusZ = 	M3SD_RefAnim(),
	rfaMinusX = M3SD_RefAnim(), rfaPlusX = 	M3SD_RefAnim(),
	rfaMinusY = M3SD_RefAnim(), rfaPlusY = 	M3SD_RefAnim(),
	rfaAlive = M3SD_RefAnim(),

	fn init s: t: i: n: =
	(
		local this_item
		try(this_item = this)catch(this_item = M3S_PROJ())
		try(this_item.read s t i n)catch()
		return this_item
	),
	fn read stream_FP tags_FP idx_FP nbr_FP =
	(
		if(stream_FP == unsupplied)then(throw "unsupplied")
		fSeek stream_FP (M3F_FindStart stream_FP tags_FP idx_FP nbr_FP) #seek_set

		this.projType = readLong stream_FP #unsigned
		this.nbrBone = readLong stream_FP #unsigned
		this.matIdx = readLong stream_FP #unsigned
		M3F_SkipBytes stream_FP 96
		this.rfaFOV.read stream_FP #float
		this.rfaAsRatio.read stream_FP #float
		this.rfaNear.read stream_FP #float
		this.rfaFar.read stream_FP #float
		this.rfaMinusZ.read stream_FP #float
		this.rfaPlusZ.read stream_FP #float
		this.rfaMinusX.read stream_FP #float
		this.rfaPlusX.read stream_FP #float
		this.rfaMinusY.read stream_FP #float
		this.rfaPlusY.read stream_FP #float
		M3F_SkipBytes stream_FP 4
		this.alphaPlay = M3F_ReadRawData stream_FP #v3d
		this.attack = M3F_ReadRawData stream_FP #v2d
		this.hold = M3F_ReadRawData stream_FP #v2d
		this.decay = M3F_ReadRawData stream_FP #v2d
		this.splatAtt = readShort stream_FP
		this.rfaAlive.read stream_FP #uint32
		this.layer = readLong stream_FP #unsigned
		this.LODreduce = readLong stream_FP #unsigned
		this.LODcut = readLong stream_FP #unsigned
		this.staticPos = readLong stream_FP #unsigned
	),
	fn write =()
)
--Physics STRUCT--------------------------------------------
struct M3S_FOR
(
	fTypes, nbrBone, fShapes, fFlags =  M3SD_Flag(), fLocalChns,
	rfaStrength = M3SD_RefAnim(),
	rfaWidth = M3SD_RefAnim(),
	rfaHeight = M3SD_RefAnim(),
	rfaLength = M3SD_RefAnim(),

	fn init s: t: i: n: =
	(
		local this_item
		try(this_item = this)catch(this_item = M3S_FOR())
		try(this_item.read s t i n)catch()
		return this_item
	),
	fn read stream_FP tags_FP idx_FP nbr_FP =
	(
		if(stream_FP == unsupplied)then(throw "unsupplied")
		fSeek stream_FP (M3F_FindStart stream_FP tags_FP idx_FP nbr_FP) #seek_set

		this.fTypes = readLong stream_FP #unsigned
		this.fShapes = readLong stream_FP #unsigned
		M3F_SkipBytes stream_FP 4
		this.nbrBone = readLong stream_FP #unsigned
		this.fFlags.valSet (readLong stream_FP #unsigned)
		this.fLocalChns = readLong stream_FP #unsigned

		this.rfaStrength.read stream_FP #float
		this.rfaWidth.read stream_FP #float
		this.rfaHeight.read stream_FP #float
		this.rfaLength.read stream_FP #float
	),
	fn write =()
)

struct M3S_WRP
(
	wTypes, nbrBone,
	rfaRadius = M3SD_RefAnim(),
	rfaHeight = M3SD_RefAnim(),
	rfaStrength = M3SD_RefAnim(),
	rfaAngular = M3SD_RefAnim(),
	rfaAxial = M3SD_RefAnim(),
	rfaRadial = M3SD_RefAnim(),

	fn init s: t: i: n: =
	(
		local this_item
		try(this_item = this)catch(this_item = M3S_WRP())
		try(this_item.read s t i n)catch()
		return this_item
	),
	fn read stream_FP tags_FP idx_FP nbr_FP =
	(
		if(stream_FP == unsupplied)then(throw "unsupplied")
		fSeek stream_FP (M3F_FindStart stream_FP tags_FP idx_FP nbr_FP) #seek_set

		this.wTypes = readLong stream_FP #unsigned
		this.nbrBone = readLong stream_FP #unsigned
		M3F_SkipBytes stream_FP 4

		this.rfaRadius.read stream_FP #float
		this.rfaHeight.read stream_FP #float
		this.rfaStrength.read stream_FP #float
		this.rfaAngular.read stream_FP #float
		this.rfaAxial.read stream_FP #float
		this.rfaRadial.read stream_FP #float
	),
	fn write =()
)

struct M3S_PHRB
(
	simTypes, phyTypes, nbrBoneParent, pFlags = M3SD_Flag(),
	rfdRigedBody = M3SD_RefData(),
	density, friction, restitution, linearDamp, angularDamp, gravityScale,
	dynamicBlendOut, pLocalChns, pPriority,
	rfaDynamicState = M3SD_RefAnim(),

	fn init s: t: i: n: =
	(
		local this_item
		try(this_item = this)catch(this_item = M3S_PHRB())
		try(this_item.read s t i n)catch()
		return this_item
	),
	fn read stream_FP tags_FP idx_FP nbr_FP =
	(
		if(stream_FP == unsupplied)then(throw "unsupplied")
		fSeek stream_FP (M3F_FindStart stream_FP tags_FP idx_FP nbr_FP) #seek_set

		this.simTypes = readShort stream_FP #unsigned
		this.nbrBoneParent = readShort stream_FP #unsigned
		this.phyTypes = readLong stream_FP #unsigned

		this.density = readFloat stream_FP
		this.friction = readFloat stream_FP
		this.restitution = readFloat stream_FP
		this.linearDamp = readFloat stream_FP
		this.angularDamp = readFloat stream_FP
		this.gravityScale = readFloat stream_FP

		this.rfaDynamicState.read stream_FP #uint32

		this.dynamicBlendOut = readFloat stream_FP

		this.rfdRigedBody.readRef stream_FP
		this.rfdRigedBody.readData stream_FP tags_FP

		this.pFlags.valSet (readLong stream_FP #unsigned)
		this.pLocalChns = readLong stream_FP #unsigned
		this.pPriority = readLong stream_FP #unsigned
	),
	fn write =()
)

struct M3S_PHYJ
(
	jTypes, nbrBone1, nbrBone2, matrixB1, matrixB2,
	enableLimits, limitMin, limitMax, coneAngle,
	enableFriction, friction, dampingRatio, angularFreq,
	breakThold, enableShape,

	fn init s: t: i: n: =
	(
		local this_item
		try(this_item = this)catch(this_item = M3S_PHYJ())
		try(this_item.read s t i n)catch()
		return this_item
	),
	fn read stream_FP tags_FP idx_FP nbr_FP =
	(
		if(stream_FP == unsupplied)then(throw "unsupplied")
		fSeek stream_FP (M3F_FindStart stream_FP tags_FP idx_FP nbr_FP) #seek_set

		this.jTypes = readLong stream_FP #unsigned
		this.nbrBone1 = readLong stream_FP #unsigned
		this.nbrBone2 = readLong stream_FP #unsigned
		this.matrixB1 = M3F_ReadRawData stream_FP #matrix
		this.matrixB2 = M3F_ReadRawData stream_FP #matrix

		this.enableLimits = readLong stream_FP #unsigned
		this.limitMin = readFloat stream_FP
		this.limitMax = readFloat stream_FP
		this.coneAngle = readFloat stream_FP

		this.enableFriction = readLong stream_FP #unsigned
		this.friction = readFloat stream_FP
		this.dampingRatio = readFloat stream_FP
		this.angularFreq = readFloat stream_FP
		this.breakThold = readFloat stream_FP
		this.enableShape = readLong stream_FP #unsigned
	),
	fn write =()
)

/* M3 MAIN STRUCT */

struct M3S_FileMain
(
	--Main
	fHeader = M3S_Header(), fTags = M3S_Tag(), fMODL = M3S_MODL(),
	--Animation
	fSEQS = #(), fSTC = #(), fSTG = #(), fSTS = #(),
	--Bone\Mesh
	fBONE = #(), fVERT = M3S_VERT(), fDIV = M3S_DIV(), fIREF = #(),
	--Helper
	fATT = M3S_ATT(), fLITE = #(), fCAM = #(),
	--Material
	fMATM = #(), fMAT = #(), fDIS = #(), fCMP = #(), fTER = #(),
	fVOL = #(), fCREP = #(), fVON = #(), fSTBM = #(), fLFLR = #(),
	--Particle
	fPAR = #(), fRIB = #(), fPROJ = #(),
	--Physics
	fFOR = #(), fWRP = #(), fPHRB = #(), fPHYJ = #(),

	fn read stream_FP =
	(
		local i, m, nbr_tags

		this.fHeader.read stream_FP
		this.fTags.entry = this.fHeader.ofsTag
		nbr_tags = this.fHeader.nbrTag
		this.fTags.read stream_FP nbr_tags

		for i=1 to nbr_tags do
		(
			case this.fTags.nameStr[i] of
			(
				"MODL":
				(
					this.fMODL.read stream_FP this.fTags i
					try(this.fTags.nameStr[this.fMODL.refVERT.ref] = "VERT")catch()
				)
				"SEQS": for m=1 to this.fTags.tags[i].nbr do
				(append this.fSEQS (M3S_SEQS.init s:stream_FP t:this.fTags i:i n:m))

				"STC_": for m=1 to this.fTags.tags[i].nbr do
				(
					local stc_temp = (M3S_STC.init s:stream_FP t:this.fTags i:i n:m)
					if(stc_temp.rfdName.data != undefined and stc_temp.rfdName.data != "")then
					(
						append this.fSTC stc_temp
					)
				)

				"STG_": for m=1 to this.fTags.tags[i].nbr do
				(append this.fSTG (M3S_STG.init s:stream_FP t:this.fTags i:i n:m))

				"STS_": for m=1 to this.fTags.tags[i].nbr do
				(append this.fSTS (M3S_STS.init s:stream_FP t:this.fTags i:i n:m))

				"BONE": for m=1 to this.fTags.tags[i].nbr do
				(append this.fBONE (M3S_BONE.init s:stream_FP t:this.fTags i:i n:m))

				"VERT": (this.fVERT.init s:stream_FP t:this.fTags i:i)

				"DIV_": (this.fDIV.init s:stream_FP t:this.fTags i:i)

				"IREF": for m=1 to this.fTags.tags[i].nbr do
				(append this.fIREF (M3S_IREF.init s:stream_FP t:this.fTags i:i n:m))

				"ATT_": (this.fATT.init s:stream_FP t:this.fTags i:i)

				"LITE": for m=1 to this.fTags.tags[i].nbr do
				(append this.fLITE (M3S_LITE.init s:stream_FP t:this.fTags i:i n:m))

				"CAM_": for m=1 to this.fTags.tags[i].nbr do
				(append this.fCAM (M3S_CAM.init s:stream_FP t:this.fTags i:i n:m))

				"MATM": for m=1 to this.fTags.tags[i].nbr do
				(append this.fMATM (M3S_MATM.init s:stream_FP t:this.fTags i:i n:m))

				"MAT_": for m=1 to this.fTags.tags[i].nbr do
				(append this.fMAT (M3S_MAT.init s:stream_FP t:this.fTags i:i n:m))

				"DIS_": for m=1 to this.fTags.tags[i].nbr do
				(append this.fDIS (M3S_DIS.init s:stream_FP t:this.fTags i:i n:m))

				"CMP_": for m=1 to this.fTags.tags[i].nbr do
				(append this.fCMP (M3S_CMP.init s:stream_FP t:this.fTags i:i n:m))

				"TER_": for m=1 to this.fTags.tags[i].nbr do
				(append this.fTER (M3S_TER.init s:stream_FP t:this.fTags i:i n:m))

				"VOL_": for m=1 to this.fTags.tags[i].nbr do
				(append this.fVOL (M3S_VOL.init s:stream_FP t:this.fTags i:i n:m))

				"CREP": for m=1 to this.fTags.tags[i].nbr do
				(append this.fCREP (M3S_CREP.init s:stream_FP t:this.fTags i:i n:m))

				"VON_": for m=1 to this.fTags.tags[i].nbr do
				(append this.fVON (M3S_VON.init s:stream_FP t:this.fTags i:i n:m))

				"STBM": for m=1 to this.fTags.tags[i].nbr do
				(append this.fSTBM (M3S_STBM.init s:stream_FP t:this.fTags i:i n:m))

				"LFLR": for m=1 to this.fTags.tags[i].nbr do
				(append this.fLFLR (M3S_LFLR.init s:stream_FP t:this.fTags i:i n:m))

				"PAR_": for m=1 to this.fTags.tags[i].nbr do
				(append this.fPAR (M3S_PAR.init s:stream_FP t:this.fTags i:i n:m))

				"RIB_": for m=1 to this.fTags.tags[i].nbr do
				(append this.fRIB (M3S_RIB.init s:stream_FP t:this.fTags i:i n:m))

				"PROJ": for m=1 to this.fTags.tags[i].nbr do
				(append this.fPROJ (M3S_PROJ.init s:stream_FP t:this.fTags i:i n:m))

				"FOR_": for m=1 to this.fTags.tags[i].nbr do
				(append this.fFOR (M3S_FOR.init s:stream_FP t:this.fTags i:i n:m))

				"WRP_": for m=1 to this.fTags.tags[i].nbr do
				(append this.fWRP (M3S_WRP.init s:stream_FP t:this.fTags i:i n:m))

				"PHRB": for m=1 to this.fTags.tags[i].nbr do
				(append this.fPHRB (M3S_PHRB.init s:stream_FP t:this.fTags i:i n:m))

				"PHYJ": for m=1 to this.fTags.tags[i].nbr do
				(append this.fPHYJ (M3S_PHYJ.init s:stream_FP t:this.fTags i:i n:m))

				default:()
			)
		)
	),
	fn write =
	(

	),
	fn buildFileData =
	(

	),

	fn readMaterials stream_FP =
	(
		local i, m, nbr_tags

		this.fHeader.read stream_FP
		this.fTags.entry = this.fHeader.ofsTag
		nbr_tags = this.fHeader.nbrTag
		this.fTags.read stream_FP nbr_tags

		this.fMATM = #()
		this.fMAT = #()
		this.fDIS = #()
		this.fCMP = #()
		this.fTER = #()
		this.fVOL = #()
		this.fCREP = #()
		this.fVON = #()
		this.fSTBM = #()
		this.fLFLR = #()
		for i=1 to nbr_tags do
		(
			case this.fTags.nameStr[i] of
			(
				"MATM": for m=1 to this.fTags.tags[i].nbr do
				(append this.fMATM (M3S_MATM.init s:stream_FP t:this.fTags i:i n:m))

				"MAT_": for m=1 to this.fTags.tags[i].nbr do
				(append this.fMAT (M3S_MAT.init s:stream_FP t:this.fTags i:i n:m))

				"DIS_": for m=1 to this.fTags.tags[i].nbr do
				(append this.fDIS (M3S_DIS.init s:stream_FP t:this.fTags i:i n:m))

				"CMP_": for m=1 to this.fTags.tags[i].nbr do
				(append this.fCMP (M3S_CMP.init s:stream_FP t:this.fTags i:i n:m))

				"TER_": for m=1 to this.fTags.tags[i].nbr do
				(append this.fTER (M3S_TER.init s:stream_FP t:this.fTags i:i n:m))

				"VOL_": for m=1 to this.fTags.tags[i].nbr do
				(append this.fVOL (M3S_VOL.init s:stream_FP t:this.fTags i:i n:m))

				"CREP": for m=1 to this.fTags.tags[i].nbr do
				(append this.fCREP (M3S_CREP.init s:stream_FP t:this.fTags i:i n:m))

				"VON_": for m=1 to this.fTags.tags[i].nbr do
				(append this.fVON (M3S_VON.init s:stream_FP t:this.fTags i:i n:m))

				"STBM": for m=1 to this.fTags.tags[i].nbr do
				(append this.fSTBM (M3S_STBM.init s:stream_FP t:this.fTags i:i n:m))

				"LFLR": for m=1 to this.fTags.tags[i].nbr do
				(append this.fLFLR (M3S_LFLR.init s:stream_FP t:this.fTags i:i n:m))

				default:()
			)
		)
	)
)
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------Scene Code--------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------
--SCENE BASE DATA STRUCT-----------------------------------------------
struct M3SD_ScSkinData
(
	index = #(), weight = #()
)

struct M3SD_ScAnimData
(
	interpolationType, frames = #(), dkeys = #()
)

struct M3SD_ScTrackData
(
	index, animStr
)
--SCENE FUNCTION --------------------------------------------
fn M3F_AddToLayer name_FP obj_FP =
(
	local layer = LayerManager.GetLayerFromName name_FP
	if(layer == undefined)then
	(
		layer = LayerManager.NewLayerFromName name_FP
	)
	layer.addNode obj_FP
)

fn M3F_CopyController obj_FP target_FP type:#all=
(
	if(type == #all or type == #rot)then
	(
		obj_FP.rotation.controller = target_FP.rotation.controller
		obj_FP.rotation.controller = Euler_XYZ()
		obj_FP.rotation.controller.X_Rotation.controller = bezier_float()
		obj_FP.rotation.controller.Y_Rotation.controller = bezier_float()
		obj_FP.rotation.controller.Z_Rotation.controller = bezier_float()
	)
	if(type == #all or type == #pos)then
	(
		obj_FP.position.controller = target_FP.position.controller
		obj_FP.position.controller = Position_XYZ()
		obj_FP.pos.controller.X_Position.controller = bezier_float()
		obj_FP.pos.controller.Y_Position.controller = bezier_float()
		obj_FP.pos.controller.Z_Position.controller = bezier_float()
	)
	if(type == #all or type == #scale)then
	(
		obj_FP.scale.controller = target_FP.scale.controller
		obj_FP.scale.controller = bezier_scale()
	)
	if(type == #all or type == #visibility)then
	(
		obj_FP.visibility = bezier_float()
		obj_FP.visibility.controller = target_FP.visibility.controller
		obj_FP.visibility.controller = bezier_float()
	)
)

fn M3F_GetAngle type_FP vector_FP =
(
	local v1 = copy vector_FP
	local v2 = copy vector_FP
	case type_FP of
	(
		#yaw:(v1[3] = 0; v2 = [1,0,0])
		#pitch: v2[3] = 0
		#vector:(return [cos v1[1], sin v1[1], sin v1[2]])
	)
	return acos(dot (normalize v1) (normalize v2))
)

fn M3F_FindBone bone_FP name_FP s1:"" s2:"" =
(
	local i,ret = 0
	for i=1 to bone_FP.count do
	(
		try
		(
			if(((findString bone_FP[i].rfdName.data name_FP) != undefined) and 	\
				((findString bone_FP[i].rfdName.data s1) != undefined) and 		\
				((findString bone_FP[i].rfdName.data s2) != undefined))			\
			then(ret = i)
		)catch
		(
			try
			(
				if(((findString bone_FP[i].nameStr name_FP) != undefined) and 	\
					((findString bone_FP[i].nameStr s1) != undefined) and 		\
					((findString bone_FP[i].nameStr s2) != undefined))			\
				then(ret = i)
			)catch()
		)
	)
	return ret
)

fn M3F_CheckMap map_FP =
(
	if(map_FP.flags.valGet() != 0)then
	(
		if(map_FP.flags.bits[11] != true)then
		(
			if((map_FP.rfdName.data == undefined) or (map_FP.rfdName.data == ""))
			then(return false)else(return true)
		)
		return true
	)
	return false
)

fn M3F_CvtType type_FP val_FP =
(

	local ret = case type_FP of
	(
		#color: [val_FP[3], val_FP[2], val_FP[1]]
		#alpha: val_FP[4]
		#x: val_FP[1]
		#y: val_FP[2]
		#z: val_FP[3]
		#t: val_FP[4]
		#u: val_FP[1]
		#v: val_FP[2]
		#w: val_FP[3]
		#bool:
		(
			if((classOf val_FP) == BooleanClass)then(if(val_FP)then(1)else(0))
			else(if(val_FP > 0)then(true)else(false))
		)
		default:(val_FP)
	)
	return ret
)

fn M3F_DataApply flag_FP this_FP source_FP str1_FP str2_FP \
	o:" = " c:false f1:" * 1.0" f2:" / 1.0" =
(
	local body = ""
	case flag_FP of
	(
		#fromfile:
		(
			if(c)then
			(body = "left."+str1_FP+o+"(right."+str2_FP+f1+")")
			else(body = "left."+str1_FP+o+"right."+str2_FP)
		)
		#tofile:
		(
			if(c)then
			(body = "right."+str2_FP+o+"(left."+str1_FP+f2+")")
			else(body = "right."+str2_FP+o+"left."+str1_FP)
		)
		#fromscene:
		(
			body = "left."+str1_FP+" = right."+str1_FP
		)
		#toscene:
		(
			body = "right."+str1_FP+" = left."+str1_FP
		)
	)
	execute ("fn M3F_TempFunc left right =("+body+")")
	M3F_TempFunc this_FP source_FP
)

fn M3F_FrameCorrect obj_FP frames_FP keys_FP start_FP end_FP pose_FP c:false mult:1.0 type: lock:true =
(
	local lens = end_FP - start_FP
	local current = -1
	local next = #(0, 1.0)
	local frame_correct = (100.0 - (M3F_GetGlobalSettings #FrameCorrect)) / 100.0
	local frame_check = 2 + M3F_GetGlobalSettings #FrameCheckRange

	if(c)then(local dkey_data_cur = (M3F_CvtType type pose_FP)*mult)
	else(local dkey_data_cur = M3F_CvtType type pose_FP)
	local dkey_data_end

	if(lock == true)then
	(
		append obj_FP.frames (start_FP-2)
		if(c)then(append obj_FP.dkeys ((M3F_CvtType type pose_FP)*mult))
		else(append obj_FP.dkeys (M3F_CvtType type pose_FP))

		append obj_FP.frames (start_FP-1)
		local extern = obj_FP.frames.count
		if(c)then(append obj_FP.dkeys ((M3F_CvtType type pose_FP)*mult))
		else(append obj_FP.dkeys (M3F_CvtType type pose_FP))
	)

	for n=1 to frames_FP.count do
	(
		local glb_frame_rate = M3F_GetGlobalSettings #FrameRate
		local ftime = frames_FP[n] * glb_frame_rate / 1000.0
		if(ftime < 0)then
		(
			if(lock == true)then
			(
				if(c)then(obj_FP.dkeys[extern] = (M3F_CvtType type keys_FP[n])*mult)
				else(obj_FP.dkeys[extern] = M3F_CvtType type keys_FP[n])
			)
			continue
		)
		if(ftime == 0.0 and current == 0)then
		(
			if(lock == true)then
			(
				if(c)then(obj_FP.dkeys[extern] = (M3F_CvtType type keys_FP[n-1])*mult)
				else(obj_FP.dkeys[extern] = M3F_CvtType type keys_FP[n-1])
				if(c)then(obj_FP.dkeys[extern+1] = (M3F_CvtType type keys_FP[n])*mult)
				else(obj_FP.dkeys[extern+1] = M3F_CvtType type keys_FP[n])
			)
			continue
		)
		if(ftime > lens)then
		(
			if(dkey_data_end == undefined)then
			(
				if(c)then(dkey_data_end = (M3F_CvtType type keys_FP[n])*mult)
				else(dkey_data_end = M3F_CvtType type keys_FP[n])
			)
			continue
		)
		local itime = (floor ftime) as integer
		local deviation = ftime - itime

		if(deviation > 0.95)then
		(
			itime += 1
			deviation = 1 - deviation
		)
		
		if(c)then(dkey_data_cur = (M3F_CvtType type keys_FP[n])*mult)
		else(dkey_data_cur = M3F_CvtType type keys_FP[n])

		if(itime == current)then
		(
			next[1] = itime + 1
			next[2] = 1.0 - deviation
		)else
		(
			if(itime == next[1])then
			(
				current = itime
				next[1] = current+1
				append obj_FP.frames (current+start_FP)
				--format "current:%\n" current
				if(deviation < next[2])then
				(
					--append current
					next[2] = 1.0
					if(c)then(append obj_FP.dkeys ((M3F_CvtType type keys_FP[n])*mult))
					else(append obj_FP.dkeys (M3F_CvtType type keys_FP[n]))
				)else
				(
					--append next
					next[2] = 1.0 - deviation
					if(c)then(append obj_FP.dkeys ((M3F_CvtType type keys_FP[n-1])*mult))
					else(append obj_FP.dkeys (M3F_CvtType type keys_FP[n-1]))
				)
			)else
			(
				if(itime - current < frame_check)then
				(
					if(next[2] < frame_correct)then
					(
						--append next
						--format "current:%\n" next[1]
						append obj_FP.frames (next[1]+start_FP)
						if(c)then(append obj_FP.dkeys ((M3F_CvtType type keys_FP[n-1])*mult))
						else(append obj_FP.dkeys (M3F_CvtType type keys_FP[n-1]))
					)	
				)else
				(
					if(next[2] < 1.0)then
					(
						--append next
						--format "current:%\n" next[1]
						append obj_FP.frames (next[1]+start_FP)
						if(c)then(append obj_FP.dkeys ((M3F_CvtType type keys_FP[n-1])*mult))
						else(append obj_FP.dkeys (M3F_CvtType type keys_FP[n-1]))
					)
				)
				--append current
				current = itime
				next[1] = current+1
				next[2] = 1.0
				--format "current:%\n" current
				append obj_FP.frames (current+start_FP)
				if(c)then(append obj_FP.dkeys ((M3F_CvtType type keys_FP[n])*mult))
				else(append obj_FP.dkeys (M3F_CvtType type keys_FP[n]))
			)
		)
	)

	if(next[1] <= lens)then
	(
		if(next[2] < 1.0)then
		(
			append obj_FP.frames (next[1]+start_FP)
			try(append obj_FP.dkeys (deepCopy dkey_data_cur))
			catch(append obj_FP.dkeys dkey_data_cur)
		)
		if(lock == true)then
		(
			append obj_FP.frames (end_FP+1)
			if(dkey_data_end == undefined)then
			(
				try(local fix_end_dkey = deepCopy obj_FP.dkeys[extern])
				catch(local fix_end_dkey = obj_FP.dkeys[extern])
				append obj_FP.dkeys fix_end_dkey
			)else
			(
				try(append obj_FP.dkeys (deepCopy dkey_data_end))
				catch(append obj_FP.dkeys dkey_data_end)
			)
		)
	)else
	(
		if(lock == true)then
		(
			append obj_FP.frames (end_FP+1)
			if(dkey_data_end == undefined)then
			(
				try(append obj_FP.dkeys (deepCopy dkey_data_cur))
				catch(append obj_FP.dkeys dkey_data_cur)
			)else
			(
				try(append obj_FP.dkeys (deepCopy dkey_data_end))
				catch(append obj_FP.dkeys dkey_data_end)
			)
		)
	)

	if(lock == true)then
	(
		append obj_FP.frames (end_FP+2)
		if(c)then(append obj_FP.dkeys ((M3F_CvtType type pose_FP)*mult))
		else(append obj_FP.dkeys (M3F_CvtType type pose_FP))
	)
)

fn M3F_AnimApply flag_FP obj1_FP obj2_FP str1_FP str2_FP \
	seq: m3: c:false mult:1.0 type: trk: tp: anim: =
(
	case flag_FP of
	(
		#fromfile:
		(
			if(matchPattern str2_FP pattern:"*[*]")then
			(
				local string_list = filterString str2_FP "[]"
				local m3_object = (getProperty obj2_FP string_list[1])[(string_list[2] as integer)]
			)else
			(local m3_object = getProperty obj2_FP str2_FP)
			if(matchPattern str1_FP pattern:"*[*]")then
			(
				local string_list = filterString str1_FP "[]"
				local this_object = (getProperty obj1_FP string_list[1])[(string_list[2] as integer)]
			)else
			(local this_object = getProperty obj1_FP str1_FP)
			
			local anim_enable = M3F_GetGlobalSettings #AnimEnable

			local trk_count = 0
			try(trk_count = trk.count)catch()
			for i=1 to trk_count do
			(
				local find_idx = findItem trk[i].animIDlist m3_object.animID
				if(find_idx != 0)then
				(
					local track_data = M3SD_ScTrackData()
					track_data.index = tp
					track_data.animStr = anim

					appendIfUnique trk[i].AnimList track_data
					trk[i].animIDlist = deleteItem trk[i].animIDlist find_idx
				)
			)

			this_object.interpolationType = m3_object.iptType
			 
			if(anim_enable == true)then
			(
				local i, k, n
				local m3_stc = m3.fSTC
				local m3_stg = m3.fSTG

				this_object.frames[1] = 0
				if(c)then(this_object.dkeys[1] = (M3F_CvtType type m3_object.initState)*mult)
				else(this_object.dkeys[1] = (M3F_CvtType type m3_object.initState))

				for i=1 to seq.count do
				(
					for k in m3_stg[i].rfdSTCidx.data do
					(
						local stc_idx = k + 1
						local anim_id = m3_stc[stc_idx].rfdAnimID.data
						if((n=(findItem anim_id m3_object.animID))==0)then(continue)

						local sd_idx1 = m3_stc[stc_idx].rfdAnimRef.data[n][1] + 1
						local sd_idx2 = m3_stc[stc_idx].rfdAnimRef.data[n][2] + 1
						local keys = \
					m3_stc[stc_idx].rfdAnimDatas[sd_idx2].data[sd_idx1].rfdKeys.data
						local frames = \
					m3_stc[stc_idx].rfdAnimDatas[sd_idx2].data[sd_idx1].rfdFrames.data
						local anim_prop = seq[i]
						
						M3F_FrameCorrect this_object frames keys \
						anim_prop.animStart anim_prop.animEnd \
						m3_object.initState c:c mult:mult type:type
					)
				)
			)
			if(this_object.dkeys.count == 1)then(this_object.frames[1] = -1)
			if(this_object.dkeys.count == 0)then
			(
				this_object.frames[1] = -1
				if(c)then(this_object.dkeys[1] = (M3F_CvtType type m3_object.initState)*mult)
				else(this_object.dkeys[1] = (M3F_CvtType type m3_object.initState))
			)
		)
		#tofile:
		(

		)
		#fromscene:
		(

		)
		#toscene:
		(
			local string_list, this_object, scene_object, index
			if(matchPattern str1_FP pattern:"*[*]")then
			(
				string_list = filterString str1_FP "[]"
				index = string_list[2] as integer
				this_object = (getProperty obj1_FP string_list[1])[index]
				scene_object = (getProperty obj2_FP string_list[1])
			)else
			(this_object = getProperty obj1_FP str1_FP)

			if(this_object.frames[1] == -1)then
			(
				if(scene_object == undefined)then
				(setProperty obj2_FP str1_FP this_object.dkeys[1])else
				(scene_object[index] = this_object.dkeys[1])
			)else
			(
				local i
				local ipt_type = case this_object.interpolationType of
				(
					0: #step
					1: #flat
					2: #linear
					default: #linear
				)
				BezierDefaultParams.inTangentType = ipt_type
				BezierDefaultParams.outTangentType = ipt_type
				
				with animate on
				(
					for i=1 to this_object.frames.count do
					(
						at time this_object.frames[i]
						(
							if(scene_object == undefined)then
							(setProperty obj2_FP str1_FP this_object.dkeys[i])else
							(scene_object[index] = this_object.dkeys[i])
						)
					)
				)
			)
		)
	)
)
--SCENE DATA STRUCT--------------------------------------------

--------Materials Data
struct M3SD_ScMapLayer
(
	MapType 				,
	--normal parameter-------------------
	UTile 					,--() : boolean
	VTile 					,--() : boolean
	ColorInvert 			,--() : boolean
	ColorClamp 				,--() : boolean
	EnableFlipbook 			,--() : boolean
	FresnelLocalTransform 	,--() : boolean
	FresnelSaturate 		,--() : boolean
	AVISyncTiming 			,--() : boolean
	UVMapping 				,--() : integer
	ColorChannels 			,--() : integer
	AVIFramerate 			,--() : integer
	AVIStartFrame 			,--() : integer
	AVIStopFrame 			,--() : integer
	AVILoopType 			,--() : integer
	Rows 					,--() : integer
	Columns 				,--() : integer
	FileName 				,--() : string
	FresnelMode 			,--() : integer
	FresnelExponent 		,--() : float
	FresnelMin 				,--: float
	FresnelMax 				,--: float
	ProceduralTexture 		,--() : integer
	RenderToTextureSource 	,--() : integer
	PerlinNoiseAmp 			,--() : float
	PerlinNoiseFreq 		,--() : float
	FresnelRotationX 		,--() : float
	FresnelRotationY 		,--() : float
	FresnelMaskX 			,--() : float
	FresnelMaskY 			,--() : float
	FresnelMaskZ 			,--() : float
	--anim parameter---------------------
	Color 					= M3SD_ScAnimData(),--() : RGB color
	Alpha 					= M3SD_ScAnimData(),--() : integer
	RGBMultiply 			= M3SD_ScAnimData(),--() : float
	RGBAdd 					= M3SD_ScAnimData(),--() : float
	AVIPlay 				= M3SD_ScAnimData(),--() : boolean
	AVIRestart 				= M3SD_ScAnimData(),--() : boolean
	CurrentFrame 			= M3SD_ScAnimData(),--() : integer
	UOffset 				= M3SD_ScAnimData(),--() : float
	VOffset 				= M3SD_ScAnimData(),--() : float
	WOffset 				= M3SD_ScAnimData(),--() : float
	UAngle 					= M3SD_ScAnimData(),--() : angle
	VAngle 					= M3SD_ScAnimData(),--() : angle
	WAngle 					= M3SD_ScAnimData(),--() : angle
	UTiling 				= M3SD_ScAnimData(),--() : float
	VTiling 				= M3SD_ScAnimData(),--() : float
	WTiling 				= M3SD_ScAnimData(),--() : float
	TriXOffset 				= M3SD_ScAnimData(),--() : float
	TriYOffset 				= M3SD_ScAnimData(),--() : float
	TriZOffset 				= M3SD_ScAnimData(),--() : float
	TriXScale 				= M3SD_ScAnimData(),--() : float
	TriYScale 				= M3SD_ScAnimData(),--() : float
	TriZScale 				= M3SD_ScAnimData(),--() : float
	--UI parameter-----------------------
	FresnelClampPosition 	,--() : boolean
	--Bitmap () : bitmap

	fn copyData source_FP seq: m3: dir:#fromfile trk: tp: =
	(
		case dir of
		(
			#fromfile:
			(
				if(this.MapType == 1)then
				(
					this.UVMapping = case source_FP.mapping of
					(
						0: 0
						1: 1
						2: 2
						3: 3
						4: 4
						5: 5
						6:
						(
							if(source_FP.flags.bits[14])then(1)else(0)
						)
						7: 6
						8: 7
						11: 10
						12: 11
						13: 12
						14: 13
						15: 14
						16: 15
						17: 16
						18: 17
						default: 0
					)
				)
				this.FresnelClampPosition = false
				this.FresnelMax = source_FP.fresnelMin + source_FP.fresnelMax
			)
			#tofile:()
			default:
			(
				if(this.MapType == 1)then
				(
					M3F_DataApply dir this source_FP "UVMapping" 		""
				)
				M3F_DataApply dir this source_FP "FresnelClampPosition" ""
				M3F_DataApply dir this source_FP "FresnelMax" 			""
			)
		)
		if(this.MapType == 1)then
		(
			M3F_DataApply dir this source_FP "UTile" 					"flags.bits[3]"
			M3F_DataApply dir this source_FP "VTile" 					"flags.bits[4]"
			M3F_DataApply dir this source_FP "ColorInvert" 				"flags.bits[5]"
			M3F_DataApply dir this source_FP "ColorClamp" 				"flags.bits[6]"
			M3F_DataApply dir this source_FP "EnableFlipbook" 			"flags.bits[9]"

			M3F_DataApply dir this source_FP "AVISyncTiming" "aviSync" o:"=M3F_CvtType #bool "
			
			M3F_DataApply dir this source_FP "ColorChannels" 			"colorType"
			M3F_DataApply dir this source_FP "ProceduralTexture" 		"pocTexture"
			M3F_DataApply dir this source_FP "PerlinNoiseAmp" 			"noiseAmp"
			M3F_DataApply dir this source_FP "PerlinNoiseFreq" 			"noiseFreq"
			M3F_DataApply dir this source_FP "RenderToTextureSource" 	"texSource" \
			c:true f1:"+1" f2:"-1"
			M3F_DataApply dir this source_FP "AVIFramerate" 			"aviFrameRate"
			M3F_DataApply dir this source_FP "AVIStartFrame" 			"aviStart"
			M3F_DataApply dir this source_FP "AVIStopFrame" 			"aviStop"
			M3F_DataApply dir this source_FP "AVILoopType" 				"aviLoop"
			M3F_DataApply dir this source_FP "Rows" 					"rows"
			M3F_DataApply dir this source_FP "Columns" 					"columns"
			M3F_DataApply dir this source_FP "FileName" "rfdName.data" o:" = copy "
		)

		M3F_DataApply dir this source_FP "FresnelLocalTransform" 		"flags.bits[17]"
		M3F_DataApply dir this source_FP "FresnelSaturate" 				"flags.bits[18]"

		M3F_DataApply dir this source_FP "FresnelMode" 			"fresnelMode"
		M3F_DataApply dir this source_FP "FresnelExponent" 		"fresnelExponent"
		M3F_DataApply dir this source_FP "FresnelMin" 			"fresnelMin"
		
		M3F_DataApply dir this source_FP "FresnelMaskX" 		"fresnelMask[1]" \
			c:true f1:"*(-1) + 1" f2:"*(-1) + 1"
		M3F_DataApply dir this source_FP "FresnelMaskY" 		"fresnelMask[2]" \
			c:true f1:"*(-1) + 1" f2:"*(-1) + 1"
		M3F_DataApply dir this source_FP "FresnelMaskZ" 		"fresnelMask[3]" \
			c:true f1:"*(-1) + 1" f2:"*(-1) + 1"
		M3F_DataApply dir this source_FP "FresnelRotationX" 	"fresnelRot[1]" \
			c:true f1:"* 57.296" f2:"/ 57.296"
		M3F_DataApply dir this source_FP "FresnelRotationY" 	"fresnelRot[2]" \
			c:true f1:"* 57.296" f2:"/ 57.296"

		if(this.MapType == 2)then
		(
			M3F_AnimApply dir this source_FP \
			"Color" "rfaColor" seq:seq m3:m3 type:#color \
			anim:"color" trk:trk tp:tp
			M3F_AnimApply dir this source_FP \
			"Alpha" "rfaColor" seq:seq m3:m3 type:#alpha \
			anim:"color" trk:trk tp:tp
		)else
		(
			M3F_AnimApply dir this source_FP \
			"RGBMultiply" "rfaRGBmult" seq:seq m3:m3 \
			anim:"RGBMultiply" trk:trk tp:tp
			M3F_AnimApply dir this source_FP \
			"RGBAdd" "rfaRGBadd" seq:seq m3:m3 \
			anim:"RGBAdd" trk:trk tp:tp
			M3F_AnimApply dir this source_FP \
			"AVIPlay" "rfaAVIplay" seq:seq m3:m3 type:#bool \
			anim:"AVIPlay" trk:trk tp:tp
			M3F_AnimApply  dir this source_FP \
			"AVIRestart" "rfaAVIrestart" seq:seq m3:m3 type:#bool \
			anim:"AVIRestart" trk:trk tp:tp
			M3F_AnimApply  dir this source_FP \
			"CurrentFrame" "rfaCurFrame" seq:seq m3:m3 \
			anim:"CurrentFrame" trk:trk tp:tp

			M3F_AnimApply  dir this source_FP \
			"UOffset" "rfaUVoffset" seq:seq m3:m3 type:#u \
			anim:"uvOffset" trk:trk tp:tp
			M3F_AnimApply  dir this source_FP \
			"VOffset" "rfaUVoffset" seq:seq m3:m3 type:#v c:true mult:-1.0 \
			anim:"uvOffset" trk:trk tp:tp

			M3F_AnimApply  dir this source_FP \
			"UAngle" "rfaAngle" seq:seq m3:m3 type:#u c:true mult:-57.296 \
			anim:"uvwAngle" trk:trk tp:tp
			M3F_AnimApply  dir this source_FP \
			"VAngle" "rfaAngle" seq:seq m3:m3 type:#v c:true mult:57.296 \
			anim:"uvwAngle" trk:trk tp:tp
			M3F_AnimApply  dir this source_FP \
			"WAngle" "rfaAngle" seq:seq m3:m3 type:#w c:true mult:-57.296 \
			anim:"uvwAngle" trk:trk tp:tp

			M3F_AnimApply  dir this source_FP \
			"UTiling" "rfaUVtill" seq:seq m3:m3 type:#u \
			anim:"uvTiling" trk:trk tp:tp
			M3F_AnimApply  dir this source_FP \
			"VTiling" "rfaUVtill" seq:seq m3:m3 type:#v \
			anim:"uvTiling" trk:trk tp:tp

			M3F_AnimApply  dir this source_FP \
			"WOffset" "rfaWoffset" seq:seq m3:m3
			M3F_AnimApply  dir this source_FP \
			"WTiling" "rfaWtill" seq:seq m3:m3
			M3F_AnimApply  dir this source_FP \
			"TriXOffset" "rfaTriOffset" seq:seq m3:m3 type:#x \
			anim:"triplanarOffset" trk:trk tp:tp
			M3F_AnimApply  dir this source_FP \
			"TriYOffset" "rfaTriOffset" seq:seq m3:m3 type:#y \
			anim:"triplanarOffset" trk:trk tp:tp
			M3F_AnimApply  dir this source_FP \
			"TriZOffset" "rfaTriOffset" seq:seq m3:m3 type:#z \
			anim:"triplanarOffset" trk:trk tp:tp
			M3F_AnimApply  dir this source_FP \
			"TriXScale" "rfaTriScale" seq:seq m3:m3 type:#x \
			anim:"triplanarScale" trk:trk tp:tp
			M3F_AnimApply  dir this source_FP \
			"TriYScale" "rfaTriScale" seq:seq m3:m3 type:#y \
			anim:"triplanarScale" trk:trk tp:tp
			M3F_AnimApply  dir this source_FP \
			"TriZScale" "rfaTriScale" seq:seq m3:m3 type:#z \
			anim:"triplanarScale" trk:trk tp:tp
		)
	)
)

struct M3SD_ScNormMat
(
	--normal parameter-------------------
	VtxColor,
	VtxAlpha,
	ExpVtxRGBA,
	TwoSided,
	Unlit,
	CastShadows,
	HitTest,
	RecvShadows,
	TranslucencyDepthWrite,
	DepthFog,
	CastTransparentShadows,
	DecalLighting,
	TransaprencyAffectsDOF,
	TransparencyLocalLights,
	DisableSoftBlend,
	ForceDoubleLambertShading,
	HairSorting,
	AcceptSplats,
	RequiresDecal,
	RequiresEmissive,
	RequiresSpecular,
	OnlyAcceptSplats,
	BackgroundObject,
	RequiresZFill,
	NoHighlights,
	ClampOutput,
	MainPass,

	Priority,
	AlphaTestThreshold,
	DepthBlendFallOff,
	BlendOp,
	HDRSpecularMul,
	HDREmissiveMul,
	SpecularPower,
	EmissiveBlendOp1,
	EmissiveBlendOp2,
	EnvironmentBlendOp,
	GlossType,
	--anim parameter---------------------
	ParallaxHeight = M3SD_ScAnimData(),
	DecalAlpha = M3SD_ScAnimData(),
	EmissiveAlpha1 = M3SD_ScAnimData(),
	EmissiveAlpha2 = M3SD_ScAnimData(),
	EnvironmentAlpha = M3SD_ScAnimData(),
	--UI parameter-----------------------
	MatSubType,
	Specularity2,

	fn copyData source_FP seq: m3: dir:#fromfile =
	(
		case dir of
		(
			#fromfile:
			(
				this.ExpVtxRGBA = (source_FP.bFlags.bits[1] or source_FP.bFlags.bits[2])
				this.Specularity2 = 6
				this.BlendOp = case source_FP.blendMode of
				(
					0: 0
					2: 1;	3: 1
					4: 2;	6: 2
					5: 3
					1: 4
					default: 0
				)
				this.EmissiveBlendOp1 = case source_FP.emisBlendType1 of
				(2: 0;	3: 1;	4: 2;	0: 3;	1: 4;	default: 0)
				this.EmissiveBlendOp2 = case source_FP.emisBlendType2 of
				(2: 0;	3: 1;	4: 2;	0: 3;	1: 4;	default: 0)

				this.CastShadows = if(source_FP.bFlags.bits[6])then(false)else(true)
				this.HitTest = if(source_FP.bFlags.bits[7])then(false)else(true)
				this.RecvShadows = if(source_FP.bFlags.bits[8])then(false)else(true)

				if(source_FP.version == 15)then
				(
					this.DepthFog = source_FP.bFlags.bits[3]
					this.CastTransparentShadows = source_FP.bFlags.bits[12]
					this.OnlyAcceptSplats = source_FP.bFlags.bits[22]
					this.AcceptSplats = source_FP.bFlags.bits[26]
					this.MainPass = if(source_FP.bFlags.bits[32])then(false)else(true)
				)else
				(
					this.DepthFog = source_FP.bFlags.bits[14]
					this.CastTransparentShadows = source_FP.bFlags.bits[15]
					this.AcceptSplats = source_FP.bFlags.bits[22]
					this.OnlyAcceptSplats = source_FP.bFlags.bits[26]
					this.MainPass = source_FP.bFlags.bits[32]
				)
				
				
			)
			#tofile:()
			default:
			(
				M3F_DataApply dir this source_FP "CastShadows" 		""
				M3F_DataApply dir this source_FP "HitTest" 			""
				M3F_DataApply dir this source_FP "RecvShadows" 		""
				M3F_DataApply dir this source_FP "CastTransparentShadows" ""

				M3F_DataApply dir this source_FP "AcceptSplats" 	""
				M3F_DataApply dir this source_FP "OnlyAcceptSplats" ""

				M3F_DataApply dir this source_FP "MainPass" 		""

				M3F_DataApply dir this source_FP "BlendOp" 			""
				M3F_DataApply dir this source_FP "EmissiveBlendOp1" ""
				M3F_DataApply dir this source_FP "EmissiveBlendOp2" ""
				M3F_DataApply dir this source_FP "Specularity2" 	""
				M3F_DataApply dir this source_FP "ExpVtxRGBA" 		""
				M3F_AnimApply dir this source_FP "DecalAlpha" 		""
				M3F_AnimApply dir this source_FP "EmissiveAlpha1" 	""
				M3F_AnimApply dir this source_FP "EmissiveAlpha2" 	""
				M3F_AnimApply dir this source_FP "EnvironmentAlpha" ""
			)
		)
		M3F_DataApply dir this source_FP "VtxColor" 				"bFlags.bits[1]"
		M3F_DataApply dir this source_FP "VtxAlpha" 				"bFlags.bits[2]"
		
		M3F_DataApply dir this source_FP "TwoSided" 				"bFlags.bits[4]"
		M3F_DataApply dir this source_FP "Unlit" 					"bFlags.bits[5]"
		
		M3F_DataApply dir this source_FP "TranslucencyDepthWrite" 	"bFlags.bits[9]"
		
		M3F_DataApply dir this source_FP "DecalLighting" 			"bFlags.bits[16]"
		M3F_DataApply dir this source_FP "TransaprencyAffectsDOF" 	"bFlags.bits[17]"
		M3F_DataApply dir this source_FP "TransparencyLocalLights" 	"bFlags.bits[18]"
		M3F_DataApply dir this source_FP "DisableSoftBlend" 		"bFlags.bits[19]"
		M3F_DataApply dir this source_FP "ForceDoubleLambertShading" "bFlags.bits[20]"
		M3F_DataApply dir this source_FP "HairSorting" 				"bFlags.bits[21]"
		
		M3F_DataApply dir this source_FP "RequiresDecal" 			"bFlags.bits[23]"
		M3F_DataApply dir this source_FP "RequiresEmissive" 		"bFlags.bits[24]"
		M3F_DataApply dir this source_FP "RequiresSpecular" 		"bFlags.bits[25]"
		
		M3F_DataApply dir this source_FP "BackgroundObject" 		"bFlags.bits[27]"
		M3F_DataApply dir this source_FP "RequiresZFill" 			"bFlags.bits[29]"
		M3F_DataApply dir this source_FP "NoHighlights" 			"bFlags.bits[30]"
		M3F_DataApply dir this source_FP "ClampOutput" 				"bFlags.bits[31]"

		M3F_DataApply dir this source_FP "Priority" 				"mPriority"
		M3F_DataApply dir this source_FP "AlphaTestThreshold" 		"cutOutTreshold"
		M3F_DataApply dir this source_FP "DepthBlendFallOff" 		"depthBlendFallOff"
		M3F_DataApply dir this source_FP "HDRSpecularMul" 			"specMult"
		M3F_DataApply dir this source_FP "HDREmissiveMul" 			"emisMult"
		M3F_DataApply dir this source_FP "SpecularPower" 			"spec"
		M3F_DataApply dir this source_FP "EnvironmentBlendOp" 		"EnvBlendType"
		M3F_DataApply dir this source_FP "GlossType" 				"GlossType"

		M3F_AnimApply dir this source_FP \
		"ParallaxHeight" "rfaParallaxHeight" seq:seq m3:m3 c:true mult:100.0
	)
)

struct M3SD_ScDispMat
(
	DisplacementStrength 	= M3SD_ScAnimData(),--() : float
	Priority 				,--() : integer
	--Displacement : texturemap
	--DisplacementStrengthTexture () : texturemap

	fn copyData source_FP seq: m3: dir:#fromfile trk: tp: =
	(
		M3F_DataApply dir this source_FP "Priority" "disPriority"
		M3F_AnimApply dir this source_FP \
		"DisplacementStrength" "rfaStrength" seq:seq m3:m3 \
		anim:"DisplacementStrength" trk:trk tp:tp
	)
)

struct M3SD_ScCompMat
(
	SubMaterials = #() 		,--() : material array
	SubMatAlphas = #() 		,--() : float array
	Priority 				--() : integer
	--SubMatEnables = #()	,--() : boolean array
)

struct M3SD_ScVolumeMat
(
	VolumeCastShadows 			,--() : boolean
	Mode 						,--() : integer
	VolumeAlphaTestThreshold 	,--() : integer
	FalloffType 				,--() : integer
	Density = M3SD_ScAnimData()	,--() : float
	--Noisy1					,
	--Noisy2					,
	--ColorMap 					,--() : texturemap

	fn copyData source_FP seq: m3: dir:#fromfile =
	(
		M3F_DataApply dir this source_FP "VolumeCastShadows" 		"volFlags.bits[6]"
		M3F_DataApply dir this source_FP "Mode" 					"blendMode"
		M3F_DataApply dir this source_FP "VolumeAlphaTestThreshold" "AlphaThreshold"
		M3F_DataApply dir this source_FP "FalloffType" 				"falloffType"
		M3F_AnimApply dir this source_FP \
		"Density" "rfaDensity" seq:seq m3:m3
	)
)

struct M3SD_ScVolNoiseMat
(
	VolumeCastShadows 				,--() : boolean
	DrawBeforeTransparency 			,--() : boolean
	VolumeAlphaTestThreshold 		,--() : integer
	FalloffType 					,--() : integer
	NoiseTranslationX 				= M3SD_ScAnimData(),--() : float
	NoiseTranslationY 				= M3SD_ScAnimData(),--() : float
	NoiseTranslationZ 				= M3SD_ScAnimData(),--() : float
	NoiseRotationX 					= M3SD_ScAnimData(),--() : float
	NoiseRotationY 					= M3SD_ScAnimData(),--() : float
	NoiseRotationZ 					= M3SD_ScAnimData(),--() : float
	NoiseScaleX 					= M3SD_ScAnimData(),--() : float
	NoiseScaleY 					= M3SD_ScAnimData(),--() : float
	NoiseScaleZ 					= M3SD_ScAnimData(),--() : float
	NoiseScrollX 					= M3SD_ScAnimData(),--() : float
	NoiseScrollY 					= M3SD_ScAnimData(),--() : float
	NoiseScrollZ 					= M3SD_ScAnimData(),--() : float
	NearPlane 						= M3SD_ScAnimData(),--() : float
	FallOff 						= M3SD_ScAnimData(),--() : float
	Density 						= M3SD_ScAnimData(),--() : float
	--ColorMap () : texturemap
	--VolumeNoise1 () : texturemap
	--VolumeNoise2 () : texturemap

	fn copyData source_FP seq: m3: dir:#fromfile =
	(
		M3F_DataApply dir this source_FP "VolumeCastShadows" 		"vonFlags.bits[6]"
		M3F_DataApply dir this source_FP \
			"DrawBeforeTransparency" "DrawTrans" o:"=M3F_CvtType #bool "
		M3F_DataApply dir this source_FP "VolumeAlphaTestThreshold" "AlphaThreshold"
		M3F_DataApply dir this source_FP "FalloffType" 				"falloffType"
		
		M3F_AnimApply dir this source_FP \
		"Density" "rfaDensity" seq:seq m3:m3
		M3F_AnimApply dir this source_FP \
		"NearPlane" "rfaNearPlane" seq:seq m3:m3
		M3F_AnimApply dir this source_FP \
		"FallOff" "rfaFalloff" seq:seq m3:m3
		M3F_AnimApply dir this source_FP \
		"NoiseTranslationX" "rfaPos" seq:seq m3:m3 type:#x
		M3F_AnimApply dir this source_FP \
		"NoiseTranslationY" "rfaPos" seq:seq m3:m3 type:#y
		M3F_AnimApply dir this source_FP \
		"NoiseTranslationY" "rfaPos" seq:seq m3:m3 type:#z
		M3F_AnimApply dir this source_FP \
		"NoiseRotationX" "rfaRot" seq:seq m3:m3 type:#x c:true mult:57.296
		M3F_AnimApply dir this source_FP \
		"NoiseRotationY" "rfaRot" seq:seq m3:m3 type:#y c:true mult:57.296
		M3F_AnimApply dir this source_FP \
		"NoiseRotationZ" "rfaRot" seq:seq m3:m3 type:#z c:true mult:57.296
		M3F_AnimApply dir this source_FP \
		"NoiseScaleX" "rfaScale" seq:seq m3:m3 type:#x
		M3F_AnimApply dir this source_FP \
		"NoiseScaleY" "rfaScale" seq:seq m3:m3 type:#y
		M3F_AnimApply dir this source_FP \
		"NoiseScaleZ" "rfaScale" seq:seq m3:m3 type:#z
		M3F_AnimApply dir this source_FP \
		"NoiseScrollX" "rfaScrollRate" seq:seq m3:m3 type:#x
		M3F_AnimApply dir this source_FP \
		"NoiseScrollY" "rfaScrollRate" seq:seq m3:m3 type:#y
		M3F_AnimApply dir this source_FP \
		"NoiseScrollZ" "rfaScrollRate" seq:seq m3:m3 type:#z
	)
)

---------Particles Data
struct M3SD_ScPar
(
	MeshLink 						,--: string
	ParticleLink 					,--() : string
	SplineLink 						,--() : string
	ParticleSplatLink 				,--() : string
	TrailingParticleLink 			,--() : string
	EmitterType		 				,--: integer
	MaxParticles		 			,--: integer
	EmissionRate 					= M3SD_ScAnimData(),--() : float
	SquirtQuantity 					= M3SD_ScAnimData(),--() : integer
	LifetimeMin 					= M3SD_ScAnimData(),--() : float
	LifetimeMax 					= M3SD_ScAnimData(),--() : float
	LifetimeRange		 			,--() : boolean
	KillSphereEnable 				,--() : boolean
	KillSphereRadius				,--() : float
	LocalTime 						,--() : boolean
	SimulateOnInit 					,--() : boolean
	InitialVelocityType 			,--() : integer
	InitialVelocityYaw 				= M3SD_ScAnimData(),--() : float
	YawFunctionOverlay 				,--() : integer
	YawFunctionAmplitude 			= M3SD_ScAnimData(),--() : float
	YawFunctionFrequency 			= M3SD_ScAnimData(),--() : float
	InitialVelocityPitch 			= M3SD_ScAnimData(),--() : float
	PitchFunctionOverlay 			,--() : integer
	PitchFunctionAmplitude 			= M3SD_ScAnimData(),--: float
	PitchFunctionFrequency 			= M3SD_ScAnimData(),--: float
	InitialVelocityHorzSpread 		= M3SD_ScAnimData(),--: float
	HorzSpreadFunctionOverlay 		,--() : integer
	HorzSpreadFunctionAmplitude		= M3SD_ScAnimData(),--() : float
	HorzSpreadFunctionFrequency		= M3SD_ScAnimData(),--() : float
	InitialVelocityVertSpread 		= M3SD_ScAnimData(),--() : float
	VertSpreadFunctionOverlay 		,--() : integer
	VertSpreadFunctionAmplitude 	= M3SD_ScAnimData(),--() : float
	VertSpreadFunctionFrequency 	= M3SD_ScAnimData(),--() : float
	InitialVelocitySpeedMin 		= M3SD_ScAnimData(),--() : float
	InitialVelocitySpeedMax 		= M3SD_ScAnimData(),--() : float
	InitialVelocitySpeedRange 		,--() : boolean
	InheritParentVelocityCheck 		,--() : boolean
	InheritParentVelocityPercent 	= M3SD_ScAnimData(),--() : float
	ParticleVelocityXYOnlyCheck 	,--() : boolean
	SpeedFunctionOverlay 			,--() : integer
	SpeedFunctionAmplitude 			= M3SD_ScAnimData(),--() : float
	SpeedFunctionFrequency 			= M3SD_ScAnimData(),--() : float
	ColorMidTime 					,--() : float
	AlphaMidTime 					,--() : float
	SizeMidTime 					,--() : float
	RotationMidTime 				,--() : float
	ColorMinBegin 					= M3SD_ScAnimData(),--() : RGB color
	ColorMaxBegin 					= M3SD_ScAnimData(),--() : RGB color
	ColorMinMid 					= M3SD_ScAnimData(),--() : RGB color
	ColorMaxMid 					= M3SD_ScAnimData(),--() : RGB color
	ColorMinEnd 					= M3SD_ScAnimData(),--() : RGB color
	ColorMaxEnd 					= M3SD_ScAnimData(),--() : RGB color
	AlphaMinBegin 					= M3SD_ScAnimData(),--() : integer
	AlphaMaxBegin 					= M3SD_ScAnimData(),--() : integer
	AlphaMinMid 					= M3SD_ScAnimData(),--() : integer
	AlphaMaxMid 					= M3SD_ScAnimData(),--() : integer
	AlphaMinEnd 					= M3SD_ScAnimData(),--() : integer
	AlphaMaxEnd 					= M3SD_ScAnimData(),--() : integer
	AlphaFunctionOverlay 			,--() : integer
	AlphaFunctionAmplitude 			= M3SD_ScAnimData(),--() : float
	AlphaFunctionFrequency 			= M3SD_ScAnimData(),--() : float
	SizeMinBegin 					= M3SD_ScAnimData(),--() : float
	SizeMaxBegin 					= M3SD_ScAnimData(),--() : float
	SizeMinMid 						= M3SD_ScAnimData(),--() : float
	SizeMaxMid 						= M3SD_ScAnimData(),--() : float
	SizeMinEnd 						= M3SD_ScAnimData(),--() : float
	SizeMaxEnd 						= M3SD_ScAnimData(),--() : float
	SizeFunctionOverlay 			,--() : integer
	SizeFunctionAmplitude 			= M3SD_ScAnimData(),--() : float
	SizeFunctionFrequency 			= M3SD_ScAnimData(),--() : float
	RotationMinBegin 				= M3SD_ScAnimData(),--() : angle
	RotationMaxBegin 				= M3SD_ScAnimData(),--() : angle
	RotationMinMid 					= M3SD_ScAnimData(),--() : angle
	RotationMaxMid 					= M3SD_ScAnimData(),--() : angle
	RotationMinEnd 					= M3SD_ScAnimData(),--() : angle
	RotationMaxEnd 					= M3SD_ScAnimData(),--() : angle
	RotationFunctionOverlay			,--() : integer
	RotationFunctionAmplitude 		= M3SD_ScAnimData(),--() : float
	RotationFunctionFrequency 		= M3SD_ScAnimData(),--() : float
	ColorRange 						,--() : boolean
	AlphaRange 						,--() : boolean
	SizeRange 						,--() : boolean
	RotationRange 					,--() : boolean
	SmoothSizeInterpolation 		,--() : integer
	SmoothRotationInterpolation 	,--() : integer
	SmoothColorInterpolation 		,--() : integer
	MassMin 						,--() : float
	MassMax 						,--() : float
	MassRange 						,--() : boolean
	MassSizeMultiplier 				,--() : float
	Gravity 						,--: float
	MultiplyByMapGravity 			,--() : boolean
	Drag 							,--() : float
	GlobalWindScalar 				,--() : float
	WorldSpaceParticles 			,--() : boolean
	LitParticles 					,--() : boolean
	ScaleTimeByParent 				,--() : boolean
	ForceCPUSimulation 				,--() : boolean
	LODReduction 					,--() : integer
	UV2RandomOffset 				,--() : boolean
	LODCut 							,--() : integer
	ParticleGroup 					,--() : integer
	InnerLength 					= M3SD_ScAnimData(),--() : float
	InnerWidth 						= M3SD_ScAnimData(),--() : float
	InnerHeight 					= M3SD_ScAnimData(),--() : float
	OuterLength 					= M3SD_ScAnimData(),--() : float
	OuterWidth 						= M3SD_ScAnimData(),--() : float
	OuterHeight 					= M3SD_ScAnimData(),--() : float
	UseInnerShape 					,--() : boolean
	InnerRadius 					= M3SD_ScAnimData(),--() : float
	OuterRadius 					= M3SD_ScAnimData(),--() : float
	FlipbookMidTime 				,--() : float
	FlipbookBegin 					,--() : integer
	FlipbookMid 					,--() : integer
	FlipbookEnd 					,--() : integer
	FlipbookRows					,--() : integer
	FlipbookColumns 				,--() : integer
	FlipBookRandomStart 			,--() : boolean	
	ClampedTailLength 				,--() : boolean
	FixedTailLength 				,--() : boolean
	EnableSorting 					,--() : boolean
	SortOnZHeight 					,--() : boolean
	ReverseParticleItr 				,--() : boolean
	TrailPercentChance 				,--() : float
	TrailEmissionRate 				= M3SD_ScAnimData(),--() : float
	ParticleInheritScaleOnSpawning 	,--() : boolean
	NoiseFrequency 					,--() : float
	NoiseAmplitude 					,--() : float
	NoiseSpeed 						,--() : float
	NoiseFallOff 					,--() : float
	EnableTerrainCollision 			,--() : boolean
	EnableObjectCollision 			,--() : boolean
	EnableIndependentOnBounce 		,--() : boolean
	--ParticleInheritScaleOnSpawning2 ,--() : boolean
	SpawnOnBounceChance 			,--() : float
	ParticleFriction 				,--() : float
	ParticleBounceAmount 			,--() : float
	ParticleBounceSpawnEnergy 		,--() : float
	ParticleSpawnBounceMin 			,--() : integer
	ParticleSpawnBounceMax 			,--() : integer
	ParticleDieOnBounce 			,--() : integer
	SplineShapeLowerBound 			= M3SD_ScAnimData(),--() : float
	SplineShapeUpperBound 			= M3SD_ScAnimData(),--() : float
	SpawnSplatOnBounceChance 		,--() : float
	ParticleInstanceType 			,--() : integer
	ParticleInstanceTailLength		,--() : float
	ParticleInstanceYaw 			= M3SD_ScAnimData(),--() : float
	ParticleInstancePitch 			= M3SD_ScAnimData(),--() : float
	ParticleInstanceOffset 			,--() : float
	ColorMidHoldTime 				,--: float
	AlphaMidHoldTime 				,--: float
	SizeMidHoldTime 				,--: float
	RotationMidHoldTime 			,--: float
	ScreenSpace 					,--() : boolean
	ScreenSpaceMapped 				,--() : boolean
	UTiling 						= M3SD_ScAnimData(),--() : float
	VTiling 						= M3SD_ScAnimData(),--() : float
	UOffset 						= M3SD_ScAnimData(),--() : float
	VOffset 						= M3SD_ScAnimData(),--() : float
	UAngle 							= M3SD_ScAnimData(),--() : float
	VAngle 							= M3SD_ScAnimData(),--() : float
	WAngle 							= M3SD_ScAnimData(),--() : float
	AlphaThreshold 					= M3SD_ScAnimData(),--() : float
	RotationRelative 				,--() : boolean
	OverlayOffset 					= M3SD_ScAnimData(),--() : float
	ColorUseMid						,
	AlphaUseMid						,
	SizeUseMid						,
	RotationUseMid					,
	FlipbookUseMid					,
	ColorUseEnd						,
	AlphaUseEnd						,
	SizeUseEnd						,
	RotationUseEnd					,
	FlipbookUseEnd					,
	colorMidTimeLock				,
	alphaMidTimeLock				,
	sizeMidTimeLock					,
	rotationMidTimeLock				,
	flipbookMidTimeLock				,
	IndependentTimings				,
	AutoCalculateMaxParticleCount	,
	ModelName 						= #(),--() : string array
	UseModel 						,--() : boolean
	SwapYZOnLinkedModels 			,--() : boolean
	RandomRotationAxisOnLinkedModels,--() : boolean
	--SpawnRibbonOnBounceChance () : float
	--ParticleRibbonLink () : string

	
	fn copyData source_FP seq: m3: dir:#fromfile trk: tp: =
	(
		case dir of
		(
			#fromfile:
			(
				this.ColorUseMid					= true
				this.AlphaUseMid					= true
				this.SizeUseMid						= true
				this.RotationUseMid					= true
				this.FlipbookUseMid					= true
				this.ColorUseEnd					= true
				this.AlphaUseEnd					= true
				this.SizeUseEnd						= true
				this.RotationUseEnd					= true
				this.FlipbookUseEnd					= true
				this.IndependentTimings				= true
				this.colorMidTimeLock				= false
				this.alphaMidTimeLock				= false
				this.sizeMidTimeLock				= false
				this.rotationMidTimeLock			= false
				this.flipbookMidTimeLock			= false
				this.AutoCalculateMaxParticleCount	= false
				this.ParticleInstanceYaw = M3F_GetAngle #yaw \
					[source_FP.instAngle[3],source_FP.instAngle[2],source_FP.instAngle[1]]
				this.ParticleInstancePitch = M3F_GetAngle #pitch \
					[source_FP.instAngle[3],source_FP.instAngle[2],source_FP.instAngle[1]]

				this.FlipbookBegin = source_FP.filpBookPlay[1] + 1
				this.FlipbookMid = source_FP.filpBookPlay[2] + 1
				this.FlipbookEnd = source_FP.filpBookPlay[3] + 1
			)
			#tofile:
			(
				source_FP.instAngle = M3F_GetAngle #vector \
				[this.ParticleInstanceYaw, this.ParticleInstancePitch]
			)
			default:
			(
				M3F_DataApply dir this source_FP "ColorUseMid" 					""
				M3F_DataApply dir this source_FP "AlphaUseMid" 					""
				M3F_DataApply dir this source_FP "SizeUseMid" 					""
				M3F_DataApply dir this source_FP "RotationUseMid" 				""
				M3F_DataApply dir this source_FP "FlipbookUseMid" 				""
				M3F_DataApply dir this source_FP "ColorUseEnd" 					""
				M3F_DataApply dir this source_FP "AlphaUseEnd" 					""
				M3F_DataApply dir this source_FP "SizeUseEnd" 					""
				M3F_DataApply dir this source_FP "RotationUseEnd" 				""
				M3F_DataApply dir this source_FP "FlipbookUseEnd" 				""
				M3F_DataApply dir this source_FP "IndependentTimings" 			""
				M3F_DataApply dir this source_FP "colorMidTimeLock" 			""
				M3F_DataApply dir this source_FP "alphaMidTimeLock" 			""
				M3F_DataApply dir this source_FP "sizeMidTimeLock" 				""
				M3F_DataApply dir this source_FP "rotationMidTimeLock" 			""
				M3F_DataApply dir this source_FP "flipbookMidTimeLock" 			""
				M3F_DataApply dir this source_FP "AutoCalculateMaxParticleCount" ""
				M3F_DataApply dir this source_FP "ParticleInstanceYaw" 			""
				M3F_DataApply dir this source_FP "ParticleInstancePitch" 		""

				M3F_DataApply dir this source_FP "FlipbookBegin" 				""
				M3F_DataApply dir this source_FP "FlipbookMid" 					""
				M3F_DataApply dir this source_FP "FlipbookEnd" 					""
			)
		)
		M3F_DataApply dir this source_FP "InitialVelocitySpeedRange" "parFlags.bits[1]"
		M3F_DataApply dir this source_FP "LifetimeRange" 			"parFlags.bits[2]"
		M3F_DataApply dir this source_FP "MassRange" 				"parFlags.bits[3]"
		M3F_DataApply dir this source_FP "WorldSpaceParticles" 		"parFlags.bits[4]"

		M3F_DataApply dir this source_FP "EnableSorting" 			"parFlags1.bits[1]"
		M3F_DataApply dir this source_FP "EnableTerrainCollision" 	"parFlags1.bits[2]"
		M3F_DataApply dir this source_FP "EnableObjectCollision" 	"parFlags1.bits[3]"
		M3F_DataApply dir this source_FP "EnableIndependentOnBounce" "parFlags1.bits[4]"
		M3F_DataApply dir this source_FP "UseInnerShape" 			"parFlags1.bits[5]"
		M3F_DataApply dir this source_FP "InheritParentVelocityCheck" "parFlags1.bits[7]"
		M3F_DataApply dir this source_FP "SortOnZHeight" 			"parFlags1.bits[8]"
		M3F_DataApply dir this source_FP "ReverseParticleItr" 		"parFlags1.bits[9]"
		M3F_DataApply dir this source_FP "LitParticles" 			"parFlags1.bits[16]"
		M3F_DataApply dir this source_FP "FlipBookRandomStart" 		"parFlags1.bits[17]"
		M3F_DataApply dir this source_FP "MultiplyByMapGravity" 	"parFlags1.bits[18]"
		M3F_DataApply dir this source_FP "ClampedTailLength" 		"parFlags1.bits[19]"
		M3F_DataApply dir this source_FP "FixedTailLength" 			"parFlags1.bits[21]"

		M3F_DataApply dir this source_FP "UseModel" 				"parFlags1.bits[23]"
		M3F_DataApply dir this source_FP "SwapYZOnLinkedModels"		"parFlags1.bits[24]"

		M3F_DataApply dir this source_FP "ScaleTimeByParent" 		"parFlags1.bits[25]"
		M3F_DataApply dir this source_FP "LocalTime" 				"parFlags1.bits[26]"
		M3F_DataApply dir this source_FP "SimulateOnInit" 			"parFlags1.bits[27]"
		M3F_DataApply dir this source_FP "ForceCPUSimulation" 		"parFlags1.bits[29]"
		M3F_DataApply dir this source_FP "ScreenSpace" 				"parFlags1.bits[30]"
		M3F_DataApply dir this source_FP "ScreenSpaceMapped" 		"parFlags1.bits[31]"

		M3F_DataApply dir this source_FP "UV2RandomOffset" 			"parFlags2.bits[1]"
		M3F_DataApply dir this source_FP "RotationRelative" 		"parFlags2.bits[2]"
		M3F_DataApply dir this source_FP "KillSphereEnable" 		"parFlags2.bits[3]"
		M3F_DataApply dir this source_FP "ParticleVelocityXYOnlyCheck" "parFlags2.bits[4]"
		M3F_DataApply dir this source_FP "ParticleInheritScaleOnSpawning" "parFlags2.bits[5]"
		M3F_DataApply dir this source_FP "RandomRotationAxisOnLinkedModels" "parFlags2.bits[8]"
		
		M3F_DataApply dir this source_FP "EmitterType" 				"emissShape"
		M3F_DataApply dir this source_FP "InitialVelocityType" 		"ivType"
		M3F_DataApply dir this source_FP "ParticleInstanceType" 	"instType"
		M3F_DataApply dir this source_FP "FlipbookRows" 			"filpBookRow"
		M3F_DataApply dir this source_FP "FlipbookColumns" 			"filpBookColumn"
		
		M3F_AnimApply dir this source_FP \
		"InnerWidth" "rfaShapeInner" seq:seq m3:m3 type:#x c:true mult:100.0 \
		anim:"EmitterInnerSize" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"InnerLength" "rfaShapeInner" seq:seq m3:m3 type:#y c:true mult:100.0 \
		anim:"EmitterInnerSize" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"InnerHeight" "rfaShapeInner" seq:seq m3:m3 type:#z c:true mult:100.0 \
		anim:"EmitterInnerSize" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"OuterWidth" "rfaShapeOuter" seq:seq m3:m3 type:#x c:true mult:100.0 \
		anim:"EmitterSize" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"OuterLength" "rfaShapeOuter" seq:seq m3:m3 type:#y c:true mult:100.0 \
		anim:"EmitterSize" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"OuterHeight" "rfaShapeOuter" seq:seq m3:m3 type:#z c:true mult:100.0 \
		anim:"EmitterSize" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"InnerRadius" "rfaInRadius" seq:seq m3:m3 c:true mult:100.0 \
		anim:"InnerRadius" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"OuterRadius" "rfaOutRadius" seq:seq m3:m3 c:true mult:100.0 \
		anim:"OuterRadius" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"SplineShapeUpperBound" "rfaUpBound" seq:seq m3:m3 \
		anim:"SplineShapeUpperBound" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"SplineShapeLowerBound" "rfaLowBound" seq:seq m3:m3 \
		anim:"SplineShapeLowerBound" trk:trk tp:tp
				
		M3F_DataApply dir this source_FP "MaxParticles" 				"maxPart"
		M3F_DataApply dir this source_FP "KillSphereRadius" 			"killRadius"
		M3F_DataApply dir this source_FP "ParticleInstanceOffset" 		"endScale"
		M3F_DataApply dir this source_FP "ParticleInstanceTailLength" 	"tailLens"
		M3F_DataApply dir this source_FP "TrailPercentChance" 			"trailChance" \
			c:true f1:"* 100.0" f2:"/ 100.0"
		
		M3F_AnimApply dir this source_FP \
		"TrailEmissionRate" "rfaTrailEmissRate" seq:seq m3:m3 \
		anim:"TrailEmissionRate" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"EmissionRate" "rfaEmissRate" seq:seq m3:m3 \
		anim:"EmissionRate" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"SquirtQuantity" "rfaSquirtAmount" seq:seq m3:m3 \
		anim:"SquirtQuantity" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"LifetimeMin" "rfaLifeTime" seq:seq m3:m3 \
		anim:"lifetime" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"LifetimeMax" "rfaLifeTimeR" seq:seq m3:m3 \
		anim:"lifetime" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"InitialVelocityYaw" "rfaIVyaw" seq:seq m3:m3 \
		anim:"InitialVelocityYaw" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"InitialVelocityPitch" "rfaIVpitch" seq:seq m3:m3 \
		anim:"InitialVelocityPitch" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"InitialVelocityHorzSpread" "rfaIVHorz" seq:seq m3:m3 c:true mult:114.592 \
		anim:"InitialVelocityHorzSpread" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"InitialVelocityVertSpread" "rfaIVvert" seq:seq m3:m3 c:true mult:114.592 \
		anim:"InitialVelocityVertSpread" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"InitialVelocitySpeedMin" "rfaIVspeed" seq:seq m3:m3 c:true mult:100.0 \
		anim:"InitialVelocitySpeedMin" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"InitialVelocitySpeedMax" "rfaIVspeedR" seq:seq m3:m3 c:true mult:100.0 \
		anim:"InitialVelocitySpeedMax" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"InheritParentVelocityPercent" "rfaPtVelocity" seq:seq m3:m3 c:true mult:100.0 \
		anim:"InheritParentVelocityPercent" trk:trk tp:tp
		
		M3F_DataApply dir this source_FP "ColorRange" "colorEnableR" o:"=M3F_CvtType #bool "
		M3F_DataApply dir this source_FP "AlphaRange" "alphaEnableR" o:"=M3F_CvtType #bool "
		M3F_DataApply dir this source_FP "SizeRange" "sizeEnableR" o:"=M3F_CvtType #bool "
		M3F_DataApply dir this source_FP "RotationRange" "rotEnableR" o:"=M3F_CvtType #bool "
	
		M3F_AnimApply dir this source_FP \
		"ColorMinBegin" "rfaColorStart" seq:seq m3:m3 type:#color \
		anim:"ColorAndAlpha" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"ColorMaxBegin" "rfaColorStartR" seq:seq m3:m3 type:#color \
		anim:"ColorAndAlpha" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"ColorMinMid" "rfaColorMid" seq:seq m3:m3 type:#color \
		anim:"ColorAndAlpha" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"ColorMaxMid" "rfaColorMidR" seq:seq m3:m3 type:#color \
		anim:"ColorAndAlpha" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"ColorMinEnd" "rfaColorEnd" seq:seq m3:m3 type:#color \
		anim:"ColorAndAlpha" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"ColorMaxEnd" "rfaColorEndR" seq:seq m3:m3 type:#color \
		anim:"ColorAndAlpha" trk:trk tp:tp

		M3F_AnimApply dir this source_FP \
		"AlphaMinBegin" "rfaColorStart" seq:seq m3:m3 type:#alpha \
		anim:"ColorAndAlpha" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"AlphaMaxBegin" "rfaColorStartR" seq:seq m3:m3 type:#alpha \
		anim:"ColorAndAlpha" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"AlphaMinMid" "rfaColorMid" seq:seq m3:m3 type:#alpha \
		anim:"ColorAndAlpha" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"AlphaMaxMid" "rfaColorMidR" seq:seq m3:m3 type:#alpha \
		anim:"ColorAndAlpha" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"AlphaMinEnd" "rfaColorEnd" seq:seq m3:m3 type:#alpha \
		anim:"ColorAndAlpha" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"AlphaMaxEnd" "rfaColorEndR" seq:seq m3:m3 type:#alpha \
		anim:"ColorAndAlpha" trk:trk tp:tp

		M3F_AnimApply dir this source_FP \
		"SizeMinBegin" "rfaSizePlay" seq:seq m3:m3 type:#x c:true mult:100.0 \
		anim:"Particle_Size" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"SizeMaxBegin" "rfaSizePlayR" seq:seq m3:m3 type:#x c:true mult:100.0 \
		anim:"Particle_Size" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"SizeMinMid" "rfaSizePlay" seq:seq m3:m3 type:#y c:true mult:100.0 \
		anim:"Particle_Size" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"SizeMaxMid" "rfaSizePlayR" seq:seq m3:m3 type:#y c:true mult:100.0 \
		anim:"Particle_Size" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"SizeMinEnd" "rfaSizePlay" seq:seq m3:m3 type:#z c:true mult:100.0 \
		anim:"Particle_Size" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"SizeMaxEnd" "rfaSizePlayR" seq:seq m3:m3 type:#z c:true mult:100.0 \
		anim:"Particle_Size" trk:trk tp:tp
	
		M3F_AnimApply dir this source_FP \
		"RotationMinBegin" "rfaRotPlay" seq:seq m3:m3 type:#x c:true mult:57.296 \
		anim:"Particle_Rotation" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"RotationMaxBegin" "rfaRotPlayR" seq:seq m3:m3 type:#x c:true mult:57.296 \
		anim:"Particle_Rotation" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"RotationMinMid" "rfaRotPlay" seq:seq m3:m3 type:#y c:true mult:57.296 \
		anim:"Particle_Rotation" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"RotationMaxMid" "rfaRotPlayR" seq:seq m3:m3 type:#y c:true mult:57.296 \
		anim:"Particle_Rotation" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"RotationMinEnd" "rfaRotPlay" seq:seq m3:m3 type:#z c:true mult:57.296 \
		anim:"Particle_Rotation" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"RotationMaxEnd" "rfaRotPlayR" seq:seq m3:m3 type:#z c:true mult:57.296 \
		anim:"Particle_Rotation" trk:trk tp:tp
	
		M3F_DataApply dir this source_FP "SmoothSizeInterpolation" 	"sizeSmootying"
		M3F_DataApply dir this source_FP "SmoothRotationInterpolation" "rotSmootying"
		M3F_DataApply dir this source_FP "SmoothColorInterpolation" "colorSmootying"

		M3F_DataApply dir this source_FP "ColorMidTime" 			"colorMTime"
		M3F_DataApply dir this source_FP "AlphaMidTime" 			"alphaMTime"
		M3F_DataApply dir this source_FP "SizeMidTime" 				"sizeMTime"
		M3F_DataApply dir this source_FP "RotationMidTime" 			"rotMTime"
		M3F_DataApply dir this source_FP "FlipbookMidTime" 			"filpBookMT"
		M3F_DataApply dir this source_FP "ColorMidHoldTime" 		"colorMHTime"
		M3F_DataApply dir this source_FP "AlphaMidHoldTime" 		"alphaMHTime"
		M3F_DataApply dir this source_FP "SizeMidHoldTime" 			"sizeMHTime"
		M3F_DataApply dir this source_FP "RotationMidHoldTime" 		"rotMHTime"

		M3F_DataApply dir this source_FP "YawFunctionOverlay" 			"yawType"
		M3F_DataApply dir this source_FP "PitchFunctionOverlay" 		"pitchType"
		M3F_DataApply dir this source_FP "HorzSpreadFunctionOverlay" 	"horzType"
		M3F_DataApply dir this source_FP "VertSpreadFunctionOverlay" 	"vertType"
		M3F_DataApply dir this source_FP "SpeedFunctionOverlay" 		"speedType"
		M3F_DataApply dir this source_FP "AlphaFunctionOverlay" 		"alphaType"
		M3F_DataApply dir this source_FP "SizeFunctionOverlay" 			"sizeType"
		M3F_DataApply dir this source_FP "RotationFunctionOverlay" 		"rotType"

		M3F_AnimApply dir this source_FP \
		"YawFunctionAmplitude" "rfaYawAmp" seq:seq m3:m3 \
		anim:"YawFunctionAmplitude" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"YawFunctionFrequency" "rfaYawFreq" seq:seq m3:m3 \
		anim:"YawFunctionFrequency" trk:trk tp:tp

		M3F_AnimApply dir this source_FP \
		"PitchFunctionAmplitude" "rfaPitchAmp" seq:seq m3:m3 \
		anim:"PitchFunctionAmplitude" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"PitchFunctionFrequency" "rfaPitchFreq" seq:seq m3:m3 \
		anim:"PitchFunctionFrequency" trk:trk tp:tp

		M3F_AnimApply dir this source_FP \
		"HorzSpreadFunctionAmplitude" "rfaHorzAmp" seq:seq m3:m3 \
		anim:"HorzSpreadFunctionAmplitude" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"HorzSpreadFunctionFrequency" "rfaHorzFreq" seq:seq m3:m3 \
		anim:"HorzSpreadFunctionFrequency" trk:trk tp:tp

		M3F_AnimApply dir this source_FP \
		"VertSpreadFunctionAmplitude" "rfaVertAmp" seq:seq m3:m3 \
		anim:"VertSpreadFunctionAmplitude" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"VertSpreadFunctionFrequency" "rfaVertFreq" seq:seq m3:m3 \
		anim:"VertSpreadFunctionFrequency" trk:trk tp:tp

		M3F_AnimApply dir this source_FP \
		"SpeedFunctionAmplitude" "rfaSpeedAmp" seq:seq m3:m3 \
		anim:"SpeedFunctionAmplitude" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"SpeedFunctionFrequency" "rfaSpeedFreq" seq:seq m3:m3 \
		anim:"SpeedFunctionFrequency" trk:trk tp:tp

		M3F_AnimApply dir this source_FP \
		"AlphaFunctionAmplitude" "rfaAlphaAmp" seq:seq m3:m3 \
		anim:"AlphaFunctionAmplitude" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"AlphaFunctionFrequency" "rfaAlphaFreq" seq:seq m3:m3 \
		anim:"AlphaFunctionFrequency" trk:trk tp:tp

		M3F_AnimApply dir this source_FP \
		"SizeFunctionAmplitude" "rfaSizeAmp" seq:seq m3:m3 \
		anim:"SizeFunctionAmplitude" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"SizeFunctionFrequency" "rfaSizeFreq" seq:seq m3:m3 \
		anim:"SizeFunctionFrequency" trk:trk tp:tp
		
		M3F_AnimApply dir this source_FP \
		"RotationFunctionAmplitude" "rfaRotAmp" seq:seq m3:m3 \
		anim:"RotationFunctionAmplitude" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"RotationFunctionFrequency" "rfaRotFreq" seq:seq m3:m3 \
		anim:"RotationFunctionFrequency" trk:trk tp:tp

		M3F_DataApply dir this source_FP "NoiseFrequency" 		"noiseFreq"
		M3F_DataApply dir this source_FP "NoiseAmplitude" 		"noiseAmp" \
			c:true f1:"* 100.0" f2:"/ 100.0"
		M3F_DataApply dir this source_FP "NoiseSpeed" 			"noiseCoh"
		M3F_DataApply dir this source_FP "NoiseFallOff" 		"noiseEdge"

		M3F_DataApply dir this source_FP "MassMin" 				"pMass"
		M3F_DataApply dir this source_FP "MassMax" 				"pMassR"
		M3F_DataApply dir this source_FP "MassSizeMultiplier" 	"pMassMult"
		M3F_DataApply dir this source_FP "Gravity" 				"pGravity" \
			c:true f1:"* (-100.0)" f2:"/ (-100.0)"
		M3F_DataApply dir this source_FP "Drag" 				"pDrag"
		M3F_DataApply dir this source_FP "GlobalWindScalar" 	"pWindMult"
		M3F_DataApply dir this source_FP "LODReduction" 		"pLODreduce"
		M3F_DataApply dir this source_FP "LODCut" 				"pLODcut"
		M3F_DataApply dir this source_FP "ParticleGroup" 		"pLocalChns"

		M3F_DataApply dir this source_FP "ParticleBounceAmount" 	"bounce" \
			c:true f1:"* 100.0" f2:"/ 100.0"
		M3F_DataApply dir this source_FP "ParticleFriction" 		"friction" \
			c:true f1:"*(-100.0) + 100.0" f2:"/(-100.0) + 1.0"
		M3F_DataApply dir this source_FP "SpawnOnBounceChance" 		"colSpawnChance" \
			c:true f1:"* 100.0" f2:"/ 100.0"
		M3F_DataApply dir this source_FP "ParticleBounceSpawnEnergy" "colSpawnEnergy" \
			c:true f1:"* 100.0" f2:"/ 100.0"
		M3F_DataApply dir this source_FP "SpawnSplatOnBounceChance" "splatChance" \
			c:true f1:"* 100.0" f2:"/ 100.0"

		M3F_DataApply dir this source_FP "ParticleSpawnBounceMin" 	"colSpawnMin"
		M3F_DataApply dir this source_FP "ParticleSpawnBounceMax" 	"colSpawnMax"
		M3F_DataApply dir this source_FP "ParticleDieOnBounce" 		"colDieBounce"
	
		M3F_AnimApply dir this source_FP \
		"UTiling" "rfaUVtill" seq:seq m3:m3 type:#u \
		anim:"uvTiling" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"VTiling" "rfaUVtill" seq:seq m3:m3 type:#v \
		anim:"uvTiling" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"UOffset" "rfaUVoffset" seq:seq m3:m3 type:#u \
		anim:"uvOffset" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"VOffset" "rfaUVoffset" seq:seq m3:m3 type:#v \
		anim:"uvOffset" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"UAngle" "rfaAngle" seq:seq m3:m3 type:#u c:true mult:57.296 \
		anim:"uvRotation" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"VAngle" "rfaAngle" seq:seq m3:m3 type:#v c:true mult:57.296 \
		anim:"uvRotation" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"WAngle" "rfaAngle" seq:seq m3:m3 type:#w c:true mult:57.296 \
		anim:"uvRotation" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"AlphaThreshold" "rfaAlphaThold" seq:seq m3:m3 \
		anim:"Alpha threshold" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"OverlayOffset" "rfaOverlay" seq:seq m3:m3 \
		anim:"OverlayOffset" trk:trk tp:tp
	)
)

struct M3SD_ScRibbon
(
	subParType						,
	LifetimeMin 					= M3SD_ScAnimData(),--() : float
	InitialVelocityYaw 				= M3SD_ScAnimData(),--() : float
	YawFunctionOverlay 				,--() : integer
	YawFunctionAmplitude 			= M3SD_ScAnimData(),--() : float
	YawFunctionFrequency 			= M3SD_ScAnimData(),--() : float
	InitialVelocityPitch 			= M3SD_ScAnimData(),--() : float
	PitchFunctionOverlay 			,--() : integer
	PitchFunctionAmplitude 			= M3SD_ScAnimData(),--() : float
	PitchFunctionFrequency 			= M3SD_ScAnimData(),--() : float
	InitialVelocitySpeedMin 		= M3SD_ScAnimData(),--() : float
	SpeedFunctionOverlay 			,--() : integer
	SpeedFunctionAmplitude 			= M3SD_ScAnimData(),--() : float
	SpeedFunctionFrequency 			= M3SD_ScAnimData(),--() : float
	InheritParentVelocityCheck 		,--() : boolean
	InheritParentVelocityPercent 	= M3SD_ScAnimData(),--() : float
	ColorMidTime 					,--() : float
	AlphaMidTime 					,--() : float
	AlphaFunctionOverlay 			,--() : integer
	AlphaFunctionAmplitude 			= M3SD_ScAnimData(),--() : float
	AlphaFunctionFrequency 			= M3SD_ScAnimData(),--() : float
	SizeMidTime 					,--() : float
	SizeFunctionOverlay 			,--() : integer
	SizeFunctionAmplitude 			= M3SD_ScAnimData(),--() : float
	SizeFunctionFrequency 			= M3SD_ScAnimData(),--() : float
	RotationMidTime 				,--() : float
	ColorMinBegin 					= M3SD_ScAnimData(),--() : RGB color
	ColorMinMid 					= M3SD_ScAnimData(),--() : RGB color
	ColorMinEnd 					= M3SD_ScAnimData(),--() : RGB color
	AlphaMinBegin 					= M3SD_ScAnimData(),--() : integer
	AlphaMinMid 					= M3SD_ScAnimData(),--() : integer
	AlphaMinEnd 					= M3SD_ScAnimData(),--() : integer
	SizeMinBegin 					= M3SD_ScAnimData(),--() : float
	SizeMinMid 						= M3SD_ScAnimData(),--() : float
	SizeMinEnd 						= M3SD_ScAnimData(),--() : float
	RotationMinBegin 				= M3SD_ScAnimData(),--() : angle
	RotationMinMid 					= M3SD_ScAnimData(),--() : angle
	RotationMinEnd 					= M3SD_ScAnimData(),--() : angle
	MassMin 						,--() : float
	MassMax 						,--() : float
	Gravity 						,--() : float
	Drag 							,--() : float
	WorldSpaceParticles 			,--() : boolean
	ScaleTimeByParent 				,--() : boolean
	OverlayOffset 					= M3SD_ScAnimData(),--() : float
	LODReduction 					,--() : integer
	LODCut 							,--() : integer
	ParticleGroup 					,--() : integer
	ForceCPUSimulation 				,--() : boolean
	AccurateGPUTangents 			,--() : boolean
	MassSizeMultiplier 				,--() : float
	ShapeType 						,--() : integer
	Interpolant 					,--() : integer
	EdgeCount 						,--() : integer
	InnerRadius 					,--() : float
	LifetimeAndLength 				,--() : boolean
	MaxLength 						= M3SD_ScAnimData(),--() : float
	LocalTime 						,--() : boolean
	SimulateOnInit 					,--() : boolean
	SmoothSizeInterpolation 		,--() : integer
	NoiseFrequency 					,--() : float
	NoiseAmplitude 					,--() : float
	NoiseSpeed 						,--() : float
	NoiseFallOff 					,--() : float
	EnableTerrainCollision 			,--() : boolean
	EnableObjectCollision 			,--() : boolean
	ParticleFriction 				,--() : float
	ParticleBounceAmount 			,--() : float
	MaxElemsPerSec 					,--() : float
	Active 							= M3SD_ScAnimData(),--() : boolean
	SizeMidHoldTime 				,--: float
	AlphaMidHoldTime 				,--: float
	ColorMidHoldTime 				,--: float
	SmoothColorInterpolation 		,--() : integer
	ColorUseMid						,
	AlphaUseMid						,
	SizeUseMid						,
	RotationUseMid					,
	ColorUseEnd 					,
	AlphaUseEnd						,
	SizeUseEnd						,
	RotationUseEnd					,
	IndependentTimings				,
	colorMidTimeLock				,
	alphaMidTimeLock				,
	sizeMidTimeLock					,
	rotationMidTimeLock				,
	------------Quality () : float
	------------LitParticles () : boolean
	------------Visible : boolean
	------------MultiplyByMapGravity () : boolean

	fn copyData source_FP seq: m3: dir:#fromfile trk: tp: =
	(
		case dir of
		(
			#fromfile:
			(
				this.ColorUseMid					= true
				this.AlphaUseMid					= true
				this.SizeUseMid						= true
				this.RotationUseMid					= true
				this.ColorUseEnd 					= true
				this.AlphaUseEnd					= true
				this.SizeUseEnd						= true
				this.RotationUseEnd					= true
				this.IndependentTimings				= true
				this.colorMidTimeLock				= false
				this.alphaMidTimeLock				= false
				this.sizeMidTimeLock				= false
				this.rotationMidTimeLock			= false

				if(source_FP.version == 0x06)then
				(
					this.WorldSpaceParticles = source_FP.ribFlags.bits[1]
				)else
				(
					this.WorldSpaceParticles = source_FP.ribFlags.bits[4]
				)
			)
			#tofile:
			()
			default:
			(
				M3F_DataApply dir this source_FP "ColorUseMid" 			""
				M3F_DataApply dir this source_FP "AlphaUseMid" 			""
				M3F_DataApply dir this source_FP "SizeUseMid" 			""
				M3F_DataApply dir this source_FP "RotationUseMid" 		""
				M3F_DataApply dir this source_FP "ColorUseEnd" 			""
				M3F_DataApply dir this source_FP "AlphaUseEnd" 			""
				M3F_DataApply dir this source_FP "SizeUseEnd" 			""
				M3F_DataApply dir this source_FP "RotationUseEnd" 		""
				M3F_DataApply dir this source_FP "IndependentTimings" 	""
				M3F_DataApply dir this source_FP "colorMidTimeLock" 	""
				M3F_DataApply dir this source_FP "alphaMidTimeLock" 	""
				M3F_DataApply dir this source_FP "sizeMidTimeLock" 		""
				M3F_DataApply dir this source_FP "rotationMidTimeLock" 	""
				M3F_DataApply dir this source_FP "WorldSpaceParticles" 	""
			)
		)

		M3F_DataApply dir this source_FP "InheritParentVelocityCheck" 	"ribFlags1.bits[5]"
		M3F_DataApply dir this source_FP "ScaleTimeByParent" 			"ribFlags1.bits[9]"
		if(this.subParType == 0)then
		(
			M3F_DataApply dir this source_FP "EnableTerrainCollision" 	"ribFlags1.bits[2]"
			M3F_DataApply dir this source_FP "EnableObjectCollision" 	"ribFlags1.bits[3]"
			M3F_DataApply dir this source_FP "ForceCPUSimulation" 		"ribFlags1.bits[10]"
			M3F_DataApply dir this source_FP "LocalTime" 				"ribFlags1.bits[11]"
			M3F_DataApply dir this source_FP "SimulateOnInit" 			"ribFlags1.bits[12]"
			M3F_DataApply dir this source_FP "LifetimeAndLength" 		"ribFlags1.bits[13]"
			M3F_DataApply dir this source_FP "AccurateGPUTangents" 		"ribFlags1.bits[14]"
			
			M3F_DataApply dir this source_FP "SmoothSizeInterpolation" 	"sizeSmootying"
			
			M3F_AnimApply dir this source_FP \
			"Active" "rfaActive" seq:seq m3:m3 type:#bool \
			anim:"active" trk:trk tp:tp

			M3F_DataApply dir this source_FP "MassSizeMultiplier" 		"pMassMult"
			M3F_DataApply dir this source_FP "ParticleFriction" 	"friction" \
			c:true f1:"*(-100.0) + 100.0" f2:"/(-100.0) + 1.0"
			M3F_DataApply dir this source_FP "ParticleBounceAmount" 	"bounce" \
			c:true f1:"* 100.0" f2:"/ 100.0"
		)
		
		M3F_DataApply dir this source_FP "ShapeType" 				"emissShape"
		M3F_DataApply dir this source_FP "Interpolant" 				"basedSrc"
		M3F_DataApply dir this source_FP "EdgeCount" 				"edges"
		M3F_DataApply dir this source_FP "MaxElemsPerSec" 			"maxSegs"
		M3F_DataApply dir this source_FP "InnerRadius" 				"innerRadius" \
			c:true f1:"* 100.0" f2:"/ 100.0"

		M3F_DataApply dir this source_FP "SmoothColorInterpolation" "colorSmootying"

		M3F_DataApply dir this source_FP "ColorMidTime" 			"colorMTime"
		M3F_DataApply dir this source_FP "AlphaMidTime" 			"alphaMTime"
		M3F_DataApply dir this source_FP "SizeMidTime" 				"sizeMTime"
		M3F_DataApply dir this source_FP "RotationMidTime" 			"rotMTime"
		
		M3F_DataApply dir this source_FP "ColorMidHoldTime" 		"colorMHTime"
		M3F_DataApply dir this source_FP "AlphaMidHoldTime" 		"alphaMHTime"
		M3F_DataApply dir this source_FP "SizeMidHoldTime" 			"sizeMHTime"

		M3F_AnimApply dir this source_FP \
			"MaxLength" "rfaMaxLen" seq:seq m3:m3 c:true mult:100.0 \
			anim:"MaxLength" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
			"LifetimeMin" "rfaLifeTime" seq:seq m3:m3 \
			anim:"lifetime" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
			"InitialVelocityYaw" "rfaIVyaw" seq:seq m3:m3 \
			anim:"InitialVelocityYaw" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
			"InitialVelocityPitch" "rfaIVpitch" seq:seq m3:m3 \
			anim:"InitialVelocityPitch" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
			"InitialVelocitySpeedMin" "rfaIVspeed" seq:seq m3:m3 c:true mult:100.0 \
			anim:"InitialVelocitySpeedMin" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
			"InheritParentVelocityPercent" "rfaPtVelocity" seq:seq m3:m3 c:true mult:100.0 \
			anim:"InheritParentVelocityPercent" trk:trk tp:tp

		M3F_AnimApply dir this source_FP \
			"SizeMinBegin" "rfaSizePlay" seq:seq m3:m3 type:#x c:true mult:50.0 \
			anim:"Particle_Size" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
			"SizeMinMid" "rfaSizePlay" seq:seq m3:m3 type:#y c:true mult:50.0 \
			anim:"Particle_Size" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
			"SizeMinEnd" "rfaSizePlay" seq:seq m3:m3 type:#z c:true mult:50.0 \
			anim:"Particle_Size" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
			"RotationMinBegin" "rfaRotPlay" seq:seq m3:m3 type:#x c:true mult:57.296 \
			anim:"Particle_Rotation" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
			"RotationMinMid" "rfaRotPlay" seq:seq m3:m3 type:#y c:true mult:57.296 \
			anim:"Particle_Rotation" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
			"RotationMinEnd" "rfaRotPlay" seq:seq m3:m3 type:#z c:true mult:57.296 \
			anim:"Particle_Rotation" trk:trk tp:tp

		M3F_AnimApply dir this source_FP \
			"ColorMinBegin" "rfaColorStart" seq:seq m3:m3 type:#color \
			anim:"ColorAndAlpha" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
			"ColorMinMid" "rfaColorMid" seq:seq m3:m3 type:#color \
			anim:"ColorAndAlpha" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
			"ColorMinEnd" "rfaColorEnd" seq:seq m3:m3 type:#color \
			anim:"ColorAndAlpha" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
			"AlphaMinBegin" "rfaColorStart" seq:seq m3:m3 type:#alpha \
			anim:"ColorAndAlpha" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
			"AlphaMinMid" "rfaColorMid" seq:seq m3:m3 type:#alpha \
			anim:"ColorAndAlpha" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
			"AlphaMinEnd" "rfaColorEnd" seq:seq m3:m3 type:#alpha \
			anim:"ColorAndAlpha" trk:trk tp:tp
		
		M3F_DataApply dir this source_FP "YawFunctionOverlay" 		"yawType"
		M3F_DataApply dir this source_FP "PitchFunctionOverlay" 	"pitchType"
		M3F_DataApply dir this source_FP "SpeedFunctionOverlay" 	"speedType"
		M3F_DataApply dir this source_FP "AlphaFunctionOverlay" 	"alphaType"
		M3F_DataApply dir this source_FP "SizeFunctionOverlay" 		"sizeType"

		M3F_AnimApply dir this source_FP \
		"YawFunctionAmplitude" "rfaYawAmp" seq:seq m3:m3 \
		anim:"YawFunctionAmplitude" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"YawFunctionFrequency" "rfaYawFreq" seq:seq m3:m3 \
		anim:"YawFunctionFrequency" trk:trk tp:tp

		M3F_AnimApply dir this source_FP \
		"PitchFunctionAmplitude" "rfaPitchAmp" seq:seq m3:m3 \
		anim:"PitchFunctionAmplitude" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"PitchFunctionFrequency" "rfaPitchFreq" seq:seq m3:m3 \
		anim:"PitchFunctionFrequency" trk:trk tp:tp

		M3F_AnimApply dir this source_FP \
		"SpeedFunctionAmplitude" "rfaSpeedAmp" seq:seq m3:m3 \
		anim:"SpeedFunctionAmplitude" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"SpeedFunctionFrequency" "rfaSpeedFreq" seq:seq m3:m3 \
		anim:"SpeedFunctionFrequency" trk:trk tp:tp

		M3F_AnimApply dir this source_FP \
		"AlphaFunctionAmplitude" "rfaAlphaAmp" seq:seq m3:m3 \
		anim:"AlphaFunctionAmplitude" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"AlphaFunctionFrequency" "rfaAlphaFreq" seq:seq m3:m3 \
		anim:"AlphaFunctionFrequency" trk:trk tp:tp

		M3F_AnimApply dir this source_FP \
		"SizeFunctionAmplitude" "rfaSizeAmp" seq:seq m3:m3 \
		anim:"SizeFunctionAmplitude" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"SizeFunctionFrequency" "rfaSizeFreq" seq:seq m3:m3 \
		anim:"SizeFunctionFrequency" trk:trk tp:tp
		
		M3F_DataApply dir this source_FP "NoiseFrequency" 		"noiseFreq"
		M3F_DataApply dir this source_FP "NoiseAmplitude" 		"noiseAmp" \
			c:true f1:"* 100.0" f2:"/ 100.0"
		M3F_DataApply dir this source_FP "NoiseSpeed" 			"noiseSpeed"
		M3F_DataApply dir this source_FP "NoiseFallOff" 		"noiseEdge"

		M3F_DataApply dir this source_FP "MassMin" 				"pMass"
		M3F_DataApply dir this source_FP "MassMax" 				"pMassR"
		M3F_DataApply dir this source_FP "Gravity" 				"pGravity" \
			c:true f1:"* (-100.0)" f2:"/ (-100.0)"

		M3F_DataApply dir this source_FP "Drag" 				"pDrag"
		M3F_DataApply dir this source_FP "LODReduction" 		"pLODreduce"
		M3F_DataApply dir this source_FP "LODCut" 				"pLODcut"
		M3F_DataApply dir this source_FP "ParticleGroup" 		"pLocalChns"
		
		M3F_AnimApply dir this source_FP \
		"OverlayOffset" "rfaOverlay" seq:seq m3:m3 \
		anim:"OverlayOffset" trk:trk tp:tp
	)
)

struct M3SD_ScSubRib
(
	InitialVelocityYaw 				= M3SD_ScAnimData(),--() : float
	YawFunctionOverlay 				,--() : integer
	YawFunctionAmplitude 			= M3SD_ScAnimData(),--() : float
	YawFunctionFrequency 			= M3SD_ScAnimData(),--() : float
	InitialVelocityPitch 			= M3SD_ScAnimData(),--() : float
	PitchFunctionOverlay 			,--() : integer
	PitchFunctionAmplitude 			= M3SD_ScAnimData(),--() : float
	PitchFunctionFrequency 			= M3SD_ScAnimData(),--() : float
	InitialVelocitySpeedMin 		,--() : float
	SpeedFunctionOverlay 			,--() : integer
	SpeedFunctionAmplitude 			= M3SD_ScAnimData(),--() : float
	SpeedFunctionFrequency 			= M3SD_ScAnimData(),--() : float

	fn copyData source_FP seq: m3: dir:#fromfile =
	(
		M3F_DataApply dir this source_FP "YawFunctionOverlay" 		"yawType"
		M3F_DataApply dir this source_FP "PitchFunctionOverlay" 	"pitchType"
		M3F_DataApply dir this source_FP "SpeedFunctionOverlay" 	"speedType"
		M3F_DataApply dir this source_FP "InitialVelocitySpeedMin" 	"subRibSpeed" \
		c:true f1:"* 100.0" f2:"/ 100.0"

		M3F_AnimApply dir this source_FP \
			"InitialVelocityYaw" "rfaYaw" seq:seq m3:m3
		M3F_AnimApply dir this source_FP \
			"InitialVelocityPitch" "rfaPitch" seq:seq m3:m3

		M3F_AnimApply dir this source_FP \
		"YawFunctionAmplitude" "rfaYawAmp" seq:seq m3:m3
		M3F_AnimApply dir this source_FP \
		"YawFunctionFrequency" "rfaYawFreq" seq:seq m3:m3

		M3F_AnimApply dir this source_FP \
		"PitchFunctionAmplitude" "rfaPitchAmp" seq:seq m3:m3
		M3F_AnimApply dir this source_FP \
		"PitchFunctionFrequency" "rfaPitchFreq" seq:seq m3:m3

		M3F_AnimApply dir this source_FP \
		"SpeedFunctionAmplitude" "rfaSpeedAmp" seq:seq m3:m3
		M3F_AnimApply dir this source_FP \
		"SpeedFunctionFrequency" "rfaSpeedFreq" seq:seq m3:m3
	)
)

struct M3SD_ScProject
(
	projector_type 		,--() : integer
	orth_width 			= M3SD_ScAnimData(),--() : float
	orth_height 		= M3SD_ScAnimData(),--() : float
	orth_depth 			= M3SD_ScAnimData(),--() : float
	pers_fov 			= M3SD_ScAnimData(),--() : float
	pers_aspect_ratio 	= M3SD_ScAnimData(),--() : float
	pers_near 			= M3SD_ScAnimData(),--() : float
	pers_far 			= M3SD_ScAnimData(),--() : float
	AlphaStart 			,--() : integer
	AlphaMid 			,--() : integer
	AlphaEnd 			,--() : integer
	AttackMinTime 		,--() : float
	AttackMaxTime 		,--() : float
	HoldMinTime 		,--() : float
	HoldMaxTime 		,--() : float
	DecayMinTime 		,--() : float
	DecayMaxTime 		,--() : float
	AttenuationPercent 	,--() : float
	Alive 				= M3SD_ScAnimData(),--: boolean
	StaticPosition 		,--() : boolean
	SplatLayer 			,--() : integer
	SplatLODReduction 	,--() : integer
	SplatLODCut 		,--() : integer
	AttackUseRange 		,--() : boolean
	HoldUseRange 		,--() : boolean
	DecayUseRange 		,--() : boolean
	HoldInfinite 		,--() : boolean
	UseAttenuation 		,--() : boolean

	fn copyData source_FP seq: m3: dir:#fromfile =
	(
		case dir of
		(
			#fromfile:
			(
				this.AttackUseRange 		= true
				this.HoldUseRange 			= true
				this.DecayUseRange 			= true
				this.HoldInfinite 			= false
				if(source_FP.splatAtt > 1)then
				(
					this.UseAttenuation = true
					this.AttenuationPercent = (source_FP.splatAtt - 1) / source_FP.splatAtt
				)else
				(
					this.UseAttenuation = false
					this.AttenuationPercent = 0
				)
			)
			#tofile:
			(
				source_FP.splatAtt = 1 / (1 - this.AttenuationPercent)
			)
			default:
			(
				M3F_DataApply dir this source_FP "AttackUseRange" 			""
				M3F_DataApply dir this source_FP "HoldUseRange" 			""
				M3F_DataApply dir this source_FP "DecayUseRange" 			""
				M3F_DataApply dir this source_FP "HoldInfinite" 			""
				M3F_DataApply dir this source_FP "UseAttenuation" 			""
				M3F_DataApply dir this source_FP "AttenuationPercent" 		""
			)
		)
		
		M3F_DataApply dir this source_FP "projector_type" 			"projType"
		M3F_DataApply dir this source_FP "AlphaStart" 				"alphaPlay[1]" \
		c:true f1:"* 255" f2:"/ 255"
		M3F_DataApply dir this source_FP "AlphaMid" 				"alphaPlay[2]" \
		c:true f1:"* 255" f2:"/ 255"
		M3F_DataApply dir this source_FP "AlphaEnd" 				"alphaPlay[3]" \
		c:true f1:"* 255" f2:"/ 255"
		M3F_DataApply dir this source_FP "AttackMinTime" 			"attack[1]"
		M3F_DataApply dir this source_FP "AttackMaxTime" 			"attack[2]"
		M3F_DataApply dir this source_FP "HoldMinTime" 				"hold[1]"
		M3F_DataApply dir this source_FP "HoldMaxTime" 				"hold[2]"
		M3F_DataApply dir this source_FP "DecayMinTime" 			"decay[1]"
		M3F_DataApply dir this source_FP "DecayMaxTime" 			"decay[2]"
		
		M3F_DataApply dir this source_FP "StaticPosition" "staticPos" o:"=M3F_CvtType #bool "
		M3F_DataApply dir this source_FP "SplatLayer" 				"layer"
		M3F_DataApply dir this source_FP "SplatLODReduction" 		"LODreduce"
		M3F_DataApply dir this source_FP "SplatLODCut" 				"LODcut"
		
		M3F_AnimApply dir this source_FP \
		"orth_width" "rfaPlusX" seq:seq m3:m3 c:true mult:200.0 \
		anim:"orth_width" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"orth_height" "rfaPlusY" seq:seq m3:m3 c:true mult:200.0 \
		anim:"orth_height" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"orth_depth" "rfaPlusZ" seq:seq m3:m3 c:true mult:200.0 \
		anim:"orth_depth" trk:trk tp:tp
		
		M3F_AnimApply dir this source_FP \
		"pers_fov" "rfaFOV" seq:seq m3:m3 \
		anim:"pers_fov" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"pers_aspect_ratio" "rfaAsRatio" seq:seq m3:m3 \
		anim:"pers_aspect_ratio" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"pers_near" "rfaNear" seq:seq m3:m3 \
		anim:"pers_near" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"pers_far" "rfaFar" seq:seq m3:m3 \
		anim:"pers_far" trk:trk tp:tp
		
		M3F_AnimApply dir this source_FP \
		"Alive" "rfaAlive" seq:seq m3:m3 type:#bool \
		anim:"Alive" trk:trk tp:tp
	)
)

---------Physics Data
struct M3SD_ScForce
(
	Type 						,--() : integer
	Shape 						,--() : integer
	ForceFieldGroups 			,--() : integer

	ForceFieldFalloff 			,--() : boolean
	ForceFieldHeightGradient 	,--() : boolean
	ForceFieldUnbounded 		,--() : boolean

	ForceFieldStrength 			= M3SD_ScAnimData(),--() : float
	ForceFieldRadius 			= M3SD_ScAnimData(),--() : float
	ForceFieldHeight 			= M3SD_ScAnimData(),--() : float
	ForceFieldLength 			= M3SD_ScAnimData(),--() : float

	--Scope () : integer

	fn copyData source_FP seq: m3: dir:#fromfile =
	(
		case dir of
		(
			#fromfile:
			()
			#tofile:
			()
			default:
			()
		)
		
		M3F_DataApply dir this source_FP "Type" 					"fTypes"
		M3F_DataApply dir this source_FP "Shape" 					"fShapes"
		M3F_DataApply dir this source_FP "ForceFieldGroups" 		"fLocalChns"
		M3F_DataApply dir this source_FP "ForceFieldFalloff" 		"fFlags.bits[1]"
		M3F_DataApply dir this source_FP "ForceFieldHeightGradient" "fFlags.bits[2]"
		M3F_DataApply dir this source_FP "ForceFieldUnbounded" 		"fFlags.bits[3]"


		M3F_AnimApply dir this source_FP \
		"ForceFieldStrength" "rfaStrength" seq:seq m3:m3 c:true mult:100.0 \
		anim:"ForceFieldStrength" trk:trk tp:tp

		if(this.ForceFieldUnbounded == false)then
		(
			M3F_AnimApply dir this source_FP \
			"ForceFieldRadius" "rfaWidth" seq:seq m3:m3 c:true mult:100.0 \
			anim:"ForceFieldRadius" trk:trk tp:tp
			M3F_AnimApply dir this source_FP \
			"ForceFieldHeight" "rfaHeight" seq:seq m3:m3 c:true mult:200.0 \
			anim:"ForceFieldHeight" trk:trk tp:tp
			M3F_AnimApply dir this source_FP \
			"ForceFieldLength" "rfaLength" seq:seq m3:m3 c:true mult:200.0 \
			anim:"ForceFieldLength" trk:trk tp:tp
		)else
		(
			M3F_AnimApply dir this source_FP \
			"ForceFieldRadius" "rfaWidth" seq:seq m3:m3 c:true mult:0.01 \
			anim:"ForceFieldRadius" trk:trk tp:tp
			M3F_AnimApply dir this source_FP \
			"ForceFieldHeight" "rfaHeight" seq:seq m3:m3 c:true mult:0.02 \
			anim:"ForceFieldHeight" trk:trk tp:tp
			M3F_AnimApply dir this source_FP \
			"ForceFieldLength" "rfaLength" seq:seq m3:m3 c:true mult:0.0001 \
			anim:"ForceFieldLength" trk:trk tp:tp
		)
	)
)

struct M3SD_ScWarp
(
	Type 							,--() : integer
	VertexWarpRadius 				= M3SD_ScAnimData(),--() : float
	VertexWarpHeight 				= M3SD_ScAnimData(),--() : float
	VertexWarpStrength 				= M3SD_ScAnimData(),--() : float
	VertexWarpAngularCompression 	= M3SD_ScAnimData(),--() : float
	VertexWarpAxialCompression 		= M3SD_ScAnimData(),--() : float
	VertexWarpRadialCompression 	= M3SD_ScAnimData(),--() : float

	fn copyData source_FP seq: m3: dir:#fromfile =
	(
		case dir of
		(
			#fromfile:
			()
			#tofile:
			()
			default:
			()
		)
		
		M3F_DataApply dir this source_FP "Type" 		"wTypes"

		M3F_AnimApply dir this source_FP \
		"VertexWarpRadius" "rfaRadius" seq:seq m3:m3 c:true mult:100.0
		M3F_AnimApply dir this source_FP \
		"VertexWarpHeight" "rfaHeight" seq:seq m3:m3
		M3F_AnimApply dir this source_FP \
		"VertexWarpStrength" "rfaStrength" seq:seq m3:m3
		M3F_AnimApply dir this source_FP \
		"VertexWarpAngularCompression" "rfaAngular" seq:seq m3:m3
		M3F_AnimApply dir this source_FP \
		"VertexWarpAxialCompression" "rfaAxial" seq:seq m3:m3
		M3F_AnimApply dir this source_FP \
		"VertexWarpRadialCompression" "rfaRadial" seq:seq m3:m3
	)
)

struct M3SD_ScRigedBody
(
	shapeType 						,--: integer
	radius 							,--: float
	length 							,--: float
	width 							,--: float
	height 							,--: float
	friction 						,--: float
	restitution 					,--: float
	maxVerts 						,--: integer
	planarTolerance 				,--: float
	useCustomProps 					,--: boolean
	physicsMaterial 				,--: string
	density 						,--: float
	linearDamp 						,--: float
	angularDamp 					,--: float
	forceFieldGroup 				,--: integer
	hasPriority 					,--: integer
	Priority 						,--: integer
	simulateOnCollision 			,--: boolean
	filterCollidable 				,--: boolean
	filterStackable 				,--: boolean
	filterWalkable 					,--: boolean
	filterIgnoreLocalBodies 		,--: boolean
	simulationType 					,--: integer
	GravityScale 					,--: float
	inheritState 					,--: boolean
	dynamicState 					= M3SD_ScAnimData(),--: boolean
	dynamicBlendOut 				,--: float
	ignoreEvtState 					,--: boolean
	rigedBodyVerts 					= #(),
	rigedBodyFaces 					= #(),
	rigedBodyNorms					= #(),
	--customMesh 					,--: maxObject
	--ConvexHull 					,--: maxObject
	--mass 							,--: float
	--Dummy

	fn copyData source_FP seq: m3: dir:#fromfile =
	(
		case dir of
		(
			#fromfile:
			(
				this.planarTolerance = 0.0
				case source_FP.phyTypes of
				(
					0: this.physicsMaterial = "Metal Heavy"
					1: this.physicsMaterial = "Metal Light"
					2: this.physicsMaterial = "Metal Protoss"
					3: this.physicsMaterial = "Rock"
					4: this.physicsMaterial = "Flesh"
					5: this.physicsMaterial = "Bone"
					6: this.physicsMaterial = "LightArmor"
					7: this.physicsMaterial = "Sand"
					8: this.physicsMaterial = "Dirt"
					9: this.physicsMaterial = "Water"
					10: this.physicsMaterial = "Lava"
					11: this.physicsMaterial = "Creep"
					12: this.physicsMaterial = "Plastic"
					13: this.physicsMaterial = "Rubber"
					14: this.physicsMaterial = "Wood"
					15: this.physicsMaterial = "Snow"
					16: this.physicsMaterial = "Ice"
					17: this.physicsMaterial = "Paper"
					18: this.physicsMaterial = "Cloth Heavy"
					19: this.physicsMaterial = "Cloth Light"
					20: this.physicsMaterial = "Hair"
					21: this.physicsMaterial = "EnergyShield"
					default: this.physicsMaterial = "Metal Heavy"
				)
				if(source_FP.simTypes == 1)then
				(
					this.simulationType = 2
				)else
				(
					this.simulationType = 1
				)

				this.shapeType = source_FP.rfdRigedBody.data.shapeType + 1
				case this.shapeType of
				(
					1:
					(
						this.radius = 25.0
						this.length = source_FP.rfdRigedBody.data.size1 * 200
						this.width = source_FP.rfdRigedBody.data.size0 * 200
						this.height = source_FP.rfdRigedBody.data.size2 * 200
					)
					2:
					(
						this.radius = source_FP.rfdRigedBody.data.size0 * 100
						this.length = 50.0
						this.width = 50.0
						this.height = 50.0
					)
					3:
					(
						this.radius = source_FP.rfdRigedBody.data.size0 * 100
						this.length = 50.0
						this.width = 50.0
						this.height = (source_FP.rfdRigedBody.data.size1*100) + this.radius*2
					)
					4:
					(
						this.radius = source_FP.rfdRigedBody.data.size0 * 100
						this.length = 50.0
						this.width = 50.0
						this.height = source_FP.rfdRigedBody.data.size1 * 100
					)
					5:
					(
						this.radius = 25.0
						this.length = 50.0
						this.width = 50.0
						this.height = 50.0

					)
					default:()
				)
				this.maxVerts = source_FP.rfdRigedBody.data.vertNbr
			)
			#tofile:
			()
			default:
			(
				M3F_DataApply dir this source_FP "planarTolerance" 		""
				M3F_DataApply dir this source_FP "physicsMaterial" 		""
				M3F_DataApply dir this source_FP "simulationType" 		""
				M3F_DataApply dir this source_FP "shapeType" 			""
				M3F_DataApply dir this source_FP "radius" 				""
				M3F_DataApply dir this source_FP "length" 				""
				M3F_DataApply dir this source_FP "width" 				""
				M3F_DataApply dir this source_FP "height" 				""
				M3F_DataApply dir this source_FP "maxVerts" 			""
			)
		)

		M3F_DataApply dir this source_FP "filterCollidable" 		"pFlags.bits[1]"
		M3F_DataApply dir this source_FP "filterWalkable" 			"pFlags.bits[2]"
		M3F_DataApply dir this source_FP "filterStackable" 			"pFlags.bits[3]"
		M3F_DataApply dir this source_FP "simulateOnCollision" 		"pFlags.bits[4]"
		M3F_DataApply dir this source_FP "filterIgnoreLocalBodies" 	"pFlags.bits[5]"
		M3F_DataApply dir this source_FP "hasPriority" 				"pFlags.bits[6]" o:"=M3F_CvtType #bool "
		M3F_DataApply dir this source_FP "inheritState" 			"pFlags.bits[7]"
		M3F_DataApply dir this source_FP "ignoreEvtState" 			"pFlags.bits[9]"
		M3F_DataApply dir this source_FP "useCustomProps" 			"pFlags.bits[10]"
		
		M3F_DataApply dir this source_FP "density" 					"density"
		M3F_DataApply dir this source_FP "friction" 				"friction"
		M3F_DataApply dir this source_FP "restitution" 				"restitution"
		M3F_DataApply dir this source_FP "linearDamp" 				"linearDamp"
		M3F_DataApply dir this source_FP "angularDamp" 				"angularDamp"
		M3F_DataApply dir this source_FP "GravityScale" 			"gravityScale"

		M3F_DataApply dir this source_FP "dynamicBlendOut" 			"dynamicBlendOut"
		M3F_DataApply dir this source_FP "forceFieldGroup" 			"pLocalChns"
		M3F_DataApply dir this source_FP "Priority" 				"pPriority"

		M3F_AnimApply dir this source_FP \
		"dynamicState" "rfaDynamicState" seq:seq m3:m3 type:#bool
	)
)

--SCENE CONTROL STRUCT--------------------------------------------
struct M3S_ScTrackSet
(
	nameStr = "", animIDlist = #(), theIndex,
	animPropList = #(), priorityList = #(),
	AnimList = #(),

	fn init m: t: =
	(
		local this_item
		try(this_item = this)catch(this_item = M3S_ScTrackSet())
		try(this_item.buildSceneData m t)catch(throw())
		return this_item
	),

	fn releaseData behholder_FP scmat_FP scbone_FP sclight_FP sccam_FP scpar_FP scphy_FP scevent_FP =
	(
		local i
		local behavior_type = M3F_GetCustAttr #trackset
		custAttributes.add behholder_FP behavior_type #unique
		this.theIndex = custAttributes.count behholder_FP
		local behavior = custAttributes.get behholder_FP this.theIndex
		
		behavior.name = this.nameStr
		behavior.behaviorType = "TrackSet"
		behavior.behaviorState = true
		behavior.globalLoop = false
		behavior.animation = this.animPropList
		behavior.Priority = this.priorityList

		for i=1 to this.AnimList.count do
		(
			local index1 = (mod (this.AnimList[i].index/100) 100) as integer
			local index2 = (mod this.AnimList[i].index 100) as integer
			local index3 = (this.AnimList[i].index/10000) as integer
			local anim_str = copy this.AnimList[i].animStr
			
			case index1 of
			(
				1:
				(
					case index2 of
					(
						0:--Materials
						(
							local the_mat = scmat_FP[index3].theMat

							local find_idx = findItem behavior.matlist the_mat
							if(find_idx == 0)then
							(
								append behavior.matlist the_mat
								append behavior.matStates true
								find_idx = behavior.matlist.count
							)
							append behavior.ActiveMatSubanim_Pointers find_idx
							append behavior.ActiveMatSubanim_Subanims anim_str
						)
						default:
						(
							local the_map

							case scmat_FP[index3].matTypes of
							(
								1:
								(case index2 of(
									1: the_map = \
									scmat_FP[index3].theMat.Diffuse
									2: the_map = \
									scmat_FP[index3].theMat.Decal
									3: the_map = \
									scmat_FP[index3].theMat.Gloss
									4: the_map = \
									scmat_FP[index3].theMat.GlossExp
									5: the_map = \
									scmat_FP[index3].theMat.Emissive1
									6: the_map = \
									scmat_FP[index3].theMat.Emissive2
									7: the_map = \
									scmat_FP[index3].theMat.Environment
									8: the_map = \
									scmat_FP[index3].theMat.EnvironmentMask
									9: the_map = \
									scmat_FP[index3].theMat.AlphaMask
									10: the_map = \
									scmat_FP[index3].theMat.AlphaMask2
									11: the_map = \
									scmat_FP[index3].theMat.NormalMap
									12: the_map = \
									scmat_FP[index3].theMat.Heightmap
									13: the_map = \
									scmat_FP[index3].theMat.Lightmap
									14: the_map = \
									scmat_FP[index3].theMat.AmbientOcclusion
								)
								)
								2:
								(case index2 of(
									1: the_map = \
									scmat_FP[index3].theMat.Displacement
									2: the_map = \
									scmat_FP[index3].theMat.DisplacementStrengthTexture
								)
								)
							)
							local find_idx = findItem behavior.texmaplist the_map

							if(find_idx == 0)then
							(
								append behavior.texmaplist the_map
								append behavior.texmapStates true
								find_idx = behavior.texmaplist.count
							)
							append behavior.ActiveTexmapSubanim_Pointers find_idx
							append behavior.ActiveTexmapSubanim_Subanims anim_str
						)
					)
					continue
				)
				2:--Bones
				(
					local the_obj = scbone_FP[index3].theBone
				)
				3:--Lights
				(
					local the_obj = sclight_FP[index3].theLight
				)
				4:--Cameras
				(
					local the_obj = sccam_FP[index3].theCam
				)
				5:--Particles
				(
					local the_obj = scpar_FP[index3].thePar
				)
				6:--Physics
				(
					local the_obj = scphy_FP[index3].thePhy
				)
				7:--Events
				(
					local the_obj = scevent_FP[index3].theEvent
				)
			)
			local find_idx = findItem behavior.bonelist the_obj
			if(find_idx == 0)then
			(
				append behavior.bonelist the_obj
				append behavior.boneStates true
				find_idx = behavior.bonelist.count
			)
			append behavior.ActiveBoneSubanim_Pointers find_idx
			append behavior.ActiveBoneSubanim_Subanims anim_str
		)
	),

	fn buildSceneData m3obj_FP track_FP =
	(
		local i
		local m3_stc = m3obj_FP.fSTC
		local m3_sts = m3obj_FP.fSTS
		local sts_idx

		this.nameStr = copy track_FP

		for i=1 to m3_stc.count do
		(
			if((findString m3_stc[i].rfdName.data this.nameStr) != undefined)then
			(
				local anim_name = subString m3_stc[i].rfdName.data 1 \
				(m3_stc[i].rfdName.data.count - this.nameStr.count - 1)
				append animPropList anim_name
				append priorityList m3_stc[i].animPriority
				sts_idx = m3_stc[i].idxSTS + 1
			)
		)

		if(m3_sts[sts_idx].rfdAnimID.data != undefined)then
		(
			this.animIDlist = deepCopy m3_sts[sts_idx].rfdAnimID.data
		)else
		(
			this.animIDlist = #(0)
		)
	),

	fn swapBoneTrack nbr_FP tp_FP =
	(
		local i
		for i=1 to this.AnimList.count do
		(
			local tmp_tp = nbr_FP * 10000 + 200
			if(this.AnimList[i].index == tmp_tp)then
			(
				this.AnimList[i].index = tp_FP
			)
		)
	)
)

struct M3S_ScAnimProp
(
	nameStr = "", value = "", animStart, animEnd, maxFrames, rarity,
	moveSpeed, nonLoop, defaultAnim, subAnim, defaultPriority,
	tracksetsList = #(),

	fn init m: i: =
	(
		local this_item
		try(this_item = this)catch(this_item = M3S_ScAnimProp())
		try(this_item.buildSceneData m i)catch(throw())
		return this_item
	),

	fn releaseData =
	(
		local anim_track = getNoteTrack rootNode 1
		local startk = AddNewNoteKey anim_track this.animStart
		startk.Value = this.value
		local endk = AddNewNoteKey anim_track this.animEnd
		endk.Value = this.value
	),

	fn collectData =(),

	fn buildSceneData m3obj_FP idx_FP =
	(
		local i
		local m3_seqs = m3obj_FP.fSEQS
		local m3_sequence = m3obj_FP.fSEQS[idx_FP]
		local m3_animset = m3obj_FP.fSTC
		local m3_animstart_calc = 40
		local glb_frame_rate = M3F_GetGlobalSettings #FrameRate
		local glb_frame_bseq = M3F_GetGlobalSettings #FramesBetweenSeq

		for i=1 to (idx_FP-1) do
		(
			m3_animstart_calc += (m3_seqs[i].maxFrames * glb_frame_rate / 1000.0 + 0.5) as integer
			m3_animstart_calc += glb_frame_bseq
		)

		this.nameStr = copy m3_sequence.rfdName.data
		this.animStart = m3_animstart_calc
		this.maxFrames = (m3_sequence.maxFrames * glb_frame_rate / 1000.0 + 0.5) as integer
		this.animEnd = this.animStart + this.maxFrames
		this.rarity = m3_sequence.frequency
		this.moveSpeed = m3_sequence.moveSpeed
		this.nonLoop = m3_sequence.seqFlags.bitGet 1
		this.defaultAnim = m3_sequence.seqFlags.bitGet 2
		this.subAnim = m3_sequence.seqFlags.bitGet 3

		this.defaultPriority = 0
		local patternstr = this.nameStr+"_*"
		for i=1 to m3_animset.count do
		(
			if(m3_animset[i].rfdName.data == (this.nameStr+"_full"))then
			(
				this.defaultPriority = m3_animset[i].animPriority
			)else
			(
				if(matchPattern m3_animset[i].rfdName.data \
				pattern:patternstr ignoreCase:false)then
				(
					local ss = substring m3_animset[i].rfdName.data \
					(this.nameStr.count+2) -1
					append this.tracksetsList ss
				)
			)
		)

		this.value = this.nameStr + 										"\r\n"+\
				"rarity = " + (this.rarity as string) + 					"\r\n"+\
				"movespeed = " + (this.movespeed as string) + 				"\r\n"+\
				"nonLoop = " + (this.nonLoop as string) + 					"\r\n"+\
				"default_Anim = " + (this.defaultAnim as string) + 			"\r\n"+\
				"sub_anim = " + (this.subAnim as string) + 					"\r\n"+\
				"defaultPriority = " + (this.defaultPriority as string)
	)
)

struct M3S_ScMaterial
(
	nameStr = "", matTypes, storeData, mapsData = #(),
	theMat,

	fn init m: s: t: i: =
	(
		local this_item
		try(this_item = this)catch(this_item = M3S_ScMaterial())
		--try(this_item.buildSceneData m s t i)catch(throw())
		this_item.buildSceneData m s t i
		return this_item
	),

	fn releaseData idx_FP =
	(
		local i
		case this.matTypes of
		(
			1:
			(
				local the_mat = SC2_Standard_Material()

				the_mat.MatSubType = this.storeData.MatSubType
				this.storeData.copyData the_mat dir:#toscene
				for i=1 to this.mapsData.count do
				(
					local layer_map
					local map_type = this.mapsData[i].MapType
					if(map_type == 0)then(continue)
					
					case i of
					(
						1:(if(map_type == 2)then(the_mat.Diffuse = SC2_Color()); layer_map = the_mat.Diffuse)
						2:(if(map_type == 2)then(the_mat.Decal = SC2_Color()); layer_map = the_mat.Decal)
						3:(if(map_type == 2)then(the_mat.Gloss = SC2_Color()); layer_map = the_mat.Gloss)
						4:(if(map_type == 2)then(the_mat.GlossExp = SC2_Color()); layer_map = the_mat.GlossExp)
						5:(if(map_type == 2)then(the_mat.Emissive1 = SC2_Color()); layer_map = the_mat.Emissive1)
						6:(if(map_type == 2)then(the_mat.Emissive2 = SC2_Color()); layer_map = the_mat.Emissive2)
						7:(if(map_type == 2)then(the_mat.Environment = SC2_Color()); layer_map = the_mat.Environment)
						8:(if(map_type == 2)then(the_mat.EnvironmentMask = SC2_Color()); layer_map = the_mat.EnvironmentMask)
						9:(if(map_type == 2)then(the_mat.AlphaMask = SC2_Color()); layer_map = the_mat.AlphaMask)
						10:(if(map_type == 2)then(the_mat.AlphaMask2 = SC2_Color()); layer_map = the_mat.AlphaMask2)
						11:(if(map_type == 2)then(the_mat.NormalMap = SC2_Color()); layer_map = the_mat.NormalMap)
						12:(if(map_type == 2)then(the_mat.Heightmap = SC2_Color()); layer_map = the_mat.Heightmap)
						13:(if(map_type == 2)then(the_mat.Lightmap = SC2_Color()); layer_map = the_mat.Lightmap)
						14:(if(map_type == 2)then(the_mat.AmbientOcclusion = SC2_Color()); layer_map = the_mat.AmbientOcclusion)
						default:(continue)
					)

					this.mapsData[i].copyData layer_map dir:#toscene
					this.validateTexture layer_map
				)
				showTextureMap the_mat the_mat.Diffuse true
			)
			2:
			(
				local the_mat = SC2_Displacement_Material()
				this.storeData.copyData the_mat dir:#toscene

				if(this.mapsData[1].MapType == 2)then(the_mat.Displacement = SC2_Color())
				this.mapsData[1].copyData the_mat.Displacement dir:#toscene
				this.validateTexture the_mat.Displacement

				if(this.mapsData[2].MapType == 2)then(the_mat.DisplacementStrengthTexture = SC2_Color())
				this.mapsData[2].copyData the_mat.DisplacementStrengthTexture dir:#toscene
				this.validateTexture the_mat.DisplacementStrengthTexture

				showTextureMap the_mat the_mat.Displacement true
			)
			3:
			(
				local the_mat = SC2_Composite_Material()
				for i=1 to this.storeData.SubMaterials.count do
				(
					the_mat.Priority = this.storeData.Priority
					M3F_AnimApply #toscene this.storeData the_mat \
					("SubMatAlphas["+(i as string)+"]") ""
				)
			)
			4:
			(
				local the_mat = SC2_Terrain_Material()

				if(this.mapsData[1].MapType == 2)then(the_mat.TerrainMaterial = SC2_Color())
				this.mapsData[1].copyData the_mat.TerrainMaterial dir:#toscene
				this.validateTexture the_mat.TerrainMaterial

				showTextureMap the_mat the_mat.TerrainMaterial true
			)
			5:
			(
				local the_mat = SC2_Volume_Material()
				this.storeData.copyData the_mat dir:#toscene

				if(this.mapsData[1].MapType == 2)then(the_mat.ColorMap = SC2_Color())
				this.mapsData[1].copyData the_mat.ColorMap dir:#toscene
				this.validateTexture the_mat.ColorMap

				if(this.mapsData[2].MapType == 2)then(the_mat.Noisy1 = SC2_Color())
				this.mapsData[2].copyData the_mat.Noisy1 dir:#toscene
				this.validateTexture the_mat.Noisy1

				if(this.mapsData[3].MapType == 2)then(the_mat.Noisy2 = SC2_Color())
				this.mapsData[3].copyData the_mat.Noisy2 dir:#toscene
				this.validateTexture the_mat.Noisy2
				showTextureMap the_mat the_mat.ColorMap true
			)
			7:
			(
				local the_mat = SC2_Creep_Material()
				the_mat.CreepRequiredOnLowEnd = this.storeData

				if(this.mapsData[1].MapType == 2)then(the_mat.CreepMaterial = SC2_Color())
				this.mapsData[1].copyData the_mat.CreepMaterial dir:#toscene
				this.validateTexture the_mat.CreepMaterial
				showTextureMap the_mat the_mat.CreepMaterial true
			)
			8:
			(
				local the_mat = SC2_Volume_Noise_Material()
				this.storeData.copyData the_mat dir:#toscene

				if(this.mapsData[1].MapType == 2)then(the_mat.ColorMap = SC2_Color())
				this.mapsData[1].copyData the_mat.ColorMap dir:#toscene
				this.validateTexture the_mat.ColorMap

				if(this.mapsData[2].MapType == 2)then(the_mat.VolumeNoise1 = SC2_Color())
				this.mapsData[2].copyData the_mat.VolumeNoise1 dir:#toscene
				this.validateTexture the_mat.VolumeNoise1

				if(this.mapsData[3].MapType == 2)then(the_mat.VolumeNoise2 = SC2_Color())
				this.mapsData[3].copyData the_mat.VolumeNoise2 dir:#toscene
				this.validateTexture the_mat.VolumeNoise2
				showTextureMap the_mat the_mat.ColorMap true
			)
			9:
			(
				local the_mat = SC2_SplatTerrainBake_Material()
				
				if(this.mapsData[1].MapType == 2)then(the_mat.DiffuseTexture = SC2_Color())
				this.mapsData[1].copyData the_mat.DiffuseTexture dir:#toscene
				this.validateTexture the_mat.DiffuseTexture

				if(this.mapsData[2].MapType == 2)then(the_mat.NormalTexture = SC2_Color())
				this.mapsData[2].copyData the_mat.NormalTexture dir:#toscene
				this.validateTexture the_mat.NormalTexture

				if(this.mapsData[3].MapType == 2)then(the_mat.SpecularTexture = SC2_Color())
				this.mapsData[3].copyData the_mat.SpecularTexture dir:#toscene
				this.validateTexture the_mat.SpecularTexture
				showTextureMap the_mat the_mat.DiffuseTexture true
			)
			11:
			(
				local the_mat = SC2_Standard_Material()
				return true
			)
		)
		this.theMat = the_mat
		the_mat.name = this.nameStr
		if(idx_FP < 25)then(meditMaterials[idx_FP] = the_mat)
	),
	fn collectData =(),

	fn buildSceneData m3obj_FP scseq_FP track_FP idx_FP =
	(
		local i
		local index = m3obj_FP.fMATM[idx_FP].matIdx + 1
		local track_tp = idx_FP * 10000 + 100
		this.matTypes = m3obj_FP.fMATM[idx_FP].matTypes

		case this.matTypes of
		(
			1:--SC2_Standard_Material
			(
				local m3_mat = m3obj_FP.fMAT[index]
				this.nameStr = copy m3_mat.rfdName.data
				this.storeData = M3SD_ScNormMat()
				
				this.storeData.MatSubType = case of
				(
					(M3F_CheckMap m3_mat.rfdMapLayrs[6].data): 1
					(M3F_CheckMap m3_mat.rfdMapLayrs[9].data): 3
					(M3F_CheckMap m3_mat.rfdMapLayrs[10].data): 3
					(M3F_CheckMap m3_mat.rfdMapLayrs[7].data): 2
					(M3F_CheckMap m3_mat.rfdMapLayrs[8].data): 2
					default: 0
				)
				this.storeData.copyData m3_mat \
				seq:scseq_FP m3:m3obj_FP dir:#fromfile
				
				for i=1 to m3_mat.rfdMapLayrs.count do
				(
					this.buildMapData i m3_mat.rfdMapLayrs[i].data \
					trk:track_FP tp:track_tp seq:scseq_FP m3:m3obj_FP
				)
				if(this.mapsData[1].MapType != 0)then
				(
					M3F_AnimApply #fromfile \
					this.storeData m3_mat.rfdMapLayrs[1].data \
					"DecalAlpha" "rfaMapAlpha" anim:"DecalAlpha" \
					seq:scseq_FP m3:m3obj_FP trk:track_FP tp:track_tp
				)
				if(this.mapsData[5].MapType != 0)then
				(
					M3F_AnimApply #fromfile \
					this.storeData m3_mat.rfdMapLayrs[5].data \
					"EmissiveAlpha1" "rfaMapAlpha" anim:"EmissiveAlpha1" \
					seq:scseq_FP m3:m3obj_FP trk:track_FP tp:track_tp
				)
				if(this.mapsData[6].MapType != 0)then
				(
					M3F_AnimApply #fromfile \
					this.storeData m3_mat.rfdMapLayrs[6].data \
					"EmissiveAlpha2" "rfaMapAlpha" anim:"EmissiveAlpha2" \
					seq:scseq_FP m3:m3obj_FP trk:track_FP tp:track_tp
				)
				if(this.mapsData[7].MapType != 0)then
				(
					M3F_AnimApply #fromfile \
					this.storeData m3_mat.rfdMapLayrs[7].data \
					"EnvironmentAlpha" "rfaMapAlpha" anim:"EnvironmentAlpha" \
					seq:scseq_FP m3:m3obj_FP trk:track_FP tp:track_tp
				)
			)
			2:--SC2_Displacement_Material
			(
				local m3_mat = m3obj_FP.fDIS[index]
				this.nameStr = copy m3_mat.rfdName.data
				this.storeData = M3SD_ScDispMat()
				this.storeData.copyData m3_mat trk:track_FP tp:track_tp \
				seq:scseq_FP m3:m3obj_FP dir:#fromfile

				this.buildMapData 1 m3_mat.rfdNormMap.data \
				trk:track_FP tp:track_tp seq:scseq_FP m3:m3obj_FP
				this.buildMapData 2 m3_mat.rfdStrgMap.data \
				trk:track_FP tp:track_tp seq:scseq_FP m3:m3obj_FP
			)
			3:--SC2_Composite_Material
			(
				local m3_mat = m3obj_FP.fCMP[index]
				this.nameStr = copy m3_mat.rfdName.data
				this.storeData = M3SD_ScCompMat()
				this.storeData.Priority = m3_mat.cmpPriority

				for i=1 to m3_mat.rfdCMS.data.count do
				(
					append this.storeData.SubMaterials (m3_mat.rfdCMS.data[i].index+1)
					local sub_alpha = M3SD_ScAnimData()
					append this.storeData.SubMatAlphas sub_alpha

					M3F_AnimApply #fromfile this.storeData m3_mat.rfdCMS.data[i] \
					("SubMatAlphas["+(i as string)+"]") "rfaMapMult" \
					seq:scseq_FP m3:m3obj_FP trk:track_FP tp:track_tp \
					anim:("SubMatAlphas0"+(i as string))
				)
			)
			4:--SC2_Terrain_Material
			(
				local m3_mat = m3obj_FP.fTER[index]
				this.nameStr = copy m3_mat.rfdName.data
				this.buildMapData 1 m3_mat.rfdTerrainMap.data \
				trk:track_FP tp:track_tp seq:scseq_FP m3:m3obj_FP
			)
			5:--SC2_Volume_Material
			(
				local m3_mat = m3obj_FP.fVOL[index]
				this.nameStr = copy m3_mat.rfdName.data
				this.storeData = M3SD_ScVolumeMat()
				this.storeData.copyData m3_mat seq:scseq_FP m3:m3obj_FP dir:#fromfile

				this.buildMapData 1 m3_mat.rfdColorMap.data \
				trk:track_FP tp:track_tp seq:scseq_FP m3:m3obj_FP
				this.buildMapData 2 m3_mat.rfdNoisyMap1.data \
				trk:track_FP tp:track_tp seq:scseq_FP m3:m3obj_FP
				this.buildMapData 3 m3_mat.rfdNoisyMap2.data \
				trk:track_FP tp:track_tp seq:scseq_FP m3:m3obj_FP
			)
			7:--SC2_Creep_Material
			(
				local m3_mat = m3obj_FP.fCREP[index]
				this.nameStr = copy m3_mat.rfdName.data
				this.storeData = M3F_CvtType #bool m3_mat.CreepLow
				this.buildMapData 1 m3_mat.rfdMaskMap.data \
				trk:track_FP tp:track_tp seq:scseq_FP m3:m3obj_FP
			)
			8:--SC2_Volume_Noise_Material
			(
				local m3_mat = m3obj_FP.fVON[index]
				this.nameStr = copy m3_mat.rfdName.data
				this.storeData = M3SD_ScVolNoiseMat()
				this.storeData.copyData m3_mat seq:scseq_FP m3:m3obj_FP dir:#fromfile

				this.buildMapData 1 m3_mat.rfdColorMap.data \
				trk:track_FP tp:track_tp seq:scseq_FP m3:m3obj_FP
				this.buildMapData 2 m3_mat.rfdNoiseMap1.data \
				trk:track_FP tp:track_tp seq:scseq_FP m3:m3obj_FP
				this.buildMapData 3 m3_mat.rfdNoiseMap2.data \
				trk:track_FP tp:track_tp seq:scseq_FP m3:m3obj_FP
			)
			9:--SC2_SplatTerrainBake_Material
			(
				local m3_mat = m3obj_FP.fSTBM[index]
				this.nameStr = copy m3_mat.rfdName.data
				this.buildMapData 1 m3_mat.rfdDiffMap.data \
				trk:track_FP tp:track_tp seq:scseq_FP m3:m3obj_FP
				this.buildMapData 2 m3_mat.rfdNormMap.data \
				trk:track_FP tp:track_tp seq:scseq_FP m3:m3obj_FP
				this.buildMapData 3 m3_mat.rfdSpecMap.data \
				trk:track_FP tp:track_tp seq:scseq_FP m3:m3obj_FP
			)
			11:--SC2_Flare_Material
			(

			)
			default: (print "BAD MatType")
		)
	),
	fn releaseCompSubMat idx_FP =
	(
		local i
		if(this.matTypes == 3)then
		(
			for i=1 to this.storeData.SubMaterials.count do
			(this.theMat.SubMaterials[i] = meditMaterials[this.storeData.SubMaterials[i]])
		)
	),
	fn buildMapData idx_FP src_FP seq: m3: trk: tp: =
	(
		local track_tp = tp + idx_FP
		this.mapsData[idx_FP] = M3SD_ScMapLayer()
		try
		(
			this.mapsData[idx_FP].MapType = case of
			(
				(src_FP.flags.bitGet 7): 1
				(src_FP.flags.bitGet 8): 1
				(src_FP.flags.bitGet 11): 2
				default: 0
			)
		)catch
		(
			this.mapsData[idx_FP].MapType = 0
		)

		if(this.mapsData[idx_FP].MapType != 0)then
		(
			this.mapsData[idx_FP].copyData src_FP trk:trk tp:track_tp \
			seq:seq m3:m3 dir:#fromfile
		)
	),

	fn validateTexture map_FP =
	(
		if((classOf map_FP) == SC2_Bitmap)then
		(
			if(map_FP.FileName != "" and map_FP.FileName != undefined)then
			(
				print map_FP.FileName
				local map_name = filenameFromPath map_FP.FileName
				local path_found = (mapPaths.getFullFilePath map_name)
				if(path_found != "")then
				(
					map_FP.FileName = path_found
				)else
				(
					M3F_MissingMap map_name
				)
			)
		)
	)
)

struct M3S_ScBone
(
	nameStr = "", parentBone, bindingPose,
	Position = M3SD_ScAnimData(),
	Rotation = M3SD_ScAnimData(),
	Scale = M3SD_ScAnimData(),
	Visibility = M3SD_ScAnimData(),
	theBone, theObj, boneType = 0,

	fn init m: s: t: i: =
	(
		local this_item
		try(this_item = this)catch(this_item = M3S_ScBone())
		try(this_item.buildSceneData m s t i)catch(throw())
		return this_item
	),

	fn releaseData bone_FP p:[0,0,0] =
	(
		if(this.theBone == undefined)then
		(
			local glb_lens = M3F_GetGlobalSettings #BoneLens
			local glb_size = M3F_GetGlobalSettings #BoneSize
			local startp = this.bindingPose.translation
			if(p == [0,0,0])then(p = startp + [0,glb_lens,0])

			if(this.boneType == 0)then
			(
				this.theBone = BoneSys.CreateBone startp p [0,0,1]
				if(M3F_GetGlobalSettings #BoneEntity)then
				(
					this.theBone.Width = glb_size
					this.theBone.Height = glb_size
				)else
				(
					this.theBone.Width = 0.05
					this.theBone.Height = 0.05
				)
				if(M3F_GetGlobalSettings #BoneLink)then
				(
					this.theBone.ShowLinks = true
				)
				this.theBone.boneScaleType = #none
			)else
			(
				this.theBone = dummy()
				case this.boneType of
				(
					2: this.theBone.boxsize = [10,10,10]
					4: this.theBone.boxsize = [7.5,7.5,7.5]
				)
			)
			this.theBone.name = this.nameStr

			if(this.parentBone > 0 and this.parentBone < 0xFFFF)then
			(
				if(bone_FP[this.parentBone].theBone == undefined)then
				(
					bone_FP[this.parentBone].releaseData bone_FP p:startp
				)else
				(
					if(M3F_GetGlobalSettings #BoneEntity)then
					(
						if(bone_FP[this.parentBone].boneType == 0 and this.boneType == 0)then
						(
							local lens = length (bone_FP[this.parentBone].bindingPose.translation - startp)
							local curlens = bone_FP[this.parentBone].theBone.length

							if(curlens < lens and lens > 5.0)then
							(
								--format "this:% parent:%\n" this.nameStr bone_FP[this.parentBone].nameStr
								bone_FP[this.parentBone].theBone.length = lens
							)
						)					
					)
				)
				if(bone_FP[this.parentBone].boneType == 1)then
				(bone_FP[this.parentBone].boneType = 3)
				this.theBone.Parent = bone_FP[this.parentBone].theBone
			)
			if(this.boneType != 2)then
			(
				with animate on
				(
					at time 0
					(
						this.theBone.Transform = this.bindingPose
					)
					in coordsys parent
					(
						at time 10
						(
							this.theBone.Rotation = this.Rotation.dkeys[1]
							this.theBone.Position = this.Position.dkeys[1]
							this.theBone.Scale = this.Scale.dkeys[1]
							--this.theBone.SetSkinPose()
						)
					)
				)
			)else
			(
				this.theBone.Transform = this.bindingPose
			)
			M3F_AnimApply #toscene this this.theBone \
			"Visibility" ""

			M3F_AddToLayer "Bones" this.theBone
		)
	),
	fn animApply =
	(
		local i
		BezierDefaultParams.inTangentType = #flat
		BezierDefaultParams.outTangentType = #flat
		--this.theBone.AssumeSkinPose()

		with animate on
		(
			if(this.Rotation.frames[1] != -1)then
			(
				for i=2 to this.Rotation.frames.count do
				(
					at time this.Rotation.frames[i]
					(
						local mtrx = matrix3 1
						rotate mtrx (inverse this.Rotation.dkeys[i])
						if(this.theBone.parent != undefined)then
						(
							mtrx = mtrx * this.theBone.parent.transform
						)

						this.theBone.transform = mtrx
						deleteKey this.theBone.position.controller \
						(numKeys this.theBone.position.controller)
						deleteKey this.theBone.scale.controller \
						(numKeys this.theBone.scale.controller)
					)
				)
			)
			if(this.Position.frames[1] != -1)then
			(
				for i=2 to this.Position.frames.count do
				(
					at time this.Position.frames[i]
					(
						in coordsys parent
						(
							this.theBone.pos = this.Position.dkeys[i]
						)
					)
				)
			)
			if(this.Scale.frames[1] != -1)then
			(
				for i=2 to this.Scale.frames.count do
				(
					at time this.Scale.frames[i]
					(
						in coordsys parent
						(
							this.theBone.Scale = this.Scale.dkeys[i]
						)
					)
				)
			)
		)
	),

	fn collectData =(),

	fn buildSceneData m3obj_FP scseq_FP track_FP idx_FP =
	(
		local i
		local m3_bone = m3obj_FP.fBONE[idx_FP]
		local m3_iref = m3obj_FP.fIREF[idx_FP]
		local track_tp = idx_FP * 10000 + 200

		this.nameStr = copy m3_bone.rfdName.data

		if(matchPattern this.nameStr pattern:"Dummy*" ignoreCase:true)then
		(
			this.boneType = 4
		)

		if(m3_bone.parent >= 0xFFFF)then(this.parentBone = 0)
		else(this.parentBone = m3_bone.parent + 1)

		this.bindingPose = inverse (matrix3 m3_iref.matrix[1] \
											m3_iref.matrix[2] \
											m3_iref.matrix[3] \
											(m3_iref.matrix[4] * 100))

		M3F_AnimApply #fromfile this m3_bone \
		"Position" "rfaPos" seq:scseq_FP m3:m3obj_FP c:true mult:100.0 \
		anim:"position" trk:track_FP tp:track_tp
		M3F_AnimApply #fromfile this m3_bone \
		"Rotation" "rfaRot" seq:scseq_FP m3:m3obj_FP c:true mult:1.0 \
		anim:"rotation" trk:track_FP tp:track_tp
		M3F_AnimApply #fromfile this m3_bone \
		"Scale" "rfaScale" seq:scseq_FP m3:m3obj_FP c:true mult:1.0 \
		anim:"scale" trk:track_FP tp:track_tp
		M3F_AnimApply #fromfile this m3_bone \
		"Visibility" "rfaVisibility" seq:scseq_FP m3:m3obj_FP type:#bool \
		anim:"visibility" trk:track_FP tp:track_tp
	),

	fn buildBonesType list_FP type_FP idx_FP =
	(
		local index = findItem list_FP idx_FP
		if(index != 0)then
		(
			this.boneType = type_FP[index]
		)
	),

	fn deleteBones =
	(
		local obj
		if((M3F_GetGlobalSettings #BoneEnable) != true)then
		(
			delete this.theBone
			return undefined
		)
		case this.boneType of
		(
			1: delete this.theBone
			3:
			(
				for obj in this.theBone.Children do
				(
					obj.Parent = this.theObj
				)
				delete this.theBone				
			)
			default:()
		)
	)
)

struct M3S_ScEvent
(
	nameStr = "", nbrBone, bindingPose,
	useHierarchy, attachToModel, sourceName = "",
	Event = M3SD_ScAnimData(), theEvent,

	fn init m: s: t: ib: i: =
	(
		local this_item
		try(this_item = this)catch(this_item = M3S_ScEvent())
		try(this_item.buildSceneData m s t ib i)catch(throw())
		return this_item
	),

	fn releaseData scbone_FP =
	(
		local the_event = SC2Event()
		local self_bone = scbone_FP[this.nbrBone]
		self_bone.theObj = the_event
		the_event.name = this.nameStr
		the_event.transform = this.bindingPose

		if(self_bone.parentBone > 0 and self_bone.parentBone < 0xFFFF)then
		(the_event.parent = scbone_FP[self_bone.parentBone].theBone)

		M3F_CopyController the_event self_bone.theBone

		the_event.useHierarchy = this.useHierarchy
		the_event.attachToModel = this.attachToModel
		the_event.sourceName = this.sourceName
		M3F_AnimApply #toscene this the_event "Event" ""

		this.theEvent = the_event
		M3F_AddToLayer "Event" the_event
	),
	fn collectData =(),

	fn buildSceneData m3obj_FP scseq_FP track_FP idxbone_FP idx_FP =
	(
		local i, k, n
		local m3_bone = m3obj_FP.fBONE
		this.nbrBone = idxbone_FP
		local m3_object = m3obj_FP.fBONE[this.nbrBone]
		local m3_iref = m3obj_FP.fIREF[this.nbrBone]
		local track_tp = idx_FP * 10000 + 700
		local anim_enable = M3F_GetGlobalSettings #AnimEnable

		for i=1 to track_FP.count do
		(track_FP[i].swapBoneTrack this.nbrBone track_tp)

		this.nameStr = copy m3_object.rfdName.data
		this.bindingPose = inverse (matrix3 m3_iref.matrix[1] \
											m3_iref.matrix[2] \
											m3_iref.matrix[3] \
											(m3_iref.matrix[4] * 100))

		this.useHierarchy = false
		this.attachToModel = false
		this.sourceName = "None"

		this.Event.interpolationType = 1
		if(anim_enable == true)then
		(
			local m3_stc = m3obj_FP.fSTC
			local m3_stg = m3obj_FP.fSTG
			local track_name = #()

			for i=1 to scseq_FP.count do
			(
				local anim_prop = scseq_FP[i]
				local anim_name = anim_prop.nameStr
				for k in m3_stg[i].rfdSTCidx.data do
				(
					local stc_idx = k + 1
					if(m3_stc[stc_idx].rfdAnimDatas[1].data.count == 0)then(continue)

					local keys_origin = m3_stc[stc_idx].rfdAnimDatas[1].data[1].rfdKeys.data
					local frames_origin = m3_stc[stc_idx].rfdAnimDatas[1].data[1].rfdFrames.data
					local keys = #()
					local frames = #()
					
					for n=1 to frames_origin.count do
					(
						if(this.nbrBone == (keys_origin[n].nbrBone+1))then
						(
							append frames frames_origin[n]
							append keys 0.0
							local stc_name = subString m3_stc[stc_idx].rfdName.data (anim_name.count+2) -1
							appendIfUnique track_name stc_name
							if(keys_origin[n].rfdOptionStr.data != undefined and this.sourceName == "None")then
							(
								this.sourceName = copy keys_origin[n].rfdOptionStr.data
							)
						)
					)

					if(frames.count > 0)then
					(
						M3F_FrameCorrect this.Event frames keys anim_prop.animStart anim_prop.animEnd 0.0 lock:false
					)
				)
			)

			for i=1 to track_FP.count do
			(
				for n in track_name where n == track_FP[i].nameStr do
				(
					local track_data = M3SD_ScTrackData()
					track_data.index = track_tp
					track_data.animStr = "Event"

					appendIfUnique track_FP[i].AnimList track_data
				)
			)
		)

		if(this.Event.dkeys.count == 0)then
		(
			this.Event.frames[1] = -1
			this.Event.dkeys[1] = 0.0
		)
	)
)

struct M3S_ScMesh
(
	nameStr = "", rootBone,
	vertPos = #(), vertNormal = #(), vertColor = #(), vertWeightPair = #(),
	faces = #(),  uvLayout = #(#(),#(),#(),#(),#(),#()), matIdx, skinBones = #(),
	theMesh,

	fn init m: i: =
	(
		local this_item
		try(this_item = this)catch(this_item = M3S_ScMesh())
		try(this_item.buildSceneData m i)catch(throw())
		return this_item
	),

	fn releaseData scbone_FP scmat_FP =
	(
		local i, n, j, k
		local the_mesh = mesh 	vertices:this.vertPos	\
								faces:this.faces 		\
								vnorms:this.vertNormal	\
								name:this.nameStr

		for n=1 to 6 do
		(
			if this.uvLayout[n].count == 0 then continue

			meshop.setNumMaps the_mesh (n+1) keep:true
			meshop.setMapSupport the_mesh n true
			meshop.setNumMapVerts the_mesh n this.uvLayout[n].count keep:false
			for i=1 to this.uvLayout[n].count do
			(
				meshop.setMapVert the_mesh n i this.uvLayout[n][i]
			)
			for i=1 to this.faces.count do
			(
				meshop.setMapFace the_mesh n i this.faces[i]
			)
		)
		for i=1 to this.vertColor.count do
		(
			meshop.setVertColor the_mesh 0 #(i) this.vertColor[i]
			meshop.setVertAlpha the_mesh -2 #(i) this.vertColor[i][4]
		)
		
		if(M3F_GetGlobalSettings #MeshSmoothEnable)then
		(
			local type = M3F_GetGlobalSettings #MeshSmoothType
			case type of
			(
				1:
				(
					local old_facelist = #{}
 					for i=1 to the_mesh.numfaces do(append old_facelist i)
 					meshop.autoSmooth the_mesh old_facelist (M3F_GetGlobalSettings #MeshSmoothAngle)
				)
				2:
				(
					local facelist = #()
					local new_facelist = #()
					for i=1 to the_mesh.numfaces do(append facelist i)
					local cnt = 0
					n = 0

					while facelist.count > 0 do
					(
						append new_facelist #(facelist[1])
						deleteItem facelist 1
						n += 1
						cnt = 0

						while cnt < new_facelist[n].count do
						(
							cnt += 1
							local the_verts = meshop.getMapVertsUsingMapFace the_mesh 1 #(new_facelist[n][cnt])
							local the_faces = meshop.getMapFacesUsingMapVert the_mesh 1 the_verts
							
							for i in the_faces where findItem new_facelist[n] i == 0 do
							(
								append new_facelist[n] i
								deleteItem facelist (findItem facelist i)
							)
						)
					)

					for n=1 to the_mesh.numfaces do
					(
						setFaceSmoothGroup the_mesh n 0
					)

					local sgroup_val = M3SD_Flag()
					for i=1 to new_facelist.count do
					(
						local k = ((mod (i-1) 32) as integer) + 1
						
						for n=1 to new_facelist[i].count do
						(
							sgroup_val.valSet 0
							sgroup_val.valSet (getFaceSmoothGroup the_mesh new_facelist[i][n])
							sgroup_val.bitSet k
							setFaceSmoothGroup the_mesh new_facelist[i][n] (sgroup_val.valGet())
						)
					)
				)
				3:
				(
					local the_mesh_copy = copy the_mesh
					local vertlist = #{}
					for i=1 to the_mesh_copy.numverts do(append vertlist i)
					meshop.weldVertsByThreshold the_mesh_copy vertlist 0.001
			
					local new_facelist = #()
					local new_pointlist = #()
					local new_pointlist_order = #()
					local facelist = #()
					for i=1 to the_mesh_copy.numfaces do(append facelist i)

					while facelist.count > 0 do
					(
						this.searchSmoothGroup the_mesh_copy facelist new_facelist \
							p:new_pointlist po:new_pointlist_order
					)
					delete the_mesh_copy

					for n=1 to the_mesh.numfaces do
					(
						setFaceSmoothGroup the_mesh n 0
					)

					local sgroup_val = M3SD_Flag()
					for i=1 to new_facelist.count do
					(
						local k = ((mod (i-1) 32) as integer) + 1
						
						for n=1 to new_facelist[i].count do
						(
							sgroup_val.valSet 0
							sgroup_val.valSet (getFaceSmoothGroup the_mesh new_facelist[i][n])
							sgroup_val.bitSet k
							setFaceSmoothGroup the_mesh new_facelist[i][n] (sgroup_val.valGet())
						)
					)
				)
			)
		)

		if(M3F_GetGlobalSettings #MeshWeldEnable)then
		(
			if((M3F_GetGlobalSettings #MeshWeldType) == 1)then
			(
				local point_origin_list = for i=1 to this.vertPos.count collect i
				while new_pointlist.count > 0 do
				(
					local point_array = #()
					local weld_group = new_pointlist_order[1]

					while weld_group == new_pointlist_order[1] do
					(
						append point_array new_pointlist[1]
						deleteItem new_pointlist 1
						deleteItem new_pointlist_order 1
					)

					if(point_array.count > 1)then
					(
						sort point_array
						local point_weld_list = #{}
						for i=1 to point_array.count do
						(
							local find = findItem point_origin_list point_array[i]
							append point_weld_list find
						)
						meshop.weldVertSet the_mesh point_weld_list

						for i=2 to point_array.count do
						(
							local find = findItem point_origin_list point_array[i]
							if(find != 0)then
							(
								deleteItem point_origin_list find
								deleteItem this.vertWeightPair find
							)else
							(
								format "Weld Point Not Found! idx:%\n" point_array[i]
							)
						)
					)
				)
			)
		)

		if(M3F_GetGlobalSettings #SkinEnable)then
		(
			with redraw on
			(
				max views redraw

				local sk_mod = Skin()
				sk_mod.bone_Limit = 4
				addModifier the_mesh sk_mod
				modPanel.setCurrentObject sk_mod

				for n=1 to this.skinBones.count do
				(
					skinOps.addBone sk_mod scbone_FP[this.skinBones[n]].theBone 0
				)

				update the_mesh
				max views redraw
				for i=1 to this.vertWeightPair.count do
				(
					skinOps.ReplaceVertexWeights sk_mod i \
					this.vertWeightPair[i].index this.vertWeightPair[i].weight
				)
			)
			modPanel.setCurrentObject the_mesh
		)

		if(M3F_GetGlobalSettings #MeshWeldEnable)then
		(
			if((M3F_GetGlobalSettings #MeshWeldType) == 2)then
			(
				local vertlist = #{}
				for i=1 to the_mesh.numverts do(append vertlist i)
				meshop.weldVertsByThreshold the_mesh vertlist 0.001
			)
		)
 		
		the_mesh.WireColor = color (random 0 128) (random 0 255) (random 0 128)
		
		if(M3F_GetGlobalSettings #MatEnable)then
		(
			the_mesh.Material = scmat_FP[this.matIdx].theMat
		)

		M3F_CopyController the_mesh scbone_FP[this.rootBone].theBone type:#visibility

		this.theMesh = the_mesh
		update the_mesh

		M3F_AddToLayer "Unit" the_mesh
	),

	fn collectData =(),

	fn buildSceneData m3obj_FP idx_FP =
	(
		--buildMeshData
		local i, j, n
		local m3_region = m3obj_FP.fDIV.rfdREGN.data[idx_FP] 
		local m3_bone = m3obj_FP.fBONE
		local m3_vert = m3obj_FP.fVERT.vertexs
		local m3_face = m3obj_FP.fDIV.rfdFace.data
		local m3_skinbone = m3obj_FP.fDIV.rfdBonelu.data
		local m3_bat = m3obj_FP.fDIV.rfdBAT.data
		local uvw_mult = m3_region.uvwMult / 16.0
		local uvw_offset = m3_region.uvwOffset

		for i=1 to m3_bat.count do
		(
			if((m3_bat[i].meshID+1) == idx_FP)then(this.matIdx = m3_bat[i].matID + 1)
		)
		
		this.rootBone = m3_region.rootBone + 1
		while m3_bone[this.rootBone].parent < 0xFFFF do
		(
			this.rootBone = m3_bone[this.rootBone].parent + 1
		)

		this.nameStr = "Mesh " + (idx_FP as string)
		for i=1 to m3_region.nbrVert do
		(
			local index = m3_region.firstVert + i

			append this.vertPos (m3_vert[index].pos * 100)
			append this.vertNormal (m3_vert[index].normal / 127.5)

			for n=1 to m3_vert[index].uv.count do
			(
				local u = (m3_vert[index].uv[n][1] * uvw_mult / 2048.0) + uvw_offset
				local v = 1 - ((m3_vert[index].uv[n][2] * uvw_mult / 2048.0) + uvw_offset)
				append this.uvLayout[n] [u, v, 0.0]
			)

			append this.vertColor (m3_vert[index].vColor / 255.0)
			
			local wbpair = M3SD_ScSkinData()
			for j=1 to 4 do
			(
				if(m3_vert[index].weight[j] > 0)then
				(
					append wbpair.index ((m3_vert[index].boneIdx[j] + 1)as integer)
					append wbpair.weight (m3_vert[index].weight[j] / 255.0)
				)
			)
			append this.vertWeightPair wbpair
		)

		for j=1 to m3_region.nbrFace by 3 do
		(
			local index = m3_region.firstFace + j
			append this.faces  \
			[m3_face[index] + 1, m3_face[index+1] + 1, m3_face[index+2] + 1]
		)

		for i=1 to m3_region.nbrBonelu do
		(
			local index = m3_region.firstBonelu + i
			append this.skinBones (m3_skinbone[index]+1)
		)
	),

	fn searchSmoothGroup mesh_FP src_FP store_FP old:#() c: o: p: po: =
	(
		local cnt = 0
		local n = 0
		local i, j, k
		local except_facelist = #()
		local wait_check_facelist = #()
		local wait_check_list_other = #()
		local check_facelist = #()
		local check_list_other = #()
		if(c != unsupplied)then
		(
			if((findItem old c) == 0)then
			(
				append store_FP #()
				n = store_FP.count
				for i in o do
				(
					cnt += 1
					append store_FP[n] i
					appendIfUnique old i
				)
				append store_FP[n] c
				appendIfUnique old c
				try(deleteItem src_FP (findItem src_FP c))catch()
			)else
			(
				for n=1 to store_FP.count do
				(
					if((findItem store_FP[n] c) != 0)then
					(
						for i in o do
						(
							appendIfUnique store_FP[n] i
						)
					)
				)
				return true
			)
		)else
		(
			append store_FP #(src_FP[1])
			n = store_FP.count
			appendIfUnique old src_FP[1]
			deleteItem src_FP 1
		)

		while cnt < store_FP[n].count do
		(
			cnt += 1
			local append_facelist = #()
			local face_list = #{}; append face_list store_FP[n][cnt]
			local the_verts = meshop.getVertsUsingFace mesh_FP face_list
			local the_faces = meshop.getFacesUsingVert mesh_FP the_verts
			
			for i in the_faces where((findItem old i) == 0)do
			(		
				local is_same_group = (this.sameGroupCheck store_FP[n][cnt] i \
					p:p po:po)

				if(is_same_group[1] == true)then
				(
					if((findItem except_facelist i) == 0)then
					(
						append append_facelist i
					)else
					(
						local new_index = findItem check_facelist i
						if(new_index == 0)then
						(
							append check_facelist i
							new_index = check_facelist.count
							check_list_other[new_index] = #()
						)
						appendIfUnique check_list_other[new_index] store_FP[n][cnt]
					)
				)
				if(is_same_group[1] == false)then
				(
					appendIfUnique except_facelist i
					local find = findItem wait_check_facelist i
					if(find != 0)then
					(
						deleteItem wait_check_facelist find
						local new_index = findItem check_facelist i
						if(new_index == 0)then
						(
							append check_facelist i
							new_index = check_facelist.count
							check_list_other[new_index] = #()
						)
						for k=1 to wait_check_list_other[find].count do
						(
							appendIfUnique check_list_other[new_index] wait_check_list_other[find][k]
						)
						deleteItem wait_check_list_other find
					)
				)
			)
			while append_facelist.count > 0 do
			(
				local score = #()
				local sum = #()
				for i=1 to append_facelist.count do(score[i] = #(); sum[i] = 0)
				for j=1 to append_facelist.count do
				(
					local is_same_group
					for k=j+1 to append_facelist.count do
					(
						is_same_group = (this.sameGroupCheck append_facelist[j] append_facelist[k] \
							p:p po:po)
						append score[j] is_same_group[2]
						sum[j] += is_same_group[2]
						append score[k] is_same_group[2]
						sum[k] += is_same_group[2]
					)
				)
				local min = 100
				local min_item = 1
				for i=1 to append_facelist.count do
				(
					if(sum[i] == min)then
					(
						min_item = i
					)
					if(sum[i] < min)then
					(
						min = sum[i]
						min_item = i
					)
				)

				if((findItem score[min_item] -1) != 0 or (findItem score[min_item] -2) != 0)then
				(
					appendIfUnique except_facelist append_facelist[min_item]

					local find = findItem wait_check_facelist append_facelist[min_item]
					if(find != 0)then
					(
						deleteItem wait_check_facelist find
						deleteItem wait_check_list_other find
					)

					local new_index = findItem check_facelist append_facelist[min_item]
					if(new_index == 0)then
					(
						append check_facelist append_facelist[min_item]
						new_index = check_facelist.count
						check_list_other[new_index] = #()
					)
					appendIfUnique check_list_other[new_index] store_FP[n][cnt]
				)else
				(
					local new_index = findItem wait_check_facelist append_facelist[min_item]
					if(new_index == 0)then
					(
						append wait_check_facelist append_facelist[min_item]
						new_index = wait_check_facelist.count
						wait_check_list_other[new_index] = #()
					)
					appendIfUnique wait_check_list_other[new_index] store_FP[n][cnt]
				)
				deleteItem append_facelist min_item
			)
			if(wait_check_facelist.count > 0)then
			(
				local new_list_other = #()
				local list_copy = deepCopy wait_check_facelist
				sort wait_check_facelist
				for i=1 to list_copy.count do
				(
					local find = findItem wait_check_facelist list_copy[i]
					new_list_other[find] = deepCopy wait_check_list_other[i]
				)
				wait_check_list_other = deepCopy new_list_other
				
				append store_FP[n] wait_check_facelist[1]
				appendIfUnique old wait_check_facelist[1]
				try(deleteItem src_FP (findItem src_FP wait_check_facelist[1]))catch()
				deleteItem wait_check_facelist 1
				deleteItem wait_check_list_other 1
			)
		)
		for i=1 to check_facelist.count do
		(
			this.searchSmoothGroup mesh_FP src_FP store_FP old:old c:check_facelist[i] o:check_list_other[i]
		)
	),

	fn sameGroupCheck src_FP dir_FP p: po: =
	(
		local j, k
		local is_same_group = #(undefined, 0)
		local add_sum = 0
		local reduce_sum = 0
		for j=1 to 3 do
		(
			local point_1 = this.faces[src_FP][j] as integer
			for k=1 to 3 do
			(
				local point_2 = this.faces[dir_FP][k]  as integer
				if(this.vertPos[point_1] == this.vertPos[point_2])then
				(
					if(is_same_group[1] != false)then(is_same_group[1] = true)
					if(this.vertNormal[point_1] != this.vertNormal[point_2])then
					(
						is_same_group[1] = false
						reduce_sum -= 1
					)else
					(
						add_sum += 1
					)
					if(p != unsupplied and po != unsupplied and point_1 != point_2)then
					(
						local find_1 = findItem p point_1
						local find_2 = findItem p point_2

						if(find_1 != 0 or find_2 != 0)then
						(
							if(find_1 == 0)then
							(
								insertItem point_1 p (find_2+1)
								insertItem po[find_2] po (find_2+1)
							)
							if(find_2 == 0)then
							(
								insertItem point_2 p (find_1+1)
								insertItem po[find_1] po (find_1+1)
							)
						)else
						(
							try(local index = po[po.count] + 1)catch(local index = 1)
							append p point_1
							append p point_2
							append po index
							append po index
						)
					)
				)
			)
		)
		case is_same_group[1] of
		(
			true: is_same_group[2] = add_sum
			false: is_same_group[2] = reduce_sum
			default:()
		)
		return is_same_group
	)
)

struct M3S_ScLight
(
	lightType, nameStr = "", nbrBone, bindingPose,
	targetBone = 0, targetName, targetPos = matrix3 1,
	shadowCast, specEnable, affectedByAO, lightOpaqueObj, lightTransObj,
	LODcut, shadowLODcut,
	diffuseColor = M3SD_ScAnimData(),
	intensity = M3SD_ScAnimData(),
	specularcolor = M3SD_ScAnimData(),
	specularMultiplier = M3SD_ScAnimData(), --attenEnd,
	attenStart = M3SD_ScAnimData(),
	decay = M3SD_ScAnimData(),
	hotspot = M3SD_ScAnimData(),
	falloff = M3SD_ScAnimData(),
	theLight,

	fn init m: s: t: i: =
	(
		local this_item
		try(this_item = this)catch(this_item = M3S_ScLight())
		try(this_item.buildSceneData m s t i)catch(throw())
		return this_item
	),

	fn releaseData scbone_FP =
	(
		case this.lightType of
		(
			1:--OmniLight
			(
				local the_light = SC2OmniLight()
				--the_light.worldLight NOT USED
				--the_light.nospecular NOT USED
				--the_light.noatten NOT USED
			)
			2:--SpotLight
			(
				local the_target = Targetobject pos:[0,0,0]
				the_target.name = this.targetName
				the_target.transform = this.targetPos
				
				local the_light = SC2SpotLight target:the_target

				if(targetBone > 0)then
				(scbone_FP[this.targetBone].theObj = the_target)

				the_light.shadowLODCut = shadowLODcut
				M3F_AnimApply #toscene this the_light \
				"falloff" ""
				M3F_AnimApply #toscene this the_light \
				"hotspot" ""
			)
			default: return undefined
		)
		local self_bone = scbone_FP[this.nbrBone]
		self_bone.theObj = the_light
		the_light.name = this.nameStr
		the_light.transform = this.bindingPose

		if(self_bone.parentBone > 0 and self_bone.parentBone < 0xFFFF)then
		(
			the_light.parent = scbone_FP[self_bone.parentBone].theBone
			try(the_target.parent = the_light.parent)catch()
		)

		if(this.lightType == 1)then
		(
			M3F_CopyController the_light self_bone.theBone
		)else
		(
			M3F_CopyController the_light self_bone.theBone type:#pos
			M3F_CopyController the_light self_bone.theBone type:#scale
		)

		the_light.shadowCast = this.shadowCast
		the_light.Specular =  this.specEnable
		the_light.affectedByAO = this.affectedByAO
		the_light.lightOpaqueObjects = this.lightOpaqueObj
		the_light.lightTransparentObjects = this.lightTransObj
		the_light.lightLODCut = this.LODcut

		M3F_AnimApply #toscene this the_light \
		"diffuseColor" ""
		M3F_AnimApply #toscene this the_light \
		"intensity" ""
		M3F_AnimApply #toscene this the_light \
		"specularcolor" ""
		M3F_AnimApply #toscene this the_light \
		"specularMultiplier" ""
		M3F_AnimApply #toscene this the_light \
		"attenStart" ""
		M3F_AnimApply #toscene this the_light \
		"decay" ""
		this.theLight = the_light

		M3F_AddToLayer "Light" the_light
	),
	fn collectData =(),

	fn buildSceneData m3obj_FP scseq_FP track_FP idx_FP =
	(
		local i, n
		local m3_bone = m3obj_FP.fBONE
		local m3_irefs = m3obj_FP.fIREF
		local m3_light = m3obj_FP.fLITE[idx_FP]
		this.nbrBone = m3_light.nbrBone+1
		local m3_object = m3obj_FP.fBONE[this.nbrBone]
		local m3_iref = m3obj_FP.fIREF[this.nbrBone]
		local track_tp = idx_FP * 10000 + 300
		this.targetBone = M3F_FindBone m3_bone m3_object.rfdName.data s1:"Target"

		for i=1 to track_FP.count do
		(track_FP[i].swapBoneTrack this.nbrBone track_tp)

		this.lightType = m3_light.lTypes
		this.nameStr = copy m3_object.rfdName.data
		this.bindingPose = inverse (matrix3 m3_iref.matrix[1] \
											m3_iref.matrix[2] \
											m3_iref.matrix[3] \
											(m3_iref.matrix[4] * 100))
		if this.targetBone != 0 then
		(
			this.targetName = copy m3_bone[this.targetBone].rfdName.data
			this.targetPos = inverse (matrix3 m3_irefs[this.targetBone].matrix[1] \
											m3_irefs[this.targetBone].matrix[2] \
											m3_irefs[this.targetBone].matrix[3] \
											(m3_irefs[this.targetBone].matrix[4] * 100))
		)else
		(
			this.targetName = this.nameStr + "_Target"
			this.targetPos.translation = [0.0,0.0,-100.0]
			this.targetPos = this.targetPos * this.bindingPose
		)

		this.shadowCast = m3_light.lFlags.bitGet 1
		this.specEnable = m3_light.lFlags.bitGet 2
		this.affectedByAO = m3_light.lFlags.bitGet 3
		this.lightOpaqueObj = m3_light.lFlags.bitGet 4
		this.lightTransObj = m3_light.lFlags.bitGet 5

		this.LODcut = m3_light.lLODcut + 1
		if(this.lightType == 2)then
		(
			this.shadowLODcut = m3_light.lsLODcut + 1
			M3F_AnimApply #fromfile this m3_light \
			"hotspot" "rfaHotSpot" seq:scseq_FP m3:m3obj_FP c:true mult:57.296 \
			anim:"hotspot" trk:track_FP tp:track_tp
			M3F_AnimApply #fromfile this m3_light \
			"falloff" "rfaFalloff" seq:scseq_FP m3:m3obj_FP c:true mult:57.296 \
			anim:"falloff" trk:track_FP tp:track_tp
		)

		M3F_AnimApply #fromfile this m3_light \
		"diffuseColor" "rfaDiffColor" seq:scseq_FP m3:m3obj_FP c:true mult:255.0 \
		anim:"diffuseColor" trk:track_FP tp:track_tp
		M3F_AnimApply #fromfile this m3_light \
		"intensity" "rfaIntensMult" seq:scseq_FP m3:m3obj_FP \
		anim:"intensity" trk:track_FP tp:track_tp
		M3F_AnimApply #fromfile this m3_light \
		"specularcolor" "rfaSpecColor" seq:scseq_FP m3:m3obj_FP c:true mult:255.0 \
		anim:"specularcolor" trk:track_FP tp:track_tp
		M3F_AnimApply #fromfile this m3_light \
		"specularMultiplier" "rfaSpecMult" seq:scseq_FP m3:m3obj_FP \
		anim:"specularMultiplier" trk:track_FP tp:track_tp
		M3F_AnimApply #fromfile this m3_light \
		"attenStart" "rfaAttenStart" seq:scseq_FP m3:m3obj_FP c:true mult:100.0 \
		anim:"attenStart" trk:track_FP tp:track_tp
		M3F_AnimApply #fromfile this m3_light \
		"decay" "rfaDecay" seq:scseq_FP m3:m3obj_FP c:true mult:100.0 \
		anim:"decay" trk:track_FP tp:track_tp
	)
)

struct M3S_ScCamera
(
	camType, nameStr = "", nbrBone, bindingPose,
	targetBone = 0, targetName, targetPos = matrix3 1,
	useVertFOV,
	shadowClipDistance = M3SD_ScAnimData(), dofAmount = M3SD_ScAnimData(),
	focusDistance = M3SD_ScAnimData(), fullFocusRange = M3SD_ScAnimData(),
	noFocusRange = M3SD_ScAnimData(), curFOV = M3SD_ScAnimData(),
	farclip = M3SD_ScAnimData(), nearclip = M3SD_ScAnimData(),
	theCam,

	fn init m: s: t: i: =
	(
		local this_item
		try(this_item = this)catch(this_item = M3S_ScCamera())
		try(this_item.buildSceneData m s t i)catch(throw())
		return this_item
	),

	fn releaseData scbone_FP =
	(
		case this.camType of
		(
			1:--FreeCamera
			(
				local the_cam = SC2Camera()
			)
			2:--TargetCamera
			(
				local the_target = Targetobject pos:[0,0,0]
				the_target.name = this.targetName
				the_target.transform = this.targetPos

				local the_cam = SC2Camera target:the_target

				if(targetBone > 0)then
				(scbone_FP[this.targetBone].theObj = the_target)
			)
			default: return undefined
		)
		local self_bone = scbone_FP[this.nbrBone]
		self_bone.theObj = the_cam
		the_cam.name = this.nameStr
		the_cam.transform = this.bindingPose

		if(self_bone.parentBone > 0 and self_bone.parentBone < 0xFFFF)then
		(
			the_cam.parent = scbone_FP[self_bone.parentBone].theBone
			try(the_target.parent = the_cam.parent)catch()
		)

		if(this.camType == 1)then
		(
			M3F_CopyController the_cam self_bone.theBone
		)else
		(
			M3F_CopyController the_cam self_bone.theBone type:#pos
			M3F_CopyController the_cam self_bone.theBone type:#scale
		)

		the_cam.useVertFOV = this.useVertFOV

		M3F_AnimApply #toscene this the_cam \
		"shadowClipDistance" ""
		M3F_AnimApply #toscene this the_cam \
		"dofAmount" ""
		M3F_AnimApply #toscene this the_cam \
		"focusDistance" ""
		M3F_AnimApply #toscene this the_cam \
		"fullFocusRange" ""
		M3F_AnimApply #toscene this the_cam \
		"noFocusRange" ""
		M3F_AnimApply #toscene this the_cam \
		"curFOV" ""
		M3F_AnimApply #toscene this the_cam \
		"farclip" ""
		M3F_AnimApply #toscene this the_cam \
		"nearclip" ""
		this.theCam = the_cam

		M3F_AddToLayer "Camera" the_cam
	),

	fn collectData =(),

	fn buildSceneData m3obj_FP scseq_FP track_FP idx_FP =
	(
		local i, n
		local m3_bone = m3obj_FP.fBONE
		local m3_irefs = m3obj_FP.fIREF
		local m3_cam = m3obj_FP.fCAM[idx_FP]
		this.nbrBone = m3_cam.nbrBone+1
		local m3_object = m3obj_FP.fBONE[this.nbrBone]
		local m3_iref = m3obj_FP.fIREF[this.nbrBone]
		local track_tp = idx_FP * 10000 + 400
		this.targetBone = M3F_FindBone m3_bone m3_object.rfdName.data s1:"Target"

		for i=1 to track_FP.count do
		(track_FP[i].swapBoneTrack this.nbrBone track_tp)

		this.camType = 1	--FreeCamera
		this.nameStr = copy m3_cam.rfdName.data
		this.bindingPose = inverse (matrix3 m3_iref.matrix[1] \
											m3_iref.matrix[2] \
											m3_iref.matrix[3] \
											(m3_iref.matrix[4] * 100))
		if this.targetBone != 0 then
		(
			this.camType = 2	--TargetCamera
			this.targetName = copy m3_bone[this.targetBone].rfdName.data
			this.targetPos = inverse (matrix3 m3_irefs[this.targetBone].matrix[1] \
								m3_irefs[this.targetBone].matrix[2] 				 \
								m3_irefs[this.targetBone].matrix[3] 				 \
								(m3_irefs[this.targetBone].matrix[4] * 100))
		)else
		(
			this.targetName = this.nameStr + "_Target"
			this.targetPos.translation = [0.0,0.0,-100.0]
			this.targetPos = this.targetPos * this.bindingPose
		)
		this.useVertFOV = M3F_CvtType #bool m3_cam.useVertFOV

		M3F_AnimApply #fromfile this m3_cam \
		"shadowClipDistance" "rfaSClipDis" seq:scseq_FP m3:m3obj_FP c:true mult:100.0 \
		anim:"shadowClipDistance" trk:track_FP tp:track_tp
		M3F_AnimApply #fromfile this m3_cam \
		"dofAmount" "rfaDOFamount" seq:scseq_FP m3:m3obj_FP \
		anim:"dofAmount" trk:track_FP tp:track_tp
		M3F_AnimApply #fromfile this m3_cam \
		"focusDistance" "rfaSClipDis" seq:scseq_FP m3:m3obj_FP c:true mult:100.0 \
		anim:"focusDistance" trk:track_FP tp:track_tp
		M3F_AnimApply #fromfile this m3_cam \
		"fullFocusRange" "rfaFFocusRange" seq:scseq_FP m3:m3obj_FP c:true mult:100.0 \
		anim:"fullFocusRange" trk:track_FP tp:track_tp
		M3F_AnimApply #fromfile this m3_cam \
		"noFocusRange" "rfaNFocusRange" seq:scseq_FP m3:m3obj_FP c:true mult:100.0 \
		anim:"noFocusRange" trk:track_FP tp:track_tp
		M3F_AnimApply #fromfile this m3_cam \
		"curFOV" "rfaFOV" seq:scseq_FP m3:m3obj_FP c:true mult:57.296 \
		anim:"FOV" trk:track_FP tp:track_tp
		M3F_AnimApply #fromfile this m3_cam \
		"farclip" "rfaFarClip" seq:scseq_FP m3:m3obj_FP c:true mult:100.0 \
		anim:"Far Clip" trk:track_FP tp:track_tp
		M3F_AnimApply #fromfile this m3_cam \
		"nearclip" "rfaNearClip" seq:scseq_FP m3:m3obj_FP c:true mult:100.0 \
		anim:"Near Clip" trk:track_FP tp:track_tp
	)
)

struct M3S_ScParicle
(
	parType = 0, nameStr = "", nbrBone, nbrSubBone = 0, bindingPose, matIdx,
	targetName, targetPos = matrix3 0, storeData, splatLine = #(), subRib,
	thePar,

	fn init m: s: t: i: f: =
	(
		local this_item
		try(this_item = this)catch(this_item = M3S_ScParicle())
		try(this_item.buildSceneData m s t i f:f)catch(throw())
		return this_item
	),

	fn releaseData scbone_FP scmat_FP =
	(
		local i, n
		case this.parType of
		(
			1:
			(
				local the_particle = SC2Particles()
				this.storeData.copyData the_particle dir:#toscene

				the_particle.MeshLink = copy this.storeData.MeshLink
				the_particle.SplineLink = copy this.storeData.SplineLink
				the_particle.TrailingParticleLink = \
					copy this.storeData.TrailingParticleLink
				the_particle.ParticleLink = copy this.storeData.ParticleLink
				the_particle.ParticleSplatLink = \
					copy this.storeData.ParticleSplatLink
				if(this.storeData.SplineLink != "NONE")then
				(
					local link_line = line()
					link_line.name = this.storeData.SplineLink
					addNewSpline link_line
					for i=1 to this.splatLine.count do
					(
						addKnot link_line 1 #corner #line splatLine[i].dkeys[1]
					)
					for i=1 to this.splatLine.count do
					(
						local s_point = this.splatLine[i]
						if(s_point.frames[1] != -1)then
						(
							animate on
							(
								for n=1 to s_point.frames.count do
								(
									at time s_point.frames[n]
									(
										setKnotPoint link_line 1 i s_point.dkeys[n]
									)
								)
							)
						)
					)
					updateShape link_line
				)
			)
			2:
			(
				if(this.storeData.subParType == 0)then
				(
					local the_particle = SC2Ribbon()
				)else
				(
					local names = #("SC2SplRbn_Start","SC2SplRbn_End")
 					mergeMAXFile ((getdir #temp) + "\\M3Import_mzp\\SC2ObjIn.max") names
 					local the_particle = $SC2SplRbn_Start
 					local the_particle2 = $SC2SplRbn_End
 					the_particle.name = this.nameStr
 					the_particle2.name = this.nameStr + "_EndPoint"

 					if(this.targetName != undefined)then
 					(
 						local self_bone2 = scbone_FP[nbrSubBone]
						self_bone2.theObj = the_particle2
 						the_particle2.name = this.targetName

 						if(self_bone2.parentBone > 0 and self_bone2.parentBone < 0xFFFF)then
						(the_particle2.parent = scbone_FP[self_bone2.parentBone].theBone)

						M3F_CopyController the_particle2 self_bone2.theBone
 					)else
 					(
 						the_particle2.name = this.nameStr + "_EndPoint"
 						the_particle2.transform = this.targetPos
 					)
 					this.subRib.copyData the_particle2 dir:#toscene
				)
				this.storeData.copyData the_particle dir:#toscene
			)
			3:
			(
				local the_particle = SC2Projector()
				this.storeData.copyData the_particle dir:#toscene
			)
		)
		local self_bone = scbone_FP[this.nbrBone]
		self_bone.theObj = the_particle
		the_particle.name = this.nameStr
		the_particle.transform = this.bindingPose

		if(self_bone.parentBone > 0 and self_bone.parentBone < 0xFFFF)then
		(the_particle.parent = scbone_FP[self_bone.parentBone].theBone)

		M3F_CopyController the_particle self_bone.theBone

		if(M3F_GetGlobalSettings #MatEnable)then
		(
			the_particle.Material = scmat_FP[this.matIdx].theMat
		)

		this.thePar = the_particle

		M3F_AddToLayer "Particle" the_particle
	),

	fn collectData =(),

	fn buildSceneData m3obj_FP scseq_FP track_FP idx_FP f:#par =
	(
		local i
		case f of
		(
			#par:
			(
				local m3_particle = m3obj_FP.fPAR[idx_FP]
				this.storeData = M3SD_ScPar()
			)
			#rib:
			(
				local m3_particle = m3obj_FP.fRIB[idx_FP]
				this.storeData = M3SD_ScRibbon()
			)
			#proj:
			(
				local m3_particle = m3obj_FP.fPROJ[idx_FP]
				this.storeData = M3SD_ScProject()
			)
			default: return undefined
		)
		this.nbrBone = m3_particle.nbrBone + 1
		local m3_bone = m3obj_FP.fBONE
		local m3_irefs = m3obj_FP.fIREF
		local m3_object = m3obj_FP.fBONE[this.nbrBone]
		local m3_iref = m3obj_FP.fIREF[this.nbrBone]
		local track_tp = idx_FP * 10000 + 500

		for i=1 to track_FP.count do
		(track_FP[i].swapBoneTrack this.nbrBone track_tp)

		this.nameStr = copy m3_object.rfdName.data
		this.matIdx = m3_particle.matIdx + 1
		this.bindingPose = inverse (matrix3 m3_iref.matrix[1] \
									m3_iref.matrix[2] \
									m3_iref.matrix[3] \
									(m3_iref.matrix[4] * 100))

		case f of
		(
			#par:
			(
				this.parType = 1
				this.storeData.copyData m3_particle trk:track_FP tp:track_tp \
				seq:scseq_FP m3:m3obj_FP dir:#fromfile
				try
				(
					this.storeData.MeshLink = "Mesh " + \
					((m3_particle.rfdEmissMesh.data[1] + 1) as string)
				)
				catch(this.storeData.MeshLink = "NONE")

				try
				(
					local point_count = m3_particle.rfdSplatLine.data.count
					this.storeData.SplineLink = this.nameStr + "_Spline"
					for i=1 to point_count by 4 do
					(
						local point_data = M3SD_ScAnimData()
						append this.splatLine point_data
						M3F_AnimApply #fromfile this m3_particle \
							("splatLine["+(((i+3)/4) as string)+"]") \
							("rfdSplatLine.data["+(i as string)+"]") \
							seq:scseq_FP m3:m3obj_FP \
							c:true mult:1.0
					)
					local point_data_end = M3SD_ScAnimData()
					append this.splatLine point_data_end
					M3F_AnimApply #fromfile this m3_particle \
						("splatLine["+(this.splatLine.count as string)+"]") \
						("rfdSplatLine.data["+(point_count as string)+"]") \
						seq:scseq_FP m3:m3obj_FP \
						c:true mult:1.0
				)catch(this.storeData.SplineLink = "NONE")

				this.storeData.TrailingParticleLink = \
					(this.findLink m3obj_FP (m3_particle.trailLinkIdx+1) #par)
				this.storeData.ParticleLink = \
					(this.findLink m3obj_FP (m3_particle.colSpawnIdx+1) #par)
				this.storeData.ParticleSplatLink = \
					(this.findLink m3obj_FP (m3_particle.splatProjIdx+1) #proj)

				if(m3_particle.parFlags1.bits[23])then
				(
					this.storeData.ModelName = #()
					for i in m3_particle.rfdModel.data do
					(
						local find = findString i.data "PrtMdl_"
						if(find != undefined)then
						(
							local mdl_name = substring i.data (find+7) (i.data.count-find-9)
							append this.storeData.ModelName (copy mdl_name)
						)
					)
					format "    Par:% hasMdl:%\n" idx_FP this.storeData.ModelName
				)
			)
			#rib:
			(
				this.parType = 2
				this.storeData.subParType = 0
				if(m3_particle.rfdSubRib.data != undefined)then
				(
					this.storeData.subParType = 1
					this.nbrSubBone = m3_particle.rfdSubRib.data.nbrBone + 1

					if this.nbrSubBone != 0 then
					(
						this.targetName = copy m3_bone[this.nbrSubBone].rfdName.data
						this.targetPos = \
							inverse (matrix3 m3_irefs[this.nbrSubBone].matrix[1] \
											m3_irefs[this.nbrSubBone].matrix[2] \
											m3_irefs[this.nbrSubBone].matrix[3] \
											(m3_irefs[this.nbrSubBone].matrix[4] * 100))
					)
					this.subRib = M3SD_ScSubRib()
					this.subRib.copyData m3_particle.rfdSubRib.data \
					seq:scseq_FP m3:m3obj_FP dir:#fromfile
				)
				this.storeData.copyData m3_particle trk:track_FP tp:track_tp \
				seq:scseq_FP m3:m3obj_FP dir:#fromfile
			)
			#proj:
			(
				this.parType = 3
				this.storeData.copyData m3_particle trk:track_FP tp:track_tp \
				seq:scseq_FP m3:m3obj_FP dir:#fromfile
			)
		)
	),

	fn findLink m3obj_FP link_FP type_FP =
	(
		if(link_FP > 0)then
		(
			local m3_par = case type_FP of(#par: m3obj_FP.fPAR; #proj: m3obj_FP.fPROJ)
			local m3_bone = m3obj_FP.fBONE
			local bone_idx = m3_par[link_FP].nbrBone
			return (copy m3_bone[bone_idx].rfdName.data)
		)else
		(
			return "NONE"
		)
	)
)

struct M3S_ScPhysics
(
	PhyType, nameStr = "", nbrBone, bindingPose,
	storeData, thePhy,

	fn init m: s: t: i: f: =
	(
		local this_item
		try(this_item = this)catch(this_item = M3S_ScPhysics())
		try(this_item.buildSceneData m s t i f:f)catch(throw())
		return this_item
	),

	fn releaseData scbone_FP =
	(
		case this.PhyType of
		(
			1:
			(
				local the_physics = SC2Force()
			)
			2:
			(
				local the_physics = SC2VertexWarp()
			)
			3:
			(
				local the_physics = SC2Physics()
				the_physics.name = this.nameStr
				the_physics.transform = this.bindingPose
				the_physics.parent = scbone_FP[this.nbrBone].theBone
				this.storeData.copyData the_physics dir:#toscene

				if(this.storeData.shapeType == 5)then
				(
					local i
					local the_mesh = editable_mesh name:(this.nameStr+"_ExtractedMesh")
					convertTo the_mesh Editable_Poly

					for i=1 to this.storeData.rigedBodyVerts.count do
					(
						polyop.createVert the_mesh this.storeData.rigedBodyVerts[i]
					)
					
					local face_list = #{}
					local filp_face = #{}
					for i=1 to this.storeData.rigedBodyFaces.count do
					(
						local face_idx = polyop.createPolygon the_mesh this.storeData.rigedBodyFaces[i]
						if(face_idx != undefined)then
						(
							append face_list face_idx
							local face_norm = polyop.getFaceNormal the_mesh face_idx
							
							if((dot (normalize this.storeData.rigedBodyNorms[i]) (normalize face_norm)) < 0)then
							(append filp_face face_idx)
						)else(format "badface:%\n" i)
					)
					max modify mode
					modPanel.setCurrentObject the_mesh
					subobjectLevel = 4
					polyop.setFaceSelection the_mesh face_list
					polyop.retriangulate the_mesh face_list
					polyop.setFaceSelection the_mesh filp_face
					polyop.flipNormals the_mesh filp_face
					subobjectLevel = 0

					the_physics.customMesh = the_mesh
					the_physics.ConvexHull = the_mesh
					delete the_mesh
				)

				this.thePhy = the_physics
				M3F_AddToLayer "Physics" the_physics
				return true
			)
			default: return undefined
		)
		local self_bone = scbone_FP[this.nbrBone]
		self_bone.theObj = the_physics
		the_physics.name = this.nameStr
		the_physics.transform = this.bindingPose

		if(self_bone.parentBone > 0 and self_bone.parentBone < 0xFFFF)then
		(the_physics.parent = scbone_FP[self_bone.parentBone].theBone)
		M3F_CopyController the_physics self_bone.theBone

		this.storeData.copyData the_physics dir:#toscene

		this.thePhy = the_physics
		M3F_AddToLayer "Physics" the_physics
	),
	fn collectData =(),

	fn buildSceneData m3obj_FP scseq_FP track_FP idx_FP f:#force =
	(
		local i
		case f of
		(
			#force:
			(
				local m3_physics = m3obj_FP.fFOR[idx_FP]
				this.storeData = M3SD_ScForce()
				this.PhyType = 1
			)
			#warp:
			(
				local m3_physics = m3obj_FP.fWRP[idx_FP]
				this.storeData = M3SD_ScWarp()
				this.PhyType = 2
			)
			#rigedbody:
			(
				local m3_physics = m3obj_FP.fPHRB[idx_FP]
				this.storeData = M3SD_ScRigedBody()
				this.PhyType = 3
				this.nameStr = "SC2Physics " + idx_FP as string
				this.nbrBone = m3_physics.nbrBoneParent + 1
				local m3_iref = m3obj_FP.fIREF[this.nbrBone]
				local self_pose = inverse (matrix3 m3_physics.rfdRigedBody.data.matrix[1] \
						m3_physics.rfdRigedBody.data.matrix[2] \
						m3_physics.rfdRigedBody.data.matrix[3] \
						(m3_physics.rfdRigedBody.data.matrix[4] * 100))
				local parent_pose = (matrix3 m3_iref.matrix[1] \
										m3_iref.matrix[2] \
										m3_iref.matrix[3] \
										(m3_iref.matrix[4] * 100))

				this.bindingPose = inverse (parent_pose * self_pose)

				this.storeData.copyData m3_physics seq:scseq_FP m3:m3obj_FP dir:#fromfile

				if(this.storeData.shapeType == 5)then
				(
					for i in m3_physics.rfdRigedBody.data.rfdVertPos.data do
					(
						append this.storeData.rigedBodyVerts (i * 100)
					)
					for i in m3_physics.rfdRigedBody.data.rfdFaceNorm.data do
					(
						append this.storeData.rigedBodyNorms [i[1],i[2],i[3]]
					)

					local face_list = for i=1 to m3_physics.rfdRigedBody.data.faceNbr collect(#())
					for i in m3_physics.rfdRigedBody.data.rfdVertFace.data do
					(
						local index = i[3] + 1
						local point_idx = i[2] + 1
						append face_list[index] (point_idx as integer)
					)

					local n, m, k
					local edge_list = for i=1 to face_list.count collect(#())
					for i=1 to face_list.count do
					(
						for n=1 to face_list[i].count do
						(
							for m=n+1 to face_list[i].count do
							(
								local edge_search = #(face_list[i][n],face_list[i][m])
								sort edge_search
								local found = false

								for k=1 to face_list.count do
								(
									if(k != i)then
									(
										local find1 = findItem face_list[k] edge_search[1]
										local find2 = findItem face_list[k] edge_search[2]
										if(find1 != 0 and find2 != 0)then
										(
											found = true
											exit
										)
									)
								)
								if(found)then(appendIfUnique edge_list[i] edge_search)
							)
						)
					)
					this.storeData.rigedBodyFaces = for i=1 to face_list.count collect(#())
					for i=1 to edge_list.count do
					(
						append this.storeData.rigedBodyFaces[i] edge_list[i][1][1]
						append this.storeData.rigedBodyFaces[i] edge_list[i][1][2]
						local point_search = edge_list[i][1][2]
						deleteItem edge_list[i] 1

						while edge_list[i].count > 0 do
						(
							for n=1 to edge_list[i].count do
							(
								local find = findItem edge_list[i][n] point_search
								case find of
								(
									1:
									(
										appendIfUnique this.storeData.rigedBodyFaces[i] edge_list[i][n][2]
										point_search = edge_list[i][n][2]
										deleteItem edge_list[i] n
										exit
									)
									2:
									(
										appendIfUnique this.storeData.rigedBodyFaces[i] edge_list[i][n][1]
										point_search = edge_list[i][n][1]
										deleteItem edge_list[i] n
										exit
									)
									default:()
								)
							)
						)
					)
				)
				return true
			)
			default: return undefined
		)
		this.nbrBone = m3_physics.nbrBone + 1
		local m3_bone = m3obj_FP.fBONE
		local m3_object = m3obj_FP.fBONE[this.nbrBone]
		local m3_iref = m3obj_FP.fIREF[this.nbrBone]
		local track_tp = idx_FP * 10000 + 600

		for i=1 to track_FP.count do
		(track_FP[i].swapBoneTrack this.nbrBone track_tp)

		this.nameStr = copy m3_object.rfdName.data
		this.bindingPose = inverse (matrix3 m3_iref.matrix[1] \
									m3_iref.matrix[2] \
									m3_iref.matrix[3] \
									(m3_iref.matrix[4] * 100))

		this.storeData.copyData m3_physics trk:track_FP tp:track_tp \
			seq:scseq_FP m3:m3obj_FP dir:#fromfile
	)
)

struct M3S_ScJoint
(
	nameStr = "", boneList = #(), jointType, axisOffset = #(),
	enableShapeCollision, coneAngle,
	enableLimit, limitMin, limitMax,
	enableJointFriction, jointFriction,
	dampingRatio, angularFrequency, breakThreshold,
	theIndex,

	fn init m: i: =
	(
		local this_item
		try(this_item = this)catch(this_item = M3S_ScJoint())
		try(this_item.buildSceneData m i)catch(throw())
		return this_item
	),

	fn releaseData behholder_FP scbone_FP =
	(
		local i
		local behavior_type = M3F_GetCustAttr #joint
		custAttributes.add behholder_FP behavior_type #unique
		this.theIndex = custAttributes.count behholder_FP
		local behavior = custAttributes.get behholder_FP this.theIndex

		behavior.behaviorType = "PhysicsJoint_Behavior"
		behavior.behaviorState = true
		behavior.name = this.nameStr

		behavior.bonelist[1] = scbone_FP[this.boneList[1]].theBone
		behavior.bonelist[2] = scbone_FP[this.boneList[2]].theBone
		behavior.boneStates = #(true,true)
		behavior.jointType = this.jointType
		behavior.axisOffset = deepCopy this.axisOffset
		behavior.enableShapeCollision = this.enableShapeCollision
		behavior.coneangle = this.coneAngle
		behavior.enableLimit = this.enableLimit
		behavior.limitMin = this.limitMin
		behavior.limitMax = this.limitMax
		behavior.enableJointFriction = this.enableJointFriction
		behavior.jointFriction = this.jointFriction
		behavior.dampingRatio = this.dampingRatio
		behavior.angularFrequency = this.angularFrequency
		behavior.breakThreshold = this.breakThreshold
	),
	fn collectData =(),

	fn buildSceneData m3obj_FP idx_FP =
	(
		local m3_joint = m3obj_FP.fPHYJ[idx_FP]
		local m3_bone = m3obj_FP.fBONE

		this.boneList[1] = m3_joint.nbrBone1 + 1
		this.boneList[2] = m3_joint.nbrBone2 + 1
		this.nameStr = 	m3_bone[this.boneList[2]].rfdName.data + "_J_" + \
						m3_bone[this.boneList[1]].rfdName.data

		this.jointType = m3_joint.jTypes + 1
		this.axisOffset[1] = matrix3 m3_joint.matrixB1[1] \
									m3_joint.matrixB1[2] \
									m3_joint.matrixB1[3] \
									(m3_joint.matrixB1[4] * 100)
		this.axisOffset[2] = matrix3 m3_joint.matrixB2[1] \
									m3_joint.matrixB2[2] \
									m3_joint.matrixB2[3] \
									(m3_joint.matrixB2[4] * 100)

		this.enableShapeCollision = M3F_CvtType #bool m3_joint.enableShape
		this.enableLimit = M3F_CvtType #bool m3_joint.enableLimits
		this.enableJointFriction = M3F_CvtType #bool m3_joint.enableFriction

		this.coneAngle = m3_joint.coneAngle * 57.296
		this.limitMin = m3_joint.limitMin * 57.296
		this.limitMax = m3_joint.limitMax * 57.296
		
		this.jointFriction = m3_joint.friction
		this.dampingRatio = m3_joint.dampingRatio
		this.angularFrequency = m3_joint.angularFreq
		this.breakThreshold = m3_joint.breakThold
	)
)

struct M3S_ScHelper
(
	nameStr = "", nbrBone, helperType, bindingPose,
	axisMatrix, size0, size1, size2,

	fn init m: i: f: =
	(
		local this_item
		try(this_item = this)catch(this_item = M3S_ScHelper())
		try(this_item.buildSceneData m i f:f)catch(throw())
		return this_item
	),

	fn releaseData scbone_FP =
	(
		if(this.helperType != 13)then
		(
			local types = (mod this.helperType 4) as integer
			case types of
			(
				1:
				(
					local the_helper = box name:this.nameStr 	\
										height:this.size2 		\
										width:this.size0		\
										length:this.size1
				)
				2:
				(
					local the_helper = sphere name:this.nameStr \
										radius:this.size0
				)
				3:
				(
					local the_helper = capsule name:this.nameStr 		\
										side:12							\
										radius:this.size0				\
										height:(this.size0*2+this.size1)	\
										heighttype:0
				)
				0:
				(
					local the_helper = Cylinder name:this.nameStr 	\
										side:12						\
										radius:this.size0			\
										height:this.size1
				)
			)

			case of
			(
				(this.helperType<9): the_helper.wireColor = color 0 0 255
				(this.helperType<13): the_helper.wireColor = color 255 0 0
			)
			if(M3F_GetGlobalSettings #VolColl)then
			(
				if(this.helperType >= 9 and this.helperType < 13)then
				(
					the_helper.boxmode = on
					the_helper.renderable = off
					freeze the_helper
				)
			)
			if(M3F_GetGlobalSettings #HitColl)then
			(
				if(this.helperType < 9)then
				(
					the_helper.boxmode = on
					the_helper.renderable = off
					freeze the_helper
				)
			)

			M3F_AddToLayer "HitTest" the_helper
		)else
		(
			if(matchPattern this.nameStr pattern:"Ref_Target*" ignoreCase:false)then(return undefined)
			local the_helper = SC2AttachPt name:this.nameStr
			the_helper.null.lockXYZ = true
			the_helper.null.xScale = (M3F_GetGlobalSettings #AttSize)
			if(M3F_GetGlobalSettings #AttColl)then
			(
				the_helper.null.nullShape = 0
				the_helper.null.displayName = false
				freeze the_helper
			)
			M3F_AddToLayer "Attachment Point" the_helper
		)
		local self_bone = scbone_FP[this.nbrBone]
		self_bone.theObj = the_helper
		the_helper.transform = this.bindingPose

		if(self_bone.parentBone > 0 and self_bone.parentBone < 0xFFFF)then
		(the_helper.parent = scbone_FP[self_bone.parentBone].theBone)

		M3F_CopyController the_helper self_bone.theBone
		--delete self_bone.theBone
	),
	fn collectData =(),

	fn buildSceneData m3obj_FP idx_FP f:#attach =
	(
		case f of
		(
			#tight:
			(
				local m3_helper = m3obj_FP.fMODL.tightTest
				this.helperType = 1 + m3_helper.type
			)
			#fuzzy:
			(
				local m3_helper = m3obj_FP.fMODL.rfdSSGS.data[idx_FP]
				this.helperType = 5 + m3_helper.type
			)
			#attvol:
			(
				local m3_helper = m3obj_FP.fMODL.rfdATVL.data[idx_FP]
				this.helperType = 9 + m3_helper.type
			)
			#attach:
			(
				local m3_helper = m3obj_FP.fATT.attachments[idx_FP]
				this.helperType = 13
				this.nameStr = copy m3_helper.rfdName.data
			)
			default: return undefined
		)
		this.nbrBone = m3_helper.nbrBone + 1
		local m3_object = m3obj_FP.fBONE[this.nbrBone]
		local m3_iref = m3obj_FP.fIREF[this.nbrBone]

		if(f != #attach)then(this.nameStr = copy m3_object.rfdName.data)

		this.bindingPose = inverse (matrix3 m3_iref.matrix[1] \
									m3_iref.matrix[2] \
									m3_iref.matrix[3] \
									(m3_iref.matrix[4] * 100))
		
		if(f != #attach)then
		(
			this.axisMatrix = inverse (matrix3 m3_helper.matrix[1]	\
										m3_helper.matrix[2]			\
										m3_helper.matrix[3]			\
										(m3_helper.matrix[4] * 100))
			this.size0 = m3_helper.size0 * 100
			this.size1 = m3_helper.size1 * 100
			this.size2 = m3_helper.size2 * 100
		)
	)
)
--SCENE MAIN STRUCT--------------------------------------------
struct M3S_SceneMain
(
	sAnimProp = #(), sTrackSet = #(), sJoint = #(),
	sBone = #(), sEvent = #(), sMesh = #(), sLight = #(), sCamera = #(),
	sParicle = #(), sPhysics = #(), sHelper = #(), sMaterial = #(),
	theMain,

	fn releaseData =
	(
		local i
		local common_behholder
		--return true

		if(M3F_GetGlobalSettings #SeqEnable)then
		(
			--releaseAnimProps
			M3F_ShowPhase "Releasing AnimProps ..."
			print "Releasing AnimProps ..."
			for i=(numNoteTracks rootNode) to 1 by -1 do
			(deleteNoteTrack rootNode (getNoteTrack rootNode i))
			addNoteTrack rootNode (notetrack "starAnimTrack")
			for i=1 to this.sAnimProp.count do
			(
				M3F_FillProgressLv flag:#execute
				this.sAnimProp[i].releaseData()
			)
		)else
		(
			M3F_ShowPhase "Skip AnimProps!"
			M3F_FillProgressLv step:this.sAnimProp.count flag:#execute
		)

		if(M3F_GetGlobalSettings #MatEnable)then
		(
			--releaseMaterials
			M3F_ShowPhase "Releasing Materials ..."
			print "Releasing Materials ..."
			for i=1 to this.sMaterial.count do
			(
				M3F_FillProgressLv flag:#execute
				this.sMaterial[i].releaseData i
			)
			for i=1 to this.sMaterial.count do
			(this.sMaterial[i].releaseCompSubMat i)
		)else
		(
			M3F_ShowPhase "Skip Materials!"
			M3F_FillProgressLv step:this.sMaterial.count flag:#execute
		)

		--releaseBones
		M3F_ShowPhase "Releasing Bones ..."
		print "Releasing Bones ..."
		for i=1 to this.sBone.count do
		(
			M3F_FillProgressLv flag:#execute
			this.sBone[i].releaseData this.sBone
		)

		if(M3F_GetGlobalSettings #EventEnable)then
		(
			--releaseEvent
			M3F_ShowPhase "Releasing Events ..."
			print "Releasing Events ..."
			for i=1 to this.sEvent.count do
			(
				M3F_FillProgressLv flag:#execute
				this.sEvent[i].releaseData this.sBone
			)
		)else
		(
			M3F_ShowPhase "Skip Events!"
			M3F_FillProgressLv step:this.sEvent.count flag:#execute
		)


		if(M3F_GetGlobalSettings #MeshEnable)then
		(
			--releaseMeshes
			print "Releasing Meshes ..."
			max modify mode
			for i=1 to this.sMesh.count do
			(
				M3F_FillProgressLv flag:#execute
				this.sMesh[i].releaseData this.sBone this.sMaterial
			)
			max create mode
		)else
		(
			M3F_ShowPhase "Skip Meshes!"
			M3F_FillProgressLv step:this.sMesh.count flag:#execute
		)

		if((M3F_GetGlobalSettings #AnimEnable) == true and (M3F_GetGlobalSettings #BoneAnim) == true)then
		(
			--animationApply
			for i=1 to this.sBone.count do
			(this.sBone[i].animApply())
		)

		if(M3F_GetGlobalSettings #LightEnable)then
		(
			--releaseLights
			M3F_ShowPhase "Releasing Lights ..."
			print "Releasing Lights ..."
			for i=1 to this.sLight.count do
			(
				M3F_FillProgressLv flag:#execute
				this.sLight[i].releaseData this.sBone
			)
		)else
		(
			M3F_ShowPhase "Skip Lights!"
			M3F_FillProgressLv step:this.sLight.count flag:#execute
		)

		if(M3F_GetGlobalSettings #CamEnable)then
		(
			--releaseCameras
			M3F_ShowPhase "Releasing Cameras ..."
			print "Releasing Cameras ..."
			for i=1 to this.sCamera.count do
			(
				M3F_FillProgressLv flag:#execute
				this.sCamera[i].releaseData this.sBone
			)
		)else
		(
			M3F_ShowPhase "Skip Cameras!"
			M3F_FillProgressLv step:this.sCamera.count flag:#execute
		)

		if(M3F_GetGlobalSettings #ParEnable)then
		(
			--releaseParticles
			M3F_ShowPhase "Releasing Particles ..."
			print "Releasing Particles ..."
			for i=1 to this.sParicle.count do
			(
				M3F_FillProgressLv flag:#execute
				this.sParicle[i].releaseData this.sBone this.sMaterial
			)
		)else
		(
			M3F_ShowPhase "Skip Particles!"
			M3F_FillProgressLv step:this.sParicle.count flag:#execute
		)

		if(M3F_GetGlobalSettings #PhyEnable)then
		(
			--releasePhysics
			M3F_ShowPhase "Releasing Physics ..."
			print "Releasing Physics ..."
			for i=1 to this.sPhysics.count do
			(
				M3F_FillProgressLv flag:#execute
				this.sPhysics[i].releaseData this.sBone
			)
			--releasePhysicsJoint
			M3F_ShowPhase "Releasing PhysicsJoint ..."
			print "Releasing PhysicsJoint ..."
			if(this.sJoint.count > 0 and common_behholder == undefined)then
			(
				common_behholder = SC2BehaviorHolder \
				name:"SC2BehaviorHolder_Import"
			)
			for i=1 to this.sJoint.count do
			(
				M3F_FillProgressLv flag:#execute
				this.sJoint[i].releaseData common_behholder this.sBone
			)
		)else
		(
			M3F_ShowPhase "Skip Physics!"
			M3F_FillProgressLv step:this.sPhysics.count flag:#execute
		)

		--releaseHelpers
		M3F_ShowPhase "Releasing Helpers ..."
		print "Releasing Helpers ..."
		for i=1 to this.sHelper.count do
		(
			M3F_FillProgressLv flag:#execute
			case of
			(
				(this.sHelper[i].helperType < 9):
				(
					if((M3F_GetGlobalSettings #HitEnable) != true)then
					(
						M3F_ShowPhase "Skip Hit Tests!"
						continue
					)
				)
				(this.sHelper[i].helperType < 13):
				(
					if((M3F_GetGlobalSettings #VolEnable) != true)then
					(
						M3F_ShowPhase "Skip Vol Targets!"
						continue
					)
				)
				(this.sHelper[i].helperType == 13):
				(
					if((M3F_GetGlobalSettings #AttEnable) != true)then
					(
						M3F_ShowPhase "Skip Attachments!"
						continue
					)
				)
			)
			M3F_ShowPhase "Releasing Helpers ..."
			this.sHelper[i].releaseData this.sBone
		)

		if(M3F_GetGlobalSettings #TrackEnable)then
		(
			--releaseAnimTrackSet
			M3F_ShowPhase "Releasing TrackSets ..."
			if(this.sTrackSet.count > 0 and common_behholder == undefined)then
			(
				common_behholder = SC2BehaviorHolder \
				name:"SC2BehaviorHolder_Import"
			)
			for i=1 to this.sTrackSet.count do
			(
				M3F_FillProgressLv flag:#execute
				this.sTrackSet[i].releaseData common_behholder \
				this.sMaterial \
				this.sBone \
				this.sLight \
				this.sCamera \
				this.sParicle \
				this.sPhysics \
				this.sEvent
			)
		)else
		(
			M3F_ShowPhase "Skip TrackSets!"
			M3F_FillProgressLv step:this.sTrackSet.count flag:#execute
		)

		--cleanBones
		if((M3F_GetGlobalSettings #BoneEnable) != true)then
		(
			M3F_ShowPhase "delete Bones!"
		)
		for i=1 to this.sBone.count do
		(this.sBone[i].deleteBones())
	),
	fn collectData =
	(

	),
	fn buildSceneData m3obj_FP =
	(
		local i, n
		local exceptBones = #()
		local bonesType = #()
		local trackName = #()
		local trackSets = #()
		local eventList = #()

		--buildAnimProp
		M3F_ShowPhase "Building AnimProps ..."
		print "Building AnimProps ..."
		format "AnimPropsCount:%\n" m3obj_FP.fSTG.count
		for i=1 to m3obj_FP.fSTG.count do
		(
			M3F_FillProgressLv()
			append this.sAnimProp (M3S_ScAnimProp.init m:m3obj_FP i:i)
			if(this.sAnimProp[i].tracksetsList.count > 0)then
			(
				append trackName (deepCopy this.sAnimProp[i].tracksetsList)
			)
		)
		M3F_FillProgressLv step:2 flag:#current

		--buildTrackSet
		for i=1 to trackName.count do
		(
			for n=1 to trackName[i].count do
			(
				appendIfUnique trackSets trackName[i][n]
			)
		)
		M3F_ShowPhase "Building TrackSet ..."
		print "Building TrackSet ..."
		format "TrackSetCount:%\n" trackSets.count
		for i=1 to trackSets.count do
		(
			M3F_FillProgressLv()
			append this.sTrackSet (M3S_ScTrackSet.init m:m3obj_FP t:trackSets[i])
		)
		M3F_FillProgressLv step:2 flag:#current

		--buildMaterials
		M3F_ShowPhase "Building Materials ..."
		print "Building Materials ..."
		format "MaterialsCount:%\n" m3obj_FP.fMATM.count
		for i=1 to m3obj_FP.fMATM.count do
		(
			M3F_FillProgressLv()
			append this.sMaterial \
			(M3S_ScMaterial.init m:m3obj_FP s:this.sAnimProp t:this.sTrackSet i:i)
		)
		M3F_FillProgressLv step:2 flag:#current

		--buildBones
		M3F_ShowPhase "Building Bones ..."
		print "Building Bones ..."
		format "BonesCount:%\n" m3obj_FP.fBONE.count
		for i=1 to m3obj_FP.fBONE.count do
		(
			M3F_FillProgressLv()
			append this.sBone \
			(M3S_ScBone.init m:m3obj_FP s:this.sAnimProp t:this.sTrackSet i:i)
			if(matchPattern this.sBone[i].nameStr pattern:"Evt_*" ignoreCase:false)then
			(
				append eventList i
			)
		)
		M3F_FillProgressLv step:2 flag:#current

		--buildEvents
		M3F_ShowPhase "Building Events ..."
		print "Building Events ..."
		format "EventCount:%\n"  eventList.count
		for i=1 to eventList.count do
		(
			M3F_FillProgressLv()
			append this.sEvent \
			(M3S_ScEvent.init m:m3obj_FP s:this.sAnimProp t:this.sTrackSet ib:eventList[i] i:i)
			append exceptBones this.sEvent[i].nbrBone
			append bonesType 1
		)
		
		--buildMeshes
		M3F_ShowPhase "Building Meshes ..."
		print "Building Meshes ..."
		if(m3obj_FP.fDIV.rfdREGN.data == undefined)then
		(
			format "MeshesCount:0\n"
		)else
		(
			format "MeshesCount:%\n" m3obj_FP.fDIV.rfdREGN.data.count
			for i=1 to m3obj_FP.fDIV.rfdREGN.data.count do
			(
				M3F_FillProgressLv()
				append this.sMesh (M3S_ScMesh.init m:m3obj_FP i:i)
				append exceptBones this.sMesh[i].rootBone
				append bonesType 2
			)
		)
		M3F_FillProgressLv step:2 flag:#current

		--buildLights
		M3F_ShowPhase "Building Lights ..."
		print "Building Lights ..."
		format "LightsCount:%\n" m3obj_FP.fLITE.count
		for i=1 to m3obj_FP.fLITE.count do
		(
			M3F_FillProgressLv()
			append this.sLight \
			(M3S_ScLight.init m:m3obj_FP s:this.sAnimProp t:this.sTrackSet i:i)
			append exceptBones this.sLight[i].nbrBone
			append bonesType 1
			append exceptBones this.sLight[i].targetBone
			append bonesType 1
		)
		M3F_FillProgressLv step:2 flag:#current

		--buildCameras
		M3F_ShowPhase "Building Cameras ..."
		print "Building Cameras ..."
		format "CamerasCount:%\n" m3obj_FP.fCAM.count
		for i=1 to m3obj_FP.fCAM.count do
		(
			M3F_FillProgressLv()
			append this.sCamera \
			(M3S_ScCamera.init m:m3obj_FP s:this.sAnimProp t:this.sTrackSet i:i)
			append exceptBones this.sCamera[i].nbrBone
			append bonesType 1
			append exceptBones this.sCamera[i].targetBone
			append bonesType 1
		)
		M3F_FillProgressLv step:2 flag:#current

		--buildParticles
		M3F_ShowPhase "Building Particles ..."
		print "Building Particles ..."
		format "ParticlesCount:%\n" m3obj_FP.fPAR.count
		for i=1 to m3obj_FP.fPAR.count do
		(
			M3F_FillProgressLv()
			append this.sParicle \
			(M3S_ScParicle.init m:m3obj_FP s:this.sAnimProp t:this.sTrackSet \
				i:i f:#par)
			append exceptBones this.sParicle[i].nbrBone
			append bonesType 1
		)
		format "RibbonsCount:%\n" m3obj_FP.fRIB.count
		for i=1 to m3obj_FP.fRIB.count do
		(
			M3F_FillProgressLv()
			append this.sParicle \
			(M3S_ScParicle.init m:m3obj_FP s:this.sAnimProp t:this.sTrackSet \
				i:i f:#rib)
			append exceptBones this.sParicle[this.sParicle.count].nbrBone
			append bonesType 1
			append exceptBones this.sParicle[this.sParicle.count].nbrSubBone
			append bonesType 1
		)
		format "ProjectorsCount:%\n" m3obj_FP.fPROJ.count
		for i=1 to m3obj_FP.fPROJ.count do
		(
			M3F_FillProgressLv()
			append this.sParicle \
			(M3S_ScParicle.init m:m3obj_FP s:this.sAnimProp t:this.sTrackSet \
				i:i f:#proj)
			append exceptBones this.sParicle[this.sParicle.count].nbrBone
			append bonesType 1
		)
		M3F_FillProgressLv step:2 flag:#current

		--buildPhysics
		M3F_ShowPhase "Building Physics ..."
		print "Building Physics ..."
		format "ForceCount:%\n" m3obj_FP.fFOR.count
		for i=1 to m3obj_FP.fFOR.count do
		(
			M3F_FillProgressLv()
			append this.sPhysics \
			(M3S_ScPhysics.init m:m3obj_FP s:this.sAnimProp t:this.sTrackSet \
				i:i f:#force)
			append exceptBones this.sPhysics[i].nbrBone
			append bonesType 1
		)
		format "WarpCount:%\n" m3obj_FP.fWRP.count
		for i=1 to m3obj_FP.fWRP.count do
		(
			M3F_FillProgressLv()
			append this.sPhysics \
			(M3S_ScPhysics.init m:m3obj_FP s:this.sAnimProp t:this.sTrackSet \
				i:i f:#warp)
			append exceptBones this.sPhysics[this.sPhysics.count].nbrBone
			append bonesType 1
		)
		format "RigedBodyCount:%\n" m3obj_FP.fPHRB.count
		for i=1 to m3obj_FP.fPHRB.count do
		(
			M3F_FillProgressLv()
			append this.sPhysics \
			(M3S_ScPhysics.init m:m3obj_FP s:this.sAnimProp t:this.sTrackSet \
				i:i f:#rigedbody)
			--append exceptBones this.sPhysics[this.sPhysics.count].nbrBone
			--append bonesType 1
		)
		format "JointCount:%\n" m3obj_FP.fPHYJ.count
		for i=1 to m3obj_FP.fPHYJ.count do
		(
			M3F_FillProgressLv()
			append this.sJoint (M3S_ScJoint.init m:m3obj_FP i:i)
		)
		M3F_FillProgressLv step:2 flag:#current

		--buildHelpers
		--M3F_ShowPhase " ..."
		M3F_ShowPhase "Building Helpers ..."
		print "Building Helpers ..."
		if(m3obj_FP.fMODL.tightTest.nbrBone < 0xFFFF)then
		(
			M3F_FillProgressLv()
			append this.sHelper (M3S_ScHelper.init m:m3obj_FP i:0 f:#tight)
			append exceptBones this.sHelper[1].nbrBone
			append bonesType 1
		)
		if(m3obj_FP.fMODL.rfdSSGS.data != undefined)then
		(
			format "fuzzyCount:%\n" m3obj_FP.fMODL.rfdSSGS.data.count
			for i=1 to m3obj_FP.fMODL.rfdSSGS.data.count do
			(
				M3F_FillProgressLv()
				append this.sHelper (M3S_ScHelper.init m:m3obj_FP i:i f:#fuzzy)
				append exceptBones this.sHelper[this.sHelper.count].nbrBone
				append bonesType 1
			)
		)else
		(
			format "fuzzyCount:0\n"
		)
		if(m3obj_FP.fMODL.rfdATVL.data != undefined)then
		(
			format "attVolCount:%\n" m3obj_FP.fMODL.rfdATVL.data.count
			for i=1 to m3obj_FP.fMODL.rfdATVL.data.count do
			(
				M3F_FillProgressLv()
				append this.sHelper (M3S_ScHelper.init m:m3obj_FP i:i f:#attvol)
				append exceptBones this.sHelper[this.sHelper.count].nbrBone
				append bonesType 1
			)
		)else
		(
			format "attVolCount:0\n"
		)
		format "attachCount:%\n" m3obj_FP.fATT.attachments.count
		for i=1 to m3obj_FP.fATT.attachments.count do
		(
			M3F_FillProgressLv()
			append this.sHelper (M3S_ScHelper.init m:m3obj_FP i:i f:#attach)
			append exceptBones this.sHelper[this.sHelper.count].nbrBone
			append bonesType 1
		)
		M3F_FillProgressLv step:2 flag:#current
		
		for i=1 to this.sBone.count do
		(
			this.sBone[i].buildBonesType exceptBones bonesType i
			--format "Name:% idx:% type:%\n" this.sBone[i].nameStr i this.sBone[i].boneType
		)
		M3F_FillProgressLv flag:#buildfinished
	),

	fn buildMaterialsData m3obj_FP =
	(
		local i
		--buildMaterials
		for i=1 to m3obj_FP.fMATM.count do
		(
			append this.sMaterial \
			(M3S_ScMaterial.init m:m3obj_FP s:this.sAnimProp t:this.sTrackSet i:i)
		)
	)
)

---------Test func
fn print_St st_FP s: =
(
	if s != unsupplied then
	(
		try
		(
			for i=1 to st_FP.count do
			(
				print st_FP[i] to:s
			)
		)catch(print st_FP to:s)
	)else
	(
		try
		(
			for i=1 to st_FP.count do
			(
				print st_FP[i]
			)
		)catch(print st_FP)
	)
)

/* Main Entries Functions */

fn M3F_ImportMain file_FP =
(
	local streamR
	streamR = fOpen file_FP "rb"

	M3F_FillProgressLv flag:#clear
	--M3F_Star2CustAttrInit()

	local m3model =  M3S_FileMain()
	local max_scene = M3S_SceneMain()

	m3model.read streamR
	max_scene.buildSceneData m3model
	max_scene.releaseData()

	fClose streamR
)