## M3FileStruct
此文件用于说明介绍现已知的M3文件的数据结构，如有不正之处请联系我进行修改。
## MainStruct<br>
|Type      |Name                  |Entry|Description|
|----------|----------------------|-----|-----------|
|FileHeader|[FileHeader]()        |     |
|*         |[ModelInfo]()         |MODL |
|Animation |[Sequence]()          |SEQS |
|*         |[SeqTransCollection]()|STC  |
|*         |[SeqTransGroup]()     |STG  |
|*         |[SeqTransSet]()       |STS  |
|*         |[TrackSet]()          |     |
|Mesh      |[Bone]()              |BONE |
|*         |[Vertex]()            |U8   |
|*         |[Division]()          |DIV  |
|*         |[BindingPose]()       |IREF |
|Attachment|[Attachment]()        |ATT  |
|Light     |[Light]()             |LITE |
|Camera    |[Camera]()            |CAM  |
|Material  |[MaterialMatch]()     |MATM |
|*         |[Standard]()          |MAT  |
|*         |[Displacement]()      |DIS  |
|*         |[Composite]()         |CMP  |
|*         |[Terrain]()           |TER  |
|*         |[Creep]()             |CREP |
|*         |[Volume]()            |VOL  |
|*         |[VolumeNoise]()       |VON  |
|*         |[SplatTerrainBake]()  |STBM |
|*         |[Flare]()             |LFLR |
|Particle  |[Particle]()          |PAR  |
|*         |[Ribbon]()            |RIB  |
|*         |[Projecter]()         |PROJ |
|Physics   |[Force]()             |FOR  |
|*         |[PhysicsRigedBody]()  |PHRB |
|*         |[PhysicsJoint]()      |PHYJ |
|Others    |[WarpVertex]()        |WRP  |
## DataStruct<br>
* BaseTypes<br>
|Type            |Name                  |Entry|Description|
|----------------|----------------------|-----|-----------|
|String          |[String]()            |CHAR |
|String[]        |[String[]]()          |SCHR |
|UnsignedByte    |[UnsignedByte]()      |U8   |
|UnsignedByte[4] |[Color]()             |COL  |
|UnsignedByte[4] |[DivisionMatch]()     |DMSE |
|Short           |[Short]()             |I16  |
|UnsignedShort   |[UnsignedShort]()     |U16  |
|UnsignedShort[2]|[UnsignedShort[2]]()  |U32  |
|Long            |[Long]()              |I32  |
|UnsignedLong    |[UnsignedLong]()      |U32  |
|Long[2]         |[Vector2]()           |VEC2 |
|Long[3]         |[Vector3]()           |VEC3 |
|Long[4]         |[Vector4]()           |VEC4 |
|Long[4]         |[Quat]()              |QUAT |
|Float           |[Float]()             |REAL |
|Bool[32]        |[Flag]()              |FLAG |
* ExternTypes<br>
|Name                     |Entry    |Description|
|-------------------------|---------|-----------|
|[BndSphere]()            |         |
|[Tag]()                  |         |
|[Spline]()               |SVC3     |
|[HitTest]()              |SSGS/ATVL|
|[Event]()                |EVNT     |
|[AnimBlock]()            |SD**     |
|[Region]()               |REGN     |
|[Boundary]()             |MSEC     |
|[MeshMaterialInfo]()     |BAT      |
|[MapLayer]()             |LAYR     |
|[CompositeMatSet]()      |CMS      |
|[FlareSubObj]()          |LFSB     |
|[RibbonSubObj]()         |SRIB     |
|[PhysicsRigedBodyShape]()|PHSH     |