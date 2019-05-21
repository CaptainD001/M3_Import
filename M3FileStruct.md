## M3FileStruct
此文件用于说明介绍现已知的M3文件的数据结构，如有不正之处请联系我进行修改。

## MainStruct<br>

|Type		|Name										|Entry	|Description|
|-----------|-------------------------------------------|-------|-----------|
|FileHeader	|[FileHeader](#FileHeader)					|		|
|*			|[ModelInfo](#ModelInfo)					|MODL	|
|Animation	|[Sequence](#Sequence)						|SEQS	|
|*			|[SeqTransCollection](#SeqTransCollection)	|STC	|
|*			|[SeqTransGroup](#SeqTransGroup)			|STG	|
|*			|[SeqTransSet](#SeqTransSet)				|STS	|
|*			|[TrackSet](#TrackSet)						|		|
|Mesh		|[Bone](#Bone)								|BONE	|
|*			|[Vertex](#Vertex)							|U8		|
|*			|[Division](#Division)						|DIV	|
|*			|[BindingPose](#BindingPose)				|IREF	|
|Attachment	|[Attachment](#Attachment)					|ATT	|
|Light		|[Light](#Light)							|LITE	|
|Camera		|[Camera](#Camera)							|CAM	|
|Material	|[MaterialMatch](#MaterialMatch)			|MATM	|
|*			|[Standard](#Standard)						|MAT	|
|*			|[Displacement](#Displacement)				|DIS	|
|*			|[Composite](#Composite)					|CMP	|
|*			|[Terrain](#Terrain)						|TER	|
|*			|[Creep](#Creep)							|CREP	|
|*			|[Volume](#Volume)							|VOL	|
|*			|[VolumeNoise](#VolumeNoise)				|VON	|
|*			|[SplatTerrainBake](#SplatTerrainBake)		|STBM	|
|*			|[Flare](#Flare)							|LFLR	|
|Particle	|[Particle](#Particle)						|PAR	|
|*			|[Ribbon](#Ribbon)							|RIB	|
|*			|[Projecter](#Projecter)					|PROJ	|
|Physics	|[Force](#Force)							|FOR	|
|*			|[PhysicsRigedBody](#PhysicsRigedBody)		|PHRB	|
|*			|[PhysicsJoint](#PhysicsJoint)				|PHYJ	|
|Others		|[WarpVertex](#WarpVertex)					|WRP	|

## DataStruct<br>
* BaseTypes<br>

|Type				|Name									|Entry	|Description|
|-------------------|---------------------------------------|-------|-----------|
|String				|[String](#String)						|CHAR	|
|String[]			|[String[]](#String[])					|SCHR	|
|UnsignedByte		|[UnsignedByte](#UnsignedByte)			|U8		|
|UnsignedByte[4]	|[Color](#Color)						|COL	|
|UnsignedByte[4]	|[DivisionMatch](#DivisionMatch)		|DMSE	|
|Short				|[Short](#Short)						|I16	|
|UnsignedShort		|[UnsignedShort](#UnsignedShort)		|U16	|
|UnsignedShort[2]	|[UnsignedShort[2]](#UnsignedShort[2])	|U32	|
|Long				|[Long](#Long)							|I32	|
|UnsignedLong		|[UnsignedLong](#UnsignedLong)			|U32	|
|Long[2]			|[Vector2](#Vector2)					|VEC2	|
|Long[3]			|[Vector3](#Vector3)					|VEC3	|
|Long[4]			|[Vector4](#Vector4)					|VEC4	|
|Long[4]			|[Quat](#Quat)							|QUAT	|
|Float				|[Float](#Float)						|REAL	|
|Bool[32]			|[Flag](#Flag)							|FLAG	|

* ExternTypes<br>

|Name												|Entry		|Description|
|---------------------------------------------------|-----------|-----------|
|[BndSphere](#BndSphere)							|			|
|[Tag](#Tag)										|			|
|[Spline](#Spline)									|SVC3		|
|[HitTest](#HitTest)								|SSGS/ATVL	|
|[Event](#Event)									|EVNT		|
|[AnimBlock](#AnimBlock)							|SD**		|
|[Region](#Region)									|REGN		|
|[Boundary](#Boundary)								|MSEC		|
|[MeshMaterialInfo](#MeshMaterialInfo)				|BAT		|
|[MapLayer](#MapLayer)								|LAYR		|
|[CompositeMatSet](#CompositeMatSet)				|CMS		|
|[FlareSubObj](#FlareSubObj)						|LFSB		|
|[RibbonSubObj](#RibbonSubObj)						|SRIB		|
|[PhysicsRigedBodyShape](#PhysicsRigedBodyShape)	|PHSH		|
______________________________________________________________________

## FileHeader
[返回](#MainStruct)
## ModelInfo
[返回](#MainStruct)
## Sequence
[返回](#MainStruct)
## SeqTransCollection
[返回](#MainStruct)
## SeqTransGroup
[返回](#MainStruct)
## SeqTransSet
[返回](#MainStruct)
## TrackSet
[返回](#MainStruct)
## Bone
[返回](#MainStruct)
## Vertex
[返回](#MainStruct)
## Division
[返回](#MainStruct)
## BindingPose
[返回](#MainStruct)
## Attachment
[返回](#MainStruct)
## Light
[返回](#MainStruct)
## Camera
[返回](#MainStruct)
## MaterialMatch
[返回](#MainStruct)
## Standard
[返回](#MainStruct)
## Displacement
[返回](#MainStruct)
## Composite
[返回](#MainStruct)
## Terrain
[返回](#MainStruct)
## Creep
[返回](#MainStruct)
## Volume
[返回](#MainStruct)
## VolumeNoise
[返回](#MainStruct)
## SplatTerrainBake
[返回](#MainStruct)
## Flare
[返回](#MainStruct)
## Particle
[返回](#MainStruct)
## Ribbon
[返回](#MainStruct)
## Projecter
[返回](#MainStruct)
## Force
[返回](#MainStruct)
## PhysicsRigedBody
[返回](#MainStruct)
## PhysicsJoint
[返回](#MainStruct)
## WarpVertex
[返回](#MainStruct)

______________________________________________________________________

## String
[返回](#DataStruct)
## String[]
[返回](#DataStruct)
## UnsignedByte
[返回](#DataStruct)
## Color
[返回](#DataStruct)
## DivisionMatch
[返回](#DataStruct)
## Short
[返回](#DataStruct)
## UnsignedShort
[返回](#DataStruct)
## UnsignedShort[2]
[返回](#DataStruct)
## Long
[返回](#DataStruct)
## UnsignedLong
[返回](#DataStruct)
## Vector2
[返回](#DataStruct)
## Vector3
[返回](#DataStruct)
## Vector4
[返回](#DataStruct)
## Quat	
[返回](#DataStruct)
## Float
[返回](#DataStruct)
## Flag
[返回](#DataStruct)

______________________________________________________________________

## BndSphere
[返回](#DataStruct)
## Tag
[返回](#DataStruct)
## Spline
[返回](#DataStruct)
## HitTest
[返回](#DataStruct)
## Event
[返回](#DataStruct)
## AnimBlock
[返回](#DataStruct)
## Region
[返回](#DataStruct)
## Boundary
[返回](#DataStruct)
## MeshMaterialInfo
[返回](#DataStruct)
## MapLayer
[返回](#DataStruct)
## CompositeMatSet
[返回](#DataStruct)
## FlareSubObj
[返回](#DataStruct)
## RibbonSubObj
[返回](#DataStruct)
## PhysicsRigedBodyShape
[返回](#DataStruct)