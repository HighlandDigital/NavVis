
function showCoverHot() {
    $('body').css("overflow", "hidden")
    $(".cover").hide();
    $("#cover_hot").show();
    $("#navbtn").click();
    searchProjectHot();
}

function showCoverSort() {
    $('body').css("overflow", "hidden")
    $(".cover").hide();
    $("#cover_sort").show();
    $("#navbtn").click();
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
    $("#navbtn").click();
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
            pagesize: "10"
        },
        success: function (data) {
            if (!data || data.length == 0) return;
            var d = "";
            for (var i = 0; i < data.length; i++) {
                var content = "<div class=\"col-xs-12 col-sm-6 placeholder\" style=\"margin-top: 10px;\">" +
                    "<a href=\"javascript:void(0);\" onclick=\"moveToPoint('" + data[i].poi_id + "')\">" +
                    "<img style=\"width:100%;\" src=\"" + getRootPath() + data[i].img_url + "\" class=\"img-responsive\" alt=\"" + data[i].poi + "\" />" +
                    "</a></div>";
                d = d + content;
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
            pagesize: "10",
            industry_id: $("#industry_id").val(),
            param: $("#input_param").val()
        },
        success: function (data) {
            if (!data || data.length == 0) return;
            var d = "";
            for (var i = 0; i < data.length; i++) {
                var content = "<div class=\"col-xs-12 col-sm-12 placeholder\" style=\"margin-top: 10px;\">" +
                    "<a href=\"javascript:void(0);\" onclick=\"moveToPoint('" + data[i].poi_id + "')\">" +
                    "<img style=\"width:100%;\" src=\"" + getRootPath() + data[i].img_url + "\" class=\"img-responsive\" alt=\"" + data[i].poi + "\" />" +
                    "</a></div>";
                d = d + content;
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
            pagesize: "10"
        },
        success: function (data) {
            if (!data || data.length == 0) return;
            var d = "";
            for (var i = 0; i < data.length; i++) {
                var content = "<div class=\"col-xs-6 col-sm-6 placeholder\" style=\"margin-top: 10px;\">" +
                    "<a href=\"javascript:void(0);\" onclick=\"showCoverProj('" + data[i].id + "')\">" +
                    "<img style=\"width:100%;\" src=\"" + getRootPath() + data[i].img_url + "\" class=\"img-responsive\" alt=\"" + data[i].name + "\" />" +
                    "</a></div>";
                d = d + content;
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
            $("#POI_title").val(d.title);
            $("#POI_body").html(d.description_mod);
            showCoverPOI();
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
