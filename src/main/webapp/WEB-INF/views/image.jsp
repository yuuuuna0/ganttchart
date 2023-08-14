<%--
  Created by IntelliJ IDEA.
  User: jyn93
  Date: 2023-08-14
  Time: 오후 4:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<form name="imageForm" method="post" action="image-action" enctype="multipart/form-data" accept-charset="UTF-8">
    <div class="imageDiv">
        <input style="display: block" type="file" id="photoFile" name="photoFile">
        <button type="submit">Submit</button>
    </div>
</form>
</body>
</html>
