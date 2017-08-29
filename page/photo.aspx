<%@ Page Language="C#" AutoEventWireup="true" CodeFile="photo.aspx.cs" Inherits="page_photo" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>拍照</title>
    <link href="/bootstrap-3.3.5/dist/css/bootstrap.min.css" rel="stylesheet" />
    <script src="/JS/jquery-3.2.1.min.js"></script>
    <script src="/bootstrap-3.3.5/dist/js/bootstrap.min.js"></script>

</head>
<body>
    <div class="container" style="margin-bottom:70px;">
        <div class="row">
            <video id="video" autoplay="" style='width: 640px; height: 480px'></video>
        </div>
        <div class="row">
            <button id='picture' style="width: 100%;">拍照</button>
        </div>
        <div class="row">
            <canvas id="canvas" width="640" height="480"></canvas>
        </div>
    </div>
    
    <script type="text/javascript">
        var video = document.getElementById("video");
        var context = canvas.getContext("2d");
        var errocb = function () {
            console.log('sth wrong!');
        }

        if (navigator.getUserMedia) { // 标准的API
            navigator.getUserMedia({ "video": true }, function (stream) {
                video.src = stream;
                video.play();
            }, errocb);
        } else if (navigator.webkitGetUserMedia) { // WebKit 核心的API
            navigator.webkitGetUserMedia({ "video": true }, function (stream) {
                video.src = window.webkitURL.createObjectURL(stream);
                video.play();
            }, errocb);
        }

        document.getElementById("picture").addEventListener("click", function () {
            context.drawImage(video, 0, 0, 640, 480);
        });
    </script>

</body>

</html>
