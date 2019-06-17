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
	iptType, flags, animID, initState, nullState, idx,
	fn init d1:0 d2:0 d3:0 d4:-1 s: t: =(),
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
fn M3F_GetGlobalSettings type_FP =
(
	local ret
	case type_FP of
	(
		#Cancel: ret = M3G_ImportInfo_Glb.cancelCheck
		#GlobalPos: ret = M3G_ImportInfo_Glb.setGPos.value
		#GlobalScale: ret = M3G_ImportInfo_Glb.setGScale.value

		#TrackEnable: ret = M3G_ImportInfo_Glb.impTrack.value
		#SeqEnable: ret = M3G_ImportInfo_Glb.impSeq.value
		#AnimEnable: ret = M3G_ImportInfo_Glb.impAnim.value

		#EventEnable: ret = M3G_ImportInfo_Glb.impEvt.value
		#TurretEnable: ret = M3G_ImportInfo_Glb.impTurt.value
		#BillBoardEnable: ret = M3G_ImportInfo_Glb.impBBrd.value
		#IKLegEnable: ret = M3G_ImportInfo_Glb.impIK.value

		#MatEnable: ret = M3G_ImportInfo_Glb.impMat.value
		#BoneEnable: ret = M3G_ImportInfo_Glb.impBone.value
		#MeshEnable: ret = M3G_ImportInfo_Glb.impMesh.value
		#SkinEnable: ret = M3G_ImportInfo_Glb.impSkin.value

		#HitEnable: ret = M3G_ImportInfo_Glb.impHit.value
		#VolEnable: ret = M3G_ImportInfo_Glb.impVol.value
		#AttEnable: ret = M3G_ImportInfo_Glb.impAttach.value
		#BoundEnable: ret = M3G_ImportInfo_Glb.impBound.value

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
			case M3G_ImportInfo_Glb.setWeldSmooth.value of
			(
				2:	ret = M3G_ImportInfo_Glb.setSmoothType.value
				5:	ret = M3G_ImportInfo_Glb.setSmoothType.value
				default: ret = 3
			)
		)
		#MeshSmoothAngle: ret = M3G_ImportInfo_Glb.setSmoothAngle.value
		#BoneEntity: ret = M3G_ImportInfo_Glb.setBEntity.value
		#BoneSize1: ret = M3G_ImportInfo_Glb.setBSize1.value
		#BoneSize2: ret = M3G_ImportInfo_Glb.setBSize2.value
		#BoneSize3: ret = M3G_ImportInfo_Glb.setBSize3.value
		#BoneAnim: ret = M3G_ImportInfo_Glb.setBAnim.value
		#BoneLink: ret = M3G_ImportInfo_Glb.setBLink.value
		#BoneFix: ret = M3G_ImportInfo_Glb.setBFix.value
		#BonePosCtl:
		(
			ret = case M3G_ImportInfo_Glb.setBPosCtl.value of
			(
				1: Position_XYZ
				2: bezier_position
				default: Position_XYZ
			)
		)
		#BoneRotCtl:
		(
			ret = case M3G_ImportInfo_Glb.setBRotCtl.value of
			(
				1: Euler_XYZ
				2: bezier_rotation
				default: Euler_XYZ
			)
		)
		#BoneScaleCtl:
		(
			ret = case M3G_ImportInfo_Glb.setBScaleCtl.value of
			(
				1: ScaleXYZ
				2: Bezier_Scale
				default: ScaleXYZ
			)
		)
		#AttSize: ret = M3G_ImportInfo_Glb.setAttSize.value
		#AttScale: ret = M3G_ImportInfo_Glb.setAttScale.value
		#BoundColl: ret = M3G_ImportInfo_Glb.setBoundColl.value
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
			if(M3F_GetGlobalSettings #Cancel)then(throw "Cancel")
		)
		#current:
		(
			M3G_ImportInfo_Glb.currProgLv += step
			local value = M3G_ImportInfo_Glb.currProgLv
			if(value > 100)then(value = 100.0)
			M3G_ImportInfo_Glb.MainUI.Import_subRoll.rollouts[1].FillProgressLv value
			if(M3F_GetGlobalSettings #Cancel)then(throw "Cancel")
		)
		#buildfinished:
		(
			local proportion = M3G_ImportInfo_Glb.currProgLv / 100.0
			M3G_ImportInfo_Glb.progressLv = M3G_ImportInfo_Glb.progressLv / (1 - proportion)
			M3G_ImportInfo_Glb.currProgLv = M3G_ImportInfo_Glb.progressLv * proportion
		)
		default:
		(
			M3G_ImportInfo_Glb.progressLv += step
		)
	)
	windows.processPostedMessages()
	setWaitCursor()
)

fn M3F_ShowPhase str_FP =
(
	M3G_ImportInfo_Glb.MainUI.Import_subRoll.rollouts[1].ChangePhaseText str_FP
)

fn M3F_ShowLogInfo str_FP type: =
(
	M3G_ImportInfo_Glb.DetailsUI.setLogInfo str_FP type:type
)

fn M3F_ShowPhaseInfo str_FP type:#Info =
(
	M3F_ShowPhase str_FP
	M3F_ShowLogInfo ("*****    " + str_FP + "    *****") type:type
)

fn M3F_ShowObjectCount str_FP count_FP =
(
	local string_temp = M3F_FormatToString "%Count:" #(str_FP)
	M3F_ShowLogInfo (string_temp + (count_FP as string))
)

