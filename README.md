# do-wallpape


## 说明
下载\处理图片
* [500px壁纸](#wallpaper500px)
* [Bing壁纸](#wallpaperBing)
* [Unsplash壁纸](#wallpaperUnsplash)
* [wallpaperBlur](#wallpaperBlur)
* [wallpaperGrid](#wallpaperGrid)
* [wallpaperHO](#wallpaperHO)
* [wallpaperTiltshift](#wallpaperTiltshift)
* [wallpaperLockScreen](#wallpaperLockScreen)    
* [wallpaperDirs](#wallpaperDirs)    
    
    
------------
## wallpaper500px
### 说明
* 下载[500px](https://500px.com/)壁纸

------------
## wallpaperBing
### 说明
> 下载bing每日壁纸，并设定桌面壁纸。如果你想要保存壁纸, 请修改picFolderBase变量为指定文件夹路径; 如果不指定, 壁纸就会被丢到系统temp文件夹, 随时有丢失的危险~
* 默认下载bing今日壁纸
* 通过指定参数[1-7]   (eg: wallpaperBing.vbs 2)下载前几天的bing壁纸
* 可以加入系统定时任务，方便每天自动定时下载




------------
## wallpaperUnsplash
### 说明
* 下载unsplash最新壁纸

  
  
  

------------
## wallpaperBlur
### 说明
模糊当前桌面壁纸，清晰图标，具有所谓的沉浸感


### 参数
* [-b blurNum] [-p processStep] infile outfile
* blurNum - 模糊程度,默认值22,值越大花费的时间越长
* processStep - 处理步骤, 0[process] 1[setDeskWallpaper] 2[setLockWallpaper], default=2
* infile - 传入图片地址,为空\#时,使用当前桌面壁纸
* outfile - 保存图片地址,为空时,保存到temp目录
* [-h help]
* help - 打印注释信息

### 预览
<div align=center><img src="https://github.com/bjc5233/do-wallpaper/raw/master/wallpaperBlur/resources/demo.png"/></div>
<div align=center><img src="https://github.com/bjc5233/do-wallpaper/raw/master/wallpaperBlur/resources/demo2.png"/></div>




------------
## wallpaperGrid
### 说明
> 九宫格化处理壁纸

### 参数
* [-p padding] [-c color] [-p processStep] infile outfile
* padding - 宫格之间间隔 default=10
* color - 宫格之间间隔颜色 default=255,255,255,0.4
* processStep - 处理步骤, 0[process] 1[setDeskWallpaper] 2[setLockWallpaper], default=2
* infile - 传入图片地址,为空\#时,使用当前桌面壁纸
* outfile - 保存图片地址,为空时,保存到temp目录
* [-h help]
* help - 打印注释信息

### 预览
<div align=center><img src="https://github.com/bjc5233/do-wallpaper/raw/master/wallpaperGrid/resources/demo.png"/></div>






------------
## wallpaperHO
### 说明
> 将图片处理为氢氧风格

### 参数
* [-m mode] [-s coverScalePercent] [-x coverPosXPercent] [-y coverPosYPercent] [-b blurNum] [-p processStep] infile outfile
* mode - cover图在back图中的样式 1[rect] 2[rect-shadow] 3[circle] 4[circle-shadow] default=random
* coverScalePercent - cover图缩放值
* coverPosXPercent - cover图在back图X轴所处位置百分比
* coverPosYPercent - cover图在back图Y轴所处位置百分比
* blur - back图模糊程度,默认值22,值越大花费的时间越长
* processStep - 处理步骤, 0[process] 1[setDeskWallpaper] 2[setLockWallpaper], default=2
* infile - 传入图片地址,为空\#时,使用当前桌面壁纸
* outfile - 保存图片地址,为空时,保存到temp目录
* [-h help]
* help - 打印注释信息

### 预览
<div align=center><img src="https://github.com/bjc5233/do-wallpaper/raw/master/wallpaperHO/resources/demo.png"/></div>
<div align=center><img src="https://github.com/bjc5233/do-wallpaper/raw/master/wallpaperHO/resources/demo2.png"/></div>



------------
## wallpaperTiltshift
### 说明
> 对图片进行移轴处理


### 调用参数
* [-m mode] [-s size] [-b blur] [-p processStep] infile outfile
* mode - vertical(v), horizontal(h), circle(c) default=vertical
* size - size of central unblurred area; -100~100 default=0
* blur - blur amount for outer area; default=22
* processStep - 处理步骤, 0[process] 1[setDeskWallpaper] 2[setLockWallpaper], default=2
* infile - 传入图片地址,为空时,使用当前桌面壁纸
* outfile - 保存图片地址,为空时,保存到temp目录
* [-h help]
* help - 打印注释信息

### 预览
* 四张图片分别是: src.jpg horizontal.jpg vertical.jpg circle.jpg
* wallpaperTiltshift.bat -m h "D:\src.jpg" "D:\horizontal.jpg"
* wallpaperTiltshift.bat -m v "D:\src.jpg" "D:\vertical.jpg"
* wallpaperTiltshift.bat -m c "D:\src.jpg" "D:\circle.jpg"


<div align=center><img src="https://github.com/bjc5233/do-wallpaper/raw/master/wallpaperTiltshift/resources/src.jpg"/></div>
<div align=center><img src="https://github.com/bjc5233/do-wallpaper/raw/master/wallpaperTiltshift/resources/horizontal.jpg"/></div>
<div align=center><img src="https://github.com/bjc5233/do-wallpaper/raw/master/wallpaperTiltshift/resources/vertical.jpg"/></div>
<div align=center><img src="https://github.com/bjc5233/do-wallpaper/raw/master/wallpaperTiltshift/resources/circle.jpg"/></div>


------------
## wallpaperLockScreen
### 说明
更换锁屏壁纸
* 调用方式A 无参数 - 将当前桌面壁纸设置为锁屏壁纸
* 调用方式B 带一个参数 - 将指定图片设置为锁屏壁纸
------------


## wallpaperDirs
### 说明
从指定文件夹中随机选择一张图片作壁纸
### 调用参数
* %1 - 处理步骤[0-setWallpaper 1-setLockWallpaper(默认值)]
### 注意
* imgDirs中指定的路径, 查询图片时只查询当前层级, 不会递归处理
------------