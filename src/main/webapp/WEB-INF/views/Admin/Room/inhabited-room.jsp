<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.Base64" %>
<%@ page isELIgnored="false" %>
<%@ page import="org.apache.tomcat.util.http.fileupload.*" %>
<%@page session="false" %>
<%@ page import="java.util.Base64" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <link rel="stylesheet" href="<c:url value='/resource/css/list-room.css'/>">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý khách sạn</title>

    <%@ include file="/WEB-INF/views/inc/links.jsp" %>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body class="bg-white">
    <%@ include file="/WEB-INF/views/inc/header.jsp" %>
    <div class="container-fluid" id="main-content">
        <div class="row">
            <div class="col-lg-10 ms-auto p-4 overflow-hidden">
                <h3 class="mb-4">Danh sách phòng có người ở</h3>

                <div class="card border-0 shadow-sm mb-4">
                    <div class="card-body">

                        <div class="text-end mb-4">
                            <c:url var="urlCheckIn" value="/nhan-phong"/>
                            <a href="${urlCheckIn}" class="btn btn-success rounded-pill shadow-none btn-sm">
                               Nhận Phòng
                            </a>
                        </div>

                        <div class="table-responsive-md" style="height: 450px; overflow-y: scroll; overflow-x:scroll;">
                             <!-- Bảng phòng -->
                            <table class="table bg-white table-hover border">
                                <thead class="sticky-top sticky-bottom">
                                    <tr class="bg-dark text-light">
                                    <th class="wide-column">Khách hàng</th>
                                    <th class="wide-column">Số điện thoại</th>
                                    <th class="wide-column">Phòng</th>
                                    <th class="wide-column">Số người ở</th>
                                    <th class="wide-column">Ngày đến</th>
                                    <th class="wide-column">Ngày đi</th>
                                    <th></th>
                                    <th></th>
                                    <th></th>
                                    </tr>
                                </thead>
                            <tbody id="occupiedBody"></tbody>
                            </table>
                        </div>
                    </div>
                </div>
    <%@ include file="/WEB-INF/views/inc/scripts.jsp" %>
     <script>
         $(document).ready(function() {
             $.ajax({
                 url: 'http://localhost:8080/DemoMVC/danh-sach-phong-da-co-nguoi-o', // Đảm bảo rằng URL này chính xác và trả về dữ liệu JSON
                 dataType: 'json',
                 success: function(data) {
                     $.each(data, function(index, occupiedRoom) {
                         var formattedDateCI = new Date(occupiedRoom.booking.checkIn).toLocaleDateString();
                         var formattedDateCO = new Date(occupiedRoom.booking.checkOut).toLocaleDateString();
                         var row = '<tr>' +
                             '<td>' + occupiedRoom.booking.customer.name + '</td>' +
                             '<td>' + occupiedRoom.booking.customer.phoneNumber + '</td>' +
                             '<td>' + occupiedRoom.booking.room.roomName + '</td>' +
                             '<td>' + occupiedRoom.booking.numberOfPeople + '</td>' +
                             '<td>' + formattedDateCI + '</td>' +
                             '<td>' + formattedDateCO + '</td>' +
                             '<td><a href="/DemoMVC/thanh-toan-phong/bookingId=' + occupiedRoom.booking.bookingId + '" class="btn btn-sm rounded-pill btn-warning">Thanh toán</a></td>' +
                             '</tr>';
                         $('#occupiedBody').append(row);
                     });
                 }
             });
         });
     </script>
    <%@ include file="/WEB-INF/views/inc/scripts.jsp" %>
</body>
</html>