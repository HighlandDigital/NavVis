<%@ Page Language="C#" AutoEventWireup="true" CodeFile="nav.aspx.cs" Inherits="nav" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>第14届中国—东盟博览会虚拟导览</title>
    <link rel="stylesheet" type="text/css" href="../style/fonts/iconfont.css" />
    <link rel="stylesheet" type="text/css" href="../style/css/ishare.css" />

    <link rel="stylesheet" type="text/css" href="../style/css/nav.css" />
    
    <script src="../JS/jquery-3.2.1.min.js"></script>
    <script src="../JS/DataSearch.js"></script>
    <script type="text/javascript" src="../JS/iShare.js"></script>
    <script src="qrcode.min.js"></script>

    <script src="http://nstlab.cn:14610/iv.example/IndoorViewerAPI.js"></script>
    
    <script type="text/javascript">
        var language = "CH";
        var xshare;

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
                'ui.search.visible': false,
                'layers.map.visible': false,
                onLoadComplete: function () {
                    indoorviewer.addEventListener("poiSelected", function (data) { clickEventListener(data); });
                    indoorviewer.setLanguage("zh");
                    loadcss("../style/theme/bootstrap.min.darkly.css");
                }
            });

        });

        function clickEventListener(data) {
            if (!data.id) return;
            searchPointByIVID(data.customData);

        }

        function hideCover() {
            $('body').css("overflow", "hidden")
            $(".cover").hide();
            setTimeout(function () {

                xshare.wx.hide();

            }, 100);

        }

        function moveToPoint(poi_id) {
            IV.moveToPOIID(poi_id);
        }
        function loadPoint(poi_id) {
            IV.moveToPOIID(poi_id);
            $(".cover").hide();
        }

        //--------------//
        function showCoverShare() {
            $('body').css("overflow", "hidden")
            $(".cover").hide();
            $("#cover_share").show();

            xshare = (new iShare({
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

        function toEn() {
            window.location = "nav_en.aspx";
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
                <a class="navbar-brand" href="#">全科盟展区</a>
                <a class="navbar-brand" href="javascript:void(0);" onclick="showCoverProj(0)"><span class="fa fa-search"></span></a>
                <a class="navbar-brand" href="javascript:void(0);" onclick="showCoverShare()"><span class="glyphicon glyphicon-share"></span></a>
            </div>
            <div id="navbar" class="navbar-collapse collapse">
                <ul class="nav navbar-nav">
                </ul>
                <ul class="nav navbar-nav navbar-right">
                    <li><a href="javascript:void(0);" onclick="showCoverHot()">明星展台</a></li>
                    <li><a href="javascript:void(0);" onclick="showCoverSort()">参展行业</a></li>
                    <li><a href="javascript:void(0);" onclick="showCoverAbout()">关于我们</a></li>
                    <li><a href="javascript:void(0);" onclick="toEn()">English</a></li>

                </ul>
            </div>
            <!--/.nav-collapse -->
        </div>
    </nav>
    <div class="container" style="width: 100%; height: 100%; margin-top: 0px; margin-left: 0px; margin-right: 0px; padding-left: 0px; padding-right: 0px; padding-bottom: 50px;">

        <div ng-include src="'iv.html'" style="width: 100%; height: 100%;"></div>

    </div>
    <div id="cover_about" class="cover">
        <div class="row">
            <a class="pull-right tooltip-viewport-bottom" style="margin-top: 10px;margin-right:20px;" href="javascript:void(0);" onclick="hideCover()"><span class="fa fa-remove" style="font-size:40px;"></span></a>
        </div>
        <div class="container" style="margin-top: 10px;margin-bottom:50px;">

            <div class="col-xs-12 col-sm-12 placeholder" style="color: #ffffff;text-indent:2em;">
                
                    <p>南宁海蓝数据有限公司是广西科学院下属院所创办的国有控股企业，是广西科技厅认证的自治区级数字化工程技术研究中心。在保持大规模图文影像资料的数字化采集处理优势的同时，加强互联网与物联网传感器数据采集，扩展室内空间三维数字化技术研究与服务业务。</p>
                    <p>目前我司在广西科技厅的支持下正在与德国NavVis开展国际合作，共建联合实验室，开展商场精准营销、会展导览、工业设计、室内导航等电子政务、商业和工业领域的应用，提供基于真实场景的室内导航、导览、导购、导医、导视等行业应用解决方案。</p>
                
            </div>

        </div>
    </div>
    <div id="cover_hot" class="cover">
        <div class="row">
            <a class="pull-right tooltip-viewport-bottom" style="margin-top: 10px;margin-right:20px;" href="javascript:void(0);" onclick="hideCover()"><span class="fa fa-remove" style="font-size:40px;"></span></a>
        </div>
        <div class="container hotlist">
        </div>
    </div>
    <div id="cover_sort" class="cover">
        <div class="row">
            <a class="pull-right tooltip-viewport-bottom" style="margin-top: 10px;margin-right:20px;" href="javascript:void(0);" onclick="hideCover()"><span class="fa fa-remove" style="font-size:40px;"></span></a>
        </div>
        <div class="container sortlist">
        </div>
    </div>
    <div id="cover_project" class="cover">
        <div class="container" style="margin-bottom: 10px; padding: 20px;">
                <div class="row" style="padding-left: 20px; padding-right: 20px;">
                    <div class="input-group">
                        <input id="industry_id" type="text" style="display: none;" value="" />
                        <input id="input_param" type="text" class="form-control border-radius" placeholder="搜索" oninput="searchProject()" />
                        <span class="input-group-addon">
                            <span class="fa fa-search"></span>
                        </span>
                        <a class="pull-right tooltip-viewport-bottom" href="javascript:void(0);" onclick="hideCover()"><span class="fa fa-remove" style="font-size:35px;"></span></a>
                    </div>

                </div>
                <div class="row projectlist" style="padding-top: 10px;padding-left:5px;padding-right:5px;">
                </div>
                

        </div>
    </div>
    
    <div id="cover_poi" class="cover" style="display: none;">
        <div class="container" style="margin-bottom: 10px; padding: 20px;">
                <div class="row">
                    <div class="col-xs-10">
                        <h3 id="POI_title"></h3>
                    </div>
                    <div class="col-xs-2">
                        <a class="pull-right" href="javascript:void(0);" style="margin:10px;" onclick="hideCover()"><span class="fa fa-remove" style="font-size:40px;"></span></a>
                        
                    </div>
                </div>
                <div id="POI_body" style="height: 100%;">
                </div>
        </div>
    </div>

    <div id="cover_share" class="cover">
        <div class="container" style="margin-bottom: 10px; padding: 20px;">
            <div class="panel panel-default" style="width: 100%; height: 100%;">
                <div class="panel-heading">
                    分享
                    <a class="pull-right tooltip-viewport-bottom" style="margin: 2px;" href="javascript:void(0);" onclick="hideCover()"><span class="fa fa-remove"></span></a>
                </div>
                <div class="panel-body">
                    <div class="iShare ">
                        <a href="#" class="iShare_qzone"><i class="iconfont qzone">&#xe610;</i></a>
                        <a href="#" class="iShare_tencent"><i class="iconfont tencent" style="vertical-align: -2px;">&#xe608;</i></a>


                        <a href="#" class="iShare_weibo"><i class="iconfont weibo">&#xe609;</i></a>
                        <a href="#" class="iShare_douban"><i class="iconfont douban" style="vertical-align: -2px;">&#xe612;</i></a>


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
                <div class="panel-footer"></div>

            </div>
        </div>

    </div>

</body>
</html>
