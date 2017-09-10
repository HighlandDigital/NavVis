
function showCoverHot() {
    $('body').css("overflow", "hidden")
    $(".cover").hide();
    $("#cover_hot").show();
    var display = $('#navbtn').css('display');
    if (display == 'block') {
        $("#navbtn").click();
    }

    searchProjectHot();
}

function showCoverSort() {
    $('body').css("overflow", "hidden")
    $(".cover").hide();
    $("#cover_sort").show();
    var display = $('#navbtn').css('display');
    if (display == 'block') {
        $("#navbtn").click();
    }

    searchIndustry();
}

function showCoverProj(sort) {
    $('body').css("overflow", "hidden")
    $(".cover").hide();
    $("#industry_id").val(sort);
    $("#cover_project").show();
    searchProject();
}

function showCoverAbout() {
    $('body').css("overflow", "hidden")
    $(".cover").hide();
    $("#cover_about").show();
    var display = $('#navbtn').css('display');
    if (display == 'block') {
        $("#navbtn").click();
    }

}

function showCoverPOI() {
    $('body').css("overflow", "hidden")
    $(".cover").hide();
    $("#cover_poi").show();

}

function searchProjectHot() {
    $.ajax({
        type: 'POST',
        url: "../handler/searchHandler.ashx",
        data: {
            method: "searchProjectHot",
            pagesize: "20",
            lang: language
        },
        success: function (data) {
            var d = "";
            if (!data || data.length == 0) d = "没有找到项目";
            else {
                for (var i = 0; i < data.length; i++) {
                    var title = "";
                    if (language == "CH") title = data[i].name;
                    else if (language == "EN") title = data[i].name_en;
                    var content = "<div class=\"col-xs-12 col-sm-12 col-lg-12 placeholder\" style=\"margin-top: 10px;\">" +
                        "<a href=\"javascript:void(0);\" onclick=\"moveToPoint('" + data[i].poi_id + "')\">" +
                        "<div class=\"panel panel-default\">" +
                        "<div class=\"panel-body\" style=\"padding:0px;\">" +
                        "<img style=\"width:100%;\" src=\"" + data[i].img_url + "\" class=\"img-responsive\" alt=\"\" onerror=\"this.src='" + loadIndustryImg(data[i].industry_id) + "'\"/>" +
                        "</div>" +
                        "<div class=\"panel-footer\" style=\"text-align:center;\">" + title + "</div>" +
                        "</div></a></div>";
                    d = d + content;
                }
            }
            
            $(".hotlist").html(d);
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
            pagesize: "30",
            industry_id: $("#industry_id").val(),
            param: $("#input_param").val(),
            lang: language
        },
        success: function (data) {
            var d = "";
            if (!data || data.length == 0) d = "<div class=\"alert alert-warning\" role=\"alert\" style=\"margin-left: 15px;margin-right: 15px;\">没有找到项目</div>";
            else {
                for (var i = 0; i < data.length; i++) {
                    var title = "";
                    if (language == "CH") title = data[i].name;
                    else if (language == "EN") title = data[i].name_en;
                    var content = "<div class=\"col-xs-12 col-sm-12 col-lg-12 placeholder\">" +
                        "<a href=\"javascript:void(0);\" onclick=\"moveToPoint('" + data[i].poi_id + "')\">" +
                        "<div class=\"panel panel-default\">" +
                        "<div class=\"panel-body\" style=\"padding:0px;\">" +
                        "<img style=\"width:100%;\" src=\"" + data[i].img_url + "\" class=\"img-responsive\" alt=\"\" onerror=\"this.src='" + loadIndustryImg(data[i].industry_id) + "'\"/>" +
                        "</div>" +
                        "<div class=\"panel-footer\" style=\"text-align:center;\">" + title + "</div>" +
                        "</div></a></div>";
                    d = d + content;
                }
            }
            
            $(".projectlist").html(d);
        },
        dataType: "json"
    });
}

function searchIndustry() {
    $.ajax({
        type: 'POST',
        url: "../handler/searchHandler.ashx",
        data: {
            method: "searchIndustry",
            pagesize: "20",
            lang: language
        },
        success: function (data) {
            var d = "";
            if (!data || data.length == 0) d = "没有找到项目";
            else {
                for (var i = 0; i < data.length; i++) {
                    var title = "";
                    if (language == "CH") title = data[i].name;
                    else if (language == "EN") title = data[i].name_en;
                    var content = "<div class=\"col-xs-12 col-sm-6 col-lg-6 placeholder\" style=\"margin-top: 10px;\">" +
                        "<a href=\"javascript:void(0);\" onclick=\"showCoverProj('" + data[i].id + "')\">" +
                        "<div class=\"panel panel-default\">" +
                        "<div class=\"panel-body\" style=\"padding:0px;\">" +
                        "<img style=\"width:100%;\" src=\""  + data[i].img_url + "\" class=\"img-responsive\" alt=\"" + data[i].name + "\" onerror=\"this.src='../image/default/industry_default.jpg'\"/>" +
                        "</div>" +
                        "<div class=\"panel-footer\" style=\"text-align:center;\">" + title + "</div>" +
                        "</div></a></div>";
                    d = d + content;
                }
            }
            
            $(".sortlist").html(d);
        },
        dataType: "json"
    });
}

function searchPointByIVID(id) {
    $.ajax({
        type: 'POST',
        url: "../handler/searchHandler.ashx",
        data: {
            method: "searchPointByIVID",
            ivid: id
        },
        success: function (data) {
            if (!data || data.length == 0) return;
            var d = data[0];
            if (language == "CH") {
                var title = d.title;
                var content = d.description_mod;
                if (title == null || title == undefined) title = "";
                if (content == null || content == undefined) content = "非常抱歉，我们没有找到相关内容，请稍后再回来";
                $("#POI_title").html(title);
                $("#POI_body").html(content);
            }
            else if (language == "EN") {
                var title = d.title_en;
                var content = d.description_en_mod;
                if (title == null || title == undefined) title = "";
                if (content == null || content == undefined) content = "Ops,we found no content here,come back later,please.";
                $("#POI_title").html(title);
                $("#POI_body").html(content);
            }
            
            showCoverPOI();
        },
        dataType: "json"
    });
}

function log(id, iv_id) {
    $.ajax({
        type: 'POST',
        url: "../handler/VisitHandler.ashx",
        data: {
            m: "add",
            poi:id,
            ivid: iv_id
        },
        success: function (data) {
            
        },
        dataType: "json"
    });
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

function loadcss(path){
    if(!path || path.length === 0){
        throw new Error('argument "path" is required !');
    }
    var head = document.getElementsByTagName('head')[0];
    var link = document.createElement('link');
    link.href = path;
    link.rel = 'stylesheet';
    link.type = 'text/css';
    head.appendChild(link);
}

function loadjs(path){
    if(!path || path.length === 0){
        throw new Error('argument "path" is required !');
    }
    var head = document.getElementsByTagName('head')[0];
    var script = document.createElement('script');
    script.src = path;
    script.type = 'text/javascript';
    head.appendChild(script);
}

var industryArray = [];
function loadIndustryArray() {
    $.ajax({
        type: "post",
        url: '../Handler/PointHandler.ashx?ac=industry',
        cache: false,
        async: false,
        dataType: 'json',
        success: function (json) {
            industryArray = json;
        },
        error: function () {

        }

    });
}

function loadIndustryImg(id) {
    for (var i = 0; i < industryArray.length; i++) {
        if (id == industryArray[i].id) return industryArray[i].img_url;
    }
    return "../image/default/industry_default.jpg";
}