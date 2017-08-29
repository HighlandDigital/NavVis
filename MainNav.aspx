<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MainNav.aspx.cs" Inherits="MainNav" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>第14届中国—东盟博览会先进技术展</title>
    <link href="bootstrap-3.3.5/dist/css/bootstrap.min.css" rel="stylesheet" />
    <script src="JS/jquery-3.2.1.min.js"></script>
    <script src="bootstrap-3.3.5/dist/js/bootstrap.min.js"></script>
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
    </style>
    <script type="text/javascript">
        $(".nav > li > a").click(function () {
            $('#collapse').addClass("collapsed");
            $('#collapse').attr("aria-expanded", false);
            $("#navbar").removeClass("in");
            $("#navbar").attr("aria-expanded", false);
        });
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

        function showSearchBar() {
            var iv = document.getElementById("iv");
            var isshown = getParameterString(iv.src, "ui.search.visible");
            if (isshown == null || isshown == "false") {
                var pstring = "//pointcloudimport.navvis.com/pci12/";
                iv.src = pstring + "#?ui.search.visible=true";
                event.preventDefault();
            }
            else {
                var pstring = "//pointcloudimport.navvis.com/pci12/";
                iv.src = pstring + "#?ui.search.visible=false";
                event.preventDefault();
            }
        }
        function showLogin() {
            var iv = document.getElementById("iv");
            var isshown = getParameterString(iv.src, "menu.login.visible");
            if (isshown == null || isshown == "false") {
                var pstring = "//pointcloudimport.navvis.com/pci12/";
                iv.src = pstring + "#?menu.login.visible=true";
                event.preventDefault();
            }
            else {
                var pstring = "//pointcloudimport.navvis.com/pci12/";
                iv.src = pstring + "#?menu.login.visible=false";
                event.preventDefault();
            }
        }
        function showLanguage() {
            var iv = document.getElementById("iv");
            var isshown = getParameterString(iv.src, "menu.settings.visible");
            if (isshown == null || isshown == "false") {
                var pstring = "//pointcloudimport.navvis.com/pci12/";
                iv.src = pstring + "#?menu.settings.visible=true";
                event.preventDefault();
            }
            else {
                var pstring = "//pointcloudimport.navvis.com/pci12/";
                iv.src = pstring + "#?menu.settings.visible=false";
                event.preventDefault();
            }
        }
        function showMask() {
            $('body').css("overflow", "hidden")
            $("#cover").show();
        }
        function hideMask() {
            $('body').css("overflow", "hidden")
            $("#cover").hide();
        }
        function showList() {
            $('body').css("overflow", "hidden")
            $("#companyCover").show();
        }
        function hideList() {
            $('body').css("overflow", "hidden")
            $("#companyCover").hide();
        }
        function showList_xjzz() {
            $('body').css("overflow", "hidden")
            $("#companyCover_xjzz").show();
        }
        function hideList_xjzz() {
            $('body').css("overflow", "hidden")
            $("#companyCover_xjzz").hide();
        }
        function loadPoint(param) {
            var pstring = "//pointcloudimport.navvis.com/pci12/";
            iv.src = pstring + "#?" + param;
            event.preventDefault();
            $(".cover").hide();
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
            </div>
            <div id="navbar" class="navbar-collapse collapse">
                <ul class="nav navbar-nav">
                    <li class="active"><a href="#">首页</a></li>
                    <li><a href="javascript:void(0);" onclick="showList()">明星企业</a></li>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">参展行业<span class="caret"></span></a>
                        <ul class="dropdown-menu">
                            <li><a href="javascript:void(0);" onclick="showList_xjzz()">先进制造</a></li>
                            <li><a href="#">大健康</a></li>
                            <li><a href="#">创新创业</a></li>
                            <li><a href="#">国际创新</a></li>
                            <li><a href="#">海洋科技</a></li>
                            <li><a href="#">新能源与可再生能源</a></li>
                            <li><a href="#">创新医疗技术</a></li>
                            <li><a href="#">节能环保</a></li>
                            <li><a href="#">电子信息</a></li>
                        </ul>
                    </li>
                    <!--<li class="dropdown">
              <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">菜单设置<span class="caret"></span></a>
              <ul class="dropdown-menu">
                <li class="dropdown-header">按钮</li>
                <li><a href="#" onclick="showLogin()">登录按钮</a></li>
                <li><a href="#" onclick="showLanguage()">设置按钮</a></li>
                <li role="separator" class="divider"></li>
                <li class="dropdown-header">操作</li>
                <li><a href="#" onclick="showSearchBar()">搜索栏</a></li>
                <li><a href="/page/photo.aspx">拍照</a></li>
              </ul>
            </li>-->
                    <li><a href="javascript:void(0);" onclick="showMask()">关于我们</a></li>

                </ul>
                <ul class="nav navbar-nav navbar-right">
                    <li></li>
                </ul>
                <!--<form class="navbar-form navbar-right">
            <div class="input-group">
                <input type="text" class="form-control" placeholder="请输入企业名称..."/>
                <span class="input-group-addon">搜索</span>
            </div>
              
          </form>-->
            </div>
            <!--/.nav-collapse -->
        </div>
    </nav>
    <div class="container" style="width: 100%; height: 100%; margin-top: 0px; margin-left: 0px; margin-right: 0px; padding-left: 0px; padding-right: 0px;">

        <iframe id="iv" src="//nstlab.cn:14610/iv.example/" onmousewheel=""></iframe>


    </div>
    <div id="cover" class="cover">
        <button type="button" class="btn btn-default pull-right tooltip-viewport-bottom" title="关闭" style="margin:10px;" onclick="hideMask()">X</button>
        <div class="container" style="margin-top: 70px;">

            <div class="col-xs-12 col-sm-12 placeholder" style="color:#ffffff;">
                <p>南宁海蓝数据公司是一家致力于室内空间数字化的高科技企业，利用国际领先的三维空间扫描技术和室内导航技术打造全新室内3D实景地图，为大型场所提供室内三维数据采集及室内定位、导航服务，为室内三维数据采集及数据应用提供解决方案。
</p>
            </div>
            
        </div>
    </div>
    <div id="companyCover" class="cover">
        <button type="button" class="btn btn-default pull-right tooltip-viewport-bottom" title="关闭" style="margin:10px;" onclick="hideList()">X</button>
        <div class="container" style="margin-top: 70px;margin-bottom:70px;">

            <div class="col-xs-12 col-sm-6 placeholder" style="margin-top:10px;">
              <a href="javascript:void(0);" onclick="loadPoint('image=140&vlon=1.82&vlat=-0.29&fov=100.0')"><img src="../image/img_1.jpg" class="img-responsive" alt="Generic placeholder thumbnail"/>
              
              </a>
            </div>
            <div class="col-xs-12 col-sm-6 placeholder" style="margin-top:10px;">
              <a href="javascript:void(0);" onclick="loadPoint('image=150&vlon=1.82&vlat=-0.29&fov=100.0')"><img src="../image/img_3.png" class="img-responsive" alt="Generic placeholder thumbnail"/>
              
              </a>
            </div>
            <div class="col-xs-12 col-sm-6 placeholder" style="margin-top:10px;">
              <a href="javascript:void(0);" onclick="loadPoint('image=75&vlon=1.82&vlat=-0.29&fov=100.0')"><img src="../image/img_5.png" class="img-responsive" alt="Generic placeholder thumbnail"/>
              
              </a>
            </div>
            <div class="col-xs-12 col-sm-6 placeholder" style="margin-top:10px;">
              <a href="javascript:void(0);" onclick="loadPoint('image=145&vlon=1.82&vlat=-0.29&fov=100.0')"><img src="../image/img_6.png" class="img-responsive" alt="Generic placeholder thumbnail"/>
              
              </a>
            </div>
            
        </div>
    </div>
    <div id="companyCover_xjzz" class="cover">
        <button type="button" class="btn btn-default pull-right tooltip-viewport-bottom" title="关闭" style="margin:10px;" onclick="hideList_xjzz()">X</button>
        <div class="container" style="margin-top: 70px;margin-bottom:70px;">

            <div class="col-xs-12 col-sm-6 placeholder" style="margin-top:10px;">
              <a href="javascript:void(0);" onclick="loadPoint('image=150&vlon=1.82&vlat=-0.29&fov=100.0')"><img src="../image/img_3.png" class="img-responsive" alt="Generic placeholder thumbnail"/>
              
              </a>
            </div>
            
        </div>
    </div>
</body>
</html>
