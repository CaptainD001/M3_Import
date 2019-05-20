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
|*         |[MeshMaterialInfo]()  |BAT  |
|*         |[BindingPose]()       |IREF |
|*         |[Boundary]()          |MSEC |
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
|BaseType  |Name                  |Description|
|----------|----------------------|-----------|
|          |[BndSphere]()         |
|          |[Tag]()               |
|          |[Vert]()              |
|          |[HitTest]()           |
|EVNT      |[Event]()             |
|          |[AnimBlock]()         |
|REGN      |[Region]()            |
