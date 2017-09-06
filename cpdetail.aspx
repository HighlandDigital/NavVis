<%@ Page Language="C#" AutoEventWireup="true" CodeFile="cpdetail.aspx.cs" ValidateRequest="false" Inherits="cpdetail" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
        <script type="text/javascript" src="jquery-easyui-1.4.5/jquery.min.js"></script>
        <script type="text/javascript" charset="utf-8" src="ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="ueditor.all.min.js"> </script>
    <!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
    <!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
    <script type="text/javascript" charset="utf-8" src="lang/zh-cn/zh-cn.js"></script>

        <link rel="stylesheet" type="text/css" href="jquery-easyui-1.4.5/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="jquery-easyui-1.4.5/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="jquery-easyui-1.4.5/demo/demo.css">
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <script type="text/javascript" src="jquery-easyui-1.4.5/jquery.min.js"></script>
    <script type="text/javascript" src="jquery-easyui-1.4.5/jquery.easyui.min.js"></script>
    <style type="text/css">
        .auto-style1 {
            width: 100px;
            height: 23px;
        }
        .auto-style2 {
            height: 23px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <div style="display:none;"><input id="id" value="0" style="width: 300px;" type="text" /><input id="projectid" value="0" style="width: 300px;" type="text" /></div>
        <table border="0" style="width: 100%">

            <tr style="border-style: none none ridge none; border-bottom-width: 1px; border-bottom-color: #FF0000; text-align: left;"  >
                <td class="auto-style1">热点类别</td>
                <td class="auto-style2"><input id="industry_id" style="width:300px" class="easyui-combobox"  /></td>
            </tr>
            <tr style="border-style: none none ridge none; border-bottom-width: 1px; border-bottom-color: #FF0000; text-align: left;"  >
                <td class="auto-style1">推荐</td>
                <td class="auto-style2"><input id="ishot"  value="1"  type="checkbox" /></td>
            </tr>
            <tr style="border-style: none none ridge none; border-bottom-width: 1px; border-bottom-color: #FF0000; text-align: left;"  >
                <td class="auto-style1">热点编号</td>
                <td class="auto-style2"><input id="iv_id" value="0" style="width: 300px;" type="text" readonly="readonly"  /></td>
            </tr>
            <tr style="border-style: none none solid none; border-bottom-width: thin; border-bottom-color: #000000; text-align: left;"  >
                <td style="width: 100px">标题</td>
                <td><input id="title" value="0" style="width: 300px;" type="text" /></td>
            </tr>
            <tr style="border-style: none none solid none; border-bottom-width: thin; border-bottom-color: #000000; text-align: left;"  >
                <td style="width: 100px">英文标题</td>
                <td><input id="title_en" value="0" style="width: 300px;" type="text" /></td>
            </tr>
            <tr style="border-style: none none solid none; border-bottom-width: thin; border-bottom-color: #000000; text-align: left;"  >
                <td style="width: 100px">图标</td>
                <td><img id="title_img" /></td>
            </tr>
            <tr style="border-style: none none solid none; border-bottom-width: thin; border-bottom-color: #000000; text-align: left;"  >
                <td style="width: 100px"></td>
                <td><input id="title_img_url"  style="width: 300px;" type="text" /></td>
            </tr>
            <tr style="border-style: none none solid none; border-bottom-width: thin; border-bottom-color: #000000; text-align: left;display:none"  >
                <td style="width: 100px">热点图标</td>
                <td><input id="iv_img_url"  style="width: 300px;" type="text" /></td>
            </tr>

            <tr style="border-style: none none solid none; border-bottom-width: thin; border-bottom-color: #000000; text-align: left;"  >
                <td style="width: 100px">锁定</td>
                <td><input id="locked" value="1"   type="checkbox" /></td>
            </tr>
            <tr style="border-style: none none solid none; border-bottom-width: thin; border-bottom-color: #000000; text-align: left;"  >
                <td style="width: 100px">中文资料</td>
                <td><textarea id="description" cols="60" rows="6"></textarea></td>
            </tr>
            <tr style="border-style: none none solid none; border-bottom-width: thin; border-bottom-color: #000000; text-align: left;"  >
                <td style="width: 100px">英文资料</td>
                <td><textarea id="description_en" cols="60" rows="6"></textarea></td>
            </tr>
            <tr style="border-style: none none solid none; border-bottom-width: thin; border-bottom-color: #000000; text-align: left;"  >
                <td style="width: 100px">中文html</td>
                <td><script id="description_mod" type="text/plain" style="width:900px;height:300px;"></script></td>
            </tr>
            <tr style="border-style: none none solid none; border-bottom-width: thin; border-bottom-color: #000000; text-align: left;"  >
                <td style="width: 100px">英文html</td>
                <td><script id="description_en_mod" type="text/plain" style="width:900px;height:300px;"></script></td>
            </tr>
            <tr style="border-style: none none solid none; border-bottom-width: thin; border-bottom-color: #000000; text-align: left;"  >
                <td style="width: 100px"></td>
                <td><input id="btok" type="button" value="提交" onclick="sumitpoint()" /><input id="btok" type="button" value="返回" /onclick="reback()"></td>
            </tr>
        </table>       

       
    </div>
    </form>

    <script type="text/javascript">

        //实例化编辑器
        //建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例

        var ue = UE.getEditor('description_mod');
        var ueen = UE.getEditor('description_en_mod');

        $(function () {


            $("#iv_id").val(guid());


            $.ajax({

                type: "post",
                url: 'Handler/PointHandler.ashx?ac=industry',
                cache: false,
                async: false,
                dataType: 'json',
                success: function (json) {
                    $("#industry_id").combobox({
                        valueField: 'id',
                        textField: 'name',
                        panelHeight: json.length >= 7 ? "280px" : "auto"
                    }).combobox("loadData", json);
                },
                error: function () {
                    alert("加载类型：" + ty + "错误！");
                }

            });


            var id = GetQueryString("id");
         //   alert(id);
            if (id!=null)
            {

                //加载热点信息
                $.ajax({
                    type: 'POST',
                    url: 'Handler/PointHandler.ashx',
                    data: {
                        'ac': 'load',
                        'id': id
                    },
                    dataType: 'json',
                    success: function (result) {
                        data = eval(result);
                    
                        //加载查询信息
                        $.ajax({
                            type: 'POST',
                            url: 'Handler/ProjectHandler.ashx',
                            data: {
                                'ac': 'load',
                                'ivid':data.iv_id
                            },
                            dataType: 'json',
                            success: function (result) {
                                datap = eval(result);

                                $("#projectid").val(datap.id);
                             //   $("#ishot").val(data.ishot);
                                $('#industry_id').combobox('setValue', datap.industry_id);
                                if (datap.ishot == true)
                                    $("#ishot").attr("checked", 'checked');
                            },
                            error: function (ex) {
                                alert(eval(ex).responseText);
                            }
                        });


                        $("#id").val(data.id);
                        $("#iv_id").val(data.iv_id);
                        $("#title").val(data.title);
                        $("#title_en").val(data.title_en);
                        $("#title_img_url").val(data.title_img_url);                      
                        $("#title_img").attr("src", data.title_img_url);
                        
                        if (data.locked==true)
                            $("#locked").attr("checked", 'checked');
                        
                        $("#description").val(data.description);
                        $("#description_en").val(data.description_en);
                        // alert(data.description_mod);
                        try
                        {
                            UE.getEditor('description_mod').setContent(data.description_mod);
                        }
                        catch(e)
                        {}

                        try
                        {
                            UE.getEditor('description_en_mod').setContent(data.description_en_mod);
                        }
                        catch(e)
                        {}
                       
                    },
                    error: function (ex) {
                        alert(eval(ex).responseText);                     
                    }
                });
            }
        });

        function guid() {
            return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function (c) {
                var r = Math.random() * 16 | 0, v = c == 'x' ? r : (r & 0x3 | 0x8);
                return v.toString(16);
            });
        }

        function reback()
        {
            window.location.href = "cplist.aspx";
        }

        function sumitpoint()
        {
            var id = $("#id").val();
            var iv_id = $("#iv_id").val();
            var title = $("#title").val();
            var title_en = $("#title_en").val();
            var title_img_url = $("#title_img_url").val();
            var locked = $("#locked").val();

            var description = $("#description").val();
            var description_en = $("#description_en").val();
            var description_mod = UE.getEditor('description_mod').getContent();
            var description_en_mod = UE.getEditor('description_en_mod').getContent();
            var iv_img_url = $("#iv_img_url").val();


            $.post("Handler/PointHandler.ashx",
            { "ac": "sumit", "id": id, "iv_id": iv_id, "title": title, "title_en": title_en, "title_img_url": title_img_url, "locked": locked, "description": description, "description_en": description_en, "description_mod": description_mod, "description_en_mod": description_en_mod ,"iv_img_url":iv_img_url},
              function (data) {
                  //提示操作结果
                 // alert(data.msg);
              },
              "json"
              );

            var projectid = $("#projectid").val();
            var ishot = $("#ishot").val();
            var industry_id = $("#industry_id").combobox("getValue");
          //  $("#industry_id").val();
            alert(industry_id)
            $.post("Handler/ProjectHandler.ashx",
            { "ac": "sumit", "id": projectid, "iv_id": iv_id, "title": title, "title_en": title_en, "ishot": ishot, "industry_id": industry_id, "description": description },
              function (data) {
                  //提示操作结果
                  alert(data.msg);
              },
              "json"
              );

        }


        function GetQueryString(name) {
            var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
            var r = window.location.search.substr(1).match(reg);
            if (r != null) return unescape(r[2]); return null;
        }
</script>

</body>
</html>
