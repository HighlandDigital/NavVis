<%@ Page Language="C#" AutoEventWireup="true" CodeFile="nav.aspx.cs" Inherits="nav" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>第14届中国—东盟博览会先进技术展</title>
    <link rel="stylesheet" type="text/css" href="../style/fonts/iconfont.css" />
    <link rel="stylesheet" type="text/css" href="../style/css/ishare.css" />

    <link rel="stylesheet" type="text/css" href="../style/css/nav.css" />

    <%--<link href="../bootstrap-3.3.5/dist/css/bootstrap.min.css" rel="stylesheet" />--%>
    <script src="../JS/jquery-3.2.1.min.js"></script>
    <script src="../JS/DataSearch.js"></script>
    <%--<script src="../bootstrap-3.3.5/dist/js/bootstrap.min.js"></script>--%>
    <script type="text/javascript" src="../JS/iShare.js"></script>
    <script src="qrcode.min.js"></script>

    <script src="http://nstlab.cn:14610/iv.example/IndoorViewerAPI.js"></script>

    <script type="text/javascript">

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
                onLoadComplete: function () {
                    indoorviewer.addEventListener("poiSelected", function (data) { clickEventListener(data); });

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
                ////if ($("#wxbox") != null) {
                //$("div[id^='wxbox']").each(function () {
                //    $(this).css("display", "none");
                //})
                xshare.wx.hide();


                //}
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
                <a class="navbar-brand" href="javascript:void(0);" onclick="showCoverProj(0)"><span class="fa fa-search"></span></a>
                <a class="navbar-brand" href="javascript:void(0);" onclick="showCoverShare();"><span class="fa fa-share"></span></a>
            </div>
            <div id="navbar" class="navbar-collapse collapse">
                <ul class="nav navbar-nav">
                </ul>
                <ul class="nav navbar-nav navbar-right">
                    <li><a href="javascript:void(0);" onclick="showCoverHot()">明星展台</a></li>
                    <li><a href="javascript:void(0);" onclick="showCoverSort()">参展行业</a></li>
                    <li><a href="javascript:void(0);" onclick="showCoverAbout()">关于我们</a></li>

                </ul>
            </div>
            <!--/.nav-collapse -->
        </div>
    </nav>
    <div class="container" style="width: 100%; height: 100%; margin-top: 0px; margin-left: 0px; margin-right: 0px; padding-left: 0px; padding-right: 0px; padding-bottom: 50px;">

        <div ng-include src="'iv.html'" style="width: 100%; height: 100%;"></div>

    </div>
    <div id="cover_about" class="cover">
        <a class="pull-right tooltip-viewport-bottom" style="margin: 10px;" href="javascript:void(0);" onclick="hideCover()"><span class="fa fa-remove"></span></a>
        <div class="container" style="margin-top: 70px;">

            <div class="col-xs-12 col-sm-12 placeholder" style="color: #ffffff;">
                <p>
                    南宁海蓝数据公司是一家致力于室内空间数字化的高科技企业，利用国际领先的三维空间扫描技术和室内导航技术打造全新室内3D实景地图，为大型场所提供室内三维数据采集及室内定位、导航服务，为室内三维数据采集及数据应用提供解决方案。
                </p>
            </div>

        </div>
    </div>
    <div id="cover_hot" class="cover">

        <a class="pull-right tooltip-viewport-bottom" style="margin: 10px;" href="javascript:void(0);" onclick="hideCover()"><span class="fa fa-remove"></span></a>
        <div class="container hotlist">
        </div>
    </div>
    <div id="cover_sort" class="cover">

        <a class="pull-right tooltip-viewport-bottom" style="margin: 10px;" href="javascript:void(0);" onclick="hideCover()"><span class="fa fa-remove"></span></a>
        <div class="container sortlist">
        </div>
    </div>
    <div id="cover_project" class="cover">
        <div class="container" style="margin-bottom: 10px; padding: 20px;">
            <div class="panel panel-default" style="width: 100%; height: 100%;">
                <div class="panel-heading">
                    <div class="input-group">
                        <input id="industry_id" type="text" style="display: none;" value="" />
                        <input id="input_param" type="text" class="form-control border-radius" placeholder="搜索" oninput="searchProject()" />
                        <span class="input-group-addon">
                            <span class="fa fa-search"></span>
                        </span>
                        <a class="pull-right tooltip-viewport-bottom" style="margin: 5px;" href="javascript:void(0);" onclick="hideCover()"><span class="fa fa-remove"></span></a>
                    </div>

                </div>
                <div class="panel-body projectlist">
                </div>
                <div class="panel-footer"></div>

            </div>
        </div>
    </div>
    <div id="cover_poi" class="cover" style="display: none;">
        <div class="container" style="margin-bottom: 10px; padding: 20px;">
            <div class="panel panel-default" style="width: 100%; height: 100%;">
                <div class="panel-heading">

                    <div class="input-group">
                        <input id="POI_title" type="text" class="form-control" placeholder="title" style="border: 0px; background-color: transparent;" readonly="readonly" />
                        <span class="input-group-addon" style="border: 0px; background-color: transparent;">
                            <a class="pull-right tooltip-viewport-bottom" style="" href="javascript:void(0);" onclick="hideCover()"><span class="fa fa-remove"></span></a>
                        </span>
                    </div>

                </div>
                <div id="POI_body" class="panel-body" style="height: 100%;">
                </div>
                <div class="panel-footer"></div>

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
