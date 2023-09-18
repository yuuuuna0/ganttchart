<%--
  Created by IntelliJ IDEA.
  User: jyn93
  Date: 2023-08-23
  Time: 오후 4:38
  To change this template use File | Settings | File Templates.
--%>
    <%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Skydash Admin</title>
    <!-- plugin : bootstrap4/ fintAwesome / jQuery -->
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js" integrity="sha384-+sLIOodYLS7CIrQpBjl+C7nPvqq+FbNUBDunl/OZv93DB7Ln/533i8e/mZXLi/P+" crossorigin="anonymous"></script>
    <script src="https://kit.fontawesome.com/c3513198ea.js" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-2.2.4.js" integrity="sha256-iT6Q9iMJYuQiMWNd9lDyBUStIq/8PuOW33aOqmvFpqI=" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js" integrity="sha256-xLD7nhI62fcsEZK2/v8LsBcb4lG7dgULkuXoXB/j91c=" crossorigin="anonymous"></script>
    <!-- plugins:css -->
    <link rel="stylesheet" href="/static/vendors/feather/feather.css">
    <link rel="stylesheet" href="/static/vendors/ti-icons/css/themify-icons.css">
    <link rel="stylesheet" href="/static/vendors/css/vendor.bundle.base.css">
    <!-- endinject -->
    <!-- Plugin css for this page -->
    <link rel="stylesheet" href="/static/vendors/datatables.net-bs4/dataTables.bootstrap4.css">
    <link rel="stylesheet" href="/static/vendors/ti-icons/css/themify-icons.css">
    <link rel="stylesheet" type="text/css" href="/static/js/select.dataTables.min.css">
    <link rel="stylesheet" href="/static/vendors/select2/select2.min.css">
    <link rel="stylesheet" href="/static/vendors/select2-bootstrap-theme/select2-bootstrap.min.css">
    <!-- End plugin css for this page -->
<%--  부트스트랩  --%>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
    <!-- inject:css -->
    <link rel="stylesheet" href="/static/css/vertical-layout-light/style.css">
    <!-- endinject -->
    <link rel="shortcut icon" href="/static/images/favicon.png" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <!-- plugins:js -->
    <script src="/static/vendors/js/vendor.bundle.base.js"></script>
    <!-- endinject -->
    <!-- Plugin js for this page -->
    <script src="/static/vendors/chart.js/Chart.min.js"></script>
    <script src="/static/vendors/datatables.net/jquery.dataTables.js"></script>
    <script src="/static/vendors/datatables.net-bs4/dataTables.bootstrap4.js"></script>
    <script src="/static/vendors/typeahead.js/typeahead.bundle.min.js"></script>
    <script src="/static/vendors/select2/select2.min.js"></script>
    <script src="/static/js/dataTables.select.min.js"></script>

    <!-- End plugin js for this page -->
    <!-- inject:js -->
    <script src="/static/js/off-canvas.js"></script>
    <script src="/static/js/hoverable-collapse.js"></script>
    <script src="/static/js/template.js"></script>
    <script src="/static/js/settings.js"></script>
    <script src="/static/js/todolist.js"></script>
    <!-- endinject -->
    <!-- Custom js for this page-->
    <script src="/static/js/dashboard.js"></script>
    <script src="/static/js/Chart.roundedBarCharts.js"></script>
    <script src="/static/js/file-upload.js"></script>
    <script src="/static/js/typeahead.js"></script>
    <script src="/static/js/select2.js"></script>
    <!-- 다음 주소 API 사용 -->
    <script src="http://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <%-- 하이차트   --%>
    <script src="https://code.highcharts.com/highcharts.js"></script>
    <script src="https://code.highcharts.com/modules/series-label.js"></script>
    <%--스마트에디터--%>
    <script type="text/javascript" src="/smartEditor/js/HuskyEZCreator.js" charset="UTF-8"></script>
    <%--카카오 지도 API--%>
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f0e11f7a07e83a3f87511dd79bbf6ffe&libraries=services"></script>

