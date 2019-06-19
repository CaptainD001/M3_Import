# M3_Import
M3 files Import Tools Usage Instructions
--------------------------------------------------------------------------------------
**M3 files Import Tools** is the M3 model file import plug-in for 3dsMax, which can import StarCraft 2 related models for editing and modifying in 3dsMax.
## Thanks
Special thanks to:<br>
Taylor Mouse:　The M3 file's data structure is based on his script.<br>
Delphinium:　　Provide help on 3dsMax usage.<br>
一叶尽书繁华:　Provide the DLL library for texture path repair tool.<br>
werd:　　　　　Helped me tested the script.
## Download
* Plug-in Download: [Jump Download Page](https://github.com/CaptainD001/M3_Import/releases)
*  **`SC2StarArtTools for Max2016`** Download：[Jump Download Page](https://github.com/CaptainD001/M3_Import/tree/SC2ArtTools)
## Use Attention
* Versions v1.7a and above and **`SC2StarArtTools for Max2016`** support **3dsMax 2016 x64** .
* Versions V1.7 and below and **`SC2StarArtTools for Max2011`** only support **3dsMax 2011 x64**, the rest of the 3dsMax is not available.
* All paths and file names should be in English.
## Installation/Unloading/Updating
* #### Installation
  * Need to install **`SC2StarArtTools`** first
  * Copy the **`CaptainD-M3Import-vXX.mzp`** script file to **`your Max installation directory/Scripts/Startup`**
  * Start 3dsMax, and the toolbar will automatically add the plug-in buttons on the right
* #### Unloading
  * Delete **`CaptainD-M3Import-vXX.mzp`** and restart 3dsmax

* #### Update
  * Delete the old version of **`CaptainD-M3Import-vXX.mzp`** script file
  * Copy the new version of **`CaptainD-M3Import-vXX.mzp`** script file to the same directory

## Use
![Interface preview](https://github.com/CaptainD001/M3_Import/blob/image/M3Import_0.png)
* When 3dsMax is opened, the script is automatically loaded and displayed in the upper toolbar (from left to right: `SC2StarArtTools'`CaptainD-M3Import')
* [**Model Import Tool**]
  * [Interface Description](#MainInterface)
  * [FAQ](#qa)
  * After opening the model import tool, click **`Select File`**, select the file you want to import, and then click the **`import`** button to import the m3 model.
  * The import process may take 30s~2min. During the import, the 3dsMax interface may flash or not respond. This is normal. Please be patient.
  * If the importer display error messages, please leave a message to me (18321277220@163.com) and inform the model that caused the import error, I will locate the problem and fix the script as soon as possible.
* [**Map Path Repair Tool**]
  * [Interface Description](#MapPathRepairToolInterface)
  * [Guide to use](#step-by-step)
  * It can fix the problem that the scene texture map path is incorrect. You can also extract the necessary map automatically from the game file. For details, see the interface preview and its description.
  * Special thanks to the support of the CASC decompression DLL library provided by 一叶尽书繁华.
--------------------------------------------------------------------------------------
## Interface Description
* #### Main interface:
[back to top](#use)
> ![Interface Preview](https://github.com/CaptainD001/M3_Import/blob/image/M3Import_1.png)    ![Interface Preview](https://github.com/CaptainD001/M3_Import/blob/image/M3Import_2.png)    ![Interface Preview](https://github.com/CaptainD001/M3_Import/blob/image/M3Import_3.png)
> ### Icon Comments
>> #### 1 -> `Default all import parameters`
>> 　　 All import parameters will be reset to the default state after clicking this button
>>
>> #### 2 -> `Language selection`
>> #### 3 -> `About`
> ### Import Settings
>> #### 1 -> `Import path and file name display`
>> #### 2 -> `Select import file button`
>> #### 3 -> `Execute the import button`
>> #### 4 -> `Import progress and stage display`
>> #### 5 -> `Whether to record and display the details of the import`
>> 　　 If this item is checked, **`import information window`** will be opened automatically when importing, and all prompts generated during the import process will be recorded.
>>
>> #### 6 -> `Whether the pop-up window prompts missing map after importing`
>> #### 7 -> `Import information window display/close button`
>> #### 8 -> `Default custom texture search path display`
>> *    The path shown here will only take effect if the texture path is selected **`User Select`**
>> #### 9 -> `Map Path Selection List`
>> 　　 Select the directory where the texture map path is automatically found when importing. You can choose: **`m3 file root directory`** **`m3 file root directory\Textures`** **`m3 file root directory\Assets\Textures` ** **`User Select`**
>>
>> #### 10 -> `Select custom texture search path`
>> #### Other -> `Each module import switch`
>> 　　 The option is the corresponding module content import switch, which is enabled by default.
>>
> ### Advance Settings
>> #### Global
>> *    **`location offset`**
>>
>> 　　 Decide where the model will appear after import
>>
>> *    **`zoom`**
>>
>> 　　 Determine the size of the model after import. Note that the size of the change is not changed by the axis scaling, so there may be distortion. In the above case, set the parameter value to 1.0.
>>
>> #### Animation
>> *    **`Animation frame rate`**
>>
>> 　　 Determine the playback rate of the animation after import, the default rate of the general model is 30 frames
>>
>> *    **`Interframe number of frames`**
>>
>> 　　 The number of interval frames between animation sequences, the minimum is 10 frames
>>
>> *    **`Frame Scale Correction`**
>>
>> 　　 When there is a sudden and slow distortion after the animation is imported, the value can be enlarged by an appropriate amount, and the key frames with uneven time will be deleted. This parameter will usually need to be adjusted when the default frame rate is changed.
>>
>> *    **`Frame Scale Correction Range`**
>>
>> 　　 Determine frame zoom correction to remove the range of distorted animation frames. If the animation is slow or slow, you can raise this value appropriately, but you will lose more keyframes.
>>
>> #### Mesh
>> *    **`Import option`**
>>
>> 　　 Set the optimization of the mesh when importing. Optional: `Origin import` `welding & smoothing` `do nothing` `only Welding` `only smoothing`
>>
>> 　　 `Origin Import` can read the actual welding situation and smoothing group settings of the mesh model in the m3 file, but it will take a lot of time to calculate and restore the data.
>>
>> 　　 `Welding & Smoothing` Weld vertices according to the 0.001 threshold and smooth the mesh model according to the selected smoothing method
>>
>> 　　 `Do Nothing` Do not do anything. If it takes a lot of time to import, you can choose this to reduce the import time.
>>
>> 　　 `Only Welding` welds the apex according to the 0.001 threshold
>>
>> 　　 `Only Smoothing` Smooth mesh model according to the selected smoothing method
>>
>> *    **`Smooth by angle`**
>>
>> 　　 Automatically smooth the mesh model according to the set angle value
>>
>> *    **`Smooth by UV`**
>>
>> 　　 Assign smoothing groups according to the mesh model UVmapping
>>
>> #### Bone
>> *    **`Bone Type`**
>>
>> 　　 Select the type of bone used for import, and set the size of each type below. Optional: `OriginBone` `Dummy` `Box` `Pyramid` `No Entity`
>>
>> 　　 `OriginBone` use normal bone objects
>>
>> 　　 `Dummy` Use a Dummy object. The orientation is also corrected when the **`Fix Bone Orientation`** option is not used, but the display orientation is modified and the actual axis is not modified.
>>
>> 　　 `Box` Use the Box object. The orientation is also corrected when the **`Fix Bone Orientation`** option is not used, but the display orientation is modified and the actual axis is not modified.
>>
>> 　　 `Pyramid` Use the pyramid objects, this type is more like a normal bone object. The orientation is also corrected when the **`Fix Bone Orientation`** option is not used, but the display orientation is modified and the actual axis is not modified.
>>
>> 　　 `No Entity` does not display any entities, forcing links to bones. The **`Fix Bone Orientation`** option has no effect on this type.
>>
>> *    **`Import Animation`**
>>
>> 　　 Decide whether to import axis animations for all bones. Turning off this item does not affect parameter animation.
>>
>> *    **`Show Link`**
>>
>> 　　 Whether to display links to bones
>>
>> *    **`Fix Bone Orientation`**
>>
>> 　　 When this item is checked, the orientation of the bone will be modified as much as possible according to the direction of the parent pointing to the child. Checking this item will modify the actual axis orientation. If the bone has non-proportional scaling, directly modifying the orientation of the axis will cause the appearance. Non-orthogonal axes, 3dsMax can't directly modify non-orthogonal axes. When editing or exporting, it will cause animation distortion, so when this problem occurs, an additional Dummy parent object will be created to save the original axis data.
>>
>> *    **`Specify controller`**
>>
>> 　　 Specifies the controller for the translation/rotation/scale used by the bone.
>>
>> #### Helper
>> *    **`attachment point size`**
>>
>> 　　 The size of the attachment point display does not affect the actual scale size
>>
>> *    **`The attachment point uses scale`**
>>
>> 　　 Decide whether to import the scaling data of the attachment point. Generally, the attachment point of the m3 model has no direct scaling data, but the actual m3 file stores redundant scaling data, and the scaling data of the attachment point can be correctly identified and derived.
>>
>> *    **`Hide the encircled ball`**
>>
>> 　　 Determines whether the bounding ball is displayed in border mode and freezes.
>>
>> *    **`Hide attachment point`**
>>
>> 　　 Decide if the attachment point is displayed as a point and freeze.
>>
>> *    **`Hide volume helper object`**
>>
>> 　　 Determines whether the volume helper object is displayed in border mode and freezes.
>>
>> *    **`Collision test helper object`**
>>
>> 　　 Determines whether the collision test helper object is displayed in border mode and freezes.
>>
>> #### Light
>> *    **`Axis Animation`**
>>
>> 　　 Decide whether to import the axis animation.
>>
>> *    **`parameter animation`**
>>
>> 　　 Decide whether to import the parameter animation.
>>
>> #### Camera
>> *    **`Axis Animation`**
>>
>> 　　 Decide whether to import the axis animation.
>>
>> *    **`parameter animation`**
>>
>> 　　 Decide whether to import the parameter animation.
>>
>> #### Particle
>> *    **`Axis Animation`**
>>
>> 　　 Decide whether to import the axis animation.
>>
>> *    **`parameter animation`**
>>
>> 　　 Decide whether to import the parameter animation.
>>
> --------------------------------------------------------------------------------------
## Q&A
* [back to top](#use)
* **Question: What do I want to cancel when I import it in half?**
  * **Answer ->** Open **`Import Info Window`** and click the **`Cancel`** button
* **Question: What should I do if I get a prompt error "Unknown error"?**
  * **Answer ->** This problem is a random error caused by 3dsMax merging files. After importing half of the imported objects, re-import them.
* **Question: What if I choose the texture search path and still can't find the texture?**
  * **Answer ->** Please use the **`map path repair tool`** to solve the problem of the texture path.
* **Question: What should I do if there is still a smoothing group setting error after the grid selection "Origin Import"?**
  * **Answer ->** Now the origin imported algorithm does not restore the smoothed group data 100%. If you encounter this problem, please choose another smoothing method.
* **Question: What should I do if the bones are chaotic after the model is imported?**
  * **Answer ->** When using standard bones, check the **`Fix bone orientation`** option or use other types of bone entities directly.
* **Question: What if some of the bones' rotation animations are jittery?**
  * **Answer ->** Because the m3 model records rotation information using the Quat quaternion form, multiple solutions occur when converting to Euler coordinates that are easy to edit. If this problem occurs, try to replace the bones. **`Rotate controller`**, if the problem is not resolved, please manually fix it according to the actual animation.
> --------------------------------------------------------------------------------------
* #### Map Path Repair Tool Interface：
[back to top](#use)
> ![Interface Preview](https://github.com/CaptainD001/M3_Import/blob/image/M3Import_4.png)
> ### Icon Comments
>> #### 1 -> `Map list Select all/None`
>> #### 2 -> `The name of the map you need to find`
>> #### 3 -> `Found texture path`
>> 　　 Red has no corresponding map for this path
>>
>> 　　 Yellow is the found map path or the path to be copied to but not actually applied to
>>
>> #### 4 -> `此贴图是否加入路径搜索`
>> #### 5 -> `刷新贴图路径`
>> 　　 重新从来源读取贴图数据
>>
>> *    注意，不管贴图列表的条目前面是否勾选，刷新按钮都会更新**整个列表**！
>> #### 6 -> `贴图数据来源`
>> #### 7 -> `是否使用文件的路径来解释(RootPath)字符串`
>> #### 8 -> `读取的完整文件路径`
>> #### 9 -> `指定根路径`
>> 　　 是否使用根路径解释(RootPath)字符串，并且 **`使用文件路径`** 会覆盖此项的设置
>>
>> #### 10 -> `添加搜索路径`  `删除搜索路径`  `搜索路径默认化`
>> 　　 **`添加搜索路径`** 如果启用根路径模式下，任何添加的路径都会尝试解释为 **`(RootPath)\*`** 的形式
>>
>> 　　 **`删除搜索路径`** 删除任何未在前面勾选的条目。如示例中的第3条
>>
>> 　　 **`搜索路径默认化`** 删除所有已经存在的路径，并添加示例中的3条路径
>>
>> #### 11 -> `是否搜索子文件夹`
>> 　　 在搜索路径时，是否将搜索路径列表中路径的存在子路径一并搜索。如示例中搜索到第2条路径时，将会提前去检索第3条路径(如果路径存在)，并跳过搜索第3条路径
>>
>> *    在文件所在路径不清楚时，建议勾选此选项
>> *    如需要准确指定贴图的路径时，建议不勾选此项，以免出现不正确的搜索顺序
>> #### 12 -> `是否自动检索游戏文件中的贴图`
>> 　　在所有指定搜索路径都未找到目标贴图时，会自动去游戏文件中检索并解压对应贴图
>>
>> *    第一次使用此功能或 **`StarCraft2`** 游戏产生了新的更新时，会提示是否建立数据目录，如果继续，将会花费 **`1~2min`** 的时间去建立整个游戏文件的目录索引
>> *    在功能开启的情况下，每次打开 **`3dsMax`** 并且第一次使用此修复工具时，都会花费 **`3~4s`** 的时间去将目录索引读入缓存中
>> *    如果没有指定可用的搜索路径或复制到路径，此功能不会生效。即如果指定了有效的复制到路径，贴图会解压到目标路径，如果没有指定解压到路径，就会解压到搜素路径列表中第一个有效的路径
>> *    此功能检索并解压每张贴图大概花费 **`1s`** 左右的时间，如贴图数量多请耐心等待
>> #### 13 -> `搜索路径`
>> 　　 显示需要进行搜索的路径
>>
>> *    所有路径在此工具关闭时会自动保存
>> *    路径含有(RootPath)字符串并且当前没有可用于解释的根路径时，条目会显示为红色
>> *    所有条目可以拖动排序，并且在搜索时按照从上往下的顺序进行搜索
>> #### 14 -> `是否复制贴图到指定目录`
>> 　　 将找到的贴图复制到目标路径，如果贴图是从场景材质中读取的，还会将场景材质中贴图的路径改为目标路径
>>
>> *    如果指定了有效的复制到路径，搜索路径时会首先搜索复制到路径，并且不会搜索复制到路径的子文件夹
>> #### 15 -> `语言选择`
>> #### 16 -> `执行搜索`  `执行应用`
>> 　　 按照当前参数执行搜索，使用搜索前需要更新搜索贴图列表
>>
> --------------------------------------------------------------------------------------
## Step by Step
* [返回顶部](#使用)
* **怎样修复场景里的贴图路径？**

  * **Step1 ->** 打开贴图路径修复工具，左边贴图列表会显示你当前场景里材质的贴图路径
  
  * **Step2 ->** 找到贴图列表里显示为红色的条目，确保此条目 **`已勾选`** 
  
  * **Step3 ->** 勾选右侧 **`根路径:`** ，点击 **`选择`** 按钮，选择一个合适路径作为贴图路径搜索的起点
  
  * **Step4 ->** **`(可选)`** 勾选 **`从CASC文件中搜索`**  **注意:** 开启此功能可能会花费一些时间用来准备必要的信息，具体见上方[图标注释](#12---是否自动检索游戏文件中的贴图)
  
  * **Step5 ->** 点击 **`+`** 按钮选择并添加要进行搜索的路径，确保添加的路径条目 **`已勾选`** 
  
  * **Step6 ->** **`(可选)`** 勾选下方 **`复制找到的贴图到:`** ，点击选择按钮，选择一个合适的路径作为贴图存放的路径
  
  * **Step7 ->** 点击 **`搜索`** 按钮，开始搜索贴图路径并等待完成
  
  * **Step8 ->** 点击 **`应用`** 按钮，将左侧黄色条目的 **`新路径值`** ，应用到场景材质中
  ______________________________________________________________________________________________
* **怎样自动寻找或解压外部m3文件的贴图到指定路径？**

  * **Step1 ->** 打开贴图路径修复工具，选择右侧 **`从文件读取`** 单选框
  
  * **Step2 ->** 点击选择按钮，选择需要寻找的 **`m3文件`** ，并点击刷新按钮，刷新左侧贴图列表
  
  * **Step3 ->** 找到贴图列表里显示为红色的条目，确保此条目 **`已勾选`** 
  
  * **Step4 ->**  **`(二选一)`** 勾选右侧 **`根路径:`** ，点击 **`选择`** 按钮，选择一个合适路径作为贴图路径搜索的起点
  
  * **Step5 ->**  **`(二选一)`** 勾选上方 **`(根路径使用文件路径)`** ，使用 **`m3文件`** 的路径作为 **`根路径`** 的路径
  
  * **Step6 ->**  **`(可选)`** 勾选 **`从CASC文件中搜索`**  **注意:** 开启此功能可能会花费一些时间用来准备必要的信息，具体见上方[图标注释](#12---是否自动检索游戏文件中的贴图)
  
  * **Step7 ->** 点击 **`+`** 按钮选择并添加要进行搜索的路径，确保添加的路径条目 **`已勾选`** 
  
  * **Step8 ->**  **`(可选)`** 勾选下方 **`复制找到的贴图到:`** ，点击选择按钮，选择一个合适的路径作为贴图存放的路径
  
  * **Step9 ->** 点击 **`搜索`** 按钮，开始搜索贴图路径并等待完成
  
  * **Step10 ->** 点击 **`应用`** 按钮，将左侧黄色条目对应的贴图复制或解压到对应的 **`新路径值`** 的位置
  ______________________________________________________________________________________________
