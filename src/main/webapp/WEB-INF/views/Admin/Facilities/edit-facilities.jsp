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
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thêm mới sản phẩm</title>
    <%@ include file="/WEB-INF/views/inc/links.jsp" %>

    <!-- jQuery library -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

    <!-- Popper JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>

    <!-- Latest compiled JavaScript -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>

    <!-- Axios for sending HTTP requests -->
    <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>

</head>


<script>
    $(document).ready(function() {
       // Lấy địa chỉ URL hiện tại
       const currentURL = window.location.href;

       // Tách đoạn cuối của URL để chỉ lấy phần chứa tham số
       const parameterPart = currentURL.split('/').pop();

       // Tách phần chứa tham số để lấy giá trị số
       const parameterValue = parameterPart.split('=').pop();

       const id = parameterValue;

        const API_URL = 'http://localhost:8080/DemoMVC/cosovatchat/id='+id;
        $.getJSON(API_URL, function(facilities) {
            // Gán các giá trị thuộc tính của productType vào các biến riêng

            // Gán giá trị vào các trường input trên form
           document.getElementById("price").value = facilities.price;
           document.getElementById("name").value = facilities.name;
           document.getElementById("quantity").value = facilities.quantity;
           document.getElementById("manufacturer").value = facilities.manufacturer;
           document.getElementById("status").value = facilities.status;
           document.getElementById("facilitiesTypeId").value = facilities.facilitiesType.facilitiesTypeName;
        });
    });
</script>

<body class="bg-white">
    <%@ include file="/WEB-INF/views/inc/header.jsp" %>
    <div class="container-fluid" id="main-content">
        <div class="row">
            <div class="col-lg-10 ms-auto p-4 overflow-hidden">
                <h3 class="mb-4">Thêm cơ sở vật chất</h3>

                <form id="addFacilitiesForm">
                    <div class="form-group">
                        <label for="name">Tên cơ sở vật chất:</label>
                        <input type="text" class="form-control" id="name" name="name">
                    </div>
                    <div class="form-group">
                        <label for="price">Giá cơ sở vật chất:</label>
                        <input type="number" class="form-control" id="price" name="price">
                    </div>
                    <div class="form-group">
                        <label for="quantity">Số lượng:</label>
                        <input type="number" class="form-control" id="quantity" name="quantity">
                    </div>
                    <div class="form-group">
                        <label for="date-buy">Ngày mua:</label>
                        <input type="date" class="form-control" id="date-buy" name="date-buy" value="<c:out value='${facilities.date_buy}'/>">
                    </div>
                    <div class="form-group">
                        <label for="status">Trạng thái:</label>
                        <select class="form-control" id="status" name="status">
                            <option value="Hoạt động">Hoạt động</option>
                            <option value="Bảo trì">Bảo trì</option>
                            <option value="Hỏng">Hỏng</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="manufacturer">Hãng sản xuất:</label>
                        <input type="text" class="form-control" id="manufacturer" name="manufacturer">
                    </div>
                    <div class="form-group">
                        <label for="facilitiesTypeId">Loại cơ sở vật chất:</label>
                        <select class="form-control" id="facilitiesTypeId" name="facilitiesTypeId">
                            <c:forEach var="facilitiesType" items="${facilitiesTypes}">
                                <option value="${facilitiesType.id}">${facilitiesType.facilitiesTypeName}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <button type="button" class="btn btn-primary" onclick="addFacilities()">Xác nhận sửa</button>
                    <button type="button" class="btn btn-sm rounded-pill btn-danger" onclick="history.go(-1)">Hủy</button>
                </form>
            </div>
        </div>
    </div>

    <script>
       function addFacilities() {
           var id = "<c:out value='${facilities.id}'/>";
           var name = $("#name").val();
           var price = parseFloat($("#price").val()); // Parse price to a number
           var quantity = $("#quantity").val();
           var total = price * quantity;
           var dateBuy = $("#date-buy").val();
           var status = $("#status").val();
           var manufacturer = $("#manufacturer").val();
           var facilitiesTypeId = $("#facilitiesTypeId").val();
                if (!name || !price || !quantity || !dateBuy || !status || !manufacturer || !facilitiesTypeId) {
                                            alert("Vui lòng điền đầy đủ thông tin.");
                                            return;
                                        }
           const facilitiesTypeJson = 'http://localhost:8080/DemoMVC/find-facilities-type/id=' + facilitiesTypeId;
           $.getJSON(facilitiesTypeJson, function(facilitiesTypeData) {
               var facilitiesTypeGet = {
                   "id": facilitiesTypeData.id,
                   "facilitiesTypeName":  facilitiesTypeData.facilitiesTypeName,
               };

               // Tạo đối tượng product với thông tin đã lấy được
               var facilitiesData = {
                   "name": name,
                   "price": price,
                   "quantity": quantity,
                   "totalPrice": total,
                   "date_buy": dateBuy,
                   "status": status,
                   "manufacturer": manufacturer,
                   "facilitiesType": facilitiesTypeGet
               };

               // Gửi yêu cầu POST để thêm sản phẩm mới
               axios.put('http://localhost:8080/DemoMVC/update/'+ id, facilitiesData)
                   .then(function (response) {
                       console.log(response.data);
                       alert("Sua thành công!");
                       window.location.href = 'http://localhost:8080/DemoMVC/danh-sach-co-so-vat-chat';
                   })
                   .catch(function (error) {
                       console.log(error);
                       alert("Lỗi xảy ra khi sua! Vui lòng kiểm tra lại thông tin.");
                   });
           });
       }
    </script>

    <%@ include file="/WEB-INF/views/inc/scripts.jsp" %>
</body>
</html>