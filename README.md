# M3_Import
M3 files Import Tools 使用说明
--------------------------------------------------------------------------------------
### [跳转下载](https://github.com/CaptainD001/M3_Import/releases)
### 注意：本插件和 SC2StarArtTools 都只支持 3dsMax 2011 x64，其余版本的 3dsMax 无法使用。
###       路径及文件名请全部使用英文，中文会引起运行错误。
#### 安装：
* 需要提前安装SC2StarArtTools
* 复制“CaptainD-M3Import-vXX.mzp”脚本文件到“你Max的安装目录/Scripts/Startup”
* 启动3dsmax，工具栏会在最右边自动添加导入面板按钮

#### 卸载：
* 删除 “CaptainD-M3Import-vXX.mzp”重启3dsmax即可

#### 更新：
* 删除旧版本 “CaptainD-M3Import-vXX.mzp” 脚本文件
* 复制新版本 “CaptainD-M3Import-vXX.mzp” 脚本文件到同目录

#### 使用：
* 点击“选择文件”，选择需要导入的文件，然后点击“导入”按钮
* 导入过程可能花费30到60秒的时间，请耐心等待
* 如大幅度超过1分钟，可能导入出现错误，请向本人留言(18321277220@163.com)并告知导致导入错误的模型，会尽快修复脚本
#### 主界面：
![界面预览](https://github.com/CaptainD001/M3_Import/blob/image/M3Import_1.png)    ![界面预览](https://github.com/CaptainD001/M3_Import/blob/image/M3Import_2.png)    ![界面预览](https://github.com/CaptainD001/M3_Import/blob/image/M3Import_3.png)
> ### Import Settings
>> ###### 底部选项为相应模块内容导入开关，默认开启

> ### Advance Settings
>> #### 动画模块：
>> * ###### “帧缩放修正”动画导入后出现忽快忽慢时，可适量放大此值，会删除时间不均匀的关键帧
>> * ###### “帧缩放修正范围”同上，影响删除关键帧的范围，单位：帧
>> #### 网格模块：
>> * ###### “原生导入”可以读取出m3文件里网格模型的实际焊接情况和平滑组设置
>> * ###### “焊接&平滑”按照0.001阈值焊接顶点，并按照下方平滑设置平滑模型
>> * ###### “按UV平滑”按照UVmapping的划分方式分配平滑组
>> #### 骨骼模块：
>> * ###### “实体”将导入的骨骼显示为正常的max骨骼，不勾选为隐藏，此时强制显示骨骼链接
>> * ###### “导入动画”控制是否导入骨骼的“移动/旋转/缩放”即轴动画
>> #### 灯光模块：
>> * ###### 选项暂时无效果
>> #### 相机模块：
>> * ###### 选项暂时无效果
>> #### 粒子模块：
>> * ###### 选项暂时无效果
#### 贴图路径修复工具界面：
![界面预览](https://github.com/CaptainD001/M3_Import/blob/image/M3Import_4.png)
> ### 图标注释
>> ###### 1 -> [贴图列表 全选/全不选]
>> ###### 2 -> [需要寻找的贴图名称]
>> ###### 3 -> [找到的贴图路径]
>>> 红色为此路径下无对应贴图;
>>>
>>> 黄色为已找到的贴图路径或准备复制到的路径但未实际应用到场景材质或已经复制贴图到目标路径
>>>
>> ###### 4 -> [此贴图是否加入路径搜索]
>> ###### 5 -> [刷新贴图路径]
>>> 重新从来源读取贴图数据
>>>
>> ###### 6 -> [贴图数据来源]
>> ###### 7 -> [是否使用文件的路径来解释(RootPath)字符串]
>> ###### 8 -> [读取的完整文件路径]
>> ###### 9 -> [指定根路径]
>>> 是否使用根路径解释(RootPath)字符串，并且'使用文件路径'会覆盖此项的设置
>>>
>> ###### 10 -> [添加搜索路径]  [删除搜索路径]  [搜索路径默认化]
>>> 添加搜索路径：如果启用根路径模式下，任何添加的路径都会尝试解释为(RootPath)\*的形式
>>>
>>> 删除搜索路径：删除任何未在前面勾选的条目。如示例中的第3条
>>>
>>> 搜索路径默认化：删除所有已经存在的路径，并添加示例中的3条路径
>>>
>> ###### 11 -> [是否搜索子文件夹]
>>> 在搜索路径时，是否将搜索路径列表中路径的存在子路径一并搜索。如示例中搜索到第2条路径时，将会提前去检索第3条路径(如果路径存在)，并跳过搜索第3条路径
>>>
>>> * 在文件所在路径不清楚时，建议勾选此选项
>>> * 如需要准确指定贴图的路径时，建议不勾选此项，以免出现不正确的搜索顺序
>> ###### 12 -> [是否自动检索游戏文件中的贴图]
>>> 在所有指定搜索路径都未找到目标贴图时，会自动去游戏文件中检索并解压对应贴图
>>>
>>> * 此功能第一次使用时，会提示是否建立数据目录，如果继续会花费1到2分钟的时间去建立整个游戏文件的目录索引
>>> * 在功能开启的情况下，每次打开 3dsMax 并且第一次使用此修复工具时，都会花费3~4s的时间去将目录索引读入缓存中
>>> * 如果没有指定可用的搜索路径或复制到路径，此功能不会生效。即如果指定了有效的复制到路径，贴图会解压到目标路径，如果没有指定解压到路径，就会解压到搜素路径列表中第一个有效的路径
>>> * 此功能检索并解压每张贴图大概花费1s左右的时间，如贴图数量多请耐心等待
>> ###### 13 -> [搜索路径]
>>> 显示需要进行搜索的路径
>>>
>>> * 所有路径在此工具关闭时会自动保存
>>> * 路径含有(RootPath)字符串并且当前没有可用于解释的根路径时，条目会显示为红色
>>> * 所有条目可以拖动排序，并且在搜索时按照从上往下的顺序进行搜索
>> ###### 14 -> [是否复制贴图到指定目录]
>>> 将找到的贴图复制到目标路径，如果贴图是从场景材质中读取的，还会将场景材质中贴图的路径改为目标路径
>>>
>>> * 如果指定了有效的复制到路径，搜索路径时会首先搜索复制到路径，并且不会搜索复制到路径的子文件夹
>> ###### 15 -> [语言选择]
>> ###### 16 -> [执行搜索]  [执行应用]
>>> 按照当前参数执行搜索，使用搜索前需要更新搜索贴图列表
>>>
