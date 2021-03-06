# M3_Import
M3 files Import Tools Usage Instructions
--------------------------------------------------------------------------------------
**M3 files Import Tools** is the M3 model file import plugin for 3dsMax, which can import StarCraft2 related models into 3dsMax for editing and modifying.
## Special Thanks
Special thanks to:<br>
Taylor Mouse:　The M3 file's data structure is based on his script.<br>
Delphinium:　　Provide help on 3dsMax usage.<br>
一叶尽书繁华:　Provide the DLL library for texture path repair tool.<br>
werd:　　　　　Helped me tested the script.
## Download
* Plugin Download: [Jump Download Page](https://github.com/CaptainD001/M3_Import/releases)
*  **`SC2StarArtTools for Max2016`** Download：[Jump Download Page](https://github.com/CaptainD001/M3_Import/tree/SC2ArtTools)
## Use Attention
* This plugin v1.7a and above and **`SC2StarArtTools for Max2016`** support **3dsMax 2016 x64**.
* This plugin v1.7 and below and **`SC2StarArtTools for Max2011`** only support **3dsMax 2011 x64**, and the remaining versions of 3dsMax are not available.
* Please use English for the path and file name.
## Install/Uninstall/Update
* #### Installation
  * Need to install **`SC2StarArtTools`** in advance
  * Copy **`CaptainD-M3Import-vXX.mzp`** script file to **`your Max installation directory/Scripts/Startup`**
  * Start 3dsMax, and the toolbar will automatically add the plugin buttons on the right
* #### Uninstall
  * Delete **`CaptainD-M3Import-vXX.mzp`** and restart 3dsMax

* #### Update
  * Remove old version **`CaptainD-M3Import-vXX.mzp`** script file
  * Copy the new version **`CaptainD-M3Import-vXX.mzp`** script file to the same directory

## Use
![Interface preview](https://github.com/CaptainD001/M3_Import/blob/image/M3Import_0.png)
* When 3dsMax is opened, the script is automatically loaded and displayed in the upper toolbar (from left to right: `SC2StarArtTools'`CaptainD-M3Import')
* [**Model Import Tool**]
  * [Interface Description](#main-interface)
  * [FAQ](#qa)
  * After opening the model import tool, click **`Select File`**, select the file you want to import, and then click the **`import`** button to import the m3 model.
  * The import process may take 30s~2min. During the import, the 3dsMax interface may flash or not respond. This is normal. Please be patient.
  * If the importer display error messages, please leave a message to me (18321277220@163.com) and inform the model that caused the import error, I will locate the problem and fix the script as soon as possible.
* [**Map Path Repair Tool**]
  * [Interface Description](#map-path-repair-tool-interface)
  * [Guide To Use](#step-by-step)
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
>> 　　 Select the directory where the texture map path is automatically found when importing. Optional: **`m3 file root directory`** **`m3 file root directory\Textures`** **`m3 file root directory\Assets\Textures` ** **`User Select`**
>>
>> #### 10 -> `Select custom texture search path`
>> #### Other -> `Each module import switch`
>> 　　 The option is the corresponding module content import switch, which is enabled by default.
>>
> ### Advance Settings
>> #### Global
>> *    **`Location Offset`**
>>
>> 　　 Decide where the model will appear after import
>>
>> *    **`Scale`**
>>
>> 　　 Determine the size of the model after import. Note that the size of the change is not changed by the axis scaling, so there may be distortion. In the above case, set the parameter value to 1.0.
>>
>> #### Animation
>> *    **`Animation frame rate`**
>>
>> 　　 Determine the playback rate of the animation after import, the default rate of the general model is 30 frames
>>
>> *    **`Frames Between Sequences`**
>>
>> 　　 The number of interval frames between animation sequences, the minimum is 10 frames
>>
>> *    **`Frame Scale Correction`**
>>
>> 　　 When the animation is suddenly and slowly after importing, the value can be enlarged by an appropriate amount, and the key frames with uneven time will be deleted. This parameter will usually need to be adjusted when the default frame rate is changed.
>>
>> *    **`Frame Scale Correction Range`**
>>
>> 　　 Determine frame scale correction to remove the range of distorted animation frames. If the animation is still flickering, you can raise this value appropriately, but you will lose more keyframes.
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
>> 　　 `Only Welding` welds the vertices according to the 0.001 threshold
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
>> 　　 `Dummy` Use a Dummy object. The orientation is also corrected when the **`Fix Bone Orientation`** option is not used. Note that only the display direction is modified at this time, and the orientation of the actual axis is not modified.
>>
>> 　　 `Box` Use the Box object. The orientation is also corrected when the **`Fix Bone Orientation`** option is not used. Note that only the display direction is modified at this time, and the orientation of the actual axis is not modified.
>>
>> 　　 `Pyramid` Use the pyramid objects, this type is more like a normal bone object. The orientation is also corrected when the **`Fix Bone Orientation`** option is not used. Note that only the display direction is modified at this time, and the orientation of the actual axis is not modified.
>>
>> 　　 `No Entity` does not display any entities, force the display of bone's link. The **`Fix Bone Orientation`** option has no effect on this type.
>>
>> *    **`Import Animation`**
>>
>> 　　 Decide whether to import axis animations for all bones. Uncheck this item does not affect parameter animation.
>>
>> *    **`Show Link`**
>>
>> 　　 Whether to display the links of bones
>>
>> *    **`Fix Bone Orientation`**
>>
>> 　　 When this item is checked, the orientation of the bone will be modified as much as possible according to the direction of the parent pointing to the child. Checking this item will modify the actual axis orientation. If the bone has non-proportional scaling, directly modifying the orientation of the axis will result in non-orthogonal axes. 3dsMax can't directly modify non-orthogonal axes. When editing or exporting, it will cause animation distortion, so when this problem occurs, an additional Dummy parent object will be created to save the original axis data to avoid this problem.
>>
>> *    **`Specify controller`**
>>
>> 　　 Specifies the controller for the position/rotation/scale used by the bone.
>>
>> #### Helper
>> *    **`attachment point size`**
>>
>> 　　 The size of the attachment point display does not affect the actual scale size
>>
>> *    **`The attachment point uses scale`**
>>
>> 　　 Decide whether to import the scaling data of the attachment point. Generally, the attachment point of the m3 model has no direct scaling data, but the actual m3 file stores redundant scaling data, and the scaling data of the attachment point can be correctly identified and exported.
>>
>> *    **`Hide the bounds object`**
>>
>> 　　 Determines whether the bounding object is displayed in border mode and freezes.
>>
>> *    **`Hide attachment point`**
>>
>> 　　 Decide if the attachment point is displayed as a single point and freeze.
>>
>> *    **`Hide volume object`**
>>
>> 　　 Determines whether the volume object is displayed in border mode and freezes.
>>
>> *    **`Hit test object`**
>>
>> 　　 Determines whether the Hit test object is displayed in border mode and freezes.
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
* **Question: What do I want to cancel during the import process?**
  * **Answer ->** Open **`Import Info Window`** and click the **`Cancel`** button
* **Question: What should I do if I get a prompt error "Unknown error"?**
  * **Answer ->** This problem is a random error caused by 3dsMax merging files. Delete all objects that failed to import, re-import them.
* **Question: What if I choose the texture search path and still can't find the texture?**
  * **Answer ->** Please use the **`map path repair tool`** to solve the problem of the texture path.
* **Question: What should I do if there is still a smoothing group setting error after the mesh operating "Origin Import"?**
  * **Answer ->** Until now the origin imported algorithm does not restore the smoothed group data 100%. If you encounter this problem, please choose another smoothing method.
* **Question: What should I do if the bones' orientation are chaotic after the model is imported?**
  * **Answer ->** When using standard bones, check the **`Fix bone orientation`** option or use other types of bone entities directly.
* **Question: What if some of the bones' rotation animations are confusion?**
  * **Answer ->** Because the m3 model records rotation information using the Quat quaternion form, multiple solutions occur when converting to Euler coordinates that are easy to edit. If this problem occurs, try to replace the bones' **`Rotate controller`**, if the problem is not resolved, please manually fix it according to the actual animation.
> --------------------------------------------------------------------------------------
* #### Map Path Repair Tool Interface：
[back to top](#use)
> ![Interface Preview](https://github.com/CaptainD001/M3_Import/blob/image/M3Import_4.png)
> ### Icon Comments
>> #### 1 -> `Map list Select all/None`
>> #### 2 -> `The name of the map you need to search`
>> #### 3 -> `Current texture path`
>> 　　 Red has no corresponding map for this path
>>
>> 　　 Yellow is the found map path or the path to be copied to but not actually applied to
>>
>> #### 4 -> `Does this map join the path search`
>> #### 5 -> `Refresh current texture path`
>> 　　 Reread texture data from source
>>
>> *    Note that the refresh button will update the **entire list** regardless of whether the item in the map list is checked!
>> #### 6 -> `Map Data Sources`
>> #### 7 -> `Whether to use the path of the external file to interpret the (RootPath) string`
>> #### 8 -> `Read external file path`
>> #### 9 -> `Specify the root path`
>> 　　 Whether to use the root path to interpret (RootPath) strings, and **`use file path`** will override this item's settings
>>
>> #### 10 -> `Add search path`  `Delete search path`  `Search path defaults`
>> 　　 **`Add search path`** If root path mode is enabled, any added path will try to be interpreted as **`(RootPath)\*`**
>>
>> 　　 **`Delete search path`** Delete any paths that are not checked in list. Such as the third line in the interface preview
>>
>> 　　 **`Search path defaults`** Delete all existing paths and add 3 paths in the interface preview
>>
>> #### 11 -> `Whether search for subfolders`
>> 　　 When searching for a path, whether to search for the existence of the subpath of the path in the search path list. If the second path is found in the interface preview, the third path will be retrieved in advance (if the path exists), and the third path will be skipped.
>>
>> *    It is recommended to check this option when the path of the file is not clear.
>> *    If you need to accurately specify the path of the texture, it is recommended not to check this option to avoid incorrect search order.
>> #### 12 -> `Whether automatically retrieve the texture in the game file`
>> 　　When the target map is not found in all specified search paths, it will automatically retrieve and extract the corresponding map from the game file.
>>
>> *    The first time you use this feature or the **`StarCraft2`** game has generated a new update, you will be prompted to create a data directory. If you continue, it will take **`1~2min`** to create a directory index of the entire game file
>> *    With the feature turned on, each time you open **`3dsMax`** and the first time you use this repair tool, it will take **3~4s`** to read the directory index into the cache.
>> *    This feature does not take effect if no search path is specified or copy to path available. That is, if a valid copy to path is specified, the texture is decompressed to the target path, and if not, the first valid path in the search path list will used instead.
>> *    This function retrieves and decompresses each texture will takes about **`1s`**. Please wait patiently if there are too many textures.
>> #### 13 -> `Search Path`
>> 　　 Display the path that needs to be searched
>>
>> *    All paths are automatically saved when this tool is closed
>> *    When the path contains a (RootPath) string and there is currently no root path available for interpretation, the path will be displayed in red and invalid
>> *    All items can be dragged and sorted, and searched in order from top to bottom during search
>> #### 14 -> `Whether copy the map to the specified directory`
>> 　　 Copy the found texture to the target path. If the texture is read from the scene material, the path of the texture in the scene material will be changed to the target path.
>>
>> *    If a valid copy to path is specified, the search operation will first search for the copy to path and will not search its subfolders.
>> #### 15 -> `Language selection`
>> #### 16 -> `Execute search` `Execute application`
>> 　　 Perform search operation according to current parameters, need to refresh search map list before click it
>>
> --------------------------------------------------------------------------------------
## Step by Step
* [back to top](#use)
* **How to fix the texture path in the scene?**

  * **Step1 ->** Open the texture path repair tool, the left map list will show the texture path of the material in your current scene.
  
  * **Step2 ->** Find the path that appears red in the map list, make sure this path is **`checked`**
  
  * **Step3 ->** Check the right side **`root path:`**, click **`Select`** button, select a suitable path as the starting point for the texture path search
  
  * **Step4 ->** **`(optional)`** Checked **`Search from CASC file`** **Note:** Turning this feature on may take some time to prepare the necessary Information, see above [icon comment] (#12--- whether to automatically retrieve the texture in the game file)
  
  * **Step5 ->** Click the **`+`** button to select and add the path to search for, make sure the added path is **`checked `**
  
  * **Step6 ->** **`(optional)`** Checked below **`Copy the found map to: `**, click the Select button and select a suitable path as the copy to path
  
  * **Step7 ->** Click the **`Search`** button to start searching the texture path and wait for completion
  
  * **Step8 ->** Click the **`Apply`** button to apply the **`new path value`** of the yellow paths on the left to the scene material
  ______________________________________________________________________________________________
* **How to automatically search or extract the texture of the external m3 file to the specified path?**

  * **Step1 ->** Open the texture path repair tool and select the right side **`Read from file`** radio button
  
  * **Step2 ->** Click the Select button, select the **`m3 file`** you need to search, and click the Refresh button to refresh the left map list.
  
  * **Step3 ->** Find the path that appears red in the map list, make sure this path is **`checked `**
  
  * **Step4 ->**  **`(two choices one)`** Checked the right **`root path:`**, click the **`Select`** button to select a suitable path as the texture path Starting point of search
  
  * **Step5 ->**  **`(two choices one)`** Checked the above **` (root path using file path) `**, use the path of **`m3 file`** as the path to the **`root path`**
  
  * **Step6 ->**  **`(optional)`** Checked **`Search from CASC file`** **Note: ** Turning this feature on may take some time to prepare the necessary Information, see above [icon comment] (#12--- whether to automatically retrieve the texture in the game file)
  
  * **Step7 ->** Click the **`+`** button to select and add the path to search for, make sure the added path is **`checked `**
  
  * **Step8 ->** **`(optional)`** Checked below **`Copy the found map to: `**, click the Select button and select a suitable path as the copy to path
  
  * **Step9 ->** Click the **`Search`** button to start searching the texture path and wait for completion
  
  * **Step10 ->** Click the **`Apply` button to copy or unzip the texture corresponding to the yellow paths on the left to the corresponding **`new path value`**
  ______________________________________________________________________________________________
