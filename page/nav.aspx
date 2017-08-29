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

        .ext-search-box .dropdown-menu
        {
            z-index: 1001;             /* Fix overlap with navbar elements */
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
            indoorviewer = new IndoorViewer({
                base_url: '//nstlab.cn:14610/iv.example',
                onLoadComplete: function () {
                    indoorviewer.addEventListener("poiSelected", function (data) { clickEventListener(data); });
                }
            });
            
        });
        
        function clickEventListener(data) {
            
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

        function showCoverAbout() {
            $('body').css("overflow", "hidden")
            $(".cover").hide();
            $("#cover_about").show();
        }

        function showCoverCom() {
            $('body').css("overflow", "hidden")
            $(".cover").hide();
            $("#cover_com").show();
            
        }

        function showCoverSort() {
            $('body').css("overflow", "hidden")
            $(".cover").hide();
            $("#cover_sort").show();

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
            var pstring = "//nstlab.cn:14910/iv.example/";
            iv.src = pstring + "#?" + param;
            event.preventDefault();
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

        }

        

    </script>

   
    

</head>
<body>
    
    <div class="ext-search-box" ng-controller="POIController">
            <!-- Typeahead template for search box -->
            <script type="text/ng-template" id="template/typeahead/poi-external.html">
                <a tabindex="-1">
                    <img ng-src="{{match.model.icon}}" class="poiIcon">
                    <div class="poi-info-wrapper">
                        <div class="poi-info">
                            <!--Name-->
                            <div ng-bind-html="match.model.title | typeaheadHighlight:query"
                                 class="poi-search-name"></div>
                        </div>
                    </div>
                </a>
            </script>

            <div class="form">
                <div class="input-group">
                    <input type="text" class="form-control border-radius"
                           ng-model="selected.poi"
                           typeahead="poi as poi.title for poi in search($viewValue)"
                           typeahead-template-url="template/typeahead/poi-external.html"
                           typeahead-editable="false"
                           placeholder=""
                           typeahead-on-select="selectPOI($item)">
                    <span class="input-group-addon">
                        <span class="fa fa-search"></span>
                    </span>
                </div>
            </div>
        </div>
    
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
                    <li><a href="javascript:void(0);" onclick="showCoverCom()">明星企业</a></li>
                    <li><a href="javascript:void(0);" onclick="showCoverSort()">参展行业</a></li>
                    <li><a href="javascript:void(0);" onclick="showCoverAbout()">关于我们</a></li>
                    
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
                    

                </ul>
                <ul class="nav navbar-nav navbar-right">
                    <li>
                        

                    </li>
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
    <div class="container" style="width: 100%; height: 100%; margin-top: 0px; margin-left: 0px; margin-right: 0px; padding-left: 0px; padding-right: 0px; padding-bottom:85px;">

        <div ng-include src="'iv.html'" style="width: 100%; height: 100%;"></div>

    </div>
    <div id="cover_about" class="cover">
        <button type="button" class="btn btn-default pull-right tooltip-viewport-bottom" title="关闭" style="margin:10px;" onclick="hideCover()">X</button>
        <div class="container" style="margin-top: 70px;">

            <div class="col-xs-12 col-sm-12 placeholder" style="color:#ffffff;">
                <p>南宁海蓝数据公司是一家致力于室内空间数字化的高科技企业，利用国际领先的三维空间扫描技术和室内导航技术打造全新室内3D实景地图，为大型场所提供室内三维数据采集及室内定位、导航服务，为室内三维数据采集及数据应用提供解决方案。
</p>
            </div>
            
        </div>
    </div>
    <div id="cover_com" class="cover">
        <button type="button" class="btn btn-default pull-right tooltip-viewport-bottom" title="关闭" style="margin:10px;" onclick="hideCover()">X</button>
        <div class="container" style="margin-top: 70px;margin-bottom:70px;">

            <div class="col-xs-12 col-sm-6 placeholder" style="margin-top:10px;">
              <a href="javascript:void(0);" onclick=""><img src="http://nstlab.cn:14910/image/img_1.jpg" class="img-responsive" alt="Generic placeholder thumbnail"/>
              
              </a>
            </div>
            <div class="col-xs-12 col-sm-6 placeholder" style="margin-top:10px;">
              <a href="javascript:void(0);" onclick=""><img src="http://nstlab.cn:14910/image/img_3.png" class="img-responsive" alt="Generic placeholder thumbnail"/>
              
              </a>
            </div>
            <div class="col-xs-12 col-sm-6 placeholder" style="margin-top:10px;">
              <a href="javascript:void(0);" onclick=""><img src="http://nstlab.cn:14910/image/img_5.png" class="img-responsive" alt="Generic placeholder thumbnail"/>
              
              </a>
            </div>
            <div class="col-xs-12 col-sm-6 placeholder" style="margin-top:10px;">
              <a href="javascript:void(0);" onclick=""><img src="http://nstlab.cn:14910/image/img_6.png" class="img-responsive" alt="Generic placeholder thumbnail"/>
              
              </a>
            </div>
            
        </div>
    </div>
    <div id="cover_sort" class="cover">
        <button type="button" class="btn btn-default pull-right tooltip-viewport-bottom" title="关闭" style="margin:10px;" onclick="hideCover()">X</button>
        <div class="container" style="margin-top: 70px;margin-bottom:70px;">

            <div class="col-xs-12 col-sm-6 placeholder" style="margin-top:10px;">
              <a href="javascript:void(0);" onclick=""><img src="http://nstlab.cn:14910/image/img_1.jpg" class="img-responsive" alt="大健康"/>
              
              </a>
            </div>
            <div class="col-xs-12 col-sm-6 placeholder" style="margin-top:10px;">
              <a href="javascript:void(0);" onclick=""><img src="http://nstlab.cn:14910/image/img_3.png" class="img-responsive" alt="创新创业"/>
              
              </a>
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
