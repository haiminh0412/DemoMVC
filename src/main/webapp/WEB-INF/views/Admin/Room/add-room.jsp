<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.Base64" %>
<%@ page isELIgnored="false" %>
<%@ page import="org.apache.tomcat.util.http.fileupload.*" %>
<%@page session="false" %>
<%@ page import="java.util.Base64" %>
<html>
<head>
    <title>Thêm phòng</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <%@ include file="/WEB-INF/views/inc/links.jsp" %>
    <link rel="stylesheet" href="<c:url value='/resource/css/edit-facilities-type.css'/>">
</head>

<body class="bg-white">
    <%@ include file="/WEB-INF/views/inc/header.jsp" %>
    <h4>Thêm phòng</h4>
    <c:url value="/them-phong" var="url"/>
    <form:form modelAttribute="room" method="post" action="${url}" id="roomForm" onsubmit="return validateRoomName()">
         <form:hidden path="roomId"/>

         <p>Tên phòng</p>
         <form:input path="roomName" id="roomName"/>
         <p id="roomNameError" style="color:red;"></p>

         <p>Loại cơ sở vật chất</p>
         <form:select path="roomTypeId" id="roomtype">
            <c:forEach var="roomType" items="${roomTypes}">
                <form:option value="${roomType.roomTypeId}">${roomType.typeName}</form:option>
            </c:forEach>
         </form:select>
         <p style="color:red;"><form:errors path="roomTypeId"> </form:errors> </p>

         <p>Giá phòng</p>
         <form:input id="price" type="number" min="1" path="pricePerNight" onkeypress="return event.charCode >= 48 && event.charCode <= 57"/>
         <p style="color:red;"><form:errors path="pricePerNight"> </form:errors> </p>

         <p>Số lượng</p>
         <form:input id="quantity" type="number" min="1" path="quantity" onkeypress="return event.charCode >= 48 && event.charCode <= 57"/>
         <p style="color:red;"><form:errors path="quantity"> </form:errors> </p>

         <p>Diện tích</p>
         <form:input type="number" id="area" min="1" path="area" onkeypress="return event.charCode >= 48 && event.charCode <= 57"/>
         <p style="color:red;"><form:errors path="area"> </form:errors> </p>

         <p>Trạng thái</p>
         <form:select path="status" id="status" onchange="updateSelectedStatus()">
            <form:option value="Hoạt động">Hoạt động</form:option>
            <form:option value="Bảo trì">Bảo trì</form:option>
            <form:option value="Hỏng">Hỏng</form:option>
         </form:select>
         <p id="selectedStatus" style="color:blue;"></p>

         <p>
             <button type="submit" class="btn btn-sm rounded-pill btn-primary" onclick="addRoom()">Thêm</button>
             <button type="button" value="Hủy" class="btn btn-sm rounded-pill btn-danger" onclick="history.go(-1)">Hủy</button>
         </p>
    </form:form>
    <%@ include file="/WEB-INF/views/inc/scripts.jsp" %>
    <script>
        function addRoom() {
            var name = $("#roomName").val();
            var roomTypeId = $("#roomtype").val();
            var price = $("#price").val();
            var quantity = $("#quantity").val();
            var area = $("#area").val();
            var status = $("#status").val();

            const productTypeAPI = 'http://localhost:8080/DemoMVC/find-room-type/id=' + roomTypeId;

            // Lấy thông tin loại sản phẩm từ API
            $.getJSON(productTypeAPI, function(roomType) {
                // Tạo đối tượng roomTypeData từ dữ liệu API
                var roomTypeData = {
                    "productTypeId": roomType.roomTypeId,
                    "name": roomType.typeName,
                    "description": roomType.description
                };

                // Tạo đối tượng roomData với thông tin đã lấy được
                var roomData = {
                    "roomName": name,
                    "roomType": roomTypeData,
                    "pricePerNight": price,
                    "area": area,
                    "quantity": quantity,
                    "status": status,
                };

                // Gửi yêu cầu POST để thêm phòng mới
                axios.post('http://localhost:8080/DemoMVC/add-room', roomData)
                    .then(function(response) {
                        console.log(response.data);
                        alert("Thêm thành công!");
                        window.location.href = 'http://localhost:8080/DemoMVC/danh-sach-phong';
                    })
                    .catch(function(error) {
                        console.log(error);
                        alert("Lỗi xảy ra khi thêm!");
                    });
            });
        }

        function displayStatus() {
            var statusSelect = document.getElementById("status");
            var selectedStatus = document.getElementById("selectedStatus");
            selectedStatus.innerHTML = statusSelect.value;
        }

        function validateRoomName() {
            var roomName = document.getElementById("roomName").value.trim();
            var roomNameError = document.getElementById("roomNameError");

            if (roomName === '') {
                roomNameError.innerHTML = 'Tên phòng không được để trống';
                return false;
            } else {
                roomNameError.innerHTML = '';
                return true;
            }
        }

        function updateSelectedStatus() {
            var statusSelect = document.getElementById("status");
            var selectedStatus = document.getElementById("selectedStatus");
            selectedStatus.innerHTML = statusSelect.value;
        }

        window.onload = function() {
            updateSelectedStatus();
        };
    </script>
</body>
</html>
