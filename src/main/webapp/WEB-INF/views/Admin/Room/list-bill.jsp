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
    <title>Danh sách hóa đơn phòng</title>
    <%@ include file="/WEB-INF/views/inc/links.jsp" %>
    <!-- Thêm thẻ script để bao gồm thư viện jQuery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body class="bg-white">
    <%@ include file="/WEB-INF/views/inc/header.jsp" %>
    <div class="container-fluid" id="main-content">
        <div class="row">
            <div class="col-lg-10 ms-auto p-4 overflow-hidden">
                <h3 class="mb-4">Danh sách hóa đơn phòng</h3>

                <div class="card border-0 shadow-sm mb-4">
                    <div class="card-body">

                        <!-- Bảng hóa đơn -->
                        <div class="table-responsive-md" style="height: 450px; overflow-y: scroll; overflow-x:scroll;">
                            <table class="table bg-white table-hover border">
                                <thead class="sticky-top sticky-bottom">
                                    <tr class="bg-dark text-light">
                                        <th class="wide-column">Mã hóa đơn</th>
                                        <th class="wide-column">Tên khách hàng</th>
                                        <th class="wide-column">Tên phòng</th>
                                        <th class="wide-column">Tiền phòng</th>
                                        <th class="wide-column">Tiền khách trả</th>
                                        <th class="wide-column">Còn nợ</th>
                                        <th class="wide-column">Ngày lập hóa đơn</th>
                                        <th class="wide-column">Trạng thái</th>
                                        <th class="wide-column"></th>

                                    </tr>
                                </thead>
                                <!-- Thay đổi id của tbody thành "invoicesBody" để phù hợp với mã jQuery -->
                                <tbody id="invoicesBody"></tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%@ include file="/WEB-INF/views/inc/scripts.jsp" %>
    <!-- Di chuyển mã script jQuery vào đây để đảm bảo rằng nó được gọi sau khi thư viện jQuery đã được bao gồm -->
 <script>
     $(document).ready(function() {
         $.ajax({
             url: 'http://localhost:8080/DemoMVC/danh-sach-thanh-toan', // Đảm bảo rằng URL này chính xác và trả về dữ liệu JSON
             dataType: 'json',
             success: function(data) {
                 $.each(data, function(index, invoice) {
                     var row = '<tr>' +
                         '<td>' + invoice.paymentId + '</td>' +
                         '<td>' + invoice.booking.customer.name + '</td>' +
                         '<td>' + invoice.booking.room.roomName + '</td>' +
                         '<td>' + invoice.booking.room.pricePerNight + '</td>' +
                         '<td>' + invoice.transactionAmount + '</td>' +
                         '<td>' + invoice.refund + '</td>' +
                         '<td>' + new Date(invoice.transactionDate).toLocaleDateString() + '</td>' +
                         '<td>' + (invoice.refund >= 0 ? 'Đã thanh toán' : 'Chưa thanh toán') + '</td>' +
                         '<td><a href="/DemoMVC/xuat-file-excel/id=' + invoice.paymentId + '" class="btn btn-sm rounded-pill btn-success">Excel</a></td>' +
                         '</tr>';
                     $('#invoicesBody').append(row);
                 });
             }
         });
     });
 </script>


</body>
</html>
