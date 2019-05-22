<font color=red>我是红色</font>

## M3 File Struct
此文件用于说明介绍现已知的M3文件的数据结构，如有不正之处请联系我进行修改。

## Supported Data Types<br>

|Type							|Description|
|-------------------------------|-----------|
|String							|
|Byte							|
|Short							|
|UShort							|
|Long							|
|ULong							|
|[Flags](#Flags)				|
|Float							|
|[TagReference](#TagReference)	|
|[AnimReference](#AnimReference)|
|[BndSphere](#BndSphere)		|

## Main Struct<br>

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

## Data Struct<br>
* Base Struct Types<br>

|Type				|Name									|Entry	|Description|
|-------------------|---------------------------------------|-------|-----------|
|String				|[String](#String)						|CHAR	|
|String[]			|[String[]](#String-1)					|SCHR	|
|UByte				|[UnsignedByte](#UnsignedByte)			|U8		|
|UByte[4]			|[Color](#Color)						|COL	|
|UByte[4]			|[DivisionMatch](#DivisionMatch)		|DMSE	|
|Short				|[Short](#Short)						|I16	|
|UShort				|[UnsignedShort](#UnsignedShort)		|U16	|
|UShort[2]			|[UnsignedShort[2]](#UnsignedShort2)	|U32	|
|Long				|[Long](#Long)							|I32	|
|ULong				|[UnsignedLong](#UnsignedLong)			|U32	|
|Long[2]			|[Vector2](#Vector2)					|VEC2	|
|Long[3]			|[Vector3](#Vector3)					|VEC3	|
|Long[4]			|[Vector4](#Vector4)					|VEC4	|
|Long[4]			|[Quat](#Quat)							|QUAT	|
|Float				|[Float](#Float)						|REAL	|
|UnsignedLong		|[Flag](#Flag)							|FLAG	|

* Extend Struct Types<br>

|Name												|Entry		|Description|
|---------------------------------------------------|-----------|-----------|
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

## TagReference
[返回](#Supported-Data-Types)
## AnimReference
[返回](#Supported-Data-Types)
## BndSphere
[返回](#Supported-Data-Types)

______________________________________________________________________

## FileHeader
[返回](#Main-Struct)

<details>
  <summary><mark><font color=darkred>点击查看详细内容</font></mark></summary>
<table>
<tr><td colspan="2" bgcolor="Yellow"><font color=#00ffff>Offset</font></td><td colspan="4">HEX</td><td>Type</td><td>Name</td><td>Description</td><td>Bound</td><td>ToMax</td></tr>
<tr><td>0x00000000</td><td>(0)</td><td>3433444D</td><td></td><td></td><td></td><td>String</td><td>FileID</td><td>M3文件类型标识</td><td>"MD33","MD34"</td><td></td></tr>
<tr><td>0x00000004</td><td>(4)</td><td>10270000</td><td></td><td></td><td></td><td>Long</td><td>TagAddr</td><td>TagStruct入口地址</td><td></td><td></td></tr>
<tr><td>0x00000008</td><td>(8)</td><td>34000000</td><td></td><td></td><td></td><td>Long</td><td>TagCount</td><td>TagStruct数量</td><td>[0,...]</td><td></td></tr>
<tr><td>0x0000000C</td><td>(12)</td><td>01000000</td><td>01000000</td><td>00000000</td><td></td><td>TagRef</td><td></td><td>TagRef->ModelInfo(Struct:MODL)</td><td></td><td></td></tr>
</table>
</details>

{| class="wikitable"
! Offset
! 
! HEX
! 
! 
! 
! Type
! Name
! Description
! Bound
! ToMax
|-
| 0x00000000
| (0)
| 3433444D
| 
| 
| 
| String
| FileID
| M3文件类型标识
| MD33,"MD34"
| 
|-
| 0x00000004
| (4)
| 10270000
| 
| 
| 
| Long
| TagAddr
| TagStruct入口地址
| 
| 
|-
| 0x00000008
| (8)
| 34000000
| 
| 
| 
| Long
| TagCount
| TagStruct数量
| [0,...]
| 
|-
| 0x0000000C
| (12)
| 01000000
| 01000000
| 00000000
| 
| TagRef
| 
| TagRef->ModelInfo(Struct:MODL)
| 
| 
|}

## ModelInfo
[返回](#Main-Struct)

|Offset				|HEX								|Type	|Description		|Bound			|ToMax	|
|-------------------|-----------------------------------|-------|-------------------|---------------|-------|
|0x00000000	(0)		|01 00 00 00	02 00 00 00	00 00 00 00|TagRef	|TagRef->MaxFilePath|				|
|0x0000000C	(12)	|53 18 08 00						|Long	|Vertex类型标识		|				|
|0x00000010	(16)	|01 00 00 00	03 00 00 00	00 00 00 00|TagRef	|TagStruct数量		|				|
|0x0000000C	(12)	|01 00 00 00	01 00 00 00	00 00 00 00|TagRef	|TagRef->MODL		|				|

## Sequence
[返回](#Main-Struct)
## SeqTransCollection
[返回](#Main-Struct)
## SeqTransGroup
[返回](#Main-Struct)
## SeqTransSet
[返回](#Main-Struct)
## TrackSet
[返回](#Main-Struct)
## Bone
[返回](#Main-Struct)
## Vertex
[返回](#Main-Struct)
## Division
[返回](#Main-Struct)
## BindingPose
[返回](#Main-Struct)
## Attachment
[返回](#Main-Struct)
## Light
[返回](#Main-Struct)
## Camera
[返回](#Main-Struct)
## MaterialMatch
[返回](#Main-Struct)
## Standard
[返回](#Main-Struct)
## Displacement
[返回](#Main-Struct)
## Composite
[返回](#Main-Struct)
## Terrain
[返回](#Main-Struct)
## Creep
[返回](#Main-Struct)
## Volume
[返回](#Main-Struct)
## VolumeNoise
[返回](#Main-Struct)
## SplatTerrainBake
[返回](#Main-Struct)
## Flare
[返回](#Main-Struct)
## Particle
[返回](#Main-Struct)
## Ribbon
[返回](#Main-Struct)
## Projecter
[返回](#Main-Struct)
## Force
[返回](#Main-Struct)
## PhysicsRigedBody
[返回](#Main-Struct)
## PhysicsJoint
[返回](#Main-Struct)
## WarpVertex
[返回](#Main-Struct)

______________________________________________________________________

## String
[返回](#Data-Struct)
## String[]
[返回](#Data-Struct)
## UnsignedByte
[返回](#Data-Struct)
## Color
[返回](#Data-Struct)
## DivisionMatch
[返回](#Data-Struct)
## Short
[返回](#Data-Struct)
## UnsignedShort
[返回](#Data-Struct)
## UnsignedShort[2]
[返回](#Data-Struct)
## Long
[返回](#Data-Struct)
## UnsignedLong
[返回](#Data-Struct)
## Vector2
[返回](#Data-Struct)
## Vector3
[返回](#Data-Struct)
## Vector4
[返回](#Data-Struct)
## Quat	
[返回](#Data-Struct)
## Float
[返回](#Data-Struct)
## Flag
[返回](#Data-Struct)

______________________________________________________________________

## BndSphere
[返回](#Data-Struct)
## Tag
[返回](#Data-Struct)
## Spline
[返回](#Data-Struct)
## HitTest
[返回](#Data-Struct)
## Event
[返回](#Data-Struct)
## AnimBlock
[返回](#Data-Struct)
## Region
[返回](#Data-Struct)
## Boundary
[返回](#Data-Struct)
## MeshMaterialInfo
[返回](#Data-Struct)
## MapLayer
[返回](#Data-Struct)
## CompositeMatSet
[返回](#Data-Struct)
## FlareSubObj
[返回](#Data-Struct)
## RibbonSubObj
[返回](#Data-Struct)
## PhysicsRigedBodyShape
[返回](#Data-Struct)
