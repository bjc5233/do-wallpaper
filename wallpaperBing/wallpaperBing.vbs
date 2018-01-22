'按照分辨率数组顺序下载,无则降低分辨率
'如果你想要保存壁纸, 请修改picFolderBase变量为指定文件夹路径; 如果不指定, 壁纸就会被丢到系统temp文件夹, 随时有丢失的危险O
Dim picFolderBase
picFolderBase = "D:\pic\bingWallpaper"




'======================================================================
Dim dayOffset, bingDate, xmlFolderBase, resolutionArray, resolution, fileObject
resolutionArray = array("1920x1080", "1920x1200", "1366x768", "1280x768", "1280x720", "1024x768", "800x600")'目前已知存在的图片分辨率
Set fileObject = CreateObject("Scripting.FileSystemObject")
xmlFolderBase = CreateObject("wscript.Shell").ExpandEnvironmentStrings("%temp%")
If picFolderBase="" Then picFolderBase = xmlFolderBase
dayOffset = getDayOffset()
bingDate = Replace(dateadd("d", -dayOffset, Date), "/", "-")


For each resolution in resolutionArray
    Dim bingXml, bingPic
    bingXml = xmlFolderBase& "\bingWallpaper"& bingDate& "_"& resolution& ".xml"  '存放到系统临时目录
    bingPic = picFolderBase& "\bingWallpaper"& bingDate& "_"& resolution& ".jpg"

    IF (Not fileObject.FileExists(bingPic)) Then
        call downloadFile(parseBingPicXmlUrl(dayOffset), bingXml) '解析出图片信息xml的url, 下载xml
        call downloadFile(parseBingPicUrl(bingXml), bingPic)      '从xml中解析出图片url地址, 下载图片
    End If
    
    If (isPicFile(bingPic)) Then      '检查是否是有效图片, 个别图片不支持某种分辨率, 下载的其实是html报错页面
        call setWallpaper(bingPic)    '设为桌面壁纸
        Wscript.quit
    Else
        fileObject.deleteFile(bingPic)
    End IF
Next
MsgBox "呜呜呜, 找不到指定分辨率壁纸!"
Wscript.quit




'======================================================================
Function getDayOffset()
    If WScript.Arguments.Count = 0 Then
        getDayOffset = 0
    Else 
        getDayOffset = Wscript.Arguments(0)
    End If
End Function

Function parseBingPicXmlUrl(dayOffset)
    parseBingPicXmlUrl = "http://www.bing.com/HPImageArchive.aspx?format=xml&idx=" & dayOffset & "&n=8&pid=hp"
    'dayOffset表示距今多少天, 如输入1表示昨天
    '地址来源: 打开bing主页cn.bing.com, 查看homepageimgviewer.js, 查看getImageData函数, 里面有构造url的方法
End Function

Sub downloadFile(url, savePath)
    Dim obj1,obj2
    Set obj1 = CreateObject("Msxml2.ServerXMLHTTP") '原来使用的对象是msxml2.xmlhttp，但url变https后会报错800C0005
    Set obj2 = CreateObject("adodb.stream")
	obj1.SetOption 2,13056 '忽略https错误
    obj1.open "get",url,False
    obj1.send
    obj2.Type = 1
    obj2.Mode = 3
    obj2.Open()
    obj2.Write(obj1.responseBody)
    obj2.SaveToFile savePath,2  '2的意思是覆盖文件
    obj2.Close
    Set obj1 = Nothing
End Sub

Function parseBingPicUrl(bingXml)
	MsgBox bingXml
    Dim xmlDoc
    Set xmlDoc = CreateObject("Microsoft.XMLDOM")
    xmlDoc.async = False
    xmlDoc.load(bingXml)
    parseBingPicUrl = "http://cn.bing.com" & xmlDoc.getElementsByTagName("urlBase")(0).childNodes(0).nodeValue & "_"& resolution & ".jpg"
End Function

Function isPicFile(bingPic)
    Dim obj
    Set obj = CreateObject("ADODB.Stream")
    obj.Type = 1
    obj.Mode = 3
    obj.Open()
    obj.LoadFromFile bingPic
    If AscB(obj.Read(1)) = &HFF And AscB(obj.Read(1)) = &HD8 Then
        isPicFile = True
    Else
        isPicFile = False
    End If
End Function

Sub setWallpaper(bingPic)
    Dim shApp, picFile, items
    Set shApp = CreateObject("Shell.Application")
    Set picFile = fileObject.GetFile(bingPic)
    Set items = shApp.NameSpace(picFile.ParentFolder.Path).ParseName(picFile.Name).Verbs
    For Each item In items
      If item.Name = "设置为桌面背景(&B)" Then
        item.DoIt
        Exit For
      End If
    Next
	
	Dim currentpath, wallpaperLockScreenBat
	currentpath = createobject("Scripting.FileSystemObject").GetFolder(".").Path
    wallpaperLockScreenBat = currentpath + "\wallpaperLockScreen.bat"
	IF (fileObject.FileExists(wallpaperLockScreenBat)) Then
		set ws = createobject("wscript.shell") 
		ws.run wallpaperLockScreenBat, 0
	End If
End Sub