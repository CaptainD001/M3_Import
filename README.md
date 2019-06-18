# M3_Import
M3 files Import Tools 使用说明
--------------------------------------------------------------------------------------
**M3 files Import Tools** 是适用于 3dsMax 的一款m3模型文件导入插件，可以导入StarCraft2的相关模型到 3dsMax 中进行编辑修改。
## 下载
* 插件本体下载：[跳转下载页面](https://github.com/CaptainD001/M3_Import/releases)
*  **`SC2StarArtTools for Max2016`** 下载：[跳转下载页面](https://github.com/CaptainD001/M3_Import/tree/SC2ArtTools)
## 使用注意
* 本插件v1.7a及以上版本和 **`SC2StarArtTools for Max2016`** 均支持 **3dsMax 2016 x64** 版本。
* 本插件v1.7及以下版本和 **`SC2StarArtTools for Max2011`** 都只支持 **3dsMax 2011 x64**，其余版本的 3dsMax 无法使用。
* 路径及文件名请全部使用英文，中文会引起运行错误。
## 安装/卸载/更新
* #### 安装
  * 需要提前安装 **`SC2StarArtTools`**
  * 复制 **`CaptainD-M3Import-vXX.mzp`** 脚本文件到 **`你Max的安装目录/Scripts/Startup`**
  * 启动 3dsMax，工具栏会在最右边自动添加导入插件的按钮
* #### 卸载
  * 删除 **`CaptainD-M3Import-vXX.mzp`** 重启 3dsmax 即可

* #### 更新
  * 删除旧版本 **`CaptainD-M3Import-vXX.mzp`** 脚本文件
  * 复制新版本 **`CaptainD-M3Import-vXX.mzp`** 脚本文件到同目录

## 使用
![界面预览](https://github.com/CaptainD001/M3_Import/blob/image/M3Import_0.png)
* 打开 3dsMax 后，会自动加载脚本，并在上方工具栏显示(从左到右: `SC2StarArtTools` `CaptainD-M3Import`)
* [**模型导入工具**]
  * [界面说明](#主界面)
  * [常见问题](#Q&A)
  * 打开模型导入工具后，点击 **`选择文件`** ，选择需要导入的文件，然后点击 **`导入`** 按钮，即可导入m3模型
  * 导入过程可能花费 30s~2min，导入期间 3dsMax 界面可能出现闪烁或未响应的情况，属于正常情况，请耐心等待
  * 如果导入出现错误提示，请向本人留言(18321277220@163.com)并告知导致导入错误的模型，我会尽快定位问题并修复脚本
* [**贴图路径修复工具**]
  * [界面说明](#贴图路径修复工具界面)
  * [使用指导](#step-by-step)
  * 可以修复场景材质贴图路径不正确的问题，也可以从游戏文件中自动解压必要贴图，具体使用方法见下方界面预览及其说明
  * 特别感谢一叶尽书繁华提供的CASC解压DLL库的支持
--------------------------------------------------------------------------------------
## 界面说明
* #### 主界面：
[返回顶部](#使用)
> ![界面预览](https://github.com/CaptainD001/M3_Import/blob/image/M3Import_1.png)    ![界面预览](https://github.com/CaptainD001/M3_Import/blob/image/M3Import_2.png)    ![界面预览](https://github.com/CaptainD001/M3_Import/blob/image/M3Import_3.png)
> ### 图标注释
>> #### 1 -> `默认化所有导入参数`
>> 　　 点击此按钮后所有导入参数会重置为默认的状态
>>
>> #### 2 -> `语言选择`
>> #### 3 -> `关于`
> ### Import Settings
>> #### 1 -> `导入路径及文件名显示`
>> #### 2 -> `选择导入文件按钮`
>> #### 3 -> `执行导入按钮`
>> #### 4 -> `导入进度及阶段显示`
>> #### 5 -> `是否记录并显示导入的详细信息`
>> 　　 如果此项被勾选，在开始导入时会自动打开 **`导入信息窗口`** ，并记录所有导入过程产生的提示信息
>>
>> #### 6 -> `是否在导入后弹出窗口提示缺失贴图`
>> #### 7 -> `导入信息窗口显示/关闭按钮`
>> #### 8 -> `默认自定义贴图搜索路径显示`
>> *    只有在贴图路径选择 **`User Select`** 时，此处显示的路径才会生效
>> #### 9 -> `贴图路径选择列表`
>> 　　 选择导入时材质贴图路径自动寻找的目录，可选择: **`m3文件根目录`** **`m3文件根目录\Textures`** **`m3文件根目录\Assets\Textures`** **`User Select`**
>>
>> #### 10 -> `选择自定义贴图搜索路径`
>> #### 其他 -> `各模块导入开关`
>> 　　 选项为相应模块内容导入开关，默认开启
>>
> ### Advance Settings
>> #### 全局
>> *    `位置偏移`
>> 　　 决定导入后模型出现的位置
>>
>> *    `缩放`
>> 　　 决定导入后模型的大小。注意，改变的大小不是通过轴缩放改变的，所以有可能出现失真的情况，遇到上述情况请将参数值设置为1.0
>>
>> #### 动画
>> *    `动画帧率`
>> 　　 决定导入后动画的播放速率，一般模型的默认速率为30帧
>>
>> *    `序列间帧数`
>> 　　 动画序列间的间隔帧数，最小为10帧
>>
>> *    `帧缩放修正`
>> 　　 动画导入后出现忽快忽慢的失真时，可适量放大此值，会删除时间不均匀的关键帧。一般在更改了默认帧率时会需要调整此项参数
>>
>> *    `帧缩放修正范围`
>> 　　 决定帧缩放修正删除失真动画帧的范围。如果动画忽快忽慢的情况没有得到解决可以适当调高此值，但也会失去更多的关键帧
>>
>> #### 网格
>> *    `导入选项`
>> 　　 设置导入时对网格进行的优化操作。可选择: **`原生导入`** **`焊接&平滑`** **`什么都不做`** **`只焊接`** **`只平滑`**
>>
>> 　　 **`原生导入`** 可以读取出m3文件里网格模型的实际焊接情况和平滑组设置，但会耗费大量时间计算并还原数据
>>
>> 　　 **`焊接&平滑`** 按照0.001阈值焊接顶点，并按照选择的平滑方式平滑网格模型
>>
>> 　　 **`什么都不做`** 不进行任何操作，如果导入时耗费大量时间，可以选择此项减少导入耗时
>>
>> 　　 **`只焊接`** 按照0.001阈值焊接顶点
>>
>> 　　 **`只平滑`** 按照选择的平滑方式平滑网格模型
>>
>> *    `按角度平滑`
>> 　　 按照设置的角度值自动平滑网格模型
>>
>> *    `按UV平滑`
>> 　　 按照网格模型 UVmapping 的划分方式分配平滑组
>>
>> #### 骨骼
>> *    `骨骼类型`
>> 　　 选择导入的骨骼使用的类型，下方设置各类型的大小。可选择: **`标准骨骼`** **`辅助体`** **`长方体`** **`四棱锥`** **`无实体`**
>>
>> 　　 **`标准骨骼`** 使用正常的骨骼对象
>>
>> 　　 **`辅助体`** 使用 Dummy 对象。在未使用 **`修正骨骼方向`** 选项时也会修正朝向，但此时修改的是显示方向，实际轴并未修改。
>>
>> 　　 **`长方体`** 使用 Box 对象。在未使用 **`修正骨骼方向`** 选项时也会修正朝向，但此时修改的是显示方向，实际轴并未修改。
>>
>> 　　 **`四棱锥`** 使用四棱锥对象，此类型比较像一般的骨骼对象。在未使用 **`修正骨骼方向`** 选项时也会修正朝向，但此时修改的是显示方向，实际轴并未修改。
>>
>> 　　 **`无实体`** 不会显示任何实体，强制显示骨骼的链接。 **`修正骨骼方向`** 选项对此类型无效。
>>
>> *    `导入动画`
>> 　　 决定是否导入所有骨骼的轴动画，关闭此项不会影响参数动画。
>>
>> *    `显示链接`
>> 　　 是否显示骨骼的链接
>>
>> *    `修正骨骼方向`
>> 　　 勾选此项时，会按照父级指向子级的方向尽可能的修改骨骼朝向，勾选此项会修改实际轴朝向，如果骨骼存在非等比缩放时，直接修改轴朝向会造成出现非正交坐标轴，3dsMax不能直接修改非正交坐标轴，编辑或导出时会造成动画失真，所以出现此问题时会额外创建一个 Dummy 父对象用来保存原来的轴数据
>>
>> *    `指定控制器`
>> 　　 指定骨骼使用的 移动/旋转/缩放 的控制器。
>>
>> #### 辅助对象
>> *    `附着点大小`
>> 　　 附着点显示的大小，不会影响实际缩放大小
>>
>> *    `附着点使用缩放`
>> 　　 决定是否导入附着点的缩放数据。一般来说m3模型的附着点没有直接的缩放数据，但是实际m3文件内存储有冗余的缩放数据，并且附着点的缩放数据可以被正确识别导出。
>>
>> *    `隐藏包围球`
>> 　　 决定包围球是否显示为边框模式，并冻结。
>>
>> *    `隐藏附着点`
>> 　　 决定附着点是否显示为点，并冻结。
>>
>> *    `隐藏体积辅助对象`
>> 　　 决定体积辅助对象是否显示为边框模式，并冻结。
>>
>> *    `碰撞测试辅助对象`
>> 　　 决定碰撞测试辅助对象是否显示为边框模式，并冻结。
>>
>> #### 灯光
>> *    `轴动画`
>> 　　 决定是否导入自身的轴动画。
>>
>> *    `参数动画`
>> 　　 决定是否导入自身的参数动画。
>>
>> #### 相机
>> *    `轴动画`
>> 　　 决定是否导入自身的轴动画。
>>
>> *    `参数动画`
>> 　　 决定是否导入自身的参数动画。
>>
>> #### 粒子
>> *    `轴动画`
>> 　　 决定是否导入自身的轴动画。
>>
>> *    `参数动画`
>> 　　 决定是否导入自身的参数动画。
>>
> --------------------------------------------------------------------------------------
## Q&A
* [返回顶部](#使用)
* **Question: 导入到一半时想取消怎么办？**
  * **Answer ->** 打开 **`导入信息窗口`** 并点击 **`Cancel`** 按钮
* **Question: 遇到提示错误"未知错误"怎么办？**
  * **Answer ->** 此问题是 3dsMax 合并文件时造成的随机错误，将导入了一半的物体删除后重新导入即可。
* **Question: 选择了贴图搜索路径依然提示找不到贴图怎么办？**
  * **Answer ->** 请使用 **`贴图路径修复工具`** ，一般可以完全解决贴图路径的问题。
* **Question: 网格选择"原生导入"后依然存在平滑组设置错误怎么办？**
  * **Answer ->** 现在原生导入的算法并不能100%还原平滑组数据，遇到此问题请选择其他平滑方式。
* **Question: 模型导入后骨骼方向混乱怎么办？**
  * **Answer ->** 使用标准骨骼时，请勾选 **`修正骨骼方向`** 选项，或直接使用其他类型的骨骼实体。
* **Question: 有些动画骨骼的旋转出现抖动怎么办？**
  * **Answer ->** 因为m3模型记录旋转信息使用的是Quat四元数的形式，在转换到易于编辑的欧拉坐标时会出现多解的情况，如果出现此问题请尝试更换骨骼的 **`旋转控制器`** ，如果问题未解决，请根据实际动画走向手动修复。
> --------------------------------------------------------------------------------------
* #### 贴图路径修复工具界面：
[返回顶部](#使用)
> ![界面预览](https://github.com/CaptainD001/M3_Import/blob/image/M3Import_4.png)
> ### 图标注释
>> #### 1 -> `贴图列表 全选/全不选`
>> #### 2 -> `需要寻找的贴图名称`
>> #### 3 -> `找到的贴图路径`
>> 　　 红色为此路径下无对应贴图
>>
>> 　　 黄色为已找到的贴图路径或准备复制到的路径但未实际应用到场景材质或已经复制贴图到目标路径
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
