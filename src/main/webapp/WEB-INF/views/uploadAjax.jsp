<%--
  Created by IntelliJ IDEA.
  User: jyn93
  Date: 2023-08-14
  Time: 오후 2:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<h1>Upload with Ajax</h1>
<div class="uploadDiv">
    <lavel for="file"></lavel>
    <input type="file" name="uploadFile" multiple>
    <button id="uploadFileBtn">Upload</button>
</div>
<div>
    <div class="img_wrap">
        <img id="img"/>
    </div>
</div>
</body>

<script src="http://code.jquery.com/jquery-3.3.1.min.js"></script>
<script>
    $(document).ready(function(){
        $('#uploadFileBtn').on('click',function(e){
            var files= e.target.files;
            console.log(files);
            var filesArray=Array.prototype.slice.call(files);

            var reg=/(.*?)\/(jpg|jpeg|png|bmp)$/;

            filesArray.forEach(function(f){
               if(!f.type.match(reg)){
                   alert("확장자는 이미지 확장자만 가능합니다.");
                   return;
               }
               sel_file=f;

               var reader=new FileReader();
               reader.onload=function(e){
                   console.log(e.target.result);
                   $('#img').attr("src",e.target.result);
               };
               reader.readAsDataURL(f);
            });
        });
    });
</script>
</html>
