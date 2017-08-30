<%@ Page Language="C#" AutoEventWireup="true" CodeFile="nav.aspx.cs" Inherits="nav" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>第14届中国—东盟博览会先进技术展</title>
    <link rel="stylesheet" type="text/css" href="style/fonts/iconfont.css">
	<link rel="stylesheet" type="text/css" href="style/css/ishare.css">
    <%--<link href="../bootstrap-3.3.5/dist/css/bootstrap.min.css" rel="stylesheet" />--%>
    <script src="../JS/jquery-3.2.1.min.js"></script>
    <%--<script src="../bootstrap-3.3.5/dist/js/bootstrap.min.js"></script>--%>
   <script type="text/javascript" src="../JS/iShare.js"></script>
    <script src="../JS/qrcode.min.js"></script>
    <script src="//nstlab.cn:14610/iv.example/IndoorViewerAPI.js"></script>

    <style type="text/css">
        

        #iv {
            width: 100%;
            height: 100%;
            display: block;
            border: none;
        }

        html, body {
            height: 100%;
        }

        .cover {
            position: fixed;
            top: 0px;
            right: 0px;
            bottom: 0px;
            filter: alpha(opacity=60);
            background-color: rgba(128, 128, 128, 0.5);
            z-index: 1002;
            left: 0px;
            display: none;
            overflow: scroll;
        }

        .ext-search-box .dropdown-menu {
            z-index: 1001; /* Fix overlap with navbar elements */
        }

        #return-to-map-mobile {
            display: none;
        }
    </style>
    <script type="text/javascript">
        var indoorviewer;
        var xshare;

        $(".nav > li > a").click(function () {
            $('#collapse').addClass("collapsed");
            $('#collapse').attr("aria-expanded", false);
            $("#navbar").removeClass("in");
            $("#navbar").attr("aria-expanded", false);
        });

        IV.loaded(function () {
            // Replace the base URL with the address of your IndoorViewer instance, and remember to get the API from the same instance
            var indoorviewer = new IndoorViewer({
                base_url: '//nstlab.cn:14610/iv.example',
                'menu.datasets.visible': false,
                'menu.poi.visible': false,
                'menu.pointcloud.visible': false,
                'menu.mode.visible': false,
                'menu.view.visible': false,
                'menu.share.visible': false,
                'menu.adout.visible': false,
                'menu.languages.visible': false,
                'menu.settings.visible': false,
                'ui.floorchanger.visible': false,
                'ui.poi_panel.visible': false,
                'ui.search.visible':false,
                onLoadComplete: function () {
                    indoorviewer.addEventListener("poiSelected", function (data) { clickEventListener(data); });
                    
                }
            });

        });

        function clickEventListener(data) {
            $("#POI_title").html(data.title);
            $("#POI_body").html(data.description);
            showCoverPOI();
            
            iShare_config.config.url = "/page/nav.aspx?poi="+data.id;
            
        }

        function getParameterString(url, name) {
            if (url.indexOf("?") != -1) {
                var str = url.substr(url.indexOf("?") + 1);
                var paraArray = str.split("&");
                for (var i = 0; i < paraArray.length; i++) {
                    if (paraArray[i].indexOf(name) != -1)
                        return paraArray[i].split("=")[1];
                }
                return null;
            }
            return null;
        }

        function getRootPath() {
            var strFullPath = window.document.location.href;
            var strPath = window.document.location.pathname;
            var pos = strFullPath.indexOf(strPath);
            var prePath = strFullPath.substring(0, pos);
            //var postPath = strPath.substring(0, strPath.substr(1).indexOf('/') + 1);
            return (prePath + "/");
        }

        function showCoverAbout() {
            $('body').css("overflow", "hidden")
            $(".cover").hide();
            $("#cover_about").show();
        }

        function showCoverHot() {
            $('body').css("overflow", "hidden")
            $(".cover").hide();
            $("#cover_hot").show();
            searchProjectHot();
        }

        function showCoverSort() {
            $('body').css("overflow", "hidden")
            $(".cover").hide();
            $("#cover_sort").show();
            searchIndustry();
        }

        function showCoverProj(sort) {
            $('body').css("overflow", "hidden")
            $(".cover").hide();
            $("#industry_id").val(sort);
            $("#cover_project").show();
            searchProject();
        }
        
        function showCoverPOI() {
            $('body').css("overflow", "hidden")
            $(".cover").hide();
            $("#cover_poi").show();

        }

        function hideCover() {
            $('body').css("overflow", "hidden")
            $(".cover").hide();
            setTimeout(function () {
                ////if ($("#wxbox") != null) {
                //$("div[id^='wxbox']").each(function () {
                //    $(this).css("display", "none");
                //})
                xshare.wx.hide();
                
                    
                //}
            }, 100);
            
        }

        function loadPoint(param) {
            IV.moveToPOIID(param);
            $(".cover").hide();
        }

        //--------------//
        function showCoverShare() {
            $('body').css("overflow", "hidden")
            $(".cover").hide();
            $("#cover_share").show();

            xshare=(new iShare({
                container: '.iShare', config: {
                    title: '分享212',
                    description: '',
                    url: window.location.href,
                    //isAbroad: false, //国内分享
                   // isTitle: true,
                    initialized: true, //自动生成分享按钮
                    WXoptions: {
                        evenType: 'click',
                        isTitleVisibility: true,
                        title: '',
                        isTipVisibility: true,
                        tip: '打开微信，扫描二维码，分享给我的朋友圈',
                        qrcodeW: 180,
                        qrcodeH: 180,
                        qrcodeBgc: '#fff',
                        qrcodeFgc: '#000',
                        bgcolor: '#EEEbEc'
                    }
                }
            }));

        function searchProjectHot() {
            $.ajax({
                type: 'POST',
                url: "../handler/searchHandler.ashx",
                data: {
                    method: "searchProjectHot"
                },
                success: function (data) {
                    var d = "";
                    for (var i = 0; i < data.length; i++) {
                        var content = "<div class=\"col-xs-12 col-sm-6 placeholder\" style=\"margin-top: 10px;\">" +
                            "<a href=\"javascript:void(0);\" onclick=\"moveToPoint('" + data[i].poi + "')\">" +
                            "<img style=\"width:100%;\" src=\"" + getRootPath() + data[i].img_url + "\" class=\"img-responsive\" alt=\"" + data[i].poi + "\" />" +
                            "</a></div>";
                        d = d + content;
                    }
                    $("#projectHot_list").html(d);
                },
                dataType: "json"
            });
        }

        function searchProject() {
            $.ajax({
                type: 'POST',
                url: "../handler/searchHandler.ashx",
                data: {
                    method: "searchProject",
                    industry_id: $("#industry_id").val(),
                    param: $("#input_param").val()
                },
                success: function (data) {
                    var d = "";
                    for (var i = 0; i < data.length; i++) {
                        var content = "<div class=\"col-xs-12 col-sm-12 placeholder\" style=\"margin-top: 10px;\">" +
                            "<a href=\"javascript:void(0);\" onclick=\"moveToPoint('" + data[i].poi + "')\">" +
                            "<img style=\"width:100%;\" src=\"" + getRootPath() + data[i].img_url + "\" class=\"img-responsive\" alt=\"" + data[i].poi + "\" />" +
                            "</a></div>";
                        d = d + content;
                    }
                    $("#project_list").html(d);
                },
                dataType: "json"
            });
        }

        function searchIndustry() {
            $.ajax({
                type: 'POST',
                url: "../handler/searchHandler.ashx",
                data: {
                    method: "searchIndustry"
                },
                success: function (data) {
                    var d = "";
                    for (var i = 0; i < data.length; i++) {
                        var content = "<div class=\"col-xs-6 col-sm-6 placeholder\" style=\"margin-top: 10px;\">" +
                            "<a href=\"javascript:void(0);\" onclick=\"showCoverProj('" + data[i].id + "')\">" +
                            "<img style=\"width:100%;\" src=\"" + getRootPath() + data[i].img_url + "\" class=\"img-responsive\" alt=\"" + data[i].name + "\" />" +
                            "</a></div>";
                        d = d + content;
                    }
                    $("#industry_list").html(d);
                },
                dataType: "json"
            });
        }

    </script>

   
    

</head>
<body>

    <nav class="navbar navbar-default navbar-fixed-bottom">
        <div class="container">
            <div class="navbar-header">
                <button id="navbtn" type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="#">虚拟导览</a>
                <a class="navbar-brand" href="javascript:void(0);" onclick="showCoverShare();" >分享</a>
            </div>
            <div id="navbar" class="navbar-collapse collapse">
                <ul class="nav navbar-nav">
                    <li><a href="javascript:void(0);" onclick="showCoverHot()">明星展台</a></li>
                    <li><a href="javascript:void(0);" onclick="showCoverSort()">参展行业</a></li>
                    <li><a href="javascript:void(0);" onclick="showCoverAbout()">关于我们</a></li>
                </ul>
                <ul class="nav navbar-nav navbar-right">
                    <li></li>
                </ul>
            </div>
            <!--/.nav-collapse -->
        </div>
    </nav>
    <div class="container" style="width: 100%; height: 100%; margin-top: 0px; margin-left: 0px; margin-right: 0px; padding-left: 0px; padding-right: 0px; padding-bottom: 50px;">

        <div ng-include src="'iv.html'" style="width: 100%; height: 100%;"></div>

    </div>
    <div id="cover_about" class="cover">
        <%--<div class="container" style="margin-top: 10px; margin-bottom: 10px;">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 id="" class="panel-title">关于我们</h3>
                    <button type="button" class="btn btn-default pull-right" title="关闭" style="border:none;background-color:transparent;" onclick="hideCover()">X</button>
                </div>
                <div id="" class="panel-body">
                    
                        <div class="col-xs-12 col-sm-12 placeholder">
                            <p>
                                南宁海蓝数据公司是一家致力于室内空间数字化的高科技企业，利用国际领先的三维空间扫描技术和室内导航技术打造全新室内3D实景地图，为大型场所提供室内三维数据采集及室内定位、导航服务，为室内三维数据采集及数据应用提供解决方案。
                            </p>
                        </div>

                </div>
            </div>
        </div>--%>
        <button type="button" class="btn btn-default pull-right tooltip-viewport-bottom" title="关闭" style="border:none;background-color:transparent;margin: 10px;" onclick="hideCover()">X</button>
        <div class="container" style="margin-top: 70px;">

            <div class="col-xs-12 col-sm-12 placeholder" style="color: #ffffff;">
                <p>
                    南宁海蓝数据公司是一家致力于室内空间数字化的高科技企业，利用国际领先的三维空间扫描技术和室内导航技术打造全新室内3D实景地图，为大型场所提供室内三维数据采集及室内定位、导航服务，为室内三维数据采集及数据应用提供解决方案。
                </p>
            </div>

        </div>
    </div>
    <div id="cover_hot" class="cover" runat="server">
        <%--<div class="container" style="margin-top: 10px; margin-bottom: 10px;">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 id="" class="panel-title">明星展台</h3>
                    <button type="button" class="btn btn-default pull-right" title="关闭" style="border:none;background-color:transparent;" onclick="hideCover()">X</button>
                </div>
                <div id="projectHot_list" class="panel-body">
                    明星展台
                </div>
            </div>
        </div>--%>
        <button type="button" class="btn btn-default pull-right tooltip-viewport-bottom" title="关闭" style="border:none;background-color:transparent;margin: 10px;" onclick="hideCover()">X</button>
        <div id="projectHot_list" class="container" style="margin-top: 50px; margin-bottom: 50px;">
           
        </div>
    </div>
    <div id="cover_sort" class="cover">
        <%--<div class="container" style="margin-top: 10px; margin-bottom: 10px;">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 id="" class="panel-title">参展行业</h3>
                    <button type="button" class="btn btn-default pull-right" title="关闭" style="border:none;background-color:transparent;" onclick="hideCover()">X</button>
                </div>
                <div id="industry_list" class="panel-body">

                </div>
            </div>
        </div>--%>
        <button type="button" class="btn btn-default pull-right tooltip-viewport-bottom" title="关闭" style="border:none;background-color:transparent;margin: 10px;" onclick="hideCover()">X</button>
        <div id="industry_list" class="container" style="margin-top: 50px; margin-bottom: 50px;">
            
        </div>
    </div>
    <div id="cover_project" class="cover" runat="server">
        <div class="container" style="margin-top: 10px; margin-bottom: 10px;">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <div class="input-group">
                        <input id="industry_id" type="text" style="display:none;" value=""/>
                        <input id="input_param" type="text" class="form-control border-radius" placeholder="搜索" oninput="searchProject()"/>
                        <span class="input-group-addon">
                            <span class="fa fa-search"></span>
                        </span>
                        <button type="button" class="btn btn-default pull-right" title="关闭" style="border:none;background-color:transparent;" onclick="hideCover()">X</button>
                    </div>
                    
                </div>
                <div id="project_list" class="panel-body">
                    项目列表
                </div>
            </div>
        </div>
        <script type="text/javascript">
            function moveToPoint(param) {
                IV.moveToPOIID(param);
            }
        </script>
        <%--<button type="button" class="btn btn-default pull-right tooltip-viewport-bottom" title="关闭" style="margin: 10px;" onclick="hideCover()">X</button>
        <div class="container" style="margin-top: 50px; margin-bottom: 50px;">
            <asp:Repeater ID="proj_Repeater" runat="server">
                <ItemTemplate>
                    <div class="col-xs-12 col-sm-6 placeholder" style="margin-top: 10px;">
                        <a href="javascript:void(0);" onclick="loadPoint('<%# Eval("poi")%>')">
                            <img src="<%# Eval("img_url")%>" class="img-responsive" alt="<%# Eval("name")%>" />

                        </a>
                    </div>
                </ItemTemplate>
            </asp:Repeater>

        </div>--%>
    </div>
    <div id="cover_poi" class="cover" runat="server">
        <div class="container" style="margin-top: 10px; margin-bottom: 30px;">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 id="POI_title" class="panel-title">兴趣点标题</h3>
                    <button type="button" class="btn btn-default pull-right" title="关闭" style="border:none;background-color:transparent;" onclick="hideCover()">X</button>
                </div>
                <div id="POI_body" class="panel-body">
                    兴趣点内容
                </div>
            </div>
        </div>
    </div>

    <div id="cover_share" class="cover">
        <button type="button" class="btn btn-default pull-right tooltip-viewport-bottom" title="关闭" style="margin:10px;" onclick="hideCover()">X</button>
        <div class="container" style="margin-top: 70px;">

          
            <div class="iShare " >
	            <div style="background:#f00">
                    <a href="#" class="iShare_qzone"><i class="iconfont qzone">&#xe610;</i></a>
	                <a href="#" class="iShare_tencent"><i class="iconfont tencent" style="vertical-align: -2px;">&#xe608;</i></a>
                </div>
                <div style="background:#ff0">
	                <a href="#" class="iShare_weibo"><i class="iconfont weibo">&#xe609;</i></a>
	                <a href="#" class="iShare_douban"><i class="iconfont douban" style=" vertical-align: -2px;">&#xe612;</i></a>
                </div>
                <div>
	                <a href="#" class="iShare_renren"><i class="iconfont renren">&#xe603;</i></a>
	                <a href="#" class="iShare_youdaonote"><i class="iconfont youdaonote" style="vertical-align: -2px;">&#xe604;</i></a>
	                <a href="#" class="iShare_facebook"><i class="iconfont facebook" style="vertical-align: 1px;">&#xe601;</i></a>
	                <a href="#" class="iShare_twitter"><i class="iconfont twitter" style="vertical-align: 1px;">&#xe60a;</i></a>
	                <a href="#" class="iShare_googleplus"><i class="iconfont googleplus" style="vertical-align: -1px;">&#xe60b;</i></a>
	                <a href="#" class="iShare_linkedin"><i class="iconfont linkedin" style="vertical-align: 2px;">&#xe607;</i></a>
	                <a href="#" class="iShare_pinterest"><i class="iconfont pinterest" style="vertical-align: 0px;">&#xe60c;</i></a>
	                <a href="#" class="iShare_wechat"><i class="iconfont wechat" style="vertical-align: -2px;">&#xe613;</i></a>
	                <a href="#" class="iShare_tumblr"><i class="iconfont tumblr" style="vertical-align: 2px;">&#xe600;</i></a>
                </div>
            </div>   

            
            
        </div>
    </div>


     

</body>
</html>
