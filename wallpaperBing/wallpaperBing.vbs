'���շֱ�������˳������,���򽵵ͷֱ���
'�������Ҫ�����ֽ, ���޸�picFolderBase����Ϊָ���ļ���·��; �����ָ��, ��ֽ�ͻᱻ����ϵͳtemp�ļ���, ��ʱ�ж�ʧ��Σ��O
Dim picFolderBase
picFolderBase = "D:\pic\bingWallpaper"




'======================================================================
Dim dayOffset, bingDate, xmlFolderBase, resolutionArray, resolution, fileObject
resolutionArray = array("1920x1080", "1920x1200", "1366x768", "1280x768", "1280x720", "1024x768", "800x600")'Ŀǰ��֪���ڵ�ͼƬ�ֱ���
Set fileObject = CreateObject("Scripting.FileSystemObject")
xmlFolderBase = CreateObject("wscript.Shell").ExpandEnvironmentStrings("%temp%")
If picFolderBase="" Then picFolderBase = xmlFolderBase
dayOffset = getDayOffset()
bingDate = Replace(dateadd("d", -dayOffset, Date), "/", "-")


For each resolution in resolutionArray
    Dim bingXml, bingPic
    bingXml = xmlFolderBase& "\bingWallpaper"& bingDate& "_"& resolution& ".xml"  '��ŵ�ϵͳ��ʱĿ¼
    bingPic = picFolderBase& "\bingWallpaper"& bingDate& "_"& resolution& ".jpg"

    IF (Not fileObject.FileExists(bingPic)) Then
        call downloadFile(parseBingPicXmlUrl(dayOffset), bingXml) '������ͼƬ��Ϣxml��url, ����xml
        call downloadFile(parseBingPicUrl(bingXml), bingPic)      '��xml�н�����ͼƬurl��ַ, ����ͼƬ
    End If
    
    If (isPicFile(bingPic)) Then      '����Ƿ�����ЧͼƬ, ����ͼƬ��֧��ĳ�ֱַ���, ���ص���ʵ��html����ҳ��
        call setWallpaper(bingPic)    '��Ϊ�����ֽ
        Wscript.quit
    Else
        fileObject.deleteFile(bingPic)
    End IF
Next
MsgBox "������, �Ҳ���ָ���ֱ��ʱ�ֽ!"
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
    'dayOffset��ʾ��������, ������1��ʾ����
    '��ַ��Դ: ��bing��ҳcn.bing.com, �鿴homepageimgviewer.js, �鿴getImageData����, �����й���url�ķ���
End Function

Sub downloadFile(url, savePath)
    Dim obj1,obj2
    Set obj1 = CreateObject("Msxml2.ServerXMLHTTP") 'ԭ��ʹ�õĶ�����msxml2.xmlhttp����url��https��ᱨ��800C0005
    Set obj2 = CreateObject("adodb.stream")
	obj1.SetOption 2,13056 '����https����
    obj1.open "get",url,False
    obj1.send
    obj2.Type = 1
    obj2.Mode = 3
    obj2.Open()
    obj2.Write(obj1.responseBody)
    obj2.SaveToFile savePath,2  '2����˼�Ǹ����ļ�
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
      If item.Name = "����Ϊ���汳��(&B)" Then
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