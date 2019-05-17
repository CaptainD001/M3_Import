# M3_Import
M3 files Import Tools 使用说明
--------------------------------------------------------------------------------------
### [跳转下载](https://github.com/CaptainD001/M3_Import/releases)
### 注意：本插件和 SC2StarArtTools 都只支持 3dsMax 2011 x64，其余版本的 3dsMax 无法使用。
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
> ### 左半部分
>> ###### 
