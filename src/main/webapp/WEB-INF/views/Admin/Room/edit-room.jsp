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
    <title>Sửa phòng</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <%@ include file="/WEB-INF/views/inc/links.jsp" %>
    <link rel="stylesheet" href="<c:url value='/resource/css/edit-facilities-type.css'/>">
    <script>
        function validateForm() {
            var roomName = document.forms["roomForm"]["roomName"].value;
            var pricePerNight = document.forms["roomForm"]["pricePerNight"].value;
            var quantity = document.forms["roomForm"]["quantity"].value;
            var area = document.forms["roomForm"]["area"].value;

            // Kiểm tra không được để trống và không điền số 0 vào các trường
            if (roomName.trim() === "") {
                alert("Vui lòng nhập tên phòng.");
                return false;
            }
            if (pricePerNight.trim() === "" || pricePerNight.trim() === "0") {
                alert("Vui lòng nhập giá phòng hợp lệ.");
                return false;
            }
            if (quantity.trim() === "" || quantity.trim() === "0") {
                alert("Vui lòng nhập số lượng phòng hợp lệ.");
                return false;
            }
            if (area.trim() === "" || area.trim() === "0") {
                alert("Vui lòng nhập diện tích hợp lệ.");
                return false;
            }
            return true;
        }
    </script>
</head>

<body class="bg-white">
    <%@ include file="/WEB-INF/views/inc/header.jsp" %>
    <h4>Sửa phòng</h4>
    <c:url value="/sua-phong" var="url"/>
    <form:form modelAttribute="room" method="post" action="${url}" name="roomForm" onsubmit="return validateForm()">
         <form:hidden path="roomId"/>

         <p>Tên phòng</p> <form:input path="roomName"/>
         <p style="color:red;"><form:errors path="roomName"> </form:errors> </p>

         <p>Loại phòng</p>
             <form:select path="roomTypeId">
                <c:forEach var="roomType" items="${roomTypes}">
                    <form:option value="${roomType.roomTypeId}">${roomType.typeName}</form:option>
                </c:forEach>
             </form:select>
         <p style="color:red;"><form:errors path="roomTypeId"> </form:errors> </p>

          <p>Hình ảnh</p>
          <form:input type="file" id="room-image" name="room-image" accept="image/*" path="pathImage"/>

         <p>Giá phòng</p> <form:input path="pricePerNight"/>
         <p style="color:red;"><form:errors path="pricePerNight"> </form:errors> </p>

         <p>Số lượng</p> <form:input path="quantity"/>
         <p style="color:red;"><form:errors path="quantity"> </form:errors> </p>

          <p>Diện tích</p> <form:input path="area"/>
          <p style="color:red;"><form:errors path="area"> </form:errors> </p>

         <p>Trạng thái</p>
         <form:select path="status">
            <form:option value="Hoạt động">Hoạt động</form:option>
            <form:option value="Bảo trì">Bảo trì</form:option>
            <form:option value="Hỏng">Hỏng</form:option>
         </form:select>
         <p style="color:red;"><form:errors path="status"> </form:errors> </p>

        <p><p><button type="submit" class="btn btn-sm rounded-pill btn-primary">Sửa</button>
        <button type="button" value="Hủy" class="btn btn-sm rounded-pill btn-danger" onclick="history.go(-1)">Hủy</button>
    </form:form>
    <%@ include file="/WEB-INF/views/inc/scripts.jsp" %>
</body>
</html>