fn M3F_MissingMap str_FP =
(
	appendIfUnique M3G_ImportInfo_Glb.missingMap str_FP
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
		#cloth: copys = (startools.behaviors.GetBehaviorDef #PhysicsCloth_Behavior)
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
		"MODL": case f of(0x17: 784;	0x1A: 820;	0x1D: 856)
		"SEQS": case f of(0x01: 96;		0x02: 92)
		"STC_": case f of(0x04: 204)
		"STG_": case f of(0x00: 24)
		"STS_": case f of(0x00: 28)
		"BONE": case f of(0x01: 160)
		"REGN": case f of(0x03: 36;		0x04: 40;	0x05: 48)
		"BAT_": case f of(0x01: 14)
		"DIV_": case f of(0x02: 52)
		"IREF": case f of(0x00: 64)
		"ATT_": case f of(0x01: 20)
		"LITE": case f of(0x07: 212)
		"CAM_": case f of(0x03: 180;	0x05:264)
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
		"REF_": case f of(0x02: 156)
		"LFLR": case f of(0x02: 80;		0x03: 152)
		"PAR_": case f of(0x0C: 1316;	0x12: 1464;	0x13: 1464;	0x15: 1464;	0x16: 1484; 0x17: 1492;	0x18: 1496)
		"PARC": case f of(0x00: 40)
		"RIB_": case f of(0x06: 748; 	0x08: 756;	0x09: 760)
		"PROJ": case f of(0x04: 388;	0x05: 388)
		"FOR_": case f of(0x01: 104;	0x02: 104)
		"WRP_": case f of(0x01: 132)
		"PHRB": case f of(0x02: 104;	0x04: 80)
		"PHYJ": case f of(0x00: 180)
		"PHCL": case f of(0x04: 192)
		"TRGD": case f of(0x00: 24)
		"PATU": case f of(0x04: 152)
		"BBSC": case f of(0x00: 48)
		"IKJT": case f of(0x00: 32)

		"EVNT": case f of(0x01: 104;	0x02: 108)
		"SSGS": case f of(0x01: 108)
		"LFSB": case f of(0x02: 56)
		"PHSH": case f of(0x01: 132;	0x03: 300)
		"DMMN": case f of(0x01: 8)
		"PHCC": case f of(0x00: 76)
		"PHAC": case f of(0x00: 32)
		"DMSE": case f of(0x00: 4)
	)
	if ret == undefined then ret = 0
	ret
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
		--Array
		"U32_": case flag_FP of(#U8: "U8Q"; #U16: "U16D")
		"U64_": case flag_FP of(#U16: "U16Q")
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
			#(M3F_CreateRawData d1:1 t:#v4d, M3F_CreateRawData d2:1 t:#v4d,
			M3F_CreateRawData d3:1 t:#v4d, M3F_CreateRawData d4:1 t:#v4d)
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
	eMin, eMax, rad
)
struct M3SD_TagData
(
	ofsData, nbr, flag
)
struct M3SD_VertData
(
	pos, weight, boneIdx, normal, uv = #(), vColor
)
struct M3SD_AttachData
(
	rfdName = M3SD_RefData(), nbrBone
)

struct M3SD_HitTest
(
	bone1, bone2, nbrBone, matrix, type, size0, size1, size2,
	rfdVertsPos = M3SD_RefData(), rfdFaces = M3SD_RefData(),

	fn init d1:0 d2:0 d3:0 d4:(M3F_CreateRawData t:#matrix) d5:0 d6:0 d7:0 d8:0 s: t: f: =
	(
		local hit_test
		try(hit_test = this)catch(hit_test = M3SD_HitTest())
		try(hit_test.read s t f:f)catch
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
		hit_test
	),

	fn read stream_FP tags_FP f:#normal =
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

		this.rfdVertsPos.readRef stream_FP
		this.rfdVertsPos.readData stream_FP tags_FP
		this.rfdFaces.readRef stream_FP
		this.rfdFaces.readData stream_FP tags_FP

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
	meshID, matID, nbrBone,

	fn init d1:0 d2:0 d3:0 s: =
	(
		local meshmat
		try(meshmat = this)catch(meshmat = M3SD_MeshMat())
		try(meshmat.read s)catch
		(
			meshmat.meshID = d1
			meshmat.matID = d2
			meshmat.nbrBone = d3
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
		this.nbrBone = readShort stream_FP #unsigned
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
	fresnelMode, fresnelExponent, fresnelMin, fresnelMax, fresnelConst, fresnelMask, fresnelRot,
	version,

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
		maplayer
	),

	fn read stream_FP tags_FP idx_FP = 
	(
		if(stream_FP == unsupplied)then(throw "unsupplied")
		local flag = tags_FP.tags[idx_FP].flag
		this.version = flag

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
		)else
		(
			this.rfaTriOffset.read stream_FP #v3d
			this.rfaTriScale.read stream_FP #v3d
		)
		M3F_SkipBytes stream_FP 4
		this.fresnelMode = readLong stream_FP #unsigned
		this.fresnelExponent = readFloat stream_FP
		this.fresnelMin = readFloat stream_FP
		this.fresnelMax = readFloat stream_FP
		if(flag == 0x16)then
		(
			this.fresnelConst = 0
			this.fresnelMask = M3F_CreateRawData d1:1.0 d2:1.0 d3:1.0 t:#v3d
			this.fresnelRot = M3F_CreateRawData t:#v2d
		)else
		(
			M3F_SkipBytes stream_FP 8
			this.fresnelConst = readFloat stream_FP
			this.fresnelMask = M3F_ReadRawData stream_FP #v3d
			this.fresnelRot = M3F_ReadRawData stream_FP #v2d
		)
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
	index, pos, sizeXY, scaleXY, fadeIn, fadeOut, colorAlpha, faceCenter, offset,

	fn init d1:0 d2:1 \
	d3:(M3F_CreateRawData t:#v2d) d4:(M3F_CreateRawData t:#v2d) \
	d5:(M3F_CreateRawData t:#v2d) d6:(M3F_CreateRawData t:#v2d) \
	d7:(M3F_CreateRawData t:#bgra) d8:0 d9:(M3F_CreateRawData t:#v2d) s: =
	(
		local sub_flare
		try(sub_flare = this)catch(sub_flare = M3SD_SubFlares())
		try(sub_flare.read s)catch
		(
			sub_flare.index = d1
			sub_flare.pos = d2
			sub_flare.sizeXY = d3
			sub_flare.scaleXY = d4
			sub_flare.fadeIn = d5
			sub_flare.fadeOut = d6
			sub_flare.colorAlpha = d7
			sub_flare.faceCenter = d8
			sub_flare.offset = d9
		)
		return sub_flare
	),

	fn read stream_FP = 
	(
		if(stream_FP == unsupplied)then(throw "unsupplied")

		this.index = readLong stream_FP #unsigned
		this.pos = readFloat stream_FP
		this.sizeXY = M3F_ReadRawData stream_FP #v2d
		this.scaleXY = M3F_ReadRawData stream_FP #v2d
		this.fadeIn = M3F_ReadRawData stream_FP #v2d
		this.fadeOut = M3F_ReadRawData stream_FP #v2d
		this.colorAlpha = M3F_ReadRawData stream_FP #bgra
		this.faceCenter = readLong stream_FP #unsigned
		this.offset = M3F_ReadRawData stream_FP #v2d
	)
)

struct M3SD_SubRibbon
(
	ribSpeed, subRibSpeed, nbrBone, yawType, pitchType, speedType,

	rfaSpeedMult =	M3SD_RefAnim(), rfaSubSpeedMult = M3SD_RefAnim(),
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
		M3F_SkipBytes stream_FP 	20
		this.ribSpeed = 			readFloat stream_FP
		M3F_SkipBytes stream_FP 	8
		this.subRibSpeed = 			readFloat stream_FP
		M3F_SkipBytes stream_FP 	12
		this.nbrBone = readLong 	stream_FP #unsigned
		this.rfaSpeedMult.read 		stream_FP #float
		this.rfaSubSpeedMult.read 	stream_FP #float
		this.yawType = 				readLong stream_FP #unsigned
		this.rfaYawAmp.read 		stream_FP #float
		this.rfaYawFreq.read 		stream_FP #float
		this.pitchType = 			readLong stream_FP #unsigned
		this.rfaPitchAmp.read 		stream_FP #float
		this.rfaPitchFreq.read 		stream_FP #float
		this.speedType = 			readLong stream_FP #unsigned
		this.rfaSpeedAmp.read 		stream_FP #float
		this.rfaSpeedFreq.read 		stream_FP #float
		this.rfaYaw.read 			stream_FP #float
		this.rfaPitch.read 			stream_FP #float
	)
)

struct M3SD_RigedBody
(
	matrix, shapeType, size0, size1, size2,
	rfdVertPos = M3SD_RefData(), rfdFaceNorm = M3SD_RefData(),
	rfdVertFace = M3SD_RefData(), rfdNormIdx = M3SD_RefData(),
	vertNbr, faceNbr, pairNbr,

	rfdNormMesh = M3SD_RefData(), rfdVertPosMesh = M3SD_RefData(),
	rfdFaceMesh = M3SD_RefData(),
	meshOffset, meshBoxSize, meshBoxOffset, normMeshNbr, vertMeshNbr, faceMeshNbr,

	fn init d1:(M3F_CreateRawData t:#matrix) d2:0 d3:0.25 d4:0.25 d5:0.25 \
	d6:(M3SD_RefData.init #()) d7:(M3SD_RefData.init #()) \
	d8:(M3SD_RefData.init #()) d9:(M3SD_RefData.init #()) d10:0 d11:0 d12:0 s: t: i: =
	(
		local riged_body
		try(riged_body = this)catch(riged_body = M3SD_RigedBody())
		try(riged_body.read s t i)catch
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
		riged_body
	),

	fn read stream_FP tags_FP idx_FP =
	(
		if(stream_FP == unsupplied)then(throw "unsupplied")
		local flag = tags_FP.tags[idx_FP].flag

		this.matrix = M3F_ReadRawData stream_FP #matrix

		if(flag == 0x01)then
		(
			this.vertNbr = 32
			M3F_SkipBytes stream_FP 4
			this.shapeType = readByte stream_FP #unsigned
			M3F_SkipBytes stream_FP 51
			this.size0 = readFloat stream_FP
			this.size1 = readFloat stream_FP
			this.size2 = readFloat stream_FP
		)else
		(
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
			M3F_SkipBytes stream_FP 8
			this.rfdNormMesh.readRef stream_FP
			this.rfdNormMesh.readData stream_FP tags_FP
			this.rfdVertPosMesh.readRef stream_FP
			this.rfdVertPosMesh.readData stream_FP tags_FP
			M3F_SkipBytes stream_FP 12
			this.rfdFaceMesh.readRef stream_FP
			this.rfdFaceMesh.readData stream_FP tags_FP c:7
			this.meshOffset = M3F_ReadRawData stream_FP #v3d
			this.meshBoxSize = M3F_ReadRawData stream_FP #v3d
			this.meshBoxOffset = M3F_ReadRawData stream_FP #v3d
			this.normMeshNbr = readLong stream_FP #unsigned
			this.vertMeshNbr = readLong stream_FP #unsigned
			M3F_SkipBytes stream_FP 4
			this.faceMeshNbr = readLong stream_FP #unsigned
			--M3F_SkipBytes stream_FP 16
		)
	)
)

struct M3SD_RBodyMeshInfo
(
	--This is incorrect !!!
	data1, data2, data3, data4,

	fn init d1:0 d2:0 d3:0 d4:0 s: =
	(
		local mesh_info
		try(mesh_info = this)catch(mesh_info = M3SD_RBodyMeshInfo())
		try(mesh_info.read s)catch
		(
			mesh_info.data1 = d1
			mesh_info.data2 = d2
			mesh_info.data3 = d3
			mesh_info.data4 = d4
		)
		mesh_info
	),

	fn read stream_FP =
	(
		if(stream_FP == unsupplied)then(throw "unsupplied")

		this.data1 = ReadShort stream_FP #unsigned
		this.data2 = ReadShort stream_FP #unsigned
		this.data3 = ReadShort stream_FP #unsigned
		this.data4 = ReadShort stream_FP #unsigned
	)
)

struct M3SD_ClothCollider
(
	matrix, radius, height,

	fn init d1:(M3F_CreateRawData t:#matrix) d2:0.25 d3:0.25 s: =
	(
		local cloth_collider
		try(cloth_collider = this)catch(cloth_collider = M3SD_ClothCollider())
		try(cloth_collider.read s)catch
		(
			cloth_collider.matrix = d1
			cloth_collider.radius = d2
			cloth_collider.height = d3
		)
		cloth_collider
	),

	fn read stream_FP =
	(
		if(stream_FP == unsupplied)then(throw "unsupplied")

		this.matrix = M3F_ReadRawData stream_FP #matrix
		this.radius = readFloat stream_FP
		this.height = readFloat stream_FP
		M3F_SkipBytes stream_FP 4
	)
)

struct M3SD_ClothProxy
(
	proxyIdx, clothIdx, rfdProxyVert = M3SD_RefData(), rfdProxyWeight = M3SD_RefData(),

	fn init d1:0 d2:0 d3:(M3SD_RefData.init #()) d4:(M3SD_RefData.init #()) s: t: =
	(
		local cloth_proxy
		try(cloth_proxy = this)catch(cloth_proxy = M3SD_ClothProxy())
		try(cloth_proxy.read s t)catch
		(
			cloth_proxy.proxyIdx = d1
			cloth_proxy.clothIdx = d2
			cloth_proxy.rfdProxyVert = d3
			cloth_proxy.rfdProxyWeight = d4
		)
		cloth_proxy
	),

	fn read stream_FP tags_FP =
	(
		if(stream_FP == unsupplied)then(throw "unsupplied")

		this.proxyIdx = readLong stream_FP #unsigned
		this.clothIdx = readLong stream_FP #unsigned
		this.rfdProxyVert.readRef stream_FP
		this.rfdProxyVert.readData stream_FP tags_FP f:#U16
		this.rfdProxyWeight.readRef stream_FP
		this.rfdProxyWeight.readData stream_FP tags_FP f:#U8
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
		ref_anim
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
		ref_data
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
		return (
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

	fn readData stream_FP tags_FP f:#null c:1 =
	(
		if(stream_FP == unsupplied)then(throw "unsupplied")
		try(local str = tags_FP.nameStr[this.ref])catch(return undefined)
		local i, n
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
				"U8Q": append this.data \
				#(
					readByte stream_FP #unsigned, readByte stream_FP #unsigned,
					readByte stream_FP #unsigned, readByte stream_FP #unsigned
				)
				"I16_": append this.data (readShort stream_FP #signed)
				"U16_": append this.data (readShort stream_FP #unsigned)
				"U16D": append this.data #(readShort stream_FP #unsigned,readShort stream_FP #unsigned)
				"U16Q": append this.data \
				#(
					readShort stream_FP #unsigned, readShort stream_FP #unsigned,
					readShort stream_FP #unsigned, readShort stream_FP #unsigned
				)
				"I32_": append this.data (readLong stream_FP #signed)
				"U32_": append this.data (readLong stream_FP #unsigned)
				"MT32": append this.data (for n=1 to c collect (readLong stream_FP #unsigned))
				"U64_": append this.data (readLongLong stream_FP #unsigned)
				"VEC2": append this.data (M3F_ReadRawData stream_FP #v2d)
				"VEC3": append this.data (M3F_ReadRawData stream_FP #v3d)
				"VEC4": append this.data (M3F_ReadRawData stream_FP #v4d)
				"QUAT": append this.data (M3F_ReadRawData stream_FP #quat)
				"REAL": append this.data (readFloat stream_FP)
				"SVC3": append this.data (M3SD_RefAnim.init s:stream_FP t:#v3d)
				"COL":  append this.data (M3F_ReadRawData stream_FP #bgra)
				"DMSE": append this.data (M3F_ReadRawData stream_FP #bgra)
				"FLAG": append this.data (readLong stream_FP #unsigned)
				"BNDS": append this.data (M3F_ReadRawData stream_FP #sphere)
				"SR32": append this.data (M3SD_RefAnim.init s:stream_FP t:#float)
				--Extern Types
				"SSGS": append this.data (M3SD_HitTest.init s:stream_FP t:tags_FP)
				"ATVL": append this.data (M3SD_HitTest.init s:stream_FP t:tags_FP f:#attachvol)
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
				"PHSH":(this.data = (M3SD_RigedBody.init s:stream_FP t:tags_FP i:this.ref);exit)
				"PHCC": append this.data (M3SD_ClothCollider.init s:stream_FP)
				"PHAC":(this.data = (M3SD_ClothProxy.init s:stream_FP t:tags_FP);exit)
				"DMMN": append this.data (M3SD_ClothCollider.init s:stream_FP)
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
		this.tightTest.read stream_FP tags_FP
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
	frequency, replayStart, replayEnd, bndSphere = M3SD_BndSphere(),

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
		local flag = tags_FP.tags[idx_FP].flag

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
		if(flag == 0x01)then(M3F_SkipBytes stream_FP 8)else(M3F_SkipBytes stream_FP 4)
		this.bndSphere.eMin = M3F_ReadRawData stream_FP #v3d
		this.bndSphere.eMax = M3F_ReadRawData stream_FP #v3d
		this.bndSphere.rad = readFloat stream_FP
		M3F_SkipBytes stream_FP 4
	),
	fn write =()
)

struct M3S_STC
(
	rfdName = M3SD_RefData(), runsConcurrent, animPriority,
	idxSTS, rfdAnimID = M3SD_RefData(), rfdAnimRef = M3SD_RefData(),
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
		M3F_SkipBytes stream_FP 2
		--this.idxSTG = readShort stream_FP #unsigned
		this.rfdAnimID.readRef stream_FP
		this.rfdAnimID.readData stream_FP tags_FP
		this.rfdAnimRef.readRef stream_FP
		this.rfdAnimRef.readData stream_FP tags_FP f:#U16
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
		local i, m, size, nbr
		local has_color = false

		if((this.vFlags.valGet()) == 0)then
		(
			fSeek stream_FP 128 #seek_set
			this.vFlags.valSet (readLong stream_FP #unsigned)
		)
		M3F_ShowLogInfo ("VertexFlag: " + formattedprint (this.vFlags.valGet()) format:"0#8x") type:#Info

		fSeek stream_FP (M3F_FindStart stream_FP tags_FP idx_FP 1) #seek_set

		this.nbrUVs = 0
		if(this.vFlags.bitGet 10)then(has_color = true)
		if(this.vFlags.bitGet 18)then(this.nbrUVs+= 1)
		if(this.vFlags.bitGet 19)then(this.nbrUVs+= 1)
		if(this.vFlags.bitGet 20)then(this.nbrUVs+= 1)
		if(this.vFlags.bitGet 21)then(this.nbrUVs+= 1)
		if(this.vFlags.bitGet 30)then(this.nbrUVs+= 1)
		size = if(has_color)then(32 + (this.nbrUVs * 4))else(28 + (this.nbrUVs * 4))
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

			if(has_color)then(vert.vColor = M3F_ReadRawData stream_FP #bgra)
			for m=1 to this.nbrUVs do
			(
				append vert.uv [ReadShort stream_FP, ReadShort stream_FP]
			)
			M3F_SkipBytes stream_FP 4

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
	nbrBone, rfdName = M3SD_RefData(), useVertFOV, dofType,
	rfaFOV = M3SD_RefAnim(),
	rfaFarClip = M3SD_RefAnim(), rfaNearClip = M3SD_RefAnim(),
	rfaSClipDis = M3SD_RefAnim(), rfaFocusDis = M3SD_RefAnim(),
	rfaFFocusRange = M3SD_RefAnim(), rfaNFocusRange = M3SD_RefAnim(),
	rfaNFalloffStart = M3SD_RefAnim(), rfaNFalloffEnd = M3SD_RefAnim(),
	rfaDOFamount = M3SD_RefAnim(),
	rfaBokehFStop = M3SD_RefAnim(), rfaBokehMaxCoCDiameter = M3SD_RefAnim(),

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
		local flag = tags_FP.tags[idx_FP].flag

		this.nbrBone = readLong stream_FP #unsigned
		this.rfdName.readRef stream_FP
		this.rfdName.readData stream_FP tags_FP
		this.rfaFOV.read stream_FP #float
		this.useVertFOV = readLong stream_FP #unsigned
		if(flag == 0x05)then(this.dofType = readLong stream_FP #unsigned)
		else(this.dofType = 3)
		this.rfaFarClip.read stream_FP #float
		this.rfaNearClip.read stream_FP #float
		this.rfaSClipDis.read stream_FP #float
		this.rfaFocusDis.read stream_FP #float
		this.rfaFFocusRange.read stream_FP #float
		this.rfaNFocusRange.read stream_FP #float
		if(flag == 0x05)then
		(
			this.rfaNFalloffStart.read stream_FP #float
			this.rfaNFalloffEnd.read stream_FP #float
		)else
		(
			this.rfaNFalloffStart.init t:#float
			this.rfaNFalloffEnd.init t:#float
		)
		this.rfaDOFamount.read stream_FP #float
		if(flag == 0x05)then
		(
			this.rfaBokehFStop.read stream_FP #float
			this.rfaBokehMaxCoCDiameter.read stream_FP #float
		)else
		(
			this.rfaBokehFStop.init t:#float
			this.rfaBokehMaxCoCDiameter.init t:#float
		)
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
	specMult, emisMult, envConstMult, envDiffMult, envSpecMult,
	EnvBlendType, emisBlendType1, emisBlendType2, GlossType,
	rfdMapLayrs = #(), rfaParallaxHeight = M3SD_RefAnim(), ar2 = M3SD_RefAnim(),
	rfdNormBlend = M3SD_RefData(),
	version,

	fn init s: t: i: n: =
	(
		local this_item
		try(this_item = this)catch(this_item = M3S_MAT())
		try(this_item.read s t i n)catch()
		this_item
	),
	fn read stream_FP tags_FP idx_FP nbr_FP =
	(
		if(stream_FP == unsupplied)then(throw "unsupplied")
		local i
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
		
		if(this.version == 0x14)then
		(
			this.envConstMult = readFloat stream_FP
			this.envDiffMult = readFloat stream_FP
			this.envSpecMult = readFloat stream_FP
		)else
		(
			this.envConstMult = 1.0
			this.envDiffMult = 0
			this.envSpecMult = 0
		)

		local nbr_layer = case this.version of
		(
			0x0F: 13
			0x10: 14
			0x11: 14
			0x12: 14
			0x13: 18
			0x14: 18
			default: 14
		)

		for i=1 to nbr_layer do
		(
			local layer = M3SD_RefData.init #() s:stream_FP t:tags_FP
			append this.rfdMapLayrs layer
			if(this.version == 0x0F and i == 3)then
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

		if(this.version == 0x14)then
		(
			this.rfdNormBlend.readRef stream_FP
			this.rfdNormBlend.readData stream_FP tags_FP
		)else
		(
			local init_temp = for i=1 to 8 collect(M3SD_RefAnim.init t:#float)
			this.rfdNormBlend.init init_temp
		)
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
struct M3S_REF
(
	rfdName = M3SD_RefData(), refFlags = M3SD_Flag(),
	rfdRefectMap = M3SD_RefData(), rfdDispMap = M3SD_RefData(), rfdBlurMap = M3SD_RefData(),

	rfaRefectStg = M3SD_RefAnim(), rfaRefectOffset = M3SD_RefAnim(),
	rfaDispStg = M3SD_RefAnim(),
	rfaBlurAngle = M3SD_RefAnim(), rfaBlurDisMax = M3SD_RefAnim(),

	fn init s: t: i: n: =
	(
		local this_item
		try(this_item = this)catch(this_item = M3S_REF())
		try(this_item.read s t i n)catch()
		this_item
	),
	fn read stream_FP tags_FP idx_FP nbr_FP =
	(
		if(stream_FP == unsupplied)then(throw "unsupplied")
		fSeek stream_FP (M3F_FindStart stream_FP tags_FP idx_FP nbr_FP) #seek_set
		--local flag = tags_FP.tags[idx_FP].flag

		this.rfdName.readRef stream_FP
		this.rfdName.readData stream_FP tags_FP
		M3F_SkipBytes stream_FP 4

		this.rfaRefectStg.read stream_FP #float
		this.rfaDispStg.read stream_FP #float
		this.rfaRefectOffset.read stream_FP #float
		this.rfaBlurAngle.read stream_FP #float
		this.rfaBlurDisMax.read stream_FP #float

		this.rfdRefectMap.readRef stream_FP
		this.rfdRefectMap.readData stream_FP tags_FP
		this.rfdDispMap.readRef stream_FP
		this.rfdDispMap.readData stream_FP tags_FP
		this.rfdBlurMap.readRef stream_FP
		this.rfdBlurMap.readData stream_FP tags_FP

		this.refFlags.valSet (readLong stream_FP #unsigned)
	),
	fn write =()
)
struct M3S_LFLR
(
	rfdName = M3SD_RefData(), rfdFlareMap = M3SD_RefData(),
	rfdMaskMap = M3SD_RefData(), rfdSubFlares = M3SD_RefData(),
	columns, rows, disFade, rfdLibName = M3SD_RefData(),
	rfaHDR = M3SD_RefAnim(), rfaColor = M3SD_RefAnim(),
	rfaIntensity = M3SD_RefAnim(), rfaSize = M3SD_RefAnim(),

	fn init s: t: i: n: =
	(
		local this_item
		try(this_item = this)catch(this_item = M3S_LFLR())
		try(this_item.read s t i n)catch()
		this_item
	),
	fn read stream_FP tags_FP idx_FP nbr_FP =
	(
		if(stream_FP == unsupplied)then(throw "unsupplied")
		fSeek stream_FP (M3F_FindStart stream_FP tags_FP idx_FP nbr_FP) #seek_set
		local flag = tags_FP.tags[idx_FP].flag

		this.rfdName.readRef stream_FP
		this.rfdName.readData stream_FP tags_FP
		this.rfdFlareMap.readRef stream_FP
		this.rfdFlareMap.readData stream_FP tags_FP
		this.rfdMaskMap.readRef stream_FP
		this.rfdMaskMap.readData stream_FP tags_FP
		this.rfdSubFlares.readRef stream_FP
		this.rfdSubFlares.readData stream_FP tags_FP
		this.columns = readLong stream_FP #unsigned
		this.rows = readLong stream_FP #unsigned
		this.disFade = readFloat stream_FP

		case flag of
		(
			2:
			(
				this.rfdLibName.init ""
				this.rfaColor.init t:#bgra
				this.rfaColor.initState = [255,255,255,255]
				this.rfaHDR.init t:#float
				this.rfaHDR.initState = 1.0
				this.rfaSize.init t:#float
				this.rfaSize.initState = 1.0

				this.rfaIntensity.read stream_FP #float
			)
			3:
			(
				this.rfdLibName.readRef stream_FP
				this.rfdLibName.readData stream_FP tags_FP
				this.rfaIntensity.read stream_FP #float
				this.rfaColor.read stream_FP #bgra
				this.rfaHDR.read stream_FP #float
				this.rfaSize.read stream_FP #float
			)
		)
	),
	fn write =()
)
--Particle STRUCT--------------------------------------------
struct M3S_PAR
(
	nbrBone, matIdx, rfdCopyIdx = M3SD_RefData(),
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
	pGravity, pDrag, pMass, pMassR, pMassSizeMult, pMassMult, pLocalChns,
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
		this_item
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
		this.rfaIVHorz.read 		stream_FP #float
		this.rfaIVvert.read 		stream_FP #float
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
			local mass_range = readLong stream_FP #unsigned
			if(mass_range != 0)then(this.parFlags.bits[3] = true)
			this.pMass = 			readFloat stream_FP
			this.pMassR = 			readFloat stream_FP
		)else
		(
			this.pMass = 			readFloat stream_FP
			this.pMassR = 			readFloat stream_FP
		)
		this.pMassSizeMult =		readFloat stream_FP

		if(flag == 0x0C)then
		(
			local world_space = readLong stream_FP #unsigned
			if(world_space != 0)then(this.parFlags.bits[4] = true)
		)
		this.pLocalChns = 			readLong stream_FP #unsigned
		M3F_SkipBytes stream_FP 4
		if(flag == 0x18)then
		(this.pMassMult = 			readFloat stream_FP)
		else(this.pMassMult = 		1.0)
		
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
		this.colSpawnMin = 			readLong stream_FP #unsigned
		this.colSpawnMax = 			readLong stream_FP #unsigned
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

		if(flag <= 0x15)then
		(
			this.rfaOverlay.init 	t:#float
		)else
		(
			this.rfaOverlay.read 	stream_FP #float
		)
		
		this.parFlags1.valSet		(readLong stream_FP #unsigned)
		if(flag == 0x0C)then(M3F_SkipBytes stream_FP 4)
		this.parFlags2.valSet		(readLong stream_FP #unsigned)

		if(flag == 0x0C)then
		(
			if(this.parFlags1.bits[22])then(this.parFlags2.bits[2] = true)
			M3F_SkipBytes stream_FP 4
			this.colorSmootying = 0
			this.sizeSmootying = 0
			this.rotSmootying = 0
			this.rfaAlphaThold.init t:#float
			this.rfaUVoffset.init 	t:#v2d
			this.rfaAngle.init 		t:#v3d
			this.rfaUVtill.init 	t:#v2d
			this.rfdSplatLine.init 	undefined
		)else
		(
			this.colorSmootying = 	readLong stream_FP #unsigned
			this.sizeSmootying = 	readLong stream_FP #unsigned
			this.rotSmootying = 	readLong stream_FP #unsigned
			this.rfaAlphaThold.read 	stream_FP #float
			this.rfaUVoffset.read 		stream_FP #v2d
			this.rfaAngle.read 			stream_FP #v3d
			this.rfaUVtill.read 		stream_FP #v2d
			this.rfdSplatLine.readRef 	stream_FP
			this.rfdSplatLine.readData 	stream_FP tags_FP
		)

		this.pWindMult = 			readFloat stream_FP
		this.pLODreduce = 			readLong stream_FP #unsigned
		this.pLODcut = 				readLong stream_FP #unsigned

		this.rfaLowBound.read 		stream_FP #float
		this.rfaUpBound.read 		stream_FP #float
		this.trailLinkIdx = 		readLong stream_FP
		this.trailChance = 			readFloat stream_FP
		this.rfaTrailEmissRate.read stream_FP #float
		this.splatProjIdx = 		readLong stream_FP #unsigned
		this.splatChance = 			readFloat stream_FP
		this.rfdModel.readRef 		stream_FP
		this.rfdModel.readData 		stream_FP tags_FP
		this.rfdCopyIdx.readRef		stream_FP
		this.rfdCopyIdx.readData 	stream_FP tags_FP
	),
	fn write =()
)
struct M3S_PARC
(
	nbrBone, rfaEmissRate = M3SD_RefAnim(), rfaSquirtAmount = M3SD_RefAnim(),

	fn init s: t: i: n: =
	(
		local this_item
		try(this_item = this)catch(this_item = M3S_PARC())
		try(this_item.read s t i n)catch()
		this_item
	),
	fn read stream_FP tags_FP idx_FP nbr_FP =
	(
		if(stream_FP == unsupplied)then(throw "unsupplied")
		fSeek stream_FP (M3F_FindStart stream_FP tags_FP idx_FP nbr_FP) #seek_set
		
		this.rfaEmissRate.read 		stream_FP #float
		this.rfaSquirtAmount.read 	stream_FP #uint16
		this.nbrBone = 				readLong stream_FP #unsigned
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
	pGravity, pDrag, pMass, pMassR, pMassSizeMult, pMassMult, pLocalChns,
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

		this.pMassSizeMult = 		readFloat stream_FP

		if(flag == 0x06)then
		(
			M3F_SkipBytes stream_FP 4
			this.ribFlags.valSet (readLong stream_FP #unsigned)
		)

		this.pLocalChns = 		readLong stream_FP #unsigned
		M3F_SkipBytes stream_FP 4
		if(flag == 0x09)then
		(this.pMassMult = 		readFloat stream_FP)
		else(this.pMassMult = 	1.0)

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
		this.splatAtt = readFloat stream_FP
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
		local flag = tags_FP.tags[idx_FP].flag

		this.fTypes = readLong stream_FP #unsigned
		this.fShapes = readLong stream_FP #unsigned
		M3F_SkipBytes stream_FP 4
		this.nbrBone = readLong stream_FP #unsigned
		this.fFlags.valSet (readLong stream_FP #unsigned)
		if(flag == 0x01)then(this.fFlags.bitSet 4; this.fFlags.bitSet 5)
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
		local flag = tags_FP.tags[idx_FP].flag

		if(flag == 0x02)then
		(
			this.simTypes = 1
			this.phyTypes = 0
			this.restitution = 0
			this.linearDamp = 0.01
			this.angularDamp = 0.01
			this.gravityScale = 1.0
			this.rfaDynamicState.init t:#uint32
			this.dynamicBlendOut = 1.0

			this.density = readFloat stream_FP
			this.friction = readFloat stream_FP
			M3F_SkipBytes stream_FP 52
			this.nbrBoneParent = readShort stream_FP #unsigned
			M3F_SkipBytes stream_FP 18
		)else
		(
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
		)
		
		this.rfdRigedBody.readRef stream_FP
		this.rfdRigedBody.readData stream_FP tags_FP

		this.pFlags.valSet (readLong stream_FP #unsigned)
		this.pLocalChns = readLong stream_FP #unsigned
		this.pPriority = readLong stream_FP #unsigned

		if(flag == 0x02)then(this.pFlags.bits[10] = true)
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
		this_item
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
		this.enableShape = readByte stream_FP #unsigned
	),
	fn write =()
)

struct M3S_PHCL
(
	nbrClothMesh, skinBoneCnt,
	rfdSkinBone = M3SD_RefData(), rfdSimEnabled = M3SD_RefData(),
	rfdVertBone = M3SD_RefData(), rfdVertWeight = M3SD_RefData(),
	rfdCollider = M3SD_RefData(), rfdProxy = M3SD_RefData(),

	clothDensity, tracking, stretchStiff, horzStiff, bendingStiff, damping,
	friction, clothGravity, explosionScale, windScale, shearStiff, dragFactor,
	liftFactor, sphereStiff, flatten,

	rfaActive = M3SD_RefAnim(),

	useSkinCollision, skinOffset, skinExponent, skinStiff,
	localChn, localWind,

	fn init s: t: i: n: =
	(
		local this_item
		try(this_item = this)catch(this_item = M3S_PHCL())
		try(this_item.read s t i n)catch()
		this_item
	),
	fn read stream_FP tags_FP idx_FP nbr_FP =
	(
		if(stream_FP == unsupplied)then(throw "unsupplied")
		fSeek stream_FP (M3F_FindStart stream_FP tags_FP idx_FP nbr_FP) #seek_set

		this.nbrClothMesh = readLong stream_FP #unsigned
		this.skinBoneCnt = readLong stream_FP #unsigned
		this.rfdSkinBone.readRef stream_FP
		this.rfdSkinBone.readData stream_FP tags_FP
		this.rfdSimEnabled.readRef stream_FP
		this.rfdSimEnabled.readData stream_FP tags_FP
		this.rfdVertBone.readRef stream_FP
		this.rfdVertBone.readData stream_FP tags_FP f:#U8
		this.rfdVertWeight.readRef stream_FP
		this.rfdVertWeight.readData stream_FP tags_FP f:#U8
		this.rfdCollider.readRef stream_FP
		this.rfdCollider.readData stream_FP tags_FP
		this.rfdProxy.readRef stream_FP
		this.rfdProxy.readData stream_FP tags_FP

		this.clothDensity = readFloat stream_FP
		this.tracking = readFloat stream_FP
		this.stretchStiff = readFloat stream_FP
		this.horzStiff = readFloat stream_FP
		this.bendingStiff = readFloat stream_FP
		this.damping = readFloat stream_FP
		this.friction = readFloat stream_FP
		this.clothGravity = readFloat stream_FP
		this.explosionScale = readFloat stream_FP
		this.windScale = readFloat stream_FP
		this.shearStiff = readFloat stream_FP
		this.dragFactor = readFloat stream_FP
		this.liftFactor = readFloat stream_FP
		this.sphereStiff = readFloat stream_FP
		this.flatten = readLong stream_FP #unsigned

		this.rfaActive.read stream_FP #uint32

		this.useSkinCollision = readLong stream_FP #unsigned
		this.skinOffset = readFloat stream_FP
		this.skinExponent = readFloat stream_FP
		this.skinStiff = readFloat stream_FP
		this.localChn = readLong stream_FP #unsigned
		this.localWind = M3F_ReadRawData stream_FP #v3d
	),
	fn write =()
)
--Misc STRUCT-----------------------------------------------
struct M3S_TRGD
(
	rfdName = M3SD_RefData(), rfdDataIdx = M3SD_RefData(),

	fn init s: t: i: n: =
	(
		local this_item
		try(this_item = this)catch(this_item = M3S_TRGD())
		try(this_item.read s t i n)catch()
		this_item
	),
	fn read stream_FP tags_FP idx_FP nbr_FP =
	(
		if(stream_FP == unsupplied)then(throw "unsupplied")
		fSeek stream_FP (M3F_FindStart stream_FP tags_FP idx_FP nbr_FP) #seek_set

		this.rfdDataIdx.readRef stream_FP
		this.rfdDataIdx.readData stream_FP tags_FP
		this.rfdName.readRef stream_FP
		this.rfdName.readData stream_FP tags_FP
	),
	fn write =()
)

struct M3S_PATU
(
	nbrBone, matrix, overrideAnim, useMain, groupID,
	yawLimited, yawMin, yawMax, yawWeight,
	pitchLimited, pitchMin, pitchMax, pitchWeight,

	fn init s: t: i: n: =
	(
		local this_item
		try(this_item = this)catch(this_item = M3S_PATU())
		try(this_item.read s t i n)catch()
		this_item
	),
	fn read stream_FP tags_FP idx_FP nbr_FP =
	(
		if(stream_FP == unsupplied)then(throw "unsupplied")
		fSeek stream_FP (M3F_FindStart stream_FP tags_FP idx_FP nbr_FP) #seek_set

		this.matrix = M3F_ReadRawData stream_FP #matrix
		M3F_SkipBytes stream_FP 28
		this.overrideAnim = readFloat stream_FP
		this.nbrBone = readShort stream_FP #unsigned
		this.useMain = readByte stream_FP #unsigned
		this.groupID = readByte stream_FP #unsigned

		this.yawLimited = readLong stream_FP #unsigned
		this.yawMin = readFloat stream_FP
		this.yawMax = readFloat stream_FP
		this.yawWeight = readFloat stream_FP
		this.pitchLimited = readLong stream_FP #unsigned
		this.pitchMin = readFloat stream_FP
		this.pitchMax = readFloat stream_FP
		this.pitchWeight = readFloat stream_FP
	),
	fn write =()
)

struct M3S_BBSC
(
	nbrBone, bbTypes, cameraLookAt,

	fn init s: t: i: n: =
	(
		local this_item
		try(this_item = this)catch(this_item = M3S_BBSC())
		try(this_item.read s t i n)catch()
		this_item
	),
	fn read stream_FP tags_FP idx_FP nbr_FP =
	(
		if(stream_FP == unsupplied)then(throw "unsupplied")
		fSeek stream_FP (M3F_FindStart stream_FP tags_FP idx_FP nbr_FP) #seek_set

		M3F_SkipBytes stream_FP 12
		this.nbrBone = readShort stream_FP #unsigned
		this.bbTypes = readByte stream_FP #unsigned
		this.cameraLookAt = readByte stream_FP #unsigned
	),
	fn write =()
)

struct M3S_IKJT
(
	nbrBone1, nbrBone2, raycastUp, raycastDn, maxSpeed, goalThreshold,

	fn init s: t: i: n: =
	(
		local this_item
		try(this_item = this)catch(this_item = M3S_IKJT())
		try(this_item.read s t i n)catch()
		this_item
	),
	fn read stream_FP tags_FP idx_FP nbr_FP =
	(
		if(stream_FP == unsupplied)then(throw "unsupplied")
		fSeek stream_FP (M3F_FindStart stream_FP tags_FP idx_FP nbr_FP) #seek_set

		M3F_SkipBytes stream_FP 12
		this.nbrBone1 = readShort stream_FP #unsigned
		this.nbrBone2 = readShort stream_FP #unsigned
		this.raycastUp = readFloat stream_FP
		this.raycastDn = readFloat stream_FP
		this.maxSpeed = readFloat stream_FP
		this.goalThreshold = readFloat stream_FP
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
	fVOL = #(), fCREP = #(), fVON = #(), fSTBM = #(), fREF = #(), fLFLR = #(),
	--Particle
	fPAR = #(), fPARC = #(), fRIB = #(), fPROJ = #(),
	--Physics
	fFOR = #(), fWRP = #(), fPHRB = #(), fPHYJ = #(), fPHCL =#(),
	--Misc
	fTRGD = #(), fPATU = #(), fBBSC = #(), fIKJT = #(),

	fn read stream_FP =
	(
		local i, m, nbr_tags
		local name_collect = #()

		this.fHeader.read stream_FP
		this.fTags.entry = this.fHeader.ofsTag
		nbr_tags = this.fHeader.nbrTag
		this.fTags.read stream_FP nbr_tags

		for i=1 to nbr_tags do
		(
			if((findItem name_collect this.fTags.nameStr[i]) == 0)then
			(
				appendIfUnique name_collect this.fTags.nameStr[i]
				format "% flag:% cnt:%\n" \
					this.fTags.nameStr[i] \
					(formattedPrint this.fTags.tags[i].flag format:"0#2x") \
					this.fTags.tags[i].nbr
			)
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

				"REF_": for m=1 to this.fTags.tags[i].nbr do
				(append this.fREF (M3S_REF.init s:stream_FP t:this.fTags i:i n:m))

				"LFLR": for m=1 to this.fTags.tags[i].nbr do
				(append this.fLFLR (M3S_LFLR.init s:stream_FP t:this.fTags i:i n:m))

				"PAR_": for m=1 to this.fTags.tags[i].nbr do
				(append this.fPAR (M3S_PAR.init s:stream_FP t:this.fTags i:i n:m))

				"PARC": for m=1 to this.fTags.tags[i].nbr do
				(append this.fPARC (M3S_PARC.init s:stream_FP t:this.fTags i:i n:m))

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

				"PHCL": for m=1 to this.fTags.tags[i].nbr do
				(append this.fPHCL (M3S_PHCL.init s:stream_FP t:this.fTags i:i n:m))

				"TRGD": for m=1 to this.fTags.tags[i].nbr do
				(append this.fTRGD (M3S_TRGD.init s:stream_FP t:this.fTags i:i n:m))

				"PATU": for m=1 to this.fTags.tags[i].nbr do
				(append this.fPATU (M3S_PATU.init s:stream_FP t:this.fTags i:i n:m))

				"BBSC": for m=1 to this.fTags.tags[i].nbr do
				(append this.fBBSC (M3S_BBSC.init s:stream_FP t:this.fTags i:i n:m))

				"IKJT": for m=1 to this.fTags.tags[i].nbr do
				(append this.fIKJT (M3S_IKJT.init s:stream_FP t:this.fTags i:i n:m))

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
		this.fREF = #()
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

				"REF_": for m=1 to this.fTags.tags[i].nbr do
				(append this.fREF (M3S_REF.init s:stream_FP t:this.fTags i:i n:m))

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
fn M3F_GetProperty obj_FP property_FP =
(
	local i
	local obj_temp = obj_FP
	local properties = filterString property_FP "."

	for i=1 to properties.count do
	(
		if(matchPattern properties[i] pattern:"*[*]")then
		(
			local string_list = filterString properties[i] "[]"
			local temp = (getProperty obj_temp string_list[1])[(string_list[2] as integer)]
			local obj_temp = temp
		)else
		(
			local temp = getProperty obj_temp properties[i]
			local obj_temp = temp
		)
	)
	obj_temp
)

fn M3F_ArrayCopy src_FP =
(
	local i
	local ret_obj = #()

	for i=1 to src_FP.count do
	(
		local check_props = src_FP[i]
		case (classOf check_props) of
		(
			UndefinedClass: append ret_obj undefined
			UnsuppliedClass: append ret_obj unsupplied
			BooleanClass: append ret_obj check_props
			Integer: append ret_obj check_props
			Float: append ret_obj check_props
			Time: append ret_obj check_props
			Name: append ret_obj check_props
			String: append ret_obj (copy check_props)
			Point2: append ret_obj (copy check_props)
			Point3: append ret_obj (copy check_props)
			Point4: append ret_obj (copy check_props)
			Color: append ret_obj (copy check_props)
			Quat: append ret_obj (copy check_props)
			Matrix3: append ret_obj (copy check_props)
			BitArray: append ret_obj (copy check_props)
			Array: append ret_obj (M3F_ArrayCopy check_props)
			MAXScriptFunction: append ret_obj (copy check_props)
			default:
			(
				case (superClassOf check_props) of
				(
					StructDef: append ret_obj (M3F_StructCopy check_props)
					GeometryClass: append ret_obj check_props
					light: append ret_obj check_props
					camera: append ret_obj check_props
					helper: append ret_obj check_props
					default: format "Bad array copy:%\n" check_props
				)
			)
		)
	)
	ret_obj
)

fn M3F_StructCopy src_FP =
(
	local i
	local ret_obj = (classOf src_FP)()
	local props_temp = getPropNames src_FP
	
	for i=1 to props_temp.count do
	(
		local check_props = getProperty src_FP props_temp[i]
		case (classOf check_props) of
		(
			UndefinedClass: setProperty ret_obj props_temp[i] undefined
			UnsuppliedClass: setProperty ret_obj props_temp[i] unsupplied
			BooleanClass: setProperty ret_obj props_temp[i] check_props
			Integer: setProperty ret_obj props_temp[i] check_props
			Float: setProperty ret_obj props_temp[i] check_props
			Time: setProperty ret_obj props_temp[i] check_props
			Name: setProperty ret_obj props_temp[i] check_props
			String: setProperty ret_obj props_temp[i] (copy check_props)
			Point2: setProperty ret_obj props_temp[i] (copy check_props)
			Point3: setProperty ret_obj props_temp[i] (copy check_props)
			Point4: setProperty ret_obj props_temp[i] (copy check_props)
			Color: setProperty ret_obj props_temp[i] (copy check_props)
			Quat: setProperty ret_obj props_temp[i] (copy check_props)
			Matrix3: setProperty ret_obj props_temp[i] (copy check_props)
			BitArray: setProperty ret_obj props_temp[i] (copy check_props)
			Array: setProperty ret_obj props_temp[i] (M3F_ArrayCopy check_props)
			MAXScriptFunction: ()
			default:
			(
				case (superClassOf check_props) of
				(
					StructDef: setProperty ret_obj props_temp[i] (M3F_StructCopy check_props)
					GeometryClass: setProperty ret_obj props_temp[i] check_props
					light: setProperty ret_obj props_temp[i] check_props
					camera: setProperty ret_obj props_temp[i] check_props
					helper: setProperty ret_obj props_temp[i] check_props
					default: format "Bad struct copy:%\n" check_props
				)
			)
		)
	)
	ret_obj
)

fn M3F_AddToLayer name_FP obj_FP =
(
	local layer = LayerManager.GetLayerFromName name_FP
	if(layer == undefined)then
	(
		layer = LayerManager.NewLayerFromName name_FP
	)
	layer.addNode obj_FP
)

fn M3F_CopyController obj_FP target_FP type:#all =
(
	if(type == #all or type == #rot)then
	(
		obj_FP.rotation.controller = target_FP.rotation.controller
		obj_FP.rotation.controller = (classOf obj_FP.rotation.controller)()
		if(classOf obj_FP.rotation.controller == Euler_XYZ)then
		(
			obj_FP.rotation.controller.X_Rotation.controller = bezier_float()
			obj_FP.rotation.controller.Y_Rotation.controller = bezier_float()
			obj_FP.rotation.controller.Z_Rotation.controller = bezier_float()
		)
	)
	if(type == #all or type == #pos)then
	(
		obj_FP.position.controller = target_FP.position.controller
		obj_FP.position.controller = (classOf obj_FP.position.controller)()
		if(classOf obj_FP.position.controller == Position_XYZ)then
		(
			obj_FP.pos.controller.X_Position.controller = bezier_float()
			obj_FP.pos.controller.Y_Position.controller = bezier_float()
			obj_FP.pos.controller.Z_Position.controller = bezier_float()
		)
	)
	if(type == #all or type == #scale)then
	(
		obj_FP.scale.controller = target_FP.scale.controller
		obj_FP.scale.controller = (classOf obj_FP.scale.controller)()
		if(classOf obj_FP.scale.controller == ScaleXYZ)then
		(
			obj_FP.scale.controller.x_scale.controller = bezier_float()
			obj_FP.scale.controller.y_scale.controller = bezier_float()
			obj_FP.scale.controller.z_scale.controller = bezier_float()
		)
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

fn M3F_GetMatrixFromVector vec_FP z:[0,0,1] =
(
	local temp_bone = BoneSys.CreateBone [0,0,0] vec_FP z
	local ret_matrix = temp_bone.transform
	delete temp_bone
	ret_matrix
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
	try
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
			#matrix:
			(
				matrix3 val_FP[1] val_FP[2] val_FP[3] val_FP[4]
			)
			#boundpos:
			(
				(val_FP[1] + val_FP[2]) / 2
			)
			#boundradius: [val_FP[3], val_FP[3], val_FP[3]]
			default:(val_FP)
			#fovVH:(atan(tan(val_FP / 2) * 4 / 3) * 2)
		)
		ret
	)catch(val_FP)
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
				if(n > 1)then
				(
					local last_ftime = frames_FP[n-1] * glb_frame_rate / 1000.0
					local linear_amp = (lens + 1 - last_ftime) / (ftime - last_ftime)

					case classOf dkey_data_end of
					(
						Integer:
						(
							local float_temp = dkey_data_cur + (dkey_data_end - dkey_data_cur) * linear_amp
							if(float_temp > 0)then(dkey_data_end = (float_temp + 0.5) as Integer)
							else(dkey_data_end = (float_temp - 0.5) as Integer)
						)
						BooleanClass:()
						default:
						(
							try
							(
								dkey_data_end = dkey_data_cur + (dkey_data_end - dkey_data_cur) * linear_amp
							)catch()
						)
					)
				)
			)
			continue
		)
		local itime = (floor ftime) as Integer
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
	seq: m3: c:false mult:1.0 type: trk: tp: anim: ea:true temp: =
(
	case flag_FP of
	(
		#fromfile:
		(
			local m3_object = M3F_GetProperty obj2_FP str2_FP
			local this_object = M3F_GetProperty obj1_FP str1_FP
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

						--if(temp == #start)then
						--(
						--	for m=1 to frames.count do
						--	(
						--		format "% f:% k:%\n" i frames[m] keys[m]
						--	)
						--)

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

			if(this_object.frames[1] == -1 or ea == false)then
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
				--BezierDefaultParams.inTangentType = #linear
				--BezierDefaultParams.outTangentType = #linear
				
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
		if(dir == #toscene and this.MapType != 1 and this.MapType != 2)then(return false)
		case dir of
		(
			#fromfile:
			(
				if(this.MapType == 1)then
				(
					/*
					format "name:% flag:% uvmapping:%\n" \
						source_FP.rfdName.data \
						(formattedprint (source_FP.flags.valGet()) format:"0#8x") \
						source_FP.mapping
					--*/

					this.UVMapping = case source_FP.mapping of
					(
						0:	--UV1 or UV2
						(
							if(source_FP.flags.bits[14])then(1)else(0)
						)
						1: 1	--UV2
						2: 2	--Reflective Cubic Env
						3: 3
						4: 4
						5: 5
						6:	--Particle UV1 or UV2
						(
							if(source_FP.flags.bits[14])then(1)else(0)
						)
						7: 6
						8: 7
						9: 8	--UV3
						10: 9	--UV4
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

				local mode_temp = if(source_FP.fresnelConst < 0 and source_FP.fresnelMode != 0)then(1)else(0)
				this.FresnelMode = source_FP.fresnelMode + mode_temp
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
				M3F_DataApply dir this source_FP "FresnelMode" 			""
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
	NormBlendEnable,
	TwoSided,
	Unlit,
	CastShadows,
	HitTest,
	RecvShadows,
	TranslucencyDepthWrite,
	SimulateRoughness,
	PerPixelForwardLighting,
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
	NormBlendEnableMask2,
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
	ENVConstantMul,
	ENVDiffuseMul,
	ENVSpecularMul,
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
	NormBlendMask1R = M3SD_ScAnimData(),
	NormBlendMask1G = M3SD_ScAnimData(),
	NormBlendMask1B = M3SD_ScAnimData(),
	NormBlendMask1A = M3SD_ScAnimData(),
	NormBlendMask2R = M3SD_ScAnimData(),
	NormBlendMask2G = M3SD_ScAnimData(),
	NormBlendMask2B = M3SD_ScAnimData(),
	NormBlendMask2A = M3SD_ScAnimData(),
	--UI parameter-----------------------
	MatSubType,
	Specularity2,
	ENVMulEnabled,

	--LegacyTangent (Legacy_Tangent_Space) : boolean
	--LegacyUVCompression (Legacy_UV_Compression) : boolean
	--Diffuse (Diffuse_texture) : texturemap
	--Decal (Decal_texture) : texturemap
	--Gloss (Specular_texture) : texturemap
	--Emissive1 (Emissive_texture) : texturemap
	--Emissive2 (Emissive_texture_2) : texturemap
	--Environment (Environment_texture) : texturemap
	--EnvironmentMask (Environment_mask_texture) : texturemap
	--AlphaMask (Alpha_Mask) : texturemap
	--NormalMap (Normal_texture) : texturemap
	--Heightmap (Height_map) : texturemap
	--Lightmap : texturemap
	--AmbientOcclusion (Ambient_Occlusion) : texturemap
	--AlphaMask2 (Alpha_mask_2) : texturemap
	--GlossExp (Gloss_Texture) : texturemap
	--NormBlendMask1 (Normal_Blending_Mask_1) : texturemap
	--NormBlendMask2 (Normal_Blending_Mask_2) : texturemap
	--NormBlendNormal1 (Normal_Blending_Normal_1) : texturemap
	--NormBlendNormal2 (Normal_Blending_Normal_2) : texturemap
	--!!!DiffuseEnable (Enable_diffuse_map) : boolean
	--!!!DecalEnable (Enable_decal_map) : boolean
	--!!!GlossEnable (Enable_specular_map) : boolean
	--!!!Emissive1Enable (Enable_emissive_map) : boolean
	--!!!Emissive2Enable (Enable_emissive_map_2) : boolean
	--!!!EnvironmentEnable (Enable_environment_map) : boolean
	--!!!EnvironmentMaskEnable (Enable_environment_mask) : boolean
	--!!!AlphaMaskEnable (Enable_alpha_mask) : boolean
	--!!!NormalEnable (Enable_normal_map) : boolean
	--!!!HeightmapEnable (Height_map_enable) : boolean
	--!!!AmbientOcclusionEnable (Enable_ambient_occlusion) : boolean
	--!!!AlphaMaskEnable2 (Alpha_mask_enable_2) : boolean
	--!!!GlossExpEnable (Gloss_Texture_enable) : boolean
	--???DXN_Style_Normal_Maps : boolean
	--???FresnelExponentObsolete (Fresnel_exponent) : float
	--???VertexBasedAmbientOcclusion (Vertex_based_occlusion_map_enable) : boolean
	--???DepthTest (Depth_test_enable) : boolean
	--???DepthWrite (Depth_write_enable) : boolean
	--???Specularity : integer
	--???DontDraw : boolean

	fn copyData source_FP seq: m3: dir:#fromfile trk: tp: =
	(
		case dir of
		(
			#fromfile:
			(
				this.ExpVtxRGBA = (source_FP.bFlags.bits[1] or source_FP.bFlags.bits[2])
				this.Specularity2 = 6
				this.ENVMulEnabled = if(source_FP.envConstMult == 1 and \
					source_FP.envDiffMult == 0 and \
					source_FP.envSpecMult == 0)then(false)else(true)
				this.BlendOp = case source_FP.blendMode of
				(
					0: 0
					2: 1;	3: 1
					4: 2;	6: 2
					5: 3
					1: 4
					7: 5
					default: 0
				)
				this.EmissiveBlendOp1 = case source_FP.emisBlendType1 of
				(2: 0;	3: 1;	4: 2;	0: 3;	1: 4;	default: 0)
				this.EmissiveBlendOp2 = case source_FP.emisBlendType2 of
				(2: 0;	3: 1;	4: 2;	0: 3;	1: 4;	default: 0)

				this.CastShadows 		= if(source_FP.bFlags.bits[6])then(false)else(true)
				this.HitTest 			= if(source_FP.bFlags.bits[7])then(false)else(true)
				this.RecvShadows 		= if(source_FP.bFlags.bits[8])then(false)else(true)

				if(source_FP.version == 0x0F)then
				(
					this.NormBlendEnable			= false
					this.SimulateRoughness			= false
					this.PerPixelForwardLighting 	= false
					this.ExpVtxRGBA 				= source_FP.bFlags.bits[3]

					this.MainPass 					= if(source_FP.bFlags.bits[32])then(false)else(true)
				)else
				(
					this.NormBlendEnable 			= source_FP.bFlags.bits[3]
					this.SimulateRoughness			= source_FP.bFlags.bits[12]
					this.PerPixelForwardLighting 	= source_FP.bFlags.bits[13]
					
					this.MainPass 					= source_FP.bFlags.bits[32]
				)
			)
			#tofile:()
			default:
			(
				M3F_DataApply dir this source_FP "NormBlendEnable"			""
				M3F_DataApply dir this source_FP "CastShadows" 				""
				M3F_DataApply dir this source_FP "HitTest" 					""
				M3F_DataApply dir this source_FP "RecvShadows" 				""
				M3F_DataApply dir this source_FP "SimulateRoughness" 		""
				M3F_DataApply dir this source_FP "PerPixelForwardLighting" 	""
				
				M3F_DataApply dir this source_FP "MainPass" 				""

				M3F_DataApply dir this source_FP "BlendOp" 					""
				M3F_DataApply dir this source_FP "EmissiveBlendOp1" 		""
				M3F_DataApply dir this source_FP "EmissiveBlendOp2" 		""
				M3F_DataApply dir this source_FP "Specularity2" 			""
				M3F_DataApply dir this source_FP "ExpVtxRGBA" 				""
				M3F_AnimApply dir this source_FP "DecalAlpha" 				""
				M3F_AnimApply dir this source_FP "EmissiveAlpha1" 			""
				M3F_AnimApply dir this source_FP "EmissiveAlpha2" 			""
				M3F_AnimApply dir this source_FP "EnvironmentAlpha" 		""
				M3F_DataApply dir this source_FP "ENVMulEnabled" 			""
			)
		)
		M3F_DataApply dir this source_FP "VtxColor" 				"bFlags.bits[1]"
		M3F_DataApply dir this source_FP "VtxAlpha" 				"bFlags.bits[2]"
		
		M3F_DataApply dir this source_FP "TwoSided" 				"bFlags.bits[4]"
		M3F_DataApply dir this source_FP "Unlit" 					"bFlags.bits[5]"
		
		M3F_DataApply dir this source_FP "TranslucencyDepthWrite" 	"bFlags.bits[9]"
		
		M3F_DataApply dir this source_FP "DepthFog" 				"bFlags.bits[14]"
		M3F_DataApply dir this source_FP "CastTransparentShadows" 	"bFlags.bits[15]"
		M3F_DataApply dir this source_FP "DecalLighting" 			"bFlags.bits[16]"
		M3F_DataApply dir this source_FP "TransaprencyAffectsDOF" 	"bFlags.bits[17]"
		M3F_DataApply dir this source_FP "TransparencyLocalLights" 	"bFlags.bits[18]"
		M3F_DataApply dir this source_FP "DisableSoftBlend" 		"bFlags.bits[19]"
		M3F_DataApply dir this source_FP "ForceDoubleLambertShading" "bFlags.bits[20]"
		M3F_DataApply dir this source_FP "HairSorting" 				"bFlags.bits[21]"
		M3F_DataApply dir this source_FP "AcceptSplats" 			"bFlags.bits[22]"
		M3F_DataApply dir this source_FP "RequiresDecal" 			"bFlags.bits[23]"
		M3F_DataApply dir this source_FP "RequiresEmissive" 		"bFlags.bits[24]"
		M3F_DataApply dir this source_FP "RequiresSpecular" 		"bFlags.bits[25]"
		M3F_DataApply dir this source_FP "OnlyAcceptSplats" 		"bFlags.bits[26]"
		M3F_DataApply dir this source_FP "BackgroundObject" 		"bFlags.bits[27]"
		M3F_DataApply dir this source_FP "NormBlendEnableMask2" 	"bFlags.bits[28]"
		M3F_DataApply dir this source_FP "RequiresZFill" 			"bFlags.bits[29]"
		M3F_DataApply dir this source_FP "NoHighlights" 			"bFlags.bits[30]"
		M3F_DataApply dir this source_FP "ClampOutput" 				"bFlags.bits[31]"
		
		M3F_DataApply dir this source_FP "Priority" 				"mPriority"
		M3F_DataApply dir this source_FP "AlphaTestThreshold" 		"cutOutTreshold"
		M3F_DataApply dir this source_FP "DepthBlendFallOff" 		"depthBlendFallOff"
		M3F_DataApply dir this source_FP "HDRSpecularMul" 			"specMult"
		M3F_DataApply dir this source_FP "HDREmissiveMul" 			"emisMult"
		M3F_DataApply dir this source_FP "ENVConstantMul" 			"envConstMult"
		M3F_DataApply dir this source_FP "ENVDiffuseMul" 			"envDiffMult"
		M3F_DataApply dir this source_FP "ENVSpecularMul" 			"envSpecMult"
		M3F_DataApply dir this source_FP "SpecularPower" 			"spec"
		M3F_DataApply dir this source_FP "EnvironmentBlendOp" 		"EnvBlendType"
		M3F_DataApply dir this source_FP "GlossType" 				"GlossType"
		
		M3F_AnimApply dir this source_FP \
			"ParallaxHeight" "rfaParallaxHeight" seq:seq m3:m3 c:true mult:100.0
		
		if(this.NormBlendEnable)then
		(
			M3F_AnimApply dir this source_FP \
				"NormBlendMask1R" "rfdNormBlend.data[1]" seq:seq m3:m3 \
				anim:"NormBlendMask1R" trk:trk tp:tp
			M3F_AnimApply dir this source_FP \
				"NormBlendMask1G" "rfdNormBlend.data[2]" seq:seq m3:m3 \
				anim:"NormBlendMask1G" trk:trk tp:tp
			M3F_AnimApply dir this source_FP \
				"NormBlendMask1B" "rfdNormBlend.data[3]" seq:seq m3:m3 \
				anim:"NormBlendMask1B" trk:trk tp:tp
			M3F_AnimApply dir this source_FP \
				"NormBlendMask1A" "rfdNormBlend.data[4]" seq:seq m3:m3 \
				anim:"NormBlendMask1A" trk:trk tp:tp

			if(this.NormBlendEnableMask2)then
			(
				M3F_AnimApply dir this source_FP \
					"NormBlendMask2R" "rfdNormBlend.data[5]" seq:seq m3:m3 \
					anim:"NormBlendMask2R" trk:trk tp:tp
				M3F_AnimApply dir this source_FP \
					"NormBlendMask2G" "rfdNormBlend.data[6]" seq:seq m3:m3 \
					anim:"NormBlendMask2G" trk:trk tp:tp
				M3F_AnimApply dir this source_FP \
					"NormBlendMask2B" "rfdNormBlend.data[7]" seq:seq m3:m3 \
					anim:"NormBlendMask2B" trk:trk tp:tp
				M3F_AnimApply dir this source_FP \
					"NormBlendMask2A" "rfdNormBlend.data[8]" seq:seq m3:m3 \
					anim:"NormBlendMask2A" trk:trk tp:tp
			)
		)
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
	SubMaterials 			= #(),--() : material array
	SubMatAlphas 			= #(),--() : float array
	Priority 				,--() : integer
	--SubMatEnables = #()	,--() : boolean array

	fn copyData source_FP seq: m3: dir:#fromfile trk: tp: =
	(
		local i
		case dir of
		(
			#fromfile:
			(
				this.SubMaterials = #()
				this.SubMatAlphas = #()
				for i=1 to source_FP.rfdCMS.data.count do
				(
					this.SubMaterials[i] = source_FP.rfdCMS.data[i].index + 1
					this.SubMatAlphas[i] = M3SD_ScAnimData()
					M3F_AnimApply dir this source_FP.rfdCMS.data[i] \
						(M3F_FormatToString "SubMatAlphas[%]" #(i)) "rfaMapMult" seq:seq m3:m3 \
						anim:(M3F_FormatToString "SubMatAlphas0%" #(i)) trk:trk tp:tp
				)
			)
			#tofile:()
			#toscene:
			(
				for i=1 to this.SubMatAlphas.count do
				(
					M3F_AnimApply dir this source_FP (M3F_FormatToString "SubMatAlphas[%]" #(i)) ""
				)
			)
			default:()
		)

		M3F_DataApply dir this source_FP "Priority" "cmpPriority"
	)
)

struct M3SD_ScVolumeMat
(
	VolumeCastShadows 			,--() : boolean
	Mode 						,--() : integer
	VolumeAlphaTestThreshold 	,--() : integer
	FalloffType 				,--() : integer
	Density 					= M3SD_ScAnimData()	,--() : float
	--Noisy1					,
	--Noisy2					,
	--ColorMap 					,--() : texturemap

	fn copyData source_FP seq: m3: dir:#fromfile trk: tp: =
	(
		M3F_DataApply dir this source_FP "VolumeCastShadows" 		"volFlags.bits[6]"
		M3F_DataApply dir this source_FP "Mode" 					"blendMode"
		M3F_DataApply dir this source_FP "VolumeAlphaTestThreshold" "AlphaThreshold"
		M3F_DataApply dir this source_FP "FalloffType" 				"falloffType"
		M3F_AnimApply dir this source_FP \
			"Density" "rfaDensity" seq:seq m3:m3 \
			anim:"density" trk:trk tp:tp
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

	fn copyData source_FP seq: m3: dir:#fromfile trk: tp: =
	(
		M3F_DataApply dir this source_FP "VolumeCastShadows" 		"vonFlags.bits[6]"
		M3F_DataApply dir this source_FP \
			"DrawBeforeTransparency" "DrawTrans" o:"=M3F_CvtType #bool "
		M3F_DataApply dir this source_FP "VolumeAlphaTestThreshold" "AlphaThreshold"
		M3F_DataApply dir this source_FP "FalloffType" 				"falloffType"
		
		M3F_AnimApply dir this source_FP \
			"Density" "rfaDensity" seq:seq m3:m3 \
			anim:"density" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
			"NearPlane" "rfaNearPlane" seq:seq m3:m3 \
			anim:"NearPlane" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
			"FallOff" "rfaFalloff" seq:seq m3:m3 \
			anim:"falloff" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
			"NoiseTranslationX" "rfaPos" seq:seq m3:m3 type:#x \
			anim:"noise translation" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
			"NoiseTranslationY" "rfaPos" seq:seq m3:m3 type:#y \
			anim:"noise translation" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
			"NoiseTranslationZ" "rfaPos" seq:seq m3:m3 type:#z \
			anim:"noise translation" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
			"NoiseRotationX" "rfaRot" seq:seq m3:m3 type:#x c:true mult:57.296 \
			anim:"noise rotation" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
			"NoiseRotationY" "rfaRot" seq:seq m3:m3 type:#y c:true mult:57.296 \
			anim:"noise rotation" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
			"NoiseRotationZ" "rfaRot" seq:seq m3:m3 type:#z c:true mult:57.296 \
			anim:"noise rotation" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
			"NoiseScaleX" "rfaScale" seq:seq m3:m3 type:#x \
			anim:"noise scale" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
			"NoiseScaleY" "rfaScale" seq:seq m3:m3 type:#y \
			anim:"noise scale" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
			"NoiseScaleZ" "rfaScale" seq:seq m3:m3 type:#z \
			anim:"noise scale" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
			"NoiseScrollX" "rfaScrollRate" seq:seq m3:m3 type:#x \
			anim:"noise scroll" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
			"NoiseScrollY" "rfaScrollRate" seq:seq m3:m3 type:#y \
			anim:"noise scroll" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
			"NoiseScrollZ" "rfaScrollRate" seq:seq m3:m3 type:#z \
			anim:"noise scroll" trk:trk tp:tp
	)
)

struct M3SD_ScReflectionMat
(
	Enable_Strength_Map 		,--: boolean
	Enable_Displacement 		,--: boolean
	Enable_Distance_Blur 		,--() : boolean
	Enable_Blur_Mask 			,--: boolean
	Render_in_Transparent_Pass 	,--() : boolean

	ReflectionStrength 			= M3SD_ScAnimData(),--() : float
	ReflectionOffset 			= M3SD_ScAnimData(),--() : float
	DisplacementStrength 		= M3SD_ScAnimData(),--() : float
	Blur_Amount 				= M3SD_ScAnimData(),--: float
	Blur_Distance 				= M3SD_ScAnimData(),--() : float

	fn copyData source_FP seq: m3: dir:#fromfile trk: tp: =
	(
		case dir of
		(
			#fromfile:()
			#tofile:()
			default:()
		)

		M3F_DataApply dir this source_FP "Enable_Displacement" 				"refFlags.bits[1]"
		M3F_DataApply dir this source_FP "Enable_Strength_Map" 				"refFlags.bits[2]"
		M3F_DataApply dir this source_FP "Render_in_Transparent_Pass" 		"refFlags.bits[3]"
		M3F_DataApply dir this source_FP "Enable_Distance_Blur" 			"refFlags.bits[4]"
		M3F_DataApply dir this source_FP "Enable_Blur_Mask" 				"refFlags.bits[5]"

		M3F_AnimApply dir this source_FP \
			"ReflectionStrength" "rfaRefectStg" seq:seq m3:m3 \
			anim:"ReflectionStrength" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
			"ReflectionOffset" "rfaRefectOffset" seq:seq m3:m3 \
			anim:"ReflectionOffset" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
			"DisplacementStrength" "rfaDispStg" seq:seq m3:m3 \
			anim:"DisplacementStrength" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
			"Blur_Amount" "rfaBlurAngle" seq:seq m3:m3 \
			anim:"Blur_Amount" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
			"Blur_Distance" "rfaBlurDisMax" seq:seq m3:m3 \
			anim:"Blur_Distance" trk:trk tp:tp
	)
)

struct M3SD_ScFlareMat
(
	LensFlareMaxFrameX 				,--() : integer
	LensFlareMaxFrameY 				,--() : integer
	LensFlareDistanceFadeIntensity 	,--() : float
	LensFlareHDRScale 				= M3SD_ScAnimData(),--() : float
	DirtyLensEnable 				,--() : boolean
	LensFlareEnables 				= #(),--() : boolean array
	LensFlareFrames 				= #(),--() : int array
	LensFlareDistances 				= #(),--() : float array
	LensFlareSizeXs 				= #(),--() : float array
	LensFlareSizeYs 				= #(),--() : float array
	LensFlareScaleXs 				= #(),--() : float array
	LensFlareScaleYs 				= #(),--() : float array
	LensFlareColors 				= #(),--() : RGB color array
	LensFlareAlphas 				= #(),--() : float array
	LensFlareCenterFacings 			= #(),--() : boolean array
	LensFlareFadeOutStarts 			= #(),--() : float array
	LensFlareFadeOutEnds 			= #(),--() : float array
	LensFlareFadeInStarts 			= #(),--() : float array
	LensFlareFadeInEnds 			= #(),--() : float array
	LensFlareOffsetAngles 			= #(),--() : float array
	LensFlareOffsetDistances 		= #(),--() : float array
	--Normal_Map 						,--() : texturemap
	--Dirty_Lens 						,--() : texturemap

	fn copyData source_FP seq: m3: dir:#fromfile trk: tp: =
	(
		local i, local_source
		local sub_count = 0
		case dir of
		(
			#fromfile:
			(
				this.DirtyLensEnable = true
				sub_count = source_FP.rfdSubFlares.data.count
				local_source = source_FP.rfdSubFlares.data
				
				for i=1 to 8 do
				(
					if(i <= sub_count)then
					(
						this.LensFlareEnables[i] = true
						local normal_vec = normalize source_FP.rfdSubFlares.data[i].offset
						if(normal_vec[1] >= 0)then
						(
							this.LensFlareOffsetAngles[i] = mod ((asin normal_vec[2]) + 360) 360
						)else
						(
							this.LensFlareOffsetAngles[i] = 180 - (asin normal_vec[2])
						)
						this.LensFlareFadeInStarts[i] = source_FP.rfdSubFlares.data[i].fadeIn[1]
						this.LensFlareFadeOutStarts[i] = source_FP.rfdSubFlares.data[i].fadeOut[1]
						this.LensFlareFadeInEnds[i] = \
							this.LensFlareFadeInStarts[i] + (1.0 / source_FP.rfdSubFlares.data[i].fadeIn[2])
						this.LensFlareFadeOutEnds[i] = \
							this.LensFlareFadeOutStarts[i] + (1.0 / source_FP.rfdSubFlares.data[i].fadeOut[2])
					)else
					(
						this.LensFlareEnables[i] = false
						this.LensFlareOffsetAngles[i] = 0
						this.LensFlareFadeInStarts[i] = 0
						this.LensFlareFadeInEnds[i] = 0
						this.LensFlareFadeOutStarts[i] = 0
						this.LensFlareFadeOutEnds[i] = 0
					)
				)
			)
			#tofile:()
			default:
			(
				local local_dir = if(dir == #toscene)then(this)else(source_FP)
				for i=1 to 8 do(if(local_dir.LensFlareEnables[i])then(sub_count += 1))

				M3F_DataApply dir this source_FP "DirtyLensEnable" 			""
				M3F_DataApply dir this source_FP "LensFlareEnables" 		""
				M3F_DataApply dir this source_FP "LensFlareOffsetAngles" 	""
				M3F_DataApply dir this source_FP "LensFlareFadeInStarts"	""
				M3F_DataApply dir this source_FP "LensFlareFadeInEnds"		""
				M3F_DataApply dir this source_FP "LensFlareFadeOutStarts"	""
				M3F_DataApply dir this source_FP "LensFlareFadeOutEnds"		""
				
				local_source = for i=1 to sub_count collect(source_FP)
			)
		)
		M3F_DataApply dir this source_FP "LensFlareMaxFrameX" 				"columns"
		M3F_DataApply dir this source_FP "LensFlareMaxFrameY" 				"rows"
		M3F_DataApply dir this source_FP "LensFlareDistanceFadeIntensity" 	"disFade"
		
		M3F_AnimApply dir this source_FP \
			"LensFlareHDRScale" "rfaHDR" seq:seq m3:m3 \
			anim:"LensFlareHDRScale" trk:trk tp:tp
		
		for i=1 to sub_count do
		(
			M3F_DataApply dir this local_source[i] (M3F_FormatToString "LensFlareFrames[%]" #(i)) \
				"index"
			M3F_DataApply dir this local_source[i] (M3F_FormatToString "LensFlareDistances[%]" #(i)) \
				"pos"
			M3F_DataApply dir this local_source[i] (M3F_FormatToString "LensFlareSizeXs[%]" #(i)) \
				"sizeXY[1]"
			M3F_DataApply dir this local_source[i] (M3F_FormatToString "LensFlareSizeYs[%]" #(i)) \
				"sizeXY[2]"
			M3F_DataApply dir this local_source[i] (M3F_FormatToString "LensFlareScaleXs[%]" #(i)) \
				"scaleXY[1]"
			M3F_DataApply dir this local_source[i] (M3F_FormatToString "LensFlareScaleYs[%]" #(i)) \
				"scaleXY[2]"
			M3F_DataApply dir this local_source[i] (M3F_FormatToString "LensFlareColors[%]" #(i)) \
				"colorAlpha" o:"= M3F_CvtType #color "
			M3F_DataApply dir this local_source[i] (M3F_FormatToString "LensFlareAlphas[%]" #(i)) \
				"colorAlpha" o:"= M3F_CvtType #alpha " c:true f1:" / 255.0" f2:" * 255.0"
			M3F_DataApply dir this local_source[i] (M3F_FormatToString "LensFlareCenterFacings[%]" #(i)) \
				"faceCenter" o:"= M3F_CvtType #bool "
			M3F_DataApply dir this local_source[i] (M3F_FormatToString "LensFlareOffsetDistances[%]" #(i)) \
				"offset" o:"= length "
		)
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
	MassMultiplier 					,--() : float
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
	Particle_Inherit_Scale_On_Spawning ,--() : boolean
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
	
	fn copyData source_FP seq: m3: dir:#fromfile trk: tp: mult:1.0 anim:true =
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

		M3F_DataApply dir this source_FP "UV2RandomOffset" 						"parFlags2.bits[1]"
		M3F_DataApply dir this source_FP "RotationRelative" 					"parFlags2.bits[2]"
		M3F_DataApply dir this source_FP "KillSphereEnable" 					"parFlags2.bits[3]"
		M3F_DataApply dir this source_FP "ParticleVelocityXYOnlyCheck" 			"parFlags2.bits[4]"
		M3F_DataApply dir this source_FP "Particle_Inherit_Scale_On_Spawning" 	"parFlags2.bits[5]"
		M3F_DataApply dir this source_FP "ParticleInheritScaleOnSpawning" 		"parFlags2.bits[6]"
		M3F_DataApply dir this source_FP "RandomRotationAxisOnLinkedModels" 	"parFlags2.bits[8]"
		
		M3F_DataApply dir this source_FP "EmitterType" 				"emissShape"
		M3F_DataApply dir this source_FP "InitialVelocityType" 		"ivType"
		M3F_DataApply dir this source_FP "ParticleInstanceType" 	"instType"
		M3F_DataApply dir this source_FP "FlipbookRows" 			"filpBookRow"
		M3F_DataApply dir this source_FP "FlipbookColumns" 			"filpBookColumn"
		
		M3F_AnimApply dir this source_FP \
		"InnerWidth" "rfaShapeInner" seq:seq m3:m3 type:#x ea:anim c:true mult:(100.0*mult) \
		anim:"EmitterInnerSize" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"InnerLength" "rfaShapeInner" seq:seq m3:m3 type:#y ea:anim c:true mult:(100.0*mult) \
		anim:"EmitterInnerSize" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"InnerHeight" "rfaShapeInner" seq:seq m3:m3 type:#z ea:anim c:true mult:(100.0*mult) \
		anim:"EmitterInnerSize" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"OuterWidth" "rfaShapeOuter" seq:seq m3:m3 type:#x ea:anim c:true mult:(100.0*mult) \
		anim:"EmitterSize" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"OuterLength" "rfaShapeOuter" seq:seq m3:m3 type:#y ea:anim c:true mult:(100.0*mult) \
		anim:"EmitterSize" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"OuterHeight" "rfaShapeOuter" seq:seq m3:m3 type:#z ea:anim c:true mult:(100.0*mult) \
		anim:"EmitterSize" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"InnerRadius" "rfaInRadius" seq:seq m3:m3 ea:anim c:true mult:(100.0*mult) \
		anim:"InnerRadius" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"OuterRadius" "rfaOutRadius" seq:seq m3:m3 ea:anim c:true mult:(100.0*mult) \
		anim:"OuterRadius" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"SplineShapeUpperBound" "rfaUpBound" seq:seq m3:m3 ea:anim c:true mult:mult \
		anim:"SplineShapeUpperBound" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"SplineShapeLowerBound" "rfaLowBound" seq:seq m3:m3 ea:anim c:true mult:mult \
		anim:"SplineShapeLowerBound" trk:trk tp:tp
				
		M3F_DataApply dir this source_FP "MaxParticles" 				"maxPart"
		M3F_DataApply dir this source_FP "KillSphereRadius" 			"killRadius" \
			c:true f1:("* " + (mult as string)) f2:("/ " + (mult as string))
		M3F_DataApply dir this source_FP "ParticleInstanceOffset" 		"endScale"
		M3F_DataApply dir this source_FP "ParticleInstanceTailLength" 	"tailLens"
		M3F_DataApply dir this source_FP "TrailPercentChance" 			"trailChance" \
			c:true f1:"* 100.0" f2:"/ 100.0"
		
		M3F_AnimApply dir this source_FP \
		"TrailEmissionRate" "rfaTrailEmissRate" seq:seq m3:m3 ea:anim \
		anim:"TrailEmissionRate" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"EmissionRate" "rfaEmissRate" seq:seq m3:m3 ea:anim \
		anim:"EmissionRate" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"SquirtQuantity" "rfaSquirtAmount" seq:seq m3:m3 ea:anim \
		anim:"SquirtQuantity" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"LifetimeMin" "rfaLifeTime" seq:seq m3:m3 ea:anim \
		anim:"lifetime" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"LifetimeMax" "rfaLifeTimeR" seq:seq m3:m3 ea:anim \
		anim:"lifetime" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"InitialVelocityYaw" "rfaIVyaw" seq:seq m3:m3 ea:anim \
		anim:"InitialVelocityYaw" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"InitialVelocityPitch" "rfaIVpitch" seq:seq m3:m3 ea:anim \
		anim:"InitialVelocityPitch" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"InitialVelocityHorzSpread" "rfaIVHorz" seq:seq m3:m3 ea:anim c:true mult:114.592 \
		anim:"InitialVelocityHorzSpread" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"InitialVelocityVertSpread" "rfaIVvert" seq:seq m3:m3 ea:anim c:true mult:114.592 \
		anim:"InitialVelocityVertSpread" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"InitialVelocitySpeedMin" "rfaIVspeed" seq:seq m3:m3 ea:anim c:true mult:(100.0*mult) \
		anim:"InitialVelocitySpeedMin" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"InitialVelocitySpeedMax" "rfaIVspeedR" seq:seq m3:m3 ea:anim c:true mult:(100.0*mult) \
		anim:"InitialVelocitySpeedMax" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"InheritParentVelocityPercent" "rfaPtVelocity" seq:seq m3:m3 ea:anim c:true mult:100.0 \
		anim:"InheritParentVelocityPercent" trk:trk tp:tp
		
		M3F_DataApply dir this source_FP "ColorRange" "colorEnableR" o:"=M3F_CvtType #bool "
		M3F_DataApply dir this source_FP "AlphaRange" "alphaEnableR" o:"=M3F_CvtType #bool "
		M3F_DataApply dir this source_FP "SizeRange" "sizeEnableR" o:"=M3F_CvtType #bool "
		M3F_DataApply dir this source_FP "RotationRange" "rotEnableR" o:"=M3F_CvtType #bool "
	
		M3F_AnimApply dir this source_FP \
		"ColorMinBegin" "rfaColorStart" seq:seq m3:m3 ea:anim type:#color \
		anim:"ColorAndAlpha" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"ColorMaxBegin" "rfaColorStartR" seq:seq m3:m3 ea:anim type:#color \
		anim:"ColorAndAlpha" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"ColorMinMid" "rfaColorMid" seq:seq m3:m3 ea:anim type:#color \
		anim:"ColorAndAlpha" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"ColorMaxMid" "rfaColorMidR" seq:seq m3:m3 ea:anim type:#color \
		anim:"ColorAndAlpha" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"ColorMinEnd" "rfaColorEnd" seq:seq m3:m3 ea:anim type:#color \
		anim:"ColorAndAlpha" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"ColorMaxEnd" "rfaColorEndR" seq:seq m3:m3 ea:anim type:#color \
		anim:"ColorAndAlpha" trk:trk tp:tp

		M3F_AnimApply dir this source_FP \
		"AlphaMinBegin" "rfaColorStart" seq:seq m3:m3 ea:anim type:#alpha \
		anim:"ColorAndAlpha" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"AlphaMaxBegin" "rfaColorStartR" seq:seq m3:m3 ea:anim type:#alpha \
		anim:"ColorAndAlpha" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"AlphaMinMid" "rfaColorMid" seq:seq m3:m3 ea:anim type:#alpha \
		anim:"ColorAndAlpha" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"AlphaMaxMid" "rfaColorMidR" seq:seq m3:m3 ea:anim type:#alpha \
		anim:"ColorAndAlpha" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"AlphaMinEnd" "rfaColorEnd" seq:seq m3:m3 ea:anim type:#alpha \
		anim:"ColorAndAlpha" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"AlphaMaxEnd" "rfaColorEndR" seq:seq m3:m3 ea:anim type:#alpha \
		anim:"ColorAndAlpha" trk:trk tp:tp

		M3F_AnimApply dir this source_FP \
		"SizeMinBegin" "rfaSizePlay" seq:seq m3:m3 ea:anim type:#x c:true mult:(100.0*mult) \
		anim:"Particle_Size" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"SizeMaxBegin" "rfaSizePlayR" seq:seq m3:m3 ea:anim type:#x c:true mult:(100.0*mult) \
		anim:"Particle_Size" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"SizeMinMid" "rfaSizePlay" seq:seq m3:m3 ea:anim type:#y c:true mult:(100.0*mult) \
		anim:"Particle_Size" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"SizeMaxMid" "rfaSizePlayR" seq:seq m3:m3 ea:anim type:#y c:true mult:(100.0*mult) \
		anim:"Particle_Size" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"SizeMinEnd" "rfaSizePlay" seq:seq m3:m3 ea:anim type:#z c:true mult:(100.0*mult) \
		anim:"Particle_Size" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"SizeMaxEnd" "rfaSizePlayR" seq:seq m3:m3 ea:anim type:#z c:true mult:(100.0*mult) \
		anim:"Particle_Size" trk:trk tp:tp
	
		M3F_AnimApply dir this source_FP \
		"RotationMinBegin" "rfaRotPlay" seq:seq m3:m3 ea:anim type:#x c:true mult:57.296 \
		anim:"Particle_Rotation" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"RotationMaxBegin" "rfaRotPlayR" seq:seq m3:m3 ea:anim type:#x c:true mult:57.296 \
		anim:"Particle_Rotation" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"RotationMinMid" "rfaRotPlay" seq:seq m3:m3 ea:anim type:#y c:true mult:57.296 \
		anim:"Particle_Rotation" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"RotationMaxMid" "rfaRotPlayR" seq:seq m3:m3 ea:anim type:#y c:true mult:57.296 \
		anim:"Particle_Rotation" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"RotationMinEnd" "rfaRotPlay" seq:seq m3:m3 ea:anim type:#z c:true mult:57.296 \
		anim:"Particle_Rotation" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"RotationMaxEnd" "rfaRotPlayR" seq:seq m3:m3 ea:anim type:#z c:true mult:57.296 \
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
		"YawFunctionAmplitude" "rfaYawAmp" seq:seq m3:m3 ea:anim \
		anim:"YawFunctionAmplitude" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"YawFunctionFrequency" "rfaYawFreq" seq:seq m3:m3 ea:anim \
		anim:"YawFunctionFrequency" trk:trk tp:tp

		M3F_AnimApply dir this source_FP \
		"PitchFunctionAmplitude" "rfaPitchAmp" seq:seq m3:m3 ea:anim \
		anim:"PitchFunctionAmplitude" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"PitchFunctionFrequency" "rfaPitchFreq" seq:seq m3:m3 ea:anim \
		anim:"PitchFunctionFrequency" trk:trk tp:tp

		M3F_AnimApply dir this source_FP \
		"HorzSpreadFunctionAmplitude" "rfaHorzAmp" seq:seq m3:m3 ea:anim \
		anim:"HorzSpreadFunctionAmplitude" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"HorzSpreadFunctionFrequency" "rfaHorzFreq" seq:seq m3:m3 ea:anim \
		anim:"HorzSpreadFunctionFrequency" trk:trk tp:tp

		M3F_AnimApply dir this source_FP \
		"VertSpreadFunctionAmplitude" "rfaVertAmp" seq:seq m3:m3 ea:anim \
		anim:"VertSpreadFunctionAmplitude" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"VertSpreadFunctionFrequency" "rfaVertFreq" seq:seq m3:m3 ea:anim \
		anim:"VertSpreadFunctionFrequency" trk:trk tp:tp

		M3F_AnimApply dir this source_FP \
		"SpeedFunctionAmplitude" "rfaSpeedAmp" seq:seq m3:m3 ea:anim \
		anim:"SpeedFunctionAmplitude" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"SpeedFunctionFrequency" "rfaSpeedFreq" seq:seq m3:m3 ea:anim \
		anim:"SpeedFunctionFrequency" trk:trk tp:tp

		M3F_AnimApply dir this source_FP \
		"AlphaFunctionAmplitude" "rfaAlphaAmp" seq:seq m3:m3 ea:anim \
		anim:"AlphaFunctionAmplitude" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"AlphaFunctionFrequency" "rfaAlphaFreq" seq:seq m3:m3 ea:anim \
		anim:"AlphaFunctionFrequency" trk:trk tp:tp

		M3F_AnimApply dir this source_FP \
		"SizeFunctionAmplitude" "rfaSizeAmp" seq:seq m3:m3 ea:anim \
		anim:"SizeFunctionAmplitude" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"SizeFunctionFrequency" "rfaSizeFreq" seq:seq m3:m3 ea:anim \
		anim:"SizeFunctionFrequency" trk:trk tp:tp
		
		M3F_AnimApply dir this source_FP \
		"RotationFunctionAmplitude" "rfaRotAmp" seq:seq m3:m3 ea:anim \
		anim:"RotationFunctionAmplitude" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"RotationFunctionFrequency" "rfaRotFreq" seq:seq m3:m3 ea:anim \
		anim:"RotationFunctionFrequency" trk:trk tp:tp

		M3F_DataApply dir this source_FP "NoiseFrequency" 		"noiseFreq"
		M3F_DataApply dir this source_FP "NoiseAmplitude" 		"noiseAmp" \
			c:true f1:"* 100.0" f2:"/ 100.0"
		M3F_DataApply dir this source_FP "NoiseSpeed" 			"noiseCoh"
		M3F_DataApply dir this source_FP "NoiseFallOff" 		"noiseEdge"

		M3F_DataApply dir this source_FP "MassMin" 				"pMass"
		M3F_DataApply dir this source_FP "MassMax" 				"pMassR"
		M3F_DataApply dir this source_FP "MassSizeMultiplier" 	"pMassSizeMult"
		M3F_DataApply dir this source_FP "MassMultiplier" 		"pMassMult"
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
		"UTiling" "rfaUVtill" seq:seq m3:m3 ea:anim type:#u \
		anim:"uvTiling" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"VTiling" "rfaUVtill" seq:seq m3:m3 ea:anim type:#v \
		anim:"uvTiling" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"UOffset" "rfaUVoffset" seq:seq m3:m3 ea:anim type:#u \
		anim:"uvOffset" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"VOffset" "rfaUVoffset" seq:seq m3:m3 ea:anim type:#v \
		anim:"uvOffset" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"UAngle" "rfaAngle" seq:seq m3:m3 ea:anim type:#u c:true mult:57.296 \
		anim:"uvRotation" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"VAngle" "rfaAngle" seq:seq m3:m3 ea:anim type:#v c:true mult:57.296 \
		anim:"uvRotation" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"WAngle" "rfaAngle" seq:seq m3:m3 ea:anim type:#w c:true mult:57.296 \
		anim:"uvRotation" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"AlphaThreshold" "rfaAlphaThold" seq:seq m3:m3 ea:anim \
		anim:"Alpha threshold" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"OverlayOffset" "rfaOverlay" seq:seq m3:m3 ea:anim \
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

	fn copyData source_FP seq: m3: dir:#fromfile trk: tp: mult:1.0 anim:true =
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
			"Active" "rfaActive" seq:seq m3:m3 ea:anim type:#bool \
			anim:"active" trk:trk tp:tp

			M3F_DataApply dir this source_FP "MassSizeMultiplier" 		"pMassSizeMult"
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
			c:true f1:("* 100.0 * "+(mult as string)) f2:("/ 100.0 / "+(mult as string))

		M3F_DataApply dir this source_FP "SmoothColorInterpolation" "colorSmootying"

		M3F_DataApply dir this source_FP "ColorMidTime" 			"colorMTime"
		M3F_DataApply dir this source_FP "AlphaMidTime" 			"alphaMTime"
		M3F_DataApply dir this source_FP "SizeMidTime" 				"sizeMTime"
		M3F_DataApply dir this source_FP "RotationMidTime" 			"rotMTime"
		
		M3F_DataApply dir this source_FP "ColorMidHoldTime" 		"colorMHTime"
		M3F_DataApply dir this source_FP "AlphaMidHoldTime" 		"alphaMHTime"
		M3F_DataApply dir this source_FP "SizeMidHoldTime" 			"sizeMHTime"

		M3F_AnimApply dir this source_FP \
			"MaxLength" "rfaMaxLen" seq:seq m3:m3 ea:anim c:true mult:(100.0*mult) \
			anim:"MaxLength" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
			"LifetimeMin" "rfaLifeTime" seq:seq m3:m3 ea:anim \
			anim:"lifetime" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
			"InitialVelocityYaw" "rfaIVyaw" seq:seq m3:m3 ea:anim \
			anim:"InitialVelocityYaw" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
			"InitialVelocityPitch" "rfaIVpitch" seq:seq m3:m3 ea:anim \
			anim:"InitialVelocityPitch" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
			"InitialVelocitySpeedMin" "rfaIVspeed" seq:seq m3:m3 ea:anim c:true mult:(100.0*mult) \
			anim:"InitialVelocitySpeedMin" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
			"InheritParentVelocityPercent" "rfaPtVelocity" seq:seq m3:m3 ea:anim c:true mult:100.0 \
			anim:"InheritParentVelocityPercent" trk:trk tp:tp

		M3F_AnimApply dir this source_FP \
			"SizeMinBegin" "rfaSizePlay" seq:seq m3:m3 ea:anim type:#x c:true mult:(50.0*mult) \
			anim:"Particle_Size" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
			"SizeMinMid" "rfaSizePlay" seq:seq m3:m3 ea:anim type:#y c:true mult:(50.0*mult) \
			anim:"Particle_Size" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
			"SizeMinEnd" "rfaSizePlay" seq:seq m3:m3 ea:anim type:#z c:true mult:(50.0*mult) \
			anim:"Particle_Size" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
			"RotationMinBegin" "rfaRotPlay" seq:seq m3:m3 ea:anim type:#x c:true mult:57.296 \
			anim:"Particle_Rotation" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
			"RotationMinMid" "rfaRotPlay" seq:seq m3:m3 ea:anim type:#y c:true mult:57.296 \
			anim:"Particle_Rotation" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
			"RotationMinEnd" "rfaRotPlay" seq:seq m3:m3 ea:anim type:#z c:true mult:57.296 \
			anim:"Particle_Rotation" trk:trk tp:tp

		M3F_AnimApply dir this source_FP \
			"ColorMinBegin" "rfaColorStart" seq:seq m3:m3 ea:anim type:#color \
			anim:"ColorAndAlpha" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
			"ColorMinMid" "rfaColorMid" seq:seq m3:m3 ea:anim type:#color \
			anim:"ColorAndAlpha" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
			"ColorMinEnd" "rfaColorEnd" seq:seq m3:m3 ea:anim type:#color \
			anim:"ColorAndAlpha" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
			"AlphaMinBegin" "rfaColorStart" seq:seq m3:m3 ea:anim type:#alpha \
			anim:"ColorAndAlpha" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
			"AlphaMinMid" "rfaColorMid" seq:seq m3:m3 ea:anim type:#alpha \
			anim:"ColorAndAlpha" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
			"AlphaMinEnd" "rfaColorEnd" seq:seq m3:m3 ea:anim type:#alpha \
			anim:"ColorAndAlpha" trk:trk tp:tp
		
		M3F_DataApply dir this source_FP "YawFunctionOverlay" 		"yawType"
		M3F_DataApply dir this source_FP "PitchFunctionOverlay" 	"pitchType"
		M3F_DataApply dir this source_FP "SpeedFunctionOverlay" 	"speedType"
		M3F_DataApply dir this source_FP "AlphaFunctionOverlay" 	"alphaType"
		M3F_DataApply dir this source_FP "SizeFunctionOverlay" 		"sizeType"

		M3F_AnimApply dir this source_FP \
		"YawFunctionAmplitude" "rfaYawAmp" seq:seq m3:m3 ea:anim \
		anim:"YawFunctionAmplitude" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"YawFunctionFrequency" "rfaYawFreq" seq:seq m3:m3 ea:anim \
		anim:"YawFunctionFrequency" trk:trk tp:tp

		M3F_AnimApply dir this source_FP \
		"PitchFunctionAmplitude" "rfaPitchAmp" seq:seq m3:m3 ea:anim \
		anim:"PitchFunctionAmplitude" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"PitchFunctionFrequency" "rfaPitchFreq" seq:seq m3:m3 ea:anim \
		anim:"PitchFunctionFrequency" trk:trk tp:tp

		M3F_AnimApply dir this source_FP \
		"SpeedFunctionAmplitude" "rfaSpeedAmp" seq:seq m3:m3 ea:anim \
		anim:"SpeedFunctionAmplitude" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"SpeedFunctionFrequency" "rfaSpeedFreq" seq:seq m3:m3 ea:anim \
		anim:"SpeedFunctionFrequency" trk:trk tp:tp

		M3F_AnimApply dir this source_FP \
		"AlphaFunctionAmplitude" "rfaAlphaAmp" seq:seq m3:m3 ea:anim \
		anim:"AlphaFunctionAmplitude" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"AlphaFunctionFrequency" "rfaAlphaFreq" seq:seq m3:m3 ea:anim \
		anim:"AlphaFunctionFrequency" trk:trk tp:tp

		M3F_AnimApply dir this source_FP \
		"SizeFunctionAmplitude" "rfaSizeAmp" seq:seq m3:m3 ea:anim \
		anim:"SizeFunctionAmplitude" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"SizeFunctionFrequency" "rfaSizeFreq" seq:seq m3:m3 ea:anim \
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
		"OverlayOffset" "rfaOverlay" seq:seq m3:m3 ea:anim \
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
	InitialVelocitySpeedMin 		= M3SD_ScAnimData(),--() : float
	SpeedFunctionOverlay 			,--() : integer
	SpeedFunctionAmplitude 			= M3SD_ScAnimData(),--() : float
	SpeedFunctionFrequency 			= M3SD_ScAnimData(),--() : float

	fn copyData source_FP seq: m3: dir:#fromfile mult:1.0 anim:true =
	(
		local base_speed = 1.0
		case dir of
		(
			#fromfile:
			(
				base_speed = if(source_FP.subRibSpeed == 0)then
					(100.0)else(source_FP.subRibSpeed * 100.0)
			)
			#tofile:
			()
			default:
			()
		)

		M3F_AnimApply dir this source_FP \
			"InitialVelocitySpeedMin" "rfaSubSpeedMult" seq:seq m3:m3 ea:anim c:true mult:(base_speed*mult)

		M3F_DataApply dir this source_FP "YawFunctionOverlay" 		"yawType"
		M3F_DataApply dir this source_FP "PitchFunctionOverlay" 	"pitchType"
		M3F_DataApply dir this source_FP "SpeedFunctionOverlay" 	"speedType"

		M3F_AnimApply dir this source_FP \
			"InitialVelocityYaw" "rfaYaw" seq:seq m3:m3 ea:anim
		M3F_AnimApply dir this source_FP \
			"InitialVelocityPitch" "rfaPitch" seq:seq m3:m3 ea:anim

		M3F_AnimApply dir this source_FP \
		"YawFunctionAmplitude" "rfaYawAmp" seq:seq m3:m3 ea:anim
		M3F_AnimApply dir this source_FP \
		"YawFunctionFrequency" "rfaYawFreq" seq:seq m3:m3 ea:anim

		M3F_AnimApply dir this source_FP \
		"PitchFunctionAmplitude" "rfaPitchAmp" seq:seq m3:m3 ea:anim
		M3F_AnimApply dir this source_FP \
		"PitchFunctionFrequency" "rfaPitchFreq" seq:seq m3:m3 ea:anim

		M3F_AnimApply dir this source_FP \
		"SpeedFunctionAmplitude" "rfaSpeedAmp" seq:seq m3:m3 ea:anim
		M3F_AnimApply dir this source_FP \
		"SpeedFunctionFrequency" "rfaSpeedFreq" seq:seq m3:m3 ea:anim
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

	fn copyData source_FP seq: m3: dir:#fromfile mult:1.0 anim:true =
	(
		case dir of
		(
			#fromfile:
			(
				this.AttackUseRange = if(source_FP.attack[2] == 0)then(false)else(true)
				this.HoldUseRange = if(source_FP.attack[2] == 0)then(false)else(true)
				this.DecayUseRange = if(source_FP.attack[2] == 0)then(false)else(true)
				this.HoldInfinite = false
				if(source_FP.splatAtt > 1)then
				(
					this.UseAttenuation = true
					this.AttenuationPercent = ((source_FP.splatAtt - 1) / source_FP.splatAtt) * 100
				)else
				(
					this.UseAttenuation = false
					this.AttenuationPercent = 0
				)
				this.SplatLayer = case source_FP.layer of
				(
					0: 0
					1: 1
					2: 2
					3: 3
					4: 4
					6: 5
					7: 6
					8: 7
					11: 8
					12: 9
					default: 0
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
				M3F_DataApply dir this source_FP "SplatLayer" 				""
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
		M3F_DataApply dir this source_FP "SplatLODReduction" 		"LODreduce"
		M3F_DataApply dir this source_FP "SplatLODCut" 				"LODcut"
		
		M3F_AnimApply dir this source_FP \
		"orth_width" "rfaPlusX" seq:seq m3:m3 ea:anim c:true mult:(200.0*mult) \
		anim:"orth_width" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"orth_height" "rfaPlusY" seq:seq m3:m3 ea:anim c:true mult:(200.0*mult) \
		anim:"orth_height" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"orth_depth" "rfaPlusZ" seq:seq m3:m3 ea:anim c:true mult:(200.0*mult) \
		anim:"orth_depth" trk:trk tp:tp
		
		M3F_AnimApply dir this source_FP \
		"pers_fov" "rfaFOV" seq:seq m3:m3 ea:anim \
		anim:"pers_fov" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"pers_aspect_ratio" "rfaAsRatio" seq:seq m3:m3 ea:anim \
		anim:"pers_aspect_ratio" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"pers_near" "rfaNear" seq:seq m3:m3 ea:anim c:true mult:mult \
		anim:"pers_near" trk:trk tp:tp
		M3F_AnimApply dir this source_FP \
		"pers_far" "rfaFar" seq:seq m3:m3 ea:anim c:true mult:mult \
		anim:"pers_far" trk:trk tp:tp
		
		M3F_AnimApply dir this source_FP \
		"Alive" "rfaAlive" seq:seq m3:m3 ea:anim type:#bool \
		anim:"Alive" trk:trk tp:tp
	)
)

---------Physics Data
struct M3SD_ScForce
(
	Type 							,--() : integer
	Shape 							,--() : integer
	ForceFieldGroups 				,--() : integer

	ForceFieldFalloff 				,--() : boolean
	ForceFieldHeightGradient 		,--() : boolean
	ForceFieldUnbounded 			,--() : boolean
	ForceFieldAffectParticles 		,--() : boolean
	ForceFieldAffectPhysicsBodies 	,--() : boolean

	ForceFieldStrength 				= M3SD_ScAnimData(),--() : float
	ForceFieldRadius 				= M3SD_ScAnimData(),--() : float
	ForceFieldHeight 				= M3SD_ScAnimData(),--() : float
	ForceFieldLength 				= M3SD_ScAnimData(),--() : float
	--Scope () : integer

	fn copyData source_FP seq: m3: dir:#fromfile mult:1.0 =
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
		
		M3F_DataApply dir this source_FP "Type" 							"fTypes"
		M3F_DataApply dir this source_FP "Shape" 							"fShapes"
		M3F_DataApply dir this source_FP "ForceFieldGroups" 				"fLocalChns"
		M3F_DataApply dir this source_FP "ForceFieldFalloff" 				"fFlags.bits[1]"
		M3F_DataApply dir this source_FP "ForceFieldHeightGradient" 		"fFlags.bits[2]"
		M3F_DataApply dir this source_FP "ForceFieldUnbounded" 				"fFlags.bits[3]"
		M3F_DataApply dir this source_FP "ForceFieldAffectParticles" 		"fFlags.bits[4]"
		M3F_DataApply dir this source_FP "ForceFieldAffectPhysicsBodies" 	"fFlags.bits[5]"

		M3F_AnimApply dir this source_FP \
		"ForceFieldStrength" "rfaStrength" seq:seq m3:m3 c:true mult:100.0 \
		anim:"ForceFieldStrength" trk:trk tp:tp

		if(this.ForceFieldUnbounded == false)then
		(
			M3F_AnimApply dir this source_FP \
			"ForceFieldRadius" "rfaWidth" seq:seq m3:m3 c:true mult:(100.0*mult) \
			anim:"ForceFieldRadius" trk:trk tp:tp
			M3F_AnimApply dir this source_FP \
			"ForceFieldHeight" "rfaHeight" seq:seq m3:m3 c:true mult:(200.0*mult) \
			anim:"ForceFieldHeight" trk:trk tp:tp
			M3F_AnimApply dir this source_FP \
			"ForceFieldLength" "rfaLength" seq:seq m3:m3 c:true mult:(200.0*mult) \
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

	fn copyData source_FP seq: m3: dir:#fromfile mult:1.0 =
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
		"VertexWarpRadius" "rfaRadius" seq:seq m3:m3 c:true mult:(100.0*mult)
		M3F_AnimApply dir this source_FP \
		"VertexWarpHeight" "rfaHeight" seq:seq m3:m3 c:true mult:mult
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
	--UI parameter-----------------------
	isRigidBody 					,--: boolean
	isClothCollider 				,--: boolean
	--customMesh 					,--: maxObject
	--ConvexHull 					,--: maxObject
	--mass 							,--: float
	--Dummy

	fn copyData source_FP seq: m3: dir:#fromfile mult:1.0 =
	(
		case dir of
		(
			#fromfile:
			(
				this.isRigidBody = true
				this.isClothCollider = false
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
						this.length = source_FP.rfdRigedBody.data.size1 * 200 * mult
						this.width = source_FP.rfdRigedBody.data.size0 * 200 * mult
						this.height = source_FP.rfdRigedBody.data.size2 * 200 * mult
					)
					2:
					(
						this.radius = source_FP.rfdRigedBody.data.size0 * 100 * mult
						this.length = 50.0
						this.width = 50.0
						this.height = 50.0
					)
					3:
					(
						this.radius = source_FP.rfdRigedBody.data.size0 * 100 * mult
						this.length = 50.0
						this.width = 50.0
						this.height = (source_FP.rfdRigedBody.data.size1*100*mult) + this.radius*2
					)
					4:
					(
						this.radius = source_FP.rfdRigedBody.data.size0 * 100 * mult
						this.length = 50.0
						this.width = 50.0
						this.height = source_FP.rfdRigedBody.data.size1 * 100 * mult
					)
					default:
					(
						this.radius = 25.0
						this.length = 50.0
						this.width = 50.0
						this.height = 50.0
					)
				)
				this.maxVerts = source_FP.rfdRigedBody.data.vertNbr
			)
			#tofile:
			()
			default:
			(
				M3F_DataApply dir this source_FP "isRigidBody" 			""
				M3F_DataApply dir this source_FP "isClothCollider" 		""
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
		try(this_item.buildSceneData m t)catch
		(
			M3F_ShowPhaseInfo ("TrackSetError:"+getCurrentException()) type:#Error
			throw()
		)
		return this_item
	),

	fn releaseData behholder_FP \
		scmat_FP scbone_FP scmesh_FP sclight_FP sccam_FP scpar_FP scphy_FP scevent_FP schelp_FP =
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
				8:--Helpers
				(
					local the_obj = schelp_FP[index3].theHelper
				)
				9:--LensFlares
				(
					local the_obj = scmesh_FP[index3].theMesh
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
		local sts_idx = 0

		this.nameStr = copy track_FP

		if(matchPattern this.nameStr pattern:"EmptyTrackSet_*")then
		(
			local anim_name = subString this.nameStr 15 -1
			this.animPropList = #(anim_name)
			this.priorityList = #(0)
			M3F_ShowLogInfo ("Empty TrackSet ! name:" + this.nameStr) type:#Warning
		)else
		(
			for i=1 to m3_stc.count do
			(
				if((findString m3_stc[i].rfdName.data this.nameStr) != undefined)then
				(
					local anim_name = subString m3_stc[i].rfdName.data 1 \
					(m3_stc[i].rfdName.data.count - this.nameStr.count - 1)
					append this.animPropList anim_name
					append this.priorityList m3_stc[i].animPriority
					sts_idx = m3_stc[i].idxSTS + 1
				)
			)
			if(sts_idx > 0)then
			(
				if(m3_sts[sts_idx].rfdAnimID.data != undefined)then
				(
					this.animIDlist = deepCopy m3_sts[sts_idx].rfdAnimID.data
				)
			)
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
		try(this_item.buildSceneData m i)catch
		(
			M3F_ShowPhaseInfo ("AnimPropError:"+getCurrentException()) type:#Error
			throw()
		)
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
		local default_concurrent = 0
		for i=1 to m3_animset.count do
		(
			if(m3_animset[i].rfdName.data == (this.nameStr+"_full"))then
			(
				this.defaultPriority = m3_animset[i].animPriority
				default_concurrent = m3_animset[i].runsConcurrent
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
		if(this.tracksetsList.count == 0 and this.subAnim and default_concurrent == 1)then
		(
			append this.tracksetsList ("EmptyTrackSet_" + this.nameStr)
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
		try(this_item.buildSceneData m s t i)catch
		(
			M3F_ShowPhaseInfo ("MaterialError:"+getCurrentException()) type:#Error
			throw()
		)
		this_item
	),

	fn releaseData idx_FP =
	(
		local i, the_mat
		local first_show = false
		local layer_map_prop = #()
		local layer_count = 0
		local has_store_data = true
		case this.matTypes of
		(
			1:
			(
				the_mat = SC2_Standard_Material()
				the_mat.MatSubType = this.storeData.MatSubType
				layer_map_prop = \
				#(
					#Diffuse, #Decal, #Gloss, #GlossExp, #Emissive1, #Emissive2, #Environment,
					#EnvironmentMask, #AlphaMask, #AlphaMask2, #NormalMap, #Heightmap, #Lightmap,
					#AmbientOcclusion, #NormBlendMask1, #NormBlendMask2, #NormBlendNormal1, #NormBlendNormal2
				)
				layer_count = 18
			)
			2:
			(
				the_mat = SC2_Displacement_Material()
				layer_map_prop = #(#Displacement, #DisplacementStrengthTexture)
				layer_count = 2
			)
			3:
			(
				local the_mat = SC2_Composite_Material()
			)
			4:
			(
				local the_mat = SC2_Terrain_Material()
				layer_map_prop = #(#TerrainMaterial)
				layer_count = 1
				has_store_data = false
			)
			5:
			(
				local the_mat = SC2_Volume_Material()
				layer_map_prop = #(#ColorMap, #Noisy1, #Noisy2)
				layer_count = 3
			)
			7:
			(
				local the_mat = SC2_Creep_Material()
				the_mat.CreepRequiredOnLowEnd = this.storeData
				layer_map_prop = #(#CreepMaterial)
				layer_count = 1
				has_store_data = false
			)
			8:
			(
				local the_mat = SC2_Volume_Noise_Material()
				layer_map_prop = #(#ColorMap, #VolumeNoise1, #VolumeNoise2)
				layer_count = 3
			)
			9:
			(
				local the_mat = SC2_SplatTerrainBake_Material()
				layer_map_prop = #(#DiffuseTexture, #NormalTexture, #SpecularTexture)
				layer_count = 3
				has_store_data = false
			)
			10:
			(
				local the_mat = SC2_Reflection_Material()
				layer_map_prop = #(#Strength_Map, #Normal_Map, #Blur_Mask_Map)
				layer_count = 3
			)
			11:
			(
				local the_mat = SC2_Lens_Flare_Material()
				layer_map_prop = #(#Normal_Map, #Dirty_Lens)
				layer_count = 2
			)
			default:
			(
				this.theMat = SC2_Standard_Material()
				return false
			)
		)

		if(has_store_data)then(this.storeData.copyData the_mat dir:#toscene)
		for i=1 to this.mapsData.count where i <= layer_count do
		(
			case this.mapsData[i].MapType of
			(
				0: continue
				2: setProperty the_mat layer_map_prop[i] (SC2_Color())
			)
			local layer_map = getProperty the_mat layer_map_prop[i]
			this.mapsData[i].copyData layer_map dir:#toscene
			this.validateTexture layer_map
			if(first_show != true)then
			(
				showTextureMap the_mat (getProperty the_mat layer_map_prop[i]) true
				first_show = true
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
				
				this.storeData.copyData m3_mat trk:track_FP tp:track_tp \
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

				this.storeData.copyData m3_mat trk:track_FP tp:track_tp \
					seq:scseq_FP m3:m3obj_FP dir:#fromfile
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

				this.storeData.copyData m3_mat trk:track_FP tp:track_tp \
					seq:scseq_FP m3:m3obj_FP dir:#fromfile

				this.buildMapData 1 m3_mat.rfdColorMap.data \
					trk:track_FP tp:track_tp seq:scseq_FP m3:m3obj_FP
				this.buildMapData 2 m3_mat.rfdNoisyMap1.data \
					trk:track_FP tp:track_tp seq:scseq_FP m3:m3obj_FP
				this.buildMapData 3 m3_mat.rfdNoisyMap2.data \
					trk:track_FP tp:track_tp seq:scseq_FP m3:m3obj_FP
			)
			--6:--SC2_Hair_Material
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
				this.storeData.copyData m3_mat trk:track_FP tp:track_tp \
					seq:scseq_FP m3:m3obj_FP dir:#fromfile

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
			10:--SC2_Reflection_Material
			(
				local m3_mat = m3obj_FP.fREF[index]
				this.nameStr = copy m3_mat.rfdName.data
				this.storeData = M3SD_ScReflectionMat()

				this.storeData.copyData m3_mat trk:track_FP tp:track_tp \
					seq:scseq_FP m3:m3obj_FP dir:#fromfile 

				this.buildMapData 1 m3_mat.rfdRefectMap.data \
					trk:track_FP tp:track_tp seq:scseq_FP m3:m3obj_FP
				this.buildMapData 2 m3_mat.rfdDispMap.data \
					trk:track_FP tp:track_tp seq:scseq_FP m3:m3obj_FP
				this.buildMapData 3 m3_mat.rfdBlurMap.data \
					trk:track_FP tp:track_tp seq:scseq_FP m3:m3obj_FP
			)
			11:--SC2_Flare_Material
			(
				local m3_mat = m3obj_FP.fLFLR[index]
				this.nameStr = copy m3_mat.rfdName.data
				this.storeData = M3SD_ScFlareMat()
				
				this.storeData.copyData m3_mat trk:track_FP tp:track_tp \
					seq:scseq_FP m3:m3obj_FP dir:#fromfile 
				
				this.buildMapData 1 m3_mat.rfdFlareMap.data \
					trk:track_FP tp:track_tp seq:scseq_FP m3:m3obj_FP
				this.buildMapData 2 m3_mat.rfdMaskMap.data \
					trk:track_FP tp:track_tp seq:scseq_FP m3:m3obj_FP
			)
			default:
			(
				M3F_ShowLogInfo \
					(M3F_FormatToString "has UnKnown Material Type! type:%" #(this.matTypes)) \
					type:#Warning
			)
		)
	),
	fn releaseCompSubMat scmat_FP =
	(
		local i
		if(this.matTypes == 3)then
		(
			for i=1 to this.storeData.SubMaterials.count do
			(this.theMat.SubMaterials[i] = scmat_FP[this.storeData.SubMaterials[i]].theMat)
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
				local map_name = filenameFromPath map_FP.FileName
				local path_found = (mapPaths.getFullFilePath map_name)
				if(path_found != "")then
				(
					map_FP.FileName = path_found
				)else
				(
					M3F_ShowLogInfo ("Missing Texture: " + map_name) type:#Warning
					M3F_MissingMap map_name
				)
			)
		)
	)
)

struct M3S_ScBone
(
	nameStr = "", parentBone, bindingPose,
	dPosition = M3SD_ScAnimData(),
	dRotation = M3SD_ScAnimData(),
	dScale = M3SD_ScAnimData(),
	Visibility = M3SD_ScAnimData(),
	theBone, theObj, boneType = 0,
	---------------------------------
	theBoneScale, fixDir = matrix3 1, applyCheck = false,

	fn init m: s: t: i: =
	(
		local this_item
		try(this_item = this)catch(this_item = M3S_ScBone())
		try(this_item.buildSceneData m s t i)catch
		(
			M3F_ShowPhaseInfo ("BoneError:"+getCurrentException()) type:#Error
			throw()
		)
		return this_item
	),

	fn releaseData scbone_FP =
	(
		if(this.theBone != undefined)then(return true)

		local start_pos = this.bindingPose.translation
		local glb_size1 = M3F_GetGlobalSettings #BoneSize1
		local glb_size2 = M3F_GetGlobalSettings #BoneSize2
		local glb_size3 = M3F_GetGlobalSettings #BoneSize3
		local glb_type = M3F_GetGlobalSettings #BoneEntity
		local glb_scale = M3F_GetGlobalSettings #GlobalScale
		local glb_link = M3F_GetGlobalSettings #BoneLink
		local glb_fix = M3F_GetGlobalSettings #BoneFix
		local glb_pos_ctl = M3F_GetGlobalSettings #BonePosCtl
		local glb_rot_ctl = M3F_GetGlobalSettings #BoneRotCtl
		local glb_scale_ctl = M3F_GetGlobalSettings #BoneScaleCtl

		if(this.boneType == 0)then
		(
			case glb_type of
			(
				1:	--StandardBone
				(
					this.theBone = BoneSys.CreateBone start_pos (start_pos + [glb_size2,0,0]) [0,0,1]
					this.theBone.Width = glb_size1
					this.theBone.Height = glb_size1
					this.theBone.boneScaleType=#none
				)
				2:	--Dummy
				(
					this.theBone = dummy pos:start_pos
					this.theBone.boxsize = [glb_size3*1.4, glb_size1, glb_size2]
				)
				3:	--Box
				(
					this.theBone = Box lengthsegs:1 widthsegs:1 heightsegs:1 pos:start_pos
					this.theBone.length = glb_size1
					this.theBone.width = glb_size2
					this.theBone.height = glb_size3
					this.theBone.objectOffsetRot = eulerAngles 0 90 0
				)
				4:	--Pyramid
				(
					this.theBone = Pyramid widthsegs:1 depthSegs:1 heightsegs:1 pos:start_pos
					this.theBone.width = glb_size1
					this.theBone.depth = glb_size2
					this.theBone.height = glb_size3
					this.theBone.objectOffsetRot = eulerAngles 0 90 0
					this.theBone.wireColor = color 174 186 203
				)
				5:	--NoneEntity
				(
					this.theBone = BoneSys.CreateBone start_pos (start_pos + [0.05,0,0]) [0,0,1]
					this.theBone.boneScaleType=#none
					this.theBone.showLinks = true
					this.theBone.showLinksOnly = true
				)
			)
		)else
		(
			this.theBone = dummy()
			case this.boneType of
			(
				2: this.theBone.boxsize = [10,10,10] * glb_scale
				4: this.theBone.boxsize = [7.5,7.5,7.5] * glb_scale
				6: this.theBone.boxsize = [7.5,7.5,7.5] * glb_scale
			)
		)
		if(glb_link)then(this.theBone.showLinks = true)
		if(classOf this.theBone.Pos.controller != glb_pos_ctl)then
		(this.theBone.Pos.controller = glb_pos_ctl())
		if(classOf this.theBone.Rotation.controller != glb_rot_ctl)then
		(this.theBone.Rotation.controller = glb_rot_ctl())
		if(classOf this.theBone.Scale.controller != glb_scale_ctl)then
		(this.theBone.Scale.controller = glb_scale_ctl())
		this.theBone.name = this.nameStr
		this.theBone.transform = this.bindingPose

		if(this.parentBone > 0 and this.parentBone < 0xFFFF)then
		(
			local parent_bone = scbone_FP[this.parentBone]
			if(parent_bone.theBone == undefined)then
			(
				parent_bone.releaseData scbone_FP
			)

			if(parent_bone.boneType == 0 and this.boneType == 0 and glb_type != 5)then
			(
				case glb_type of
				(
					1:
					(
						local glb_size_cmp = glb_size2
						local curlens = parent_bone.theBone.length
					)
					2:
					(
						local glb_size_cmp = glb_size3
						local curlens = parent_bone.theBone.boxsize[1] / 1.4
						local base_rot = quat 0 0 0 1
						local obj_axis_x = [1,0,0]
					)
					3:
					(
						local glb_size_cmp = glb_size3
						local curlens = parent_bone.theBone.height
						local base_rot = quat 0 -0.707107 0 0.707107
						local obj_axis_x = [0,0,1]
					)
					4:
					(
						local glb_size_cmp = glb_size3
						local curlens = parent_bone.theBone.height
						local base_rot = quat 0 -0.707107 0 0.707107
						local obj_axis_x = [0,0,1]
					)
				)

				local local_axis_x = (this.bindingPose * (inverse parent_bone.bindingPose)).translation
				local lens = amax (length local_axis_x) glb_size_cmp

				if((abs local_axis_x[2]) < 0.005 and (abs local_axis_x[3]) < 0.005)then
				(local_axis_x = [local_axis_x[1],0,0])

				if(parent_bone.theBone.children.count == 0 or lens < curlens)then
				(
					case glb_type of
					(
						1: parent_bone.theBone.length = lens
						2: parent_bone.theBone.boxsize = \
							[lens*1.4, parent_bone.theBone.boxsize[2], parent_bone.theBone.boxsize[3]]
						3: parent_bone.theBone.height = lens
						4: parent_bone.theBone.height = lens
					)
				)

				if(glb_fix)then
				(
					if(parent_bone.theBone.children.count == 0)then
					(
						if((normalize local_axis_x) != [1,0,0])then
						(
							parent_bone.fixDir = M3F_GetMatrixFromVector local_axis_x
						)
					)else
					(
						local old_axis_x = [1,0,0] * parent_bone.fixDir
						if((normalize local_axis_x) != old_axis_x)then
						(
							parent_bone.fixDir = \
								M3F_GetMatrixFromVector (((normalize local_axis_x) + old_axis_x) / 2)
						)
					)
				)else if(glb_type != 1)then
				(
					if(parent_bone.theBone.children.count == 0)then
					(
						if((normalize local_axis_x) != [1,0,0])then
						(
							parent_bone.theBone.objectOffsetRot = base_rot * \
								(M3F_GetMatrixFromVector local_axis_x).rotationpart
						)
					)else
					(
						local old_axis_x = obj_axis_x * parent_bone.theBone.objectOffsetRot
						if((normalize local_axis_x) != old_axis_x)then
						(
							parent_bone.theBone.objectOffsetRot = base_rot * (M3F_GetMatrixFromVector \
								(((normalize local_axis_x) + old_axis_x) / 2)).rotationpart
						)
					)
				)
			)
			this.theBone.Parent = parent_bone.theBone
		)

		M3F_AnimApply #toscene this this.theBone "Visibility" ""
		M3F_AddToLayer "Bones" this.theBone
	),

	fn calculateBoxBoundary =
	(
		if(this.boneType == 0 and this.theBone.children.count > 1)then
		(
			local min_vec
			local min_dis = 0xFFFFFFFF
			local glb_fix = M3F_GetGlobalSettings #BoneFix
			local glb_size1 = (M3F_GetGlobalSettings #BoneSize1) / 2
			local glb_size2 = (M3F_GetGlobalSettings #BoneSize2) / 2
			local glb_min_dis = sqrt (glb_size1*glb_size1 + glb_size2*glb_size2)

			if(glb_fix)then
			(
				local local_axis_x = [1,0,0] * this.theBone.transform.rotationpart
				local local_axis_y = [0,1,0] * this.theBone.transform.rotationpart
				local local_axis_z = [0,0,1] * this.theBone.transform.rotationpart
			)else
			(
				local local_axis_x = [0,0,1] * this.theBone.objectOffsetRot
				local local_axis_y = [0,1,0] * this.theBone.objectOffsetRot
				local local_axis_z = [1,0,0] * this.theBone.objectOffsetRot
			)
			
			for i=1 to this.theBone.children.count do
			(
				local vec_temp = this.theBone.children[i].pos - this.theBone.pos
				vec_temp = vec_temp - local_axis_x * (dot vec_temp local_axis_x)

				local vertical_dis = length vec_temp

				if(min_dis > vertical_dis)then
				(
					min_dis = vertical_dis
					min_vec = copy vec_temp
				)
			)
			if(min_dis > glb_min_dis)then
			(
				local glb_type = M3F_GetGlobalSettings #BoneEntity
				local weight_y = dot min_vec local_axis_y
				local weight_z = dot min_vec local_axis_z

				if(weight_y <= glb_size1)then
				(
					local reweight_y = glb_size1 * 2
					local reweight_z = (sqrt (min_dis*min_dis - glb_size1*glb_size1)) * 2
				)else if(weight_z <= glb_size2)then
				(
					local reweight_y = (sqrt (min_dis*min_dis - glb_size2*glb_size2)) * 2
					local reweight_z = glb_size2 * 2
				)else
				(
					local reweight_y = weight_y * 2
					local reweight_z = weight_z * 2
				)
				if(glb_type == 2)then
				(
					this.theBone.boxsize = [this.theBone.boxsize[1], reweight_y, reweight_z]
				)else
				(
					this.theBone.length = reweight_y
					this.theBone.width = reweight_z
				)
			)
		)
	),

	fn bindingPoseApply =
	(
		local i
		local fix_x = [1,0,0] * this.fixDir
		local fix_y = [0,1,0] * this.fixDir
		local fix_z = [0,0,1] * this.fixDir

		if(((abs fix_x[1]) != 1 and (abs fix_x[2]) != 1 and (abs fix_x[3]) != 1) or \
			((abs fix_y[1]) != 1 and (abs fix_y[2]) != 1 and (abs fix_y[3]) != 1) or \
			((abs fix_z[1]) != 1 and (abs fix_z[2]) != 1 and (abs fix_z[3]) != 1))then
		(
			local fix_check = false
			local local_scale = (this.bindingPose * (inverse this.theBone.parent.transform)).scalepart
			local copy_dkeys = makeUniqueArray (deepCopy this.dScale.dkeys)
			insertItem local_scale copy_dkeys 1
			for i=1 to copy_dkeys.count do
			(
				if((copy_dkeys[i] - copy_dkeys[i][1]) != [0,0,0])then
				(
					fix_check = true; exit
				)
			)

			if(fix_check)then
			(
				local glb_scale = M3F_GetGlobalSettings #GlobalScale
				this.theBoneScale = Dummy name:(this.nameStr + "_FixScale")
				this.theBoneScale.boxsize = [5,5,5] * glb_scale

				M3F_CopyController this.theBoneScale this.theBone

				this.theBoneScale.transform = this.bindingPose
				this.theBoneScale.parent = this.theBone.parent
				this.theBone.parent = this.theBoneScale

				M3F_AddToLayer "FixedBones" this.theBoneScale

				M3F_ShowLogInfo \
					(M3F_FormatToString ("The revised coordinate of (%) is non-orthogonal coordinate. " + \
						"Create a Dummy to prevent animation distortion!") #(this.nameStr)) \
					type:#Warning
			)
		)
		
		if(this.theBoneScale != undefined)then(this.theBoneScale.Transform = this.bindingPose)
		this.theBone.Transform = this.fixDir * this.bindingPose
		--this.theBone.SetSkinPose()
	),

	fn animApply scbone_FP =
	(
		local i
		BezierDefaultParams.inTangentType = #flat
		BezierDefaultParams.outTangentType = #flat
		local the_bone = if(this.theBoneScale != undefined)then(this.theBoneScale)else(this.theBone)
		--this.theBone.AssumeSkinPose()

		with animate on
		(
			for i=1 to this.dRotation.frames.count do
			(
				at time this.dRotation.frames[i]
				(
					local mtrx = rotate (matrix3 1) (inverse this.dRotation.dkeys[i])
					if(this.theBoneScale == undefined)then(mtrx = this.fixDir * mtrx)
					
					if(the_bone.parent != undefined)then
					(
						mtrx = mtrx * ((inverse scbone_FP[this.parentBone].fixDir) * the_bone.parent.transform)
					)

					the_bone.transform = mtrx
					deleteKey the_bone.Position.controller \
					(numKeys the_bone.Position.controller)
					deleteKey the_bone.Scale.controller \
					(numKeys the_bone.Scale.controller)
				)
			)

			for i=1 to this.dScale.frames.count do
			(
				local index_temp = undefined
				addNewKey the_bone.Scale.controller this.dScale.frames[i]
				for n=1 to the_bone.Scale.controller.keys.count do
				(
					if(the_bone.Scale.controller.keys[n].time == this.dScale.frames[i])then
					(index_temp = n; exit)
				)
				
				if(index_temp != undefined)then
				(
					if(this.theBoneScale != undefined)then
					(
						local real_value = this.dScale.dkeys[i]
					)else
					(
						local mtrx = xformMat (scaleMatrix this.dScale.dkeys[i]) this.fixDir
						local real_value = mtrx.scalepart * mtrx.determinantsign
					)

					case (classOf the_bone.Scale.controller) of
					(
						ScaleXYZ:
						(
							the_bone.Scale.controller.x_scale.Keys[index_temp].value = real_value[1]*100
							the_bone.Scale.controller.y_scale.Keys[index_temp].value = real_value[2]*100
							the_bone.Scale.controller.z_scale.Keys[index_temp].value = real_value[3]*100
						)
						Bezier_Scale:
						(
							the_bone.Scale.controller.Keys[index_temp].value = real_value
						)
					)
				)
			)

			for i=1 to this.dPosition.frames.count do
			(
				at time this.dPosition.frames[i]
				(
					if(the_bone.parent != undefined)then
					(
						in coordsys ((inverse scbone_FP[this.parentBone].fixDir) * the_bone.parent.transform)
						(
							the_bone.pos = this.dPosition.dkeys[i]
						)
					)else
					(
						the_bone.pos = this.dPosition.dkeys[i]
					)
				)
			)
		)
		if(this.parentBone <= 0 or this.parentBone >= 0xFFFF)then
		(
			local glb_pos = M3F_GetGlobalSettings #GlobalPos
			the_bone.pos = the_bone.pos + glb_pos
		)
	),

	fn collectData =(),

	fn buildSceneData m3obj_FP scseq_FP track_FP idx_FP =
	(
		local i
		local m3_bone = m3obj_FP.fBONE[idx_FP]
		local m3_iref = m3obj_FP.fIREF[idx_FP]
		local track_tp = idx_FP * 10000 + 200
		local glb_scale = M3F_GetGlobalSettings #GlobalScale

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
											(m3_iref.matrix[4] * 100 * glb_scale))

		M3F_AnimApply #fromfile this m3_bone \
			"dPosition" "rfaPos" seq:scseq_FP m3:m3obj_FP c:true mult:(100.0 * glb_scale) \
			anim:"position" trk:track_FP tp:track_tp
		M3F_AnimApply #fromfile this m3_bone \
			"dRotation" "rfaRot" seq:scseq_FP m3:m3obj_FP c:true mult:1.0 \
			anim:"rotation" trk:track_FP tp:track_tp
		M3F_AnimApply #fromfile this m3_bone \
			"dScale" "rfaScale" seq:scseq_FP m3:m3obj_FP c:true mult:1.0 \
			anim:"scale" trk:track_FP tp:track_tp
		M3F_AnimApply #fromfile this m3_bone \
			"Visibility" "rfaVisibility" seq:scseq_FP m3:m3obj_FP type:#bool \
			anim:"visibility" trk:track_FP tp:track_tp

		this.dRotation.frames[1] = 10
		this.dScale.frames[1] = 10
		this.dPosition.frames[1] = 10
	),

	fn copyBonesType list_FP type_FP idx_FP =
	(
		local index = findItem list_FP idx_FP
		if(index != 0)then
		(
			this.boneType = type_FP[index]
		)
	),

	fn buildBonesType scbone_FP scmesh_FP idx_FP =
	(
		local i
		if(this.parentBone > 0 and this.parentBone < 0xFFFF)then
		(
			case scbone_FP[this.parentBone].boneType of
			(
				1: scbone_FP[this.parentBone].boneType = 3
				5: scbone_FP[this.parentBone].boneType = 6
			)
		)
		if(this.boneType == 5)then
		(
			for i=1 to scmesh_FP.count do
			(
				if(scmesh_FP[i].meshTypes != 2)then
				(
					if((findItem scmesh_FP[i].skinBones idx_FP) != 0)then
					(
						this.boneType = 6
						exit
					)
				)
			)
		)
	),

	fn deleteBones =
	(
		if((M3F_GetGlobalSettings #BoneEnable) != true)then
		(
			delete this.theBone
			return undefined
		)

		if(classOf this.theBone.parent == BoneGeometry)then
		(
			local lens_temp = this.theBone.parent.length
			local parent_temp = this.theBone.parent
		)

		case this.boneType of
		(
			1: delete this.theBone
			5: delete this.theBone
			3:
			(
				local obj
				for obj in this.theBone.Children do
				(
					obj.Parent = this.theObj
				)
				delete this.theBone
			)
			default:()
		)
		if(parent_temp != undefined)then(parent_temp.length = lens_temp)
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
		try(this_item.buildSceneData m s t ib i)catch
		(
			M3F_ShowPhaseInfo ("EventError:"+getCurrentException()) type:#Error
			throw()
		)
		return this_item
	),

	fn releaseData scbone_FP =
	(
		local the_event = SC2Event()
		local self_bone = scbone_FP[this.nbrBone]
		self_bone.theObj = the_event
		the_event.name = this.nameStr

		the_event.parent = self_bone.theBone.parent
		M3F_CopyController the_event self_bone.theBone
		the_event.transform = this.bindingPose

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
		local glb_scale = M3F_GetGlobalSettings #GlobalScale

		for i=1 to track_FP.count do
		(track_FP[i].swapBoneTrack this.nbrBone track_tp)

		this.nameStr = copy m3_object.rfdName.data
		this.bindingPose = inverse (matrix3 m3_iref.matrix[1] \
											m3_iref.matrix[2] \
											m3_iref.matrix[3] \
											(m3_iref.matrix[4] * 100 * glb_scale))

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
	nameStr = "", rootBone, nbrBone, meshTypes,
	vertPos = #(), vertNormal = #(), vertColor = #(), vertWeightPair = #(),
	faces = #(), uvLayout = #(#(),#(),#(),#(),#(),#()), matIdx, skinBones = #(),
	lensFlareSize = M3SD_ScAnimData(), lensFlareColor = M3SD_ScAnimData(),
	lensFlareIntensity = M3SD_ScAnimData(), lensFlareLibMaterial,
	theMesh,

	fn init m: s: t: i: =
	(
		local this_item
		try(this_item = this)catch(this_item = M3S_ScMesh())
		try(this_item.buildSceneData m s t i)catch
		(
			M3F_ShowPhaseInfo ("MeshError:"+getCurrentException()) type:#Error
			throw()
		)
		this_item
	),

	fn releaseData scbone_FP scmat_FP =
	(
		local i, n, j, k
		local the_mesh = mesh 	vertices:this.vertPos	\
								faces:this.faces 		\
								vnorms:this.vertNormal	\
								name:this.nameStr
		
		if(this.meshTypes == 2)then
		(
			the_mesh.name = this.nameStr + "_ExtractedMesh"
			
			local vertlist = #{}
			for i=1 to the_mesh.numverts do(append vertlist i)
			meshop.weldVertsByThreshold the_mesh vertlist 0.001
			local old_facelist = #{}
 			for i=1 to the_mesh.numfaces do(append old_facelist i)
 			meshop.autoSmooth the_mesh old_facelist 30
			convertTo the_mesh Editable_Poly
			local face_list = #{}
			for i=1 to the_mesh.numfaces do(append face_list i)
			modPanel.setCurrentObject the_mesh
			subobjectLevel = 4
			polyop.setFaceSelection the_mesh face_list
			polyop.retriangulate the_mesh face_list

			the_mesh.WireColor = color (random 0 128) (random 0 255) (random 0 128)

			local the_flare = SC2LensFlare name:this.nameStr
			
			M3F_AnimApply #toscene this the_flare "lensFlareSize" ""
			M3F_AnimApply #toscene this the_flare "lensFlareColor" ""
			M3F_AnimApply #toscene this the_flare "lensFlareIntensity" ""
			
			if(this.lensFlareLibMaterial == "")then
			(
				the_flare.lensFlareLibMaterial = "Use Scene Material"
				the_flare.lensFlareMaterial = scmat_FP[this.matIdx].theMat
			)
			else(the_flare.lensFlareLibMaterial = this.lensFlareLibMaterial)
			
			the_flare.SC2Shapes.shapeType = 5
			the_flare.SC2Shapes.maxVerts = 32
			the_flare.SC2Shapes.customMesh = the_mesh
			the_flare.SC2Shapes.ConvexHull = the_mesh

			delete the_mesh

			local self_bone = scbone_FP[this.nbrBone]
			self_bone.theObj = the_flare
			the_flare.parent = self_bone.theBone.parent
			M3F_CopyController the_flare self_bone.theBone
			the_flare.transform = (inverse self_bone.fixDir) * the_flare.transform
			this.theMesh = the_flare
			M3F_AddToLayer "LensFlare" the_flare
			return true
		)

		for n=1 to 5 do
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
			meshop.setVertAlpha the_mesh -2 #(i) (this.vertColor[i][4] / 255.0)
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
					windows.processPostedMessages()
					setWaitCursor()
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
					windows.processPostedMessages()
					setWaitCursor()
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
								M3F_ShowLogInfo \
									(M3F_FormatToString "Weld Point Not Found! Index:%" #(point_array[i])) \
									type:#Warning
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
				skinOps.RemoveZeroWeights sk_mod
			)
			modPanel.setCurrentObject the_mesh
			windows.processPostedMessages()
			setWaitCursor()
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

		if(this.nbrBone < 0xFFFF)then
		(
			M3F_CopyController the_mesh scbone_FP[this.nbrBone].theBone type:#visibility
		)else
		(
			M3F_CopyController the_mesh scbone_FP[this.rootBone].theBone type:#visibility
		)
		
		this.theMesh = the_mesh
		update the_mesh
		local glb_pos = M3F_GetGlobalSettings #GlobalPos
		the_mesh.pos = glb_pos

		M3F_AddToLayer "Unit" the_mesh
	),

	fn collectData =(),

	fn buildSceneData m3obj_FP scseq_FP track_FP idx_FP =
	(
		--buildMeshData
		local i, j, n
		local m3_region = m3obj_FP.fDIV.rfdREGN.data[idx_FP] 
		local m3_bone = m3obj_FP.fBONE
		local m3_vert = m3obj_FP.fVERT.vertexs
		local m3_face = m3obj_FP.fDIV.rfdFace.data
		local m3_skinbone = m3obj_FP.fDIV.rfdBonelu.data
		local m3_bat = m3obj_FP.fDIV.rfdBAT.data
		local m3_mat = m3obj_FP.fMATM
		local uvw_mult = m3_region.uvwMult / 16.0
		local uvw_offset = m3_region.uvwOffset
		local glb_scale = M3F_GetGlobalSettings #GlobalScale

		for i=1 to m3_bat.count do
		(
			if((m3_bat[i].meshID+1) == idx_FP)then
			(
				this.matIdx = m3_bat[i].matID + 1
				this.nbrBone = m3_bat[i].nbrBone + 1
			)
		)
		this.meshTypes = if(m3_mat[this.matIdx].matTypes == 11)then(2)else(1)
		
		if(this.meshTypes != 2)then
		(
			this.rootBone = m3_region.rootBone + 1
			while m3_bone[this.rootBone].parent < 0xFFFF do
			(
				this.rootBone = m3_bone[this.rootBone].parent + 1
			)
			this.nameStr = M3F_FormatToString "Mesh %" #(idx_FP)
		)else
		(
			local track_tp = idx_FP * 10000 + 900
			local track_tp_mat = this.matIdx * 10000 + 100
			local m3_flare = m3obj_FP.fLFLR[m3_mat[this.matIdx].matIdx+1]
			local m3_irefs = m3obj_FP.fIREF

			this.rootBone = 0
			this.nbrBone = m3_region.rootBone + 1
			this.nameStr = copy m3_bone[this.nbrBone].rfdName.data

			local mtrx = inverse (matrix3 m3_irefs[this.nbrBone].matrix[1] \
										m3_irefs[this.nbrBone].matrix[2] \
										m3_irefs[this.nbrBone].matrix[3] \
										m3_irefs[this.nbrBone].matrix[4])
			local pos_offset = mtrx.translationpart
			local pos_scale = mtrx.scalepart

			for i=1 to track_FP.count do
			(track_FP[i].swapBoneTrack this.nbrBone track_tp)

			this.lensFlareLibMaterial = copy m3_flare.rfdLibName.data
			M3F_AnimApply #fromfile this m3_flare \
				"lensFlareSize" "rfaSize" seq:scseq_FP m3:m3obj_FP
			M3F_AnimApply #fromfile this m3_flare \
				"lensFlareColor" "rfaColor" seq:scseq_FP m3:m3obj_FP type:#color
			M3F_AnimApply #fromfile this m3_flare \
				"lensFlareIntensity" "rfaIntensity" seq:scseq_FP m3:m3obj_FP \
				anim:"LensFlareHDRScale" trk:track_FP tp:track_tp_mat
		)
		
		for i=1 to m3_region.nbrVert do
		(
			local index = m3_region.firstVert + i

			local vert_pos = if(this.meshTypes == 2)then
			((m3_vert[index].pos / pos_scale - pos_offset) * 100 * glb_scale)
			else(m3_vert[index].pos * 100 * glb_scale)

			append this.vertPos vert_pos
			append this.vertNormal (m3_vert[index].normal / 127.5)

			for n=1 to m3_vert[index].uv.count do
			(
				local u = (m3_vert[index].uv[n][1] * uvw_mult / 2048.0) + uvw_offset
				local v = 1 - ((m3_vert[index].uv[n][2] * uvw_mult / 2048.0) + uvw_offset)
				append this.uvLayout[n] [u, v, 0.0]
			)

			if(m3_vert[index].vColor != undefined)then
			(
				append this.vertColor \
					[m3_vert[index].vColor[3], \
					m3_vert[index].vColor[2], \
					m3_vert[index].vColor[1], \
					m3_vert[index].vColor[4]]
			)
			
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
			append this.skinBones (m3_skinbone[index] + 1)
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
	),

	fn replaceSkinedBone scbone_FP =
	(
		local i, n, m

		if(this.meshTypes == 2)then(return false)
		with redraw on
		(
			local sk_mod = this.theMesh.modifiers[#skin]
			if(sk_mod != undefined)then
			(
				max views redraw
				local delete_bone = 0
				modPanel.setCurrentObject sk_mod
				for i=1 to this.skinBones.count do
				(
					local index = this.skinBones[i]
					if(scbone_FP[index].boneType == 1 or scbone_FP[index].boneType == 3)then
					(
						local old_cur = i - delete_bone

						M3F_ShowLogInfo \
							(M3F_FormatToString "ReplaceWeights:% Bone:%" \
								#(this.nameStr, scbone_FP[index].nameStr)) \
							type:#Warning

						skinOps.addBone sk_mod scbone_FP[index].theObj -1

						local add_idx = skinOps.GetNumberBones sk_mod
						skinOps.SelectBone sk_mod old_cur
						skinOps.copySelectedBone sk_mod
						skinOps.pasteToBone sk_mod add_idx

						for n=1 to this.theMesh.numverts do
						(
							local bone_cnt = skinOps.GetVertexWeightCount sk_mod n
							for m=1 to bone_cnt do
							(
								if(old_cur == (skinOps.GetVertexWeightBoneID sk_mod n m))then
								(
									skinOps.SetVertexWeights sk_mod n add_idx \
										(skinOps.GetVertexWeight sk_mod n m)
								)
							)
						)
						skinOps.removebone sk_mod
						delete_bone += 1
					)
				)
				skinOps.RemoveZeroWeights sk_mod
				modPanel.setCurrentObject this.theMesh
			)
		)
	)
)

struct M3S_ScLight
(
	lightType, nameStr = "", nbrBone, bindingPose,
	targetBone = 0, targetName, targetPos = matrix3 1,
	shadowCast, specEnable, affectedByAO, lightOpaqueObj, lightTransObj, useTeamColor,
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
		try(this_item.buildSceneData m s t i)catch
		(
			M3F_ShowPhaseInfo ("LightError:"+getCurrentException()) type:#Error
			throw()
		)
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

				--the_light.shadowLODCut = this.shadowLODcut
				M3F_AnimApply #toscene this the_light \
					"falloff" ""
				M3F_AnimApply #toscene this the_light \
					"hotspot" ""
			)
			default: return undefined
		)
		local self_bone = scbone_FP[this.nbrBone]
		local glb_mtrx_anim = M3F_GetGlobalSettings #LightTrans
		local glb_parm_anim = M3F_GetGlobalSettings #LightParm
		self_bone.theObj = the_light
		the_light.name = this.nameStr

		the_light.parent = self_bone.theBone.parent
		try(the_target.parent = the_light.parent)catch()

		if(glb_mtrx_anim)then
		(
			if(this.lightType == 1)then
			(
				M3F_CopyController the_light self_bone.theBone
			)else
			(
				M3F_CopyController the_light self_bone.theBone type:#pos
				M3F_CopyController the_light self_bone.theBone type:#scale
			)
		)
		the_light.transform = this.bindingPose

		the_light.shadowCast = this.shadowCast
		the_light.Specular =  this.specEnable
		the_light.affectedByAO = this.affectedByAO
		the_light.lightOpaqueObjects = this.lightOpaqueObj
		the_light.lightTransparentObjects = this.lightTransObj
		the_light.useTeamColor = this.useTeamColor
		the_light.lightLODCut = this.LODcut

		M3F_AnimApply #toscene this the_light "diffuseColor" "" ea:glb_parm_anim
		M3F_AnimApply #toscene this the_light "intensity" "" ea:glb_parm_anim
		M3F_AnimApply #toscene this the_light "specularcolor" "" ea:glb_parm_anim
		M3F_AnimApply #toscene this the_light "specularMultiplier" "" ea:glb_parm_anim
		M3F_AnimApply #toscene this the_light "attenStart" "" ea:glb_parm_anim
		M3F_AnimApply #toscene this the_light "decay" "" ea:glb_parm_anim

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
		local glb_scale = M3F_GetGlobalSettings #GlobalScale

		for i=1 to track_FP.count do
		(track_FP[i].swapBoneTrack this.nbrBone track_tp)

		this.lightType = m3_light.lTypes
		this.nameStr = copy m3_object.rfdName.data
		this.bindingPose = inverse (matrix3 m3_iref.matrix[1] \
											m3_iref.matrix[2] \
											m3_iref.matrix[3] \
											(m3_iref.matrix[4] * 100 * glb_scale))
		if this.targetBone != 0 then
		(
			this.targetName = copy m3_bone[this.targetBone].rfdName.data
			this.targetPos = inverse (matrix3 m3_irefs[this.targetBone].matrix[1] \
											m3_irefs[this.targetBone].matrix[2] \
											m3_irefs[this.targetBone].matrix[3] \
											(m3_irefs[this.targetBone].matrix[4] * 100 * glb_scale))
		)else
		(
			this.targetName = this.nameStr + "_Target"
			this.targetPos.translation = [0.0,0.0,-100.0] * glb_scale
			this.targetPos = this.targetPos * this.bindingPose
		)

		this.shadowCast = m3_light.lFlags.bitGet 1
		this.specEnable = m3_light.lFlags.bitGet 2
		this.affectedByAO = m3_light.lFlags.bitGet 3
		this.lightOpaqueObj = m3_light.lFlags.bitGet 4
		this.lightTransObj = m3_light.lFlags.bitGet 5
		this.useTeamColor = m3_light.lFlags.bitGet 6

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
			"attenStart" "rfaAttenStart" seq:scseq_FP m3:m3obj_FP c:true mult:(100.0*glb_scale) \
			anim:"attenStart" trk:track_FP tp:track_tp
		M3F_AnimApply #fromfile this m3_light \
			"decay" "rfaDecay" seq:scseq_FP m3:m3obj_FP c:true mult:(100.0*glb_scale) \
			anim:"decay" trk:track_FP tp:track_tp
	)
)

struct M3S_ScCamera
(
	camType, nameStr = "", nbrBone, bindingPose,
	targetBone = 0, targetName, targetPos = matrix3 1,
	useVertFOV, dofType,
	shadowClipDistance = M3SD_ScAnimData(), dofAmount = M3SD_ScAnimData(),
	focusDistance = M3SD_ScAnimData(), fullFocusRange = M3SD_ScAnimData(),
	noFocusRange = M3SD_ScAnimData(), curFOV = M3SD_ScAnimData(),
	farclip = M3SD_ScAnimData(), nearclip = M3SD_ScAnimData(),
	nearFallloffStart = M3SD_ScAnimData(), nearFalloffEnd = M3SD_ScAnimData(),
	bokehFStop = M3SD_ScAnimData(), bokehMaxCoCDiameter = M3SD_ScAnimData(),
	theCam,

	fn init m: s: t: i: =
	(
		local this_item
		try(this_item = this)catch(this_item = M3S_ScCamera())
		try(this_item.buildSceneData m s t i)catch
		(
			M3F_ShowPhaseInfo ("CameraError:"+getCurrentException()) type:#Error
			throw()
		)
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
		local glb_mtrx_anim = M3F_GetGlobalSettings #CameraTrans
		local glb_parm_anim = M3F_GetGlobalSettings #CameraParm
		self_bone.theObj = the_cam
		the_cam.name = this.nameStr

		the_cam.parent = self_bone.theBone.parent
		try(the_target.parent = the_cam.parent)catch()

		if(glb_mtrx_anim)then
		(
			if(this.camType == 1)then
			(
				M3F_CopyController the_cam self_bone.theBone
			)else
			(
				M3F_CopyController the_cam self_bone.theBone type:#pos
				M3F_CopyController the_cam self_bone.theBone type:#scale
			)
		)
		the_cam.transform = this.bindingPose

		the_cam.useVertFOV = this.useVertFOV
		the_cam.dofType = this.dofType

		M3F_AnimApply #toscene this the_cam "shadowClipDistance" "" ea:glb_parm_anim
		M3F_AnimApply #toscene this the_cam "dofAmount" "" ea:glb_parm_anim
		M3F_AnimApply #toscene this the_cam "focusDistance" "" ea:glb_parm_anim
		M3F_AnimApply #toscene this the_cam "fullFocusRange" "" ea:glb_parm_anim
		M3F_AnimApply #toscene this the_cam "noFocusRange" "" ea:glb_parm_anim
		M3F_AnimApply #toscene this the_cam "curFOV" "" ea:glb_parm_anim
		M3F_AnimApply #toscene this the_cam "farclip" "" ea:glb_parm_anim
		M3F_AnimApply #toscene this the_cam "nearclip" "" ea:glb_parm_anim
		M3F_AnimApply #toscene this the_cam "nearFallloffStart" "" ea:glb_parm_anim
		M3F_AnimApply #toscene this the_cam "nearFalloffEnd" "" ea:glb_parm_anim
		M3F_AnimApply #toscene this the_cam "bokehFStop" "" ea:glb_parm_anim
		M3F_AnimApply #toscene this the_cam "bokehMaxCoCDiameter" "" ea:glb_parm_anim

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
		this.nbrBone = m3_cam.nbrBone + 1
		local m3_object = m3obj_FP.fBONE[this.nbrBone]
		local m3_iref = m3obj_FP.fIREF[this.nbrBone]
		local track_tp = idx_FP * 10000 + 400
		this.targetBone = M3F_FindBone m3_bone m3_object.rfdName.data s1:"Target"
		local glb_scale = M3F_GetGlobalSettings #GlobalScale

		for i=1 to track_FP.count do
		(track_FP[i].swapBoneTrack this.nbrBone track_tp)

		this.camType = 1	--FreeCamera
		this.nameStr = copy m3_cam.rfdName.data
		this.bindingPose = inverse (matrix3 m3_iref.matrix[1] \
											m3_iref.matrix[2] \
											m3_iref.matrix[3] \
											(m3_iref.matrix[4] * 100 * glb_scale))
		if this.targetBone != 0 then
		(
			this.camType = 2	--TargetCamera
			this.targetName = copy m3_bone[this.targetBone].rfdName.data
			this.targetPos = inverse (matrix3 m3_irefs[this.targetBone].matrix[1] \
								m3_irefs[this.targetBone].matrix[2] 				 \
								m3_irefs[this.targetBone].matrix[3] 				 \
								(m3_irefs[this.targetBone].matrix[4] * 100 * glb_scale))
		)

		this.useVertFOV = M3F_CvtType #bool m3_cam.useVertFOV
		this.dofType = m3_cam.dofType + 1

		M3F_AnimApply #fromfile this m3_cam \
			"farclip" "rfaFarClip" seq:scseq_FP m3:m3obj_FP c:true mult:(100.0*glb_scale) \
			anim:"Far Clip" trk:track_FP tp:track_tp
		M3F_AnimApply #fromfile this m3_cam \
			"nearclip" "rfaNearClip" seq:scseq_FP m3:m3obj_FP c:true mult:(100.0*glb_scale) \
			anim:"Near Clip" trk:track_FP tp:track_tp

		if(this.useVertFOV)then
		(
			M3F_AnimApply #fromfile this m3_cam \
				"curFOV" "rfaFOV" seq:scseq_FP m3:m3obj_FP type:#fovVH c:true mult:57.296 \
				anim:"FOV" trk:track_FP tp:track_tp
		)else
		(
			M3F_AnimApply #fromfile this m3_cam \
				"curFOV" "rfaFOV" seq:scseq_FP m3:m3obj_FP c:true mult:57.296 \
				anim:"FOV" trk:track_FP tp:track_tp
		)

		M3F_AnimApply #fromfile this m3_cam \
			"shadowClipDistance" "rfaSClipDis" seq:scseq_FP m3:m3obj_FP c:true mult:(100.0*glb_scale) \
			anim:"shadowClipDistance" trk:track_FP tp:track_tp

		M3F_AnimApply #fromfile this m3_cam \
			"focusDistance" "rfaSClipDis" seq:scseq_FP m3:m3obj_FP c:true mult:(100.0*glb_scale) \
			anim:"focusDistance" trk:track_FP tp:track_tp
		M3F_AnimApply #fromfile this m3_cam \
			"fullFocusRange" "rfaFFocusRange" seq:scseq_FP m3:m3obj_FP c:true mult:(100.0*glb_scale) \
			anim:"fullFocusRange" trk:track_FP tp:track_tp
		M3F_AnimApply #fromfile this m3_cam \
			"noFocusRange" "rfaNFocusRange" seq:scseq_FP m3:m3obj_FP c:true mult:(100.0*glb_scale) \
			anim:"noFocusRange" trk:track_FP tp:track_tp
		
		M3F_AnimApply #fromfile this m3_cam \
			"nearFallloffStart" "rfaNFalloffStart" seq:scseq_FP m3:m3obj_FP c:true mult:glb_scale \
			anim:"nearFallloffStart" trk:track_FP tp:track_tp
		M3F_AnimApply #fromfile this m3_cam \
			"nearFalloffEnd" "rfaNFalloffEnd" seq:scseq_FP m3:m3obj_FP c:true mult:glb_scale \
			anim:"nearFalloffEnd" trk:track_FP tp:track_tp

		M3F_AnimApply #fromfile this m3_cam \
			"dofAmount" "rfaDOFamount" seq:scseq_FP m3:m3obj_FP \
			anim:"dofAmount" trk:track_FP tp:track_tp

		M3F_AnimApply #fromfile this m3_cam \
			"bokehFStop" "rfaBokehFStop" seq:scseq_FP m3:m3obj_FP \
			anim:"bokehFStop" trk:track_FP tp:track_tp
		M3F_AnimApply #fromfile this m3_cam \
			"bokehMaxCoCDiameter" "rfaBokehMaxCoCDiameter" seq:scseq_FP m3:m3obj_FP \
			anim:"bokehMaxCoCDiameter" trk:track_FP tp:track_tp
	)
)

struct M3S_ScParticle
(
	parType = 0, nameStr = "", nbrBone, nbrSubBone = 0, bindingPose, matIdx,
	targetName, targetPos = matrix3 0, storeData, splatLine = #(), subRib,
	thePar,

	fn init m: s: t: i: f: c: =
	(
		local this_item
		try(this_item = this)catch(this_item = M3S_ScParticle())
		try(this_item.buildSceneData m s t i f:f c:c)catch
		(
			M3F_ShowPhaseInfo ("ParticleError:"+getCurrentException()) type:#Error
			throw()
		)

		return this_item
	),

	fn releaseData scbone_FP scmat_FP =
	(
		local i, n
		local glb_parm_anim = M3F_GetGlobalSettings #PartParm
		case this.parType of
		(
			1:
			(
				local the_particle = SC2Particles()
				this.storeData.copyData the_particle dir:#toscene anim:glb_parm_anim

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

						the_particle2.parent = self_bone2.theBone.parent
						M3F_CopyController the_particle2 self_bone2.theBone
 					)else
 					(
 						the_particle2.name = this.nameStr + "_EndPoint"
 					)
 					the_particle2.transform = this.targetPos

 					this.subRib.copyData the_particle2 dir:#toscene anim:glb_parm_anim
 					M3F_AddToLayer "Particle" the_particle2
				)
				this.storeData.copyData the_particle dir:#toscene anim:glb_parm_anim
			)
			3:
			(
				local the_particle = SC2Projector()
				this.storeData.copyData the_particle dir:#toscene anim:glb_parm_anim
			)
		)
		local self_bone = scbone_FP[this.nbrBone]
		local glb_mtrx_anim = M3F_GetGlobalSettings #PartTrans
		self_bone.theObj = the_particle
		the_particle.name = this.nameStr

		the_particle.parent = self_bone.theBone.parent
		if(glb_mtrx_anim)then(M3F_CopyController the_particle self_bone.theBone)
		the_particle.transform = this.bindingPose

		if(M3F_GetGlobalSettings #MatEnable)then
		(
			the_particle.Material = scmat_FP[this.matIdx].theMat
		)

		this.thePar = the_particle

		M3F_AddToLayer "Particle" the_particle
	),

	fn collectData =(),

	fn buildSceneData m3obj_FP scseq_FP track_FP idx_FP f:#par c:0 =
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
		local track_tp = (c + 1) * 10000 + 500
		local glb_scale = M3F_GetGlobalSettings #GlobalScale

		for i=1 to track_FP.count do
		(track_FP[i].swapBoneTrack this.nbrBone track_tp)

		this.nameStr = copy m3_object.rfdName.data
		this.matIdx = m3_particle.matIdx + 1
		this.bindingPose = inverse (matrix3 m3_iref.matrix[1] \
									m3_iref.matrix[2] \
									m3_iref.matrix[3] \
									(m3_iref.matrix[4] * 100 * glb_scale))
		
		case f of
		(
			#par:
			(
				this.parType = 1
				this.storeData.copyData m3_particle trk:track_FP tp:track_tp \
					seq:scseq_FP m3:m3obj_FP dir:#fromfile mult:glb_scale
				
				try
				(
					this.storeData.MeshLink = M3F_FormatToString "Mesh %" #((m3_particle.rfdEmissMesh.data[1]+1))
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
							(M3F_FormatToString "splatLine[%]" #(((i+3)/4))) \
							(M3F_FormatToString "rfdSplatLine.data[%]" #(i)) \
							seq:scseq_FP m3:m3obj_FP \
							c:true mult:1.0
					)
					local point_data_end = M3SD_ScAnimData()
					append this.splatLine point_data_end
					M3F_AnimApply #fromfile this m3_particle \
						(M3F_FormatToString "splatLine[%]" #(this.splatLine.count)) \
						(M3F_FormatToString "rfdSplatLine.data[%]" #(point_count)) \
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

					M3F_ShowLogInfo \
						(M3F_FormatToString "Particle has PrtMdl Group! Particle:% MdlGroup:%" \
							#(this.nameStr, this.storeData.ModelName)) \
						type:#Warning
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
											(m3_irefs[this.nbrSubBone].matrix[4] * 100 * glb_scale))
					)
					this.subRib = M3SD_ScSubRib()
					this.subRib.copyData m3_particle.rfdSubRib.data \
					seq:scseq_FP m3:m3obj_FP dir:#fromfile mult:glb_scale
				)
				this.storeData.copyData m3_particle trk:track_FP tp:track_tp \
				seq:scseq_FP m3:m3obj_FP dir:#fromfile mult:glb_scale
			)
			#proj:
			(
				this.parType = 3
				this.storeData.copyData m3_particle trk:track_FP tp:track_tp \
				seq:scseq_FP m3:m3obj_FP dir:#fromfile mult:glb_scale
			)
		)
	),

	fn buildCopyData m3obj_FP scseq_FP track_FP copy_FP idx_FP c:0 =
	(
		local i, n
		local m3_particle_copy = m3obj_FP.fPARC[m3obj_FP.fPAR[copy_FP].rfdCopyIdx.data[idx_FP] + 1]
		this.nbrBone = m3_particle_copy.nbrBone + 1
		local m3_object = m3obj_FP.fBONE[this.nbrBone]
		local m3_iref = m3obj_FP.fIREF[this.nbrBone]
		local track_tp_copy = (c - idx_FP) * 10000 + 500
		local track_tp = c * 10000 + 500
		local glb_scale = M3F_GetGlobalSettings #GlobalScale

		for i=1 to track_FP.count do
		(
			track_FP[i].swapBoneTrack this.nbrBone track_tp

			local anim_list = #()
			for n=1 to track_FP[i].AnimList.count do
			(
				if(track_FP[i].AnimList[n].index == track_tp_copy)then
				(
					case track_FP[i].AnimList[n].animStr of
					(
						"position": ()
						"rotation": ()
						"scale": ()
						"visibility": ()
						"EmissionRate": ()
						"SquirtQuantity": ()
						default:
						(
							local track_data = M3SD_ScTrackData()
							track_data.index = track_tp
							track_data.animStr = copy track_FP[i].AnimList[n].animStr
							append anim_list track_data
						)
					)
				)
			)
			join track_FP[i].AnimList anim_list
		)

		this.nameStr = copy m3_object.rfdName.data
		this.bindingPose = inverse (matrix3 m3_iref.matrix[1] \
											m3_iref.matrix[2] \
											m3_iref.matrix[3] \
											(m3_iref.matrix[4] * 100 * glb_scale))

		this.storeData.EmissionRate = M3SD_ScAnimData()
		this.storeData.SquirtQuantity = M3SD_ScAnimData()
		M3F_AnimApply #fromfile this.storeData m3_particle_copy \
			"EmissionRate" "rfaEmissRate" seq:scseq_FP m3:m3obj_FP \
			anim:"EmissionRate" trk:track_FP tp:track_tp
		M3F_AnimApply #fromfile this.storeData m3_particle_copy \
			"SquirtQuantity" "rfaSquirtAmount" seq:scseq_FP m3:m3obj_FP \
			anim:"SquirtQuantity" trk:track_FP tp:track_tp
	),

	fn findLink m3obj_FP link_FP type_FP =
	(
		if(link_FP > 0)then
		(
			local m3_par = case type_FP of(#par: m3obj_FP.fPAR; #proj: m3obj_FP.fPROJ)
			local m3_bone = m3obj_FP.fBONE
			local bone_idx = m3_par[link_FP].nbrBone + 1
			return (copy m3_bone[bone_idx].rfdName.data)
		)else
		(
			return "NONE"
		)
	)
)

struct M3S_ScPhysics
(
	PhyType, nameStr = "", nbrBone, nbrBoneParent, bindingPose,
	storeData, thePhy,

	fn init m: s: t: i: f: c: =
	(
		local this_item
		try(this_item = this)catch(this_item = M3S_ScPhysics())
		try(this_item.buildSceneData m s t i f:f c:c)catch
		(
			M3F_ShowPhaseInfo ("PhysicsError:"+getCurrentException()) type:#Error
			throw()
		)
		this_item
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
				local the_physics = SC2VtxWarp()
			)
			3:
			(
				local the_physics = SC2Physics()
				the_physics.name = this.nameStr

				the_physics.parent = scbone_FP[this.nbrBoneParent].theBone
				if(this.nbrBone > 0 and this.nbrBone <= 0xFFFF)then
				(
					scbone_FP[this.nbrBone].theObj = the_physics
					M3F_CopyController the_physics scbone_FP[this.nbrBone].theBone
				)
				the_physics.transform = this.bindingPose
				
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
						)else
						(
							M3F_ShowLogInfo \
								(M3F_FormatToString "Can't Create RigedBody MeshFace! RigedBody:% Face:%" \
							#(this.nameStr, i)) \
								type:#Warning
						)
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
				)else if(this.storeData.shapeType == 6)then
				(
					local the_mesh = mesh vertices:this.storeData.rigedBodyVerts	\
											faces:this.storeData.rigedBodyFaces 	\
											name:(this.nameStr+"_ExtractedMesh")

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

		the_physics.parent = self_bone.theBone.parent
		M3F_CopyController the_physics self_bone.theBone
		the_physics.transform = this.bindingPose

		this.storeData.copyData the_physics dir:#toscene

		this.thePhy = the_physics
		M3F_AddToLayer "Physics" the_physics
	),
	fn collectData =(),

	fn buildSceneData m3obj_FP scseq_FP track_FP idx_FP f:#force c:0 =
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
				local m3_bones = m3obj_FP.fBONE
				local m3_irefs = m3obj_FP.fIREF
				this.nbrBoneParent = m3_physics.nbrBoneParent + 1
				local m3_iref_parent = m3obj_FP.fIREF[this.nbrBoneParent]
				local glb_scale = M3F_GetGlobalSettings #GlobalScale

				this.storeData = M3SD_ScRigedBody()
				this.PhyType = 3
				this.nameStr = M3F_FormatToString "SC2Physics_%" #(idx_FP)
				
				local self_pose = matrix3 m3_physics.rfdRigedBody.data.matrix[1] \
										m3_physics.rfdRigedBody.data.matrix[2] \
										m3_physics.rfdRigedBody.data.matrix[3] \
										m3_physics.rfdRigedBody.data.matrix[4]
				local parent_pose = inverse (matrix3 m3_iref_parent.matrix[1] \
													m3_iref_parent.matrix[2] \
													m3_iref_parent.matrix[3] \
													m3_iref_parent.matrix[4])

				this.bindingPose = self_pose * parent_pose
				local find_list = #()
				for i=1 to m3_bones.count where m3_bones[i].parent == m3_physics.nbrBoneParent do
				(
					local mtrx = matrix3 m3_irefs[i].matrix[1] \
										m3_irefs[i].matrix[2] \
										m3_irefs[i].matrix[3] \
										m3_irefs[i].matrix[4]
					local check_mtrx = mtrx * this.bindingPose
					for k=1 to 4 do
					(
						local replace_row = copy check_mtrx[k]
						if((abs check_mtrx[k][1]) < 0.00001)then(replace_row[1] = 0)
						if((abs check_mtrx[k][2]) < 0.00001)then(replace_row[2] = 0)
						if((abs check_mtrx[k][3]) < 0.00001)then(replace_row[3] = 0)
						check_mtrx[k] = replace_row
					)
					if(check_mtrx as string == (matrix3 1) as string)then(append find_list i)
				)
				this.bindingPose[4] = this.bindingPose[4] * 100 * glb_scale
				
				if(find_list.count == 1)then
				(
					local track_tp = (c + 1) * 10000 + 600
					this.nbrBone = find_list[1]
					for i=1 to track_FP.count do
					(track_FP[i].swapBoneTrack this.nbrBone track_tp)
					this.nameStr = copy m3_bones[this.nbrBone].rfdName.data
				)else
				(
					this.nbrBone = 0
					M3F_ShowLogInfo \
						(M3F_FormatToString \
						("Can't find the bone that matches the rigedbody! "+ \
						"Need to remove excess bone manually. RigedBody: %") \
						#(this.nameStr)) type:#Warning
				)

				this.storeData.copyData m3_physics seq:scseq_FP m3:m3obj_FP dir:#fromfile mult:glb_scale

				if(this.storeData.shapeType == 5)then
				(
					for i in m3_physics.rfdRigedBody.data.rfdVertPos.data do
					(
						append this.storeData.rigedBodyVerts (i * 100 * glb_scale)
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
				)else if(this.storeData.shapeType == 6)then
				(
					local mesh_offset = m3_physics.rfdRigedBody.data.meshOffset
					for i in m3_physics.rfdRigedBody.data.rfdVertPosMesh.data do
					(
						local vert_pos = ([i[1],i[2],i[3]] + mesh_offset) * 100 * glb_scale
						append this.storeData.rigedBodyVerts vert_pos
					)

					for i in m3_physics.rfdRigedBody.data.rfdFaceMesh.data do
					(
						local face_set = [i[1]+1, i[2]+1, i[3]+1]
						append this.storeData.rigedBodyFaces face_set
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
		local track_tp = (c + 1) * 10000 + 600
		local glb_scale = M3F_GetGlobalSettings #GlobalScale

		for i=1 to track_FP.count do
		(track_FP[i].swapBoneTrack this.nbrBone track_tp)

		this.nameStr = copy m3_object.rfdName.data
		this.bindingPose = inverse (matrix3 m3_iref.matrix[1] \
									m3_iref.matrix[2] \
									m3_iref.matrix[3] \
									(m3_iref.matrix[4] * 100 * glb_scale))

		this.storeData.copyData m3_physics trk:track_FP tp:track_tp \
			seq:scseq_FP m3:m3obj_FP dir:#fromfile mult:glb_scale
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
		try(this_item.buildSceneData m i)catch
		(
			M3F_ShowPhaseInfo ("JointError:"+getCurrentException()) type:#Error
			throw()
		)
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
		local glb_scale = M3F_GetGlobalSettings #GlobalScale

		this.boneList[1] = m3_joint.nbrBone1 + 1
		this.boneList[2] = m3_joint.nbrBone2 + 1
		this.nameStr = 	m3_bone[this.boneList[2]].rfdName.data + "_J_" + \
						m3_bone[this.boneList[1]].rfdName.data

		this.jointType = m3_joint.jTypes + 1
		this.axisOffset[1] = matrix3 m3_joint.matrixB1[1] \
									m3_joint.matrixB1[2] \
									m3_joint.matrixB1[3] \
									(m3_joint.matrixB1[4] * 100 * glb_scale)
		this.axisOffset[2] = matrix3 m3_joint.matrixB2[1] \
									m3_joint.matrixB2[2] \
									m3_joint.matrixB2[3] \
									(m3_joint.matrixB2[4] * 100 * glb_scale)

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

struct M3S_ScCloth
(
	nameStr = "", nbrSkinBones = #(), dynamicVertsThreshold, nbrCloth, nbrProxy, nbrColliders = #(),
	clothState = M3SD_ScAnimData(),

	clothDensity, tracking, stiffness, horizontalStiffness, bendResistence,
	damping, friction, gravity, explosionScale, windScale, shearStiffness,
	dragFactor, liftFactor, sphereAttachmentStiffness, flatten,

	useSkinCollision, skinOffset, skinExponent, skinStiffness,
	localForceChannel, selfWind,
	theIndex,
	--stability : float
	--airDensity : float
	--maxExplosionVelocity : float
	--useAttachmentSpheres : boolean
	--sphereMassTaper : float

	fn init m: s: r: i: =
	(
		local this_item
		try(this_item = this)catch(this_item = M3S_ScCloth())
		try(this_item.buildSceneData m s r i)catch
		(
			M3F_ShowPhaseInfo ("ClothError:"+getCurrentException()) type:#Error
			throw()
		)
		this_item
	),

	fn releaseData behholder_FP scbone_FP scmesh_FP scphy_FP =
	(
		local i
		local behavior_type = M3F_GetCustAttr #cloth
		custAttributes.add behholder_FP behavior_type #unique
		this.theIndex = custAttributes.count behholder_FP
		local behavior = custAttributes.get behholder_FP this.theIndex

		behavior.behaviorType = "PhysicsCloth_Behavior"
		behavior.behaviorState = true
		behavior.name = this.nameStr

		append behavior.boneList scmesh_FP[this.nbrCloth].theMesh
		append behavior.boneStates true
		append behavior.clothProxies scmesh_FP[this.nbrProxy].theMesh

		for i in this.nbrSkinBones do
		(
			local the_obj = \
				if(scbone_FP[i].theObj != undefined)then(scbone_FP[i].theObj)else(scbone_FP[i].theBone)
			append behavior.skinBones the_obj
		)
		for i in this.nbrColliders do
		(
			append behavior.clothColliders scphy_FP[i].thePhy
		)

		behavior.dynamicVertsThreshold = this.dynamicVertsThreshold
		behavior.clothProxiesInfluenceDistance = 1.0

		M3F_AnimApply #toscene this behavior \
			"clothState" ""

		behavior.useCustomProps = true
		behavior.clothDensity = this.clothDensity
		behavior.tracking = this.tracking
		behavior.stiffness = this.stiffness
		behavior.horizontalStiffness = this.horizontalStiffness
		behavior.bendResistence = this.bendResistence
		behavior.damping = this.damping
		behavior.friction = this.friction
		behavior.gravity = this.gravity
		behavior.explosionScale = this.explosionScale
		behavior.windScale = this.windScale
		behavior.shearStiffness = shearStiffness
		behavior.dragFactor = this.dragFactor
		behavior.liftFactor = this.liftFactor
		behavior.sphereAttachmentStiffness = this.sphereAttachmentStiffness
		behavior.flatten = this.flatten

		behavior.useSkinCollision = this.useSkinCollision
		behavior.skinOffset = this.skinOffset
		behavior.skinExponent = this.skinExponent
		behavior.skinStiffness = this.skinStiffness
		behavior.localForceChannel = this.localForceChannel
		behavior.selfWind = this.selfWind
	),
	fn collectData =(),

	fn buildSceneData m3obj_FP scseq_FP scphy_FP idx_FP =
	(
		local i, k
		local m3_cloth = m3obj_FP.fPHCL[idx_FP]
		local m3_collider_data = m3_cloth.rfdCollider.data
		local riged_bodys = scphy_FP

		this.nbrCloth = m3_cloth.nbrClothMesh + 1
		this.nbrProxy = m3_cloth.rfdProxy.data.proxyIdx + 1

		this.nameStr = M3F_FormatToString "Cloth_Mesh_%_Proxy_Mesh_%" #(this.nbrCloth, this.nbrProxy)

		this.nbrSkinBones = #()
		if(m3_cloth.rfdSkinBone.data != undefined)then
		(
			local enableds = m3_cloth.rfdSimEnabled.data
			local verts = m3_cloth.rfdVertBone.data
			local weight = m3_cloth.rfdVertWeight.data
			local check_bones = for i in m3_cloth.rfdSkinBone.data collect i
			local check_bones_type = for i in m3_cloth.rfdSkinBone.data collect 1
			this.dynamicVertsThreshold = 1.0

			local changed = false
			i = 1
			while(i <= enableds.count)do
			(
				if(enableds[i] == 0)then
				(
					local sim_weight = 1.0
					for k=1 to 4 where weight[i][k] > 0 do
					(
						local find = findItem check_bones verts[i][k]
						if(check_bones_type[find] == 0)then
						(
							sim_weight -= weight[i][k] / 255.0
						)else
						(
							check_bones_type[find] = 1
						)
					)

					while(sim_weight > this.dynamicVertsThreshold)do
					(
						for k=1 to 4 where weight[i][k] > 0 do
						(
							local find = findItem check_bones verts[i][k]
							if(check_bones_type[find] == 1)then
							(
								check_bones_type[find] = 0
								sim_weight -= weight[i][k] / 255.0
								changed = true
								exit
							)
						)
					)
				)else
				(
					local sim_weight = 0.0
					for k=1 to 4 where weight[i][k] > 0 do
					(
						local find = findItem check_bones verts[i][k]
						
						if(check_bones_type[find] != 0)then
						(
							sim_weight += weight[i][k] / 255.0
						)
					)
					if(sim_weight <= this.dynamicVertsThreshold and sim_weight > 0)then
					(
						this.dynamicVertsThreshold = amax 0 (sim_weight - 0.01)
						changed = true
					)
				)
				if(changed)then(i = 1; changed = false)else(i += 1)
			)

			this.nbrSkinBones = \
				for i=1 to check_bones.count where check_bones_type[i] == 1 collect(check_bones[i]+1)
		)

		this.nbrColliders = #()
		if(m3_collider_data != undefined)then
		(
			local glb_scale = M3F_GetGlobalSettings #GlobalScale
			
			for i=1 to m3_collider_data.count do
			(
				local collider_idx = 0
				local collider_mtrx = M3F_CvtType #matrix m3_collider_data[i].matrix
				collider_mtrx.row4 = collider_mtrx.row4 * 100 * glb_scale
				local collider_radius = m3_collider_data[i].radius * 100 * glb_scale
				local collider_height = m3_collider_data[i].height * 100 * glb_scale + collider_radius * 2

				for k=1 to riged_bodys.count where riged_bodys[k].PhyType == 3 do
				(
					if(riged_bodys[k].storeData.shapeType == 3 and \
						collider_radius == riged_bodys[k].storeData.radius and \
						collider_height == riged_bodys[k].storeData.height and \
						(collider_mtrx as string) == (riged_bodys[k].bindingPose as string))then
					(
						collider_idx = k
						riged_bodys[k].storeData.isClothCollider = true
						exit
					)
				)
				if(collider_idx == 0)then
				(
					M3F_ShowLogInfo (M3F_FormatToString "Bad Cloth Collider Data ! Index:%" #(i)) type:#Warning
				)else(append this.nbrColliders collider_idx)
			)
		)

		M3F_AnimApply #fromfile this m3_cloth \
			"clothState" "rfaActive" seq:scseq_FP m3:m3obj_FP type:#bool

		this.clothDensity = m3_cloth.clothDensity
		this.tracking = m3_cloth.tracking
		this.stiffness = m3_cloth.stretchStiff
		this.horizontalStiffness = m3_cloth.horzStiff
		this.bendResistence = m3_cloth.bendingStiff
		this.damping = m3_cloth.damping
		this.friction = m3_cloth.friction
		this.gravity = m3_cloth.clothGravity
		this.explosionScale = m3_cloth.explosionScale
		this.windScale = m3_cloth.windScale
		this.shearStiffness = m3_cloth.shearStiff
		this.dragFactor = m3_cloth.dragFactor
		this.liftFactor = m3_cloth.liftFactor
		this.sphereAttachmentStiffness = m3_cloth.sphereStiff
		this.flatten = M3F_CvtType #bool m3_cloth.flatten

		this.useSkinCollision = M3F_CvtType #bool m3_cloth.useSkinCollision
		this.skinOffset = m3_cloth.skinOffset
		this.skinExponent = m3_cloth.skinExponent
		this.skinStiffness = m3_cloth.skinStiff
		this.localForceChannel = m3_cloth.localChn
		this.selfWind = m3_cloth.localWind * 1
	)
)

struct M3S_ScHelper
(
	nameStr = "", nbrBone, helperType, bindingPose,
	axisMatrix, size0, size1, size2, vertPos = #(), facesSet = #(),
	Position = M3SD_ScAnimData(), Scale = M3SD_ScAnimData(),
	theHelper,

	fn init m: s: t: i: f: c: =
	(
		local this_item
		try(this_item = this)catch(this_item = M3S_ScHelper())
		try(this_item.buildSceneData m s t i f:f c:c)catch
		(
			M3F_ShowPhaseInfo ("HelperError:"+getCurrentException()) type:#Error
			throw()
		)
		this_item
	),

	fn releaseData scbone_FP =
	(
		if(this.helperType < 31)then
		(
			local types = (mod this.helperType 10) as integer
			case types of
			(
				1:
				(
					local the_helper = box name:this.nameStr 	\
										width:(this.size0*2) 	\
										length:(this.size1*2)	\
										height:(this.size2*2)
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
										height:(this.size1+this.size0*2) \
										heighttype:0
				)
				4:
				(
					local the_helper = Cylinder name:this.nameStr 	\
										side:12						\
										radius:this.size0			\
										height:this.size1
				)
				5:
				(
					local the_helper = mesh vertices:this.vertPos	\
											faces:this.facesSet 	\
											name:this.nameStr
				)
			)

			case of
			(
				(this.helperType < 11): the_helper.wireColor = color 0 0 255
				(this.helperType < 21): the_helper.wireColor = color 160 160 255
				(matchPattern this.nameStr pattern:"Vol_Shield*"): the_helper.wireColor = color 0 0 255
				(this.helperType < 31): the_helper.wireColor = color 255 0 0
			)
			if(M3F_GetGlobalSettings #VolColl)then
			(
				if(this.helperType >= 21 and this.helperType < 31)then
				(
					the_helper.boxmode = on
					the_helper.renderable = off
					freeze the_helper
				)
			)else(the_helper.xray = true)
			if(M3F_GetGlobalSettings #HitColl)then
			(
				if(this.helperType < 21)then
				(
					the_helper.boxmode = on
					the_helper.renderable = off
					freeze the_helper
				)
			)else(the_helper.xray = true)
			
			local self_bone = scbone_FP[this.nbrBone]
			self_bone.theObj = the_helper
			
			the_helper.parent = self_bone.theBone.parent
			M3F_CopyController the_helper self_bone.theBone
			the_helper.transform = this.bindingPose

			M3F_AddToLayer "HitTest" the_helper
		)else if(this.helperType == 31)then
		(
			local the_helper = SC2AttachPt name:this.nameStr
			the_helper.null.lockXYZ = true
			the_helper.null.xScale = (M3F_GetGlobalSettings #AttSize)
			if(M3F_GetGlobalSettings #AttColl)then
			(
				the_helper.null.nullShape = 0
				the_helper.null.displayName = false
				freeze the_helper
			)

			local self_bone = scbone_FP[this.nbrBone]
			self_bone.theObj = the_helper

			the_helper.parent = self_bone.theBone.parent
			M3F_CopyController the_helper self_bone.theBone type:#rot
			M3F_CopyController the_helper self_bone.theBone type:#pos
			M3F_CopyController the_helper self_bone.theBone type:#visibility
			if(M3F_GetGlobalSettings #AttScale)then
			(
				M3F_CopyController the_helper self_bone.theBone type:#scale
			)else
			(
				local glb_scale_ctl = M3F_GetGlobalSettings #BoneScaleCtl
				if(classOf the_helper.Scale.controller != glb_scale_ctl)then
				(the_helper.Scale.controller = glb_scale_ctl())
			)
			the_helper.transform = this.bindingPose
			
			M3F_AddToLayer "Attachment Point" the_helper
		)else if(this.helperType == 41)then
		(
			local glb_pos = M3F_GetGlobalSettings #GlobalPos
			local the_helper = sphere name:this.nameStr radius:this.size0

			the_helper.transform = this.bindingPose
			M3F_AnimApply #toscene this the_helper "Position" ""
			M3F_AnimApply #toscene this the_helper "Scale" ""
			the_helper.pos = the_helper.pos + glb_pos

			the_helper.wireColor = color 255 0 0
			if(M3F_GetGlobalSettings #BoundColl)then
			(
				the_helper.boxmode = on
				the_helper.renderable = off
				freeze the_helper
			)else(the_helper.xray = true)
			
			M3F_AddToLayer "Bounds" the_helper
		)
		this.theHelper = the_helper
	),
	fn collectData =(),

	fn buildSceneData m3obj_FP scseq_FP track_FP idx_FP f:#attach c:0 =
	(
		case f of
		(
			#bounds:
			(
				local glb_scale = M3F_GetGlobalSettings #GlobalScale
				local m3_bounds = m3obj_FP.fMODL.bndSphere
				local m3_seqs = m3obj_FP.fSEQS

				this.helperType = 41
				this.nameStr = "Bounds"
				this.bindingPose = transMatrix ((m3_bounds.eMin + m3_bounds.eMax) * 50 * glb_scale)
				this.size0 = m3_bounds.rad * 100 * glb_scale

				
				for i=1 to m3_seqs.count do
				(
					append this.Position.frames scseq_FP[i].animStart
					append this.Scale.frames scseq_FP[i].animStart
					local pos_temp = (m3_seqs[i].bndSphere.eMin + m3_seqs[i].bndSphere.eMax) * 50 * glb_scale
					local scale_temp = m3_seqs[i].bndSphere.rad / m3_bounds.rad
					append this.Position.dkeys (pos_temp * 1)
					append this.Scale.dkeys [scale_temp, scale_temp, scale_temp]

					append this.Position.frames scseq_FP[i].animEnd
					append this.Scale.frames scseq_FP[i].animEnd
					append this.Position.dkeys (pos_temp * 1)
					append this.Scale.dkeys [scale_temp, scale_temp, scale_temp]
				)

				return true
			)
			#tight:
			(
				local m3_helper = m3obj_FP.fMODL.tightTest
				this.helperType = 1 + m3_helper.type
			)
			#fuzzy:
			(
				local m3_helper = m3obj_FP.fMODL.rfdSSGS.data[idx_FP]
				this.helperType = 11 + m3_helper.type
			)
			#attvol:
			(
				local m3_helper = m3obj_FP.fMODL.rfdATVL.data[idx_FP]
				this.helperType = 21 + m3_helper.type
			)
			#attach:
			(
				local m3_helper = m3obj_FP.fATT.attachments[idx_FP]
				this.helperType = 31
				--this.nameStr = copy m3_helper.rfdName.data
			)
			default: return false
		)
		this.nbrBone = m3_helper.nbrBone + 1
		local m3_object = m3obj_FP.fBONE[this.nbrBone]
		local m3_iref = m3obj_FP.fIREF[this.nbrBone]
		local track_tp = (c + 1) * 10000 + 800
		local glb_scale = M3F_GetGlobalSettings #GlobalScale

		this.nameStr = copy m3_object.rfdName.data
		if(f == #attach)then
		(if(matchPattern this.nameStr pattern:"Vol_*" ignoreCase:false)then(return false))
		
		for i=1 to track_FP.count do
		(track_FP[i].swapBoneTrack this.nbrBone track_tp)

		this.bindingPose = inverse (matrix3 m3_iref.matrix[1] \
									m3_iref.matrix[2] \
									m3_iref.matrix[3] \
									(m3_iref.matrix[4] * 100 * glb_scale))
		
		if(f != #attach)then
		(
			this.axisMatrix = matrix3 m3_helper.matrix[1]		\
									m3_helper.matrix[2]			\
									m3_helper.matrix[3]			\
									(m3_helper.matrix[4] * 100 * glb_scale)

			this.size0 = m3_helper.size0 * 100 * glb_scale
			this.size1 = m3_helper.size1 * 100 * glb_scale
			this.size2 = m3_helper.size2 * 100 * glb_scale

			local mtrx_fix = case m3_helper.type of
			(
				0: transMatrix [0, 0, this.size2 * -1]
				2: transMatrix [0, 0, this.size1 / -2 - this.size0]
				3: transMatrix [0, 0, this.size1 / -2]
				default: matrix3 1
			)

			this.bindingPose = mtrx_fix * this.axisMatrix * this.bindingPose
			
			if(m3_helper.type == 4)then
			(
				local i
				local m3_vert = m3_helper.rfdVertsPos.data
				local m3_face = m3_helper.rfdFaces.data

				this.vertPos = #()
				this.facesSet = #()
				for i=1 to m3_vert.count do
				(
					append this.vertPos (m3_vert[i] * 100 * glb_scale)
				)
				for i=1 to m3_face.count by 3 do
				(
					append this.facesSet [m3_face[i]+1, m3_face[i+1]+1, m3_face[i+2]+1]
				)
			)
		)
		true
	)
)

struct M3S_ScTurret
(
	nameStr = "", turretGroupID, overrideAnimations,
	nbrBones = #()			,--: node array
	axisOffset = #()		,--: matrix3 array
	yawEnabled = #()		,--: boolean array
	yawLimited = #()		,--: boolean array
	yawLimitMin = #()		,--: float array
	yawLimitMax = #()		,--: float array
	yawWeight = #()			,--: int array
	pitchEnabled = #()		,--: boolean array
	pitchLimited = #()		,--: boolean array
	pitchLimitMin = #()		,--: float array
	pitchLimitMax = #()		,--: float array
	pitchWeight = #()		,--: int array
	isMainTurret = #()		,--: boolean array
	theIndex,

	fn init m: i: =
	(
		local this_item
		try(this_item = this)catch(this_item = M3S_ScTurret())
		try(this_item.buildSceneData m i)catch
		(
			M3F_ShowPhaseInfo ("TurretError:"+getCurrentException()) type:#Error
			throw()
		)
		this_item
	),

	fn releaseData behholder_FP scbone_FP =
	(
		local i
		local behavior_type = M3F_GetCustAttr #turret
		custAttributes.add behholder_FP behavior_type #unique
		this.theIndex = custAttributes.count behholder_FP
		local behavior = custAttributes.get behholder_FP this.theIndex

		behavior.behaviorType = "Turret_Behavior"
		behavior.behaviorState = true
		behavior.name = this.nameStr

		for i=1 to this.nbrBones.count do
		(
			if(scbone_FP[this.nbrBones[i]].theObj != undefined)then
			(append behavior.boneList scbone_FP[this.nbrBones[i]].theObj)
			else(append behavior.boneList scbone_FP[this.nbrBones[i]].theBone)
			append behavior.boneStates true
		)
		behavior.axisOffset = this.axisOffset
		behavior.yaw_enabled = this.yawEnabled
		behavior.yaw_limited = this.yawLimited
		behavior.yaw_limitMin = this.yawLimitMin
		behavior.yaw_limitMax = this.yawLimitMax
		behavior.yaw_weight = this.yawWeight
		behavior.pitch_enabled = this.pitchEnabled
		behavior.pitch_limited = this.pitchLimited
		behavior.pitch_limitMin = this.pitchLimitMin
		behavior.pitch_limitMax = this.pitchLimitMax
		behavior.pitch_weight = this.pitchWeight
		behavior.isMainTurret = this.isMainTurret

		behavior.turretGroupID = this.turretGroupID
		behavior.overrideAnimations = this.overrideAnimations
	),
	fn collectData =(),

	fn buildSceneData m3obj_FP idx_FP =
	(
		local i
		local m3_turret = m3obj_FP.fTRGD[idx_FP]
		local m3_turret_data = m3obj_FP.fPATU
		local glb_scale = M3F_GetGlobalSettings #GlobalScale

		this.nameStr = copy m3_turret.rfdName.data

		if(m3_turret.rfdDataIdx.data == undefined)then
		(
			this.turretGroupID = 1
			this.overrideAnimations = false
			this.nbrBones = #()
			M3F_ShowLogInfo ("Empty TurretSet ! name:" + this.nameStr) type:#Warning
			return false
		)

		for i=1 to m3_turret.rfdDataIdx.data.count do
		(
			local m3_data_temp = m3_turret_data[m3_turret.rfdDataIdx.data[i] + 1]
			append this.nbrBones (m3_data_temp.nbrBone + 1)

			local mtrx = matrix3 m3_data_temp.matrix[1] \
								m3_data_temp.matrix[2] \
								m3_data_temp.matrix[3] \
								(m3_data_temp.matrix[4] * 100 * glb_scale)
			append this.axisOffset mtrx

			append this.yawLimited (M3F_CvtType #bool m3_data_temp.yawLimited)
			append this.yawLimitMin (m3_data_temp.yawMin * 57.296)
			append this.yawLimitMax (m3_data_temp.yawMax * 57.296)
			append this.yawWeight (m3_data_temp.yawWeight * 100)
			if(this.yawLimitMin[i] != 0 or this.yawLimitMax[i] != 0 or this.yawWeight[i] != 0)then
			(
				append this.yawEnabled true
			)else
			(
				append this.yawEnabled false
			)
			
			append this.pitchLimited (M3F_CvtType #bool m3_data_temp.pitchLimited)
			append this.pitchLimitMin (m3_data_temp.pitchMin * 57.296)
			append this.pitchLimitMax (m3_data_temp.pitchMax * 57.296)
			append this.pitchWeight (m3_data_temp.pitchWeight * 100)
			if(this.pitchLimitMin[i] != 0 or this.pitchLimitMax[i] != 0 or this.pitchWeight[i] != 0)then
			(
				append this.pitchEnabled true
			)else
			(
				append this.pitchEnabled false
			)

			append this.isMainTurret (M3F_CvtType #bool m3_data_temp.useMain)
			if(i == 1)then
			(
				this.turretGroupID = m3_data_temp.groupID
				this.overrideAnimations = if(m3_data_temp.overrideAnim > 0)then(false)else(true)
			)
		)
	)
)

struct M3S_ScBillBoard
(
	nameStr = "", nbrBones = #(), billBoardType, cameraLookAt,
	theIndex,

	fn init m: b: i: =
	(
		local this_item
		try(this_item = this)catch(this_item = M3S_ScBillBoard())
		try(this_item.buildSceneData m b i)catch
		(
			M3F_ShowPhaseInfo ("BillBoardError:"+getCurrentException()) type:#Error
			throw()
		)
		this_item
	),

	fn releaseData behholder_FP scbone_FP =
	(
		local i
		local behavior_type = M3F_GetCustAttr #billboard
		custAttributes.add behholder_FP behavior_type #unique
		this.theIndex = custAttributes.count behholder_FP
		local behavior = custAttributes.get behholder_FP this.theIndex

		behavior.behaviorType = "Billboard_behavior"
		behavior.behaviorState = true
		behavior.name = this.nameStr

		for i=1 to this.nbrBones.count do
		(
			if(scbone_FP[this.nbrBones[i]].theObj != undefined)then
			(append behavior.boneList scbone_FP[this.nbrBones[i]].theObj)
			else(append behavior.boneList scbone_FP[this.nbrBones[i]].theBone)
			append behavior.boneStates true
		)
		behavior.billboadType = this.billBoardType
		behavior.cameraLookAt = this.cameraLookAt
	),
	fn collectData =(),

	fn buildSceneData m3obj_FP scbboard_FP idx_FP =
	(
		local i
		local m3_billboard = m3obj_FP.fBBSC[idx_FP]

		this.nameStr = M3F_FormatToString "Billboard_behavior_%" #((scbboard_FP.count + 1))
		append this.nbrBones (m3_billboard.nbrBone + 1)
		this.billBoardType = m3_billboard.bbTypes + 1
		this.cameraLookAt = M3F_CvtType #bool m3_billboard.cameraLookAt

		for i=1 to scbboard_FP.count do
		(
			if(scbboard_FP[i].billBoardType == this.billBoardType and \
				scbboard_FP[i].cameraLookAt == this.cameraLookAt)then
			(
				append scbboard_FP[i].nbrBones this.nbrBones[1]
				return false
			)
		)
		true
	)
)

struct M3S_ScIKleg
(
	nameStr = "", nbrBone1, nbrBone2, raycastUp, raycastDn, maxSpeed, goalThreshold,
	theIndex,

	fn init m: i: =
	(
		local this_item
		try(this_item = this)catch(this_item = M3S_ScIKleg())
		try(this_item.buildSceneData m i)catch
		(
			M3F_ShowPhaseInfo ("IKlegError:"+getCurrentException()) type:#Error
			throw()
		)
		this_item
	),

	fn releaseData behholder_FP scbone_FP =
	(
		local i
		local behavior_type = M3F_GetCustAttr #IKleg
		custAttributes.add behholder_FP behavior_type #unique
		this.theIndex = custAttributes.count behholder_FP
		local behavior = custAttributes.get behholder_FP this.theIndex

		behavior.behaviorType = "IK_Leg_Behavior"
		behavior.behaviorState = true
		behavior.name = this.nameStr

		if(scbone_FP[this.nbrBone1].theObj != undefined)then
		(append behavior.boneList scbone_FP[this.nbrBone1].theObj)
		else(append behavior.boneList scbone_FP[this.nbrBone1].theBone)
		append behavior.boneStates true
		if(scbone_FP[this.nbrBone2].theObj != undefined)then
		(append behavior.boneList scbone_FP[this.nbrBone2].theObj)
		else(append behavior.boneList scbone_FP[this.nbrBone2].theBone)
		append behavior.boneStates true

		behavior.raycastUp = this.raycastUp
		behavior.raycastDn = this.raycastDn
		behavior.maxSpeed = this.maxSpeed
		behavior.goalThreshold = this.goalThreshold
	),
	fn collectData =(),

	fn buildSceneData m3obj_FP idx_FP =
	(
		local i
		local m3_ikleg = m3obj_FP.fIKJT[idx_FP]
		local m3_bone = m3obj_FP.fBONE

		this.nbrBone1 = m3_ikleg.nbrBone1 + 1
		this.nbrBone2 = m3_ikleg.nbrBone2 + 1
		this.nameStr = m3_bone[this.nbrBone2].rfdName.data + "_IK_" + m3_bone[this.nbrBone1].rfdName.data

		this.raycastUp = m3_ikleg.raycastUp * 100
		this.raycastDn = m3_ikleg.raycastDn * 100
		this.maxSpeed = m3_ikleg.maxSpeed * 100
		this.goalThreshold = m3_ikleg.goalThreshold * 100
	)
)

--SCENE MAIN STRUCT--------------------------------------------
struct M3S_SceneMain
(
	sAnimProp = #(), sTrackSet = #(),
	sJoint = #(), sTurret = #(), sBillBoard = #(), sIKleg = #(), sCloth = #(),
	sBone = #(), sEvent = #(), sMesh = #(), sLight = #(), sCamera = #(),
	sParticle = #(), sPhysics = #(), sHelper = #(), sMaterial = #(),

	fn releaseData =
	(
		local i
		local common_behholder
		local glb_pos = M3F_GetGlobalSettings #GlobalPos
		--return true

		--releaseAnimProps--------------------------------------------------------------------------
		if(M3F_GetGlobalSettings #SeqEnable)then
		(
			M3F_ShowPhaseInfo "Releasing AnimProps ..."
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
			M3F_ShowPhaseInfo "Skip AnimProps!" type:#Warning
			M3F_FillProgressLv step:this.sAnimProp.count flag:#execute
		)
		--releaseMaterials--------------------------------------------------------------------------
		if(M3F_GetGlobalSettings #MatEnable)then
		(
			M3F_ShowPhaseInfo "Releasing Materials ..."
			for i=1 to this.sMaterial.count do
			(
				M3F_FillProgressLv flag:#execute
				this.sMaterial[i].releaseData i
			)
			for i=1 to this.sMaterial.count do
			(this.sMaterial[i].releaseCompSubMat this.sMaterial)
		)else
		(
			M3F_ShowPhaseInfo "Skip Materials!" type:#Warning
			M3F_FillProgressLv step:this.sMaterial.count flag:#execute
		)
		--releaseBones------------------------------------------------------------------------------
		M3F_ShowPhaseInfo "Releasing Bones ..."
		for i=1 to this.sBone.count do
		(
			M3F_FillProgressLv flag:#execute
			this.sBone[i].releaseData this.sBone
		)
		for i=1 to this.sBone.count do
		(this.sBone[i].bindingPoseApply())
		if((M3F_GetGlobalSettings #BoneEntity) == 2 or (M3F_GetGlobalSettings #BoneEntity) == 3)then
		(
			for i=1 to this.sBone.count do
			(this.sBone[i].calculateBoxBoundary())
		)
		--releaseEvent------------------------------------------------------------------------------
		if(M3F_GetGlobalSettings #EventEnable)then
		(
			M3F_ShowPhaseInfo "Releasing Events ..."
			for i=1 to this.sEvent.count do
			(
				M3F_FillProgressLv flag:#execute
				this.sEvent[i].releaseData this.sBone
			)
		)else
		(
			M3F_ShowPhaseInfo "Skip Events!" type:#Warning
			M3F_FillProgressLv step:this.sEvent.count flag:#execute
		)
		--releaseMeshes-----------------------------------------------------------------------------
		if(M3F_GetGlobalSettings #MeshEnable)then
		(
			M3F_ShowPhaseInfo "Releasing Meshes ..."
			max modify mode
			for i=1 to this.sMesh.count do
			(
				M3F_FillProgressLv step:5 flag:#execute
				this.sMesh[i].releaseData this.sBone this.sMaterial
			)
			max create mode
		)else
		(
			M3F_ShowPhaseInfo "Skip Meshes!" type:#Warning
			M3F_FillProgressLv step:(this.sMesh.count * 5) flag:#execute
		)
		--animationApply----------------------------------------------------------------------------
		if((M3F_GetGlobalSettings #AnimEnable) == true and (M3F_GetGlobalSettings #BoneAnim) == true)then
		(
			for i=1 to this.sBone.count do
			(this.sBone[i].animApply this.sBone)
		)
		--releaseLights-----------------------------------------------------------------------------
		if(M3F_GetGlobalSettings #LightEnable)then
		(
			M3F_ShowPhaseInfo "Releasing Lights ..."
			for i=1 to this.sLight.count do
			(
				M3F_FillProgressLv flag:#execute
				this.sLight[i].releaseData this.sBone
			)
		)else
		(
			M3F_ShowPhaseInfo "Skip Lights!" type:#Warning
			M3F_FillProgressLv step:this.sLight.count flag:#execute
		)
		--releaseCameras----------------------------------------------------------------------------
		if(M3F_GetGlobalSettings #CamEnable)then
		(
			M3F_ShowPhaseInfo "Releasing Cameras ..."
			for i=1 to this.sCamera.count do
			(
				M3F_FillProgressLv flag:#execute
				this.sCamera[i].releaseData this.sBone
			)
		)else
		(
			M3F_ShowPhaseInfo "Skip Cameras!" type:#Warning
			M3F_FillProgressLv step:this.sCamera.count flag:#execute
		)
		--releaseParticles--------------------------------------------------------------------------
		if(M3F_GetGlobalSettings #ParEnable)then
		(
			M3F_ShowPhaseInfo "Releasing Particles ..."
			for i=1 to this.sParticle.count do
			(
				M3F_FillProgressLv flag:#execute
				this.sParticle[i].releaseData this.sBone this.sMaterial
			)
		)else
		(
			M3F_ShowPhaseInfo "Skip Particles!" type:#Warning
			M3F_FillProgressLv step:this.sParticle.count flag:#execute
		)
		--releasePhysics----------------------------------------------------------------------------
		if(M3F_GetGlobalSettings #PhyEnable)then
		(
			M3F_ShowPhaseInfo "Releasing Physics ..."
			for i=1 to this.sPhysics.count do
			(
				M3F_FillProgressLv flag:#execute
				this.sPhysics[i].releaseData this.sBone
			)
			--releasePhysicsJoint-------------------------------------------------------------------
			M3F_ShowPhaseInfo "Releasing PhysicsJoint ..."
			if(this.sJoint.count > 0 and common_behholder == undefined)then
			(
				common_behholder = SC2BehaviorHolder name:"SC2BehaviorHolder_Import" pos:glb_pos
			)
			for i=1 to this.sJoint.count do
			(
				M3F_FillProgressLv flag:#execute
				this.sJoint[i].releaseData common_behholder this.sBone
			)
		)else
		(
			M3F_ShowPhaseInfo "Skip Physics Sys!" type:#Warning
			M3F_FillProgressLv step:this.sPhysics.count flag:#execute
		)
		--releaseHelpers----------------------------------------------------------------------------
		M3F_ShowPhaseInfo "Releasing Helpers ..."
		if((M3F_GetGlobalSettings #HitEnable) != true)then(M3F_ShowPhaseInfo "Skip Hit Tests!" type:#Warning)
		if((M3F_GetGlobalSettings #VolEnable) != true)then(M3F_ShowPhaseInfo "Skip Vol Targets!" type:#Warning)
		if((M3F_GetGlobalSettings #AttEnable) != true)then(M3F_ShowPhaseInfo "Skip Attachments!" type:#Warning)
		if((M3F_GetGlobalSettings #BoundEnable) != true)then(M3F_ShowPhaseInfo "Skip Bounds!" type:#Warning)
		for i=1 to this.sHelper.count do
		(
			M3F_FillProgressLv flag:#execute
			case of
			(
				(this.sHelper[i].helperType < 9):
				(
					if((M3F_GetGlobalSettings #HitEnable) != true)then(continue)
				)
				(this.sHelper[i].helperType < 13):
				(
					if((M3F_GetGlobalSettings #VolEnable) != true)then(continue)
				)
				(this.sHelper[i].helperType == 13):
				(
					if((M3F_GetGlobalSettings #AttEnable) != true)then(continue)
				)
				(this.sHelper[i].helperType == 14):
				(
					if((M3F_GetGlobalSettings #BoundEnable) != true)then(continue)
				)
			)
			this.sHelper[i].releaseData this.sBone
		)
		--releasePhysicsCloth-------------------------------------------------------------------
		if(M3F_GetGlobalSettings #PhyEnable)then
		(
			M3F_ShowPhaseInfo "Releasing PhysicsCloth ..."
			if(this.sCloth.count > 0 and common_behholder == undefined)then
			(
				common_behholder = SC2BehaviorHolder name:"SC2BehaviorHolder_Import" pos:glb_pos
			)
			for i=1 to this.sCloth.count do
			(
				M3F_FillProgressLv flag:#execute
				this.sCloth[i].releaseData common_behholder this.sBone this.sMesh this.sPhysics
			)
		)
		--releaseAnimTrackSet-----------------------------------------------------------------------
		if(M3F_GetGlobalSettings #TrackEnable)then
		(
			M3F_ShowPhaseInfo "Releasing TrackSets ..."
			if(this.sTrackSet.count > 0 and common_behholder == undefined)then
			(
				common_behholder = SC2BehaviorHolder name:"SC2BehaviorHolder_Import" pos:glb_pos
			)
			for i=1 to this.sTrackSet.count do
			(
				M3F_FillProgressLv flag:#execute
				this.sTrackSet[i].releaseData common_behholder \
				this.sMaterial \
				this.sBone \
				this.sMesh \
				this.sLight \
				this.sCamera \
				this.sParticle \
				this.sPhysics \
				this.sEvent \
				this.sHelper
			)
		)else
		(
			M3F_ShowPhaseInfo "Skip TrackSets!" type:#Warning
			M3F_FillProgressLv step:this.sTrackSet.count flag:#execute
		)
		--releaseTurret-----------------------------------------------------------------------------
		if(M3F_GetGlobalSettings #TurretEnable)then
		(
			M3F_ShowPhaseInfo "Releasing Turrets ..."
			if(this.sTurret.count > 0 and common_behholder == undefined)then
			(
				common_behholder = SC2BehaviorHolder name:"SC2BehaviorHolder_Import" pos:glb_pos
			)
			for i=1 to this.sTurret.count do
			(
				M3F_FillProgressLv flag:#execute
				this.sTurret[i].releaseData common_behholder this.sBone
			)
		)else
		(
			M3F_ShowPhaseInfo "Skip Turrets!" type:#Warning
			M3F_FillProgressLv step:this.sTurret.count flag:#execute
		)
		--releaseBillBoard--------------------------------------------------------------------------
		if(M3F_GetGlobalSettings #BillBoardEnable)then
		(
			M3F_ShowPhaseInfo "Releasing BillBoards ..."
			if(this.sBillBoard.count > 0 and common_behholder == undefined)then
			(
				common_behholder = SC2BehaviorHolder name:"SC2BehaviorHolder_Import" pos:glb_pos
			)
			for i=1 to this.sBillBoard.count do
			(
				M3F_FillProgressLv flag:#execute
				this.sBillBoard[i].releaseData common_behholder this.sBone
			)
		)else
		(
			M3F_ShowPhaseInfo "Skip BillBoards!" type:#Warning
			M3F_FillProgressLv step:this.sBillBoard.count flag:#execute
		)
		--releaseIKleg------------------------------------------------------------------------------
		if(M3F_GetGlobalSettings #IKLegEnable)then
		(
			M3F_ShowPhaseInfo "Releasing IKlegs ..."
			if(this.sIKleg.count > 0 and common_behholder == undefined)then
			(
				common_behholder = SC2BehaviorHolder name:"SC2BehaviorHolder_Import" pos:glb_pos
			)
			for i=1 to this.sIKleg.count do
			(
				M3F_FillProgressLv flag:#execute
				this.sIKleg[i].releaseData common_behholder this.sBone
			)
		)else
		(
			M3F_ShowPhaseInfo "Skip IKlegs!" type:#Warning
			M3F_FillProgressLv step:this.sIKleg.count flag:#execute
		)
		--ReplaceWeights----------------------------------------------------------------------------
		if(M3F_GetGlobalSettings #SkinEnable)then
		(
			max modify mode
			for i=1 to this.sMesh.count do
			(
				this.sMesh[i].replaceSkinedBone this.sBone
			)
			max create mode
		)
		--cleanBones--------------------------------------------------------------------------------
		if((M3F_GetGlobalSettings #BoneEnable) != true)then
		(
			M3F_ShowPhaseInfo "Delete Additional Bones ..."
		)
		for i=1 to this.sBone.count do
		(this.sBone[i].deleteBones())
		M3F_ShowPhaseInfo "----------------------Release Finished----------------------"
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

		--buildAnimProp-----------------------------------------------------------------------------
		M3F_ShowPhaseInfo "Building AnimProps ..."
		M3F_ShowObjectCount "AnimProps" m3obj_FP.fSTG.count
		for i=1 to m3obj_FP.fSTG.count do
		(
			M3F_FillProgressLv()
			append this.sAnimProp (M3S_ScAnimProp.init m:m3obj_FP i:i)
			if(this.sAnimProp[i].tracksetsList.count > 0)then
			(
				append trackName (deepCopy this.sAnimProp[i].tracksetsList)
			)
		)
		M3F_FillProgressLv step:1 flag:#current
		--buildTrackSet-----------------------------------------------------------------------------
		for i=1 to trackName.count do
		(
			for n=1 to trackName[i].count do
			(
				appendIfUnique trackSets trackName[i][n]
			)
		)
		M3F_ShowPhaseInfo "Building TrackSet ..."
		M3F_ShowObjectCount "TrackSet" trackSets.count
		for i=1 to trackSets.count do
		(
			M3F_FillProgressLv()
			append this.sTrackSet (M3S_ScTrackSet.init m:m3obj_FP t:trackSets[i])
		)
		M3F_FillProgressLv step:1 flag:#current
		--buildMaterials----------------------------------------------------------------------------
		M3F_ShowPhaseInfo "Building Materials ..."
		M3F_ShowObjectCount "Materials" m3obj_FP.fMATM.count
		for i=1 to m3obj_FP.fMATM.count do
		(
			M3F_FillProgressLv()
			append this.sMaterial \
			(M3S_ScMaterial.init m:m3obj_FP s:this.sAnimProp t:this.sTrackSet i:i)
		)
		M3F_FillProgressLv step:1 flag:#current
		--buildBones--------------------------------------------------------------------------------
		M3F_ShowPhaseInfo "Building Bones ..."
		M3F_ShowObjectCount "Bones" m3obj_FP.fBONE.count
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
		--buildEvents-------------------------------------------------------------------------------
		M3F_ShowPhaseInfo "Building Events ..."
		M3F_ShowObjectCount "Events" eventList.count
		for i=1 to eventList.count do
		(
			M3F_FillProgressLv()
			append this.sEvent \
			(M3S_ScEvent.init m:m3obj_FP s:this.sAnimProp t:this.sTrackSet ib:eventList[i] i:i)
			append exceptBones this.sEvent[i].nbrBone
			append bonesType 1
		)
		M3F_FillProgressLv step:1 flag:#current
		--buildMeshes-------------------------------------------------------------------------------
		M3F_ShowPhaseInfo "Building Meshes ..."
		if(m3obj_FP.fDIV.rfdREGN.data == undefined)then
		(
			M3F_ShowObjectCount "Meshes" 0
		)else
		(
			M3F_ShowObjectCount "Meshes" m3obj_FP.fDIV.rfdREGN.data.count
			for i=1 to m3obj_FP.fDIV.rfdREGN.data.count do
			(
				M3F_FillProgressLv step:5
				append this.sMesh (M3S_ScMesh.init m:m3obj_FP s:this.sAnimProp t:this.sTrackSet i:i)
				append exceptBones this.sMesh[i].rootBone
				append bonesType 2
				append exceptBones this.sMesh[i].nbrBone
				append bonesType 5
			)
		)
		M3F_FillProgressLv step:2 flag:#current
		--buildLights-------------------------------------------------------------------------------
		M3F_ShowPhaseInfo "Building Lights ..."
		M3F_ShowObjectCount "Lights" m3obj_FP.fLITE.count
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
		M3F_FillProgressLv step:1 flag:#current
		--buildCameras------------------------------------------------------------------------------
		M3F_ShowPhaseInfo "Building Cameras ..."
		M3F_ShowObjectCount "Cameras" m3obj_FP.fCAM.count
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
		M3F_FillProgressLv step:1 flag:#current
		--buildParticles----------------------------------------------------------------------------
		M3F_ShowPhaseInfo "Building Particles ..."
		M3F_ShowObjectCount "Particles" (m3obj_FP.fPAR.count + m3obj_FP.fPARC.count)
		for i=1 to m3obj_FP.fPAR.count do
		(
			M3F_FillProgressLv()
			append this.sParticle \
			(M3S_ScParticle.init m:m3obj_FP s:this.sAnimProp t:this.sTrackSet \
				i:i f:#par c:this.sParticle.count)
			append exceptBones this.sParticle[this.sParticle.count].nbrBone
			append bonesType 1

			if(m3obj_FP.fPAR[i].rfdCopyIdx.data != undefined)then
			(
				local copy_src = this.sParticle.count
				for n=1 to m3obj_FP.fPAR[i].rfdCopyIdx.data.count do
				(
					append this.sParticle (M3F_StructCopy this.sParticle[copy_src])

					this.sParticle[this.sParticle.count].buildCopyData \
						m3obj_FP this.sAnimProp this.sTrackSet i n c:this.sParticle.count
					append exceptBones this.sParticle[this.sParticle.count].nbrBone
					append bonesType 1
				)
			)
		)
		M3F_ShowObjectCount "Ribbons" m3obj_FP.fRIB.count
		for i=1 to m3obj_FP.fRIB.count do
		(
			M3F_FillProgressLv()
			append this.sParticle \
			(M3S_ScParticle.init m:m3obj_FP s:this.sAnimProp t:this.sTrackSet \
				i:i f:#rib c:this.sParticle.count)
			append exceptBones this.sParticle[this.sParticle.count].nbrBone
			append bonesType 1
			append exceptBones this.sParticle[this.sParticle.count].nbrSubBone
			append bonesType 1
		)
		M3F_ShowObjectCount "Projectors" m3obj_FP.fPROJ.count
		for i=1 to m3obj_FP.fPROJ.count do
		(
			M3F_FillProgressLv()
			append this.sParticle \
			(M3S_ScParticle.init m:m3obj_FP s:this.sAnimProp t:this.sTrackSet \
				i:i f:#proj c:this.sParticle.count)
			append exceptBones this.sParticle[this.sParticle.count].nbrBone
			append bonesType 1
		)
		M3F_FillProgressLv step:2 flag:#current
		--buildPhysicsSys------------------------------------------------------------------------------
		M3F_ShowPhaseInfo "Building Physics Sys ..."
		M3F_ShowObjectCount "Force" m3obj_FP.fFOR.count
		for i=1 to m3obj_FP.fFOR.count do
		(
			M3F_FillProgressLv()
			append this.sPhysics \
			(M3S_ScPhysics.init m:m3obj_FP s:this.sAnimProp t:this.sTrackSet \
				i:i f:#force c:this.sPhysics.count)
			append exceptBones this.sPhysics[i].nbrBone
			append bonesType 1
		)
		M3F_ShowObjectCount "Warp" m3obj_FP.fWRP.count
		for i=1 to m3obj_FP.fWRP.count do
		(
			M3F_FillProgressLv()
			append this.sPhysics \
			(M3S_ScPhysics.init m:m3obj_FP s:this.sAnimProp t:this.sTrackSet \
				i:i f:#warp c:this.sPhysics.count)
			append exceptBones this.sPhysics[this.sPhysics.count].nbrBone
			append bonesType 1
		)
		M3F_ShowObjectCount "RigedBody" m3obj_FP.fPHRB.count
		for i=1 to m3obj_FP.fPHRB.count do
		(
			M3F_FillProgressLv()
			append this.sPhysics \
			(M3S_ScPhysics.init m:m3obj_FP s:this.sAnimProp t:this.sTrackSet \
				i:i f:#rigedbody c:this.sPhysics.count)
			append exceptBones this.sPhysics[this.sPhysics.count].nbrBone
			append bonesType 1
		)
		M3F_ShowObjectCount "Joint" m3obj_FP.fPHYJ.count
		for i=1 to m3obj_FP.fPHYJ.count do
		(
			M3F_FillProgressLv()
			append this.sJoint (M3S_ScJoint.init m:m3obj_FP i:i)
		)
		M3F_ShowObjectCount "Cloth" m3obj_FP.fPHCL.count
		for i=1 to m3obj_FP.fPHCL.count do
		(
			M3F_FillProgressLv()
			append this.sCloth (M3S_ScCloth.init m:m3obj_FP s:this.sAnimProp r:this.sPhysics i:i)
		)
		M3F_FillProgressLv step:3 flag:#current
		--buildHelpers------------------------------------------------------------------------------
		M3F_ShowPhaseInfo "Building Helpers ..."
		if(m3obj_FP.fMODL.bndSphere.rad > 0)then
		(
			M3F_ShowObjectCount "Bounds" 1
			M3F_FillProgressLv()
			append this.sHelper (M3S_ScHelper.init m:m3obj_FP s:this.sAnimProp f:#bounds)
		)else(M3F_ShowObjectCount "Bounds" 0)
		-------------------------------------
		if(m3obj_FP.fMODL.tightTest.nbrBone < 0xFFFF)then
		(
			M3F_ShowObjectCount "Tight" 1
			M3F_FillProgressLv()
			append this.sHelper (M3S_ScHelper.init m:m3obj_FP t:this.sTrackSet f:#tight c:this.sHelper.count)
			append exceptBones this.sHelper[this.sHelper.count].nbrBone
			append bonesType 1
		)else(M3F_ShowObjectCount "Tight" 0)
		-------------------------------------
		if(m3obj_FP.fMODL.rfdSSGS.data != undefined)then
		(
			M3F_ShowObjectCount "Fuzzy" m3obj_FP.fMODL.rfdSSGS.data.count
			for i=1 to m3obj_FP.fMODL.rfdSSGS.data.count do
			(
				M3F_FillProgressLv()
				append this.sHelper \
					(M3S_ScHelper.init m:m3obj_FP t:this.sTrackSet i:i f:#fuzzy c:this.sHelper.count)
				append exceptBones this.sHelper[this.sHelper.count].nbrBone
				append bonesType 1
			)
		)else
		(M3F_ShowObjectCount "Fuzzy" 0)
		-------------------------------------
		if(m3obj_FP.fMODL.rfdATVL.data != undefined)then
		(
			M3F_ShowObjectCount "attVol" m3obj_FP.fMODL.rfdATVL.data.count
			for i=1 to m3obj_FP.fMODL.rfdATVL.data.count do
			(
				M3F_FillProgressLv()
				append this.sHelper \
					(M3S_ScHelper.init m:m3obj_FP t:this.sTrackSet i:i f:#attvol c:this.sHelper.count)
				append exceptBones this.sHelper[this.sHelper.count].nbrBone
				append bonesType 1
			)
		)else
		(M3F_ShowObjectCount "attVol" 0)
		-------------------------------------
		M3F_ShowObjectCount "attach" m3obj_FP.fATT.attachments.count
		for i=1 to m3obj_FP.fATT.attachments.count do
		(
			local attach_temp = M3S_ScHelper()
			if(attach_temp.buildSceneData m3obj_FP unsupplied this.sTrackSet i f:#attach c:this.sHelper.count)then
			(
				M3F_FillProgressLv()
				append this.sHelper attach_temp
				append exceptBones this.sHelper[this.sHelper.count].nbrBone
				append bonesType 1
			)
		)
		M3F_FillProgressLv step:2 flag:#current
		--buildTurrets------------------------------------------------------------------------------
		M3F_ShowPhaseInfo "Building Turrets ..."
		M3F_ShowObjectCount "Turret" m3obj_FP.fTRGD.count
		for i=1 to m3obj_FP.fTRGD.count do
		(
			M3F_FillProgressLv()
			append this.sTurret (M3S_ScTurret.init m:m3obj_FP i:i)
		)
		M3F_FillProgressLv step:1 flag:#current
		--buildBillBoard----------------------------------------------------------------------------
		M3F_ShowPhaseInfo "Building BillBoards ..."
		M3F_ShowObjectCount "BillBoard" m3obj_FP.fBBSC.count
		for i=1 to m3obj_FP.fBBSC.count do
		(
			local bill_board = M3S_ScBillBoard()
			if(bill_board.buildSceneData m3obj_FP this.sBillBoard i)then
			(
				M3F_FillProgressLv()
				append this.sBillBoard bill_board
			)
		)
		M3F_FillProgressLv step:1 flag:#current
		--buildIKleg--------------------------------------------------------------------------------
		M3F_ShowPhaseInfo "Building IKlegs ..."
		M3F_ShowObjectCount "IKleg" m3obj_FP.fIKJT.count
		for i=1 to m3obj_FP.fIKJT.count do
		(
			M3F_FillProgressLv()
			append this.sIKleg (M3S_ScIKleg.init m:m3obj_FP i:i)
		)
		M3F_FillProgressLv step:1 flag:#current
		--buildBonesType----------------------------------------------------------------------------
		for i=1 to this.sBone.count do
		(
			this.sBone[i].copyBonesType exceptBones bonesType i
			--format "Name:% idx:% type:%\n" this.sBone[i].nameStr i this.sBone[i].boneType
		)
		for i=1 to this.sBone.count do
		(this.sBone[i].buildBonesType this.sBone this.sMesh i)
		M3F_FillProgressLv flag:#buildfinished
		M3F_ShowPhaseInfo "----------------------Building Finished----------------------"
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

/* Main Entries Functions */

fn M3F_ImportMain file_FP =
(
	local streamR
	streamR = fOpen file_FP "rb"

	M3F_FillProgressLv flag:#clear

	local time_range = animationRange
	local slider_time = sliderTime

	animationRange = interval 0 100
	sliderTime = 0

	local m3model =  M3S_FileMain()
	local max_scene = M3S_SceneMain()

	try
	(
		m3model.read streamR
		--format "-------------------------------------\n"
		max_scene.buildSceneData m3model
		--format "-------------------------------------\n"
		max_scene.releaseData()
	)catch
	(
		M3F_ShowLogInfo ("Error:" + getCurrentException()) type:#Error
		if(matchPattern (getCurrentException()) pattern:"*Cancel")then
		(
			M3F_ShowLogInfo "Canceled by User" type:#Error
		)
		else
		(
			M3F_ShowLogInfo "Script Run Error!!!" type:#Error
			messageBox "Script Run Error!!!"
		)
	)

	animationRange = time_range
	sliderTime = slider_time

	fClose streamR
)
---End Script--------------------------------------------------