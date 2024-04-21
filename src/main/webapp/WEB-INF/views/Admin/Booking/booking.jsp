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
    <title>Đặt phòng</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <%@ include file="/WEB-INF/views/inc/links.jsp" %>
    <link rel="stylesheet" href="<c:url value='/resource/css/edit-facilities-type.css'/>">
</head>

<body class="bg-white">
    <%@ include file="/WEB-INF/views/inc/header.jsp" %>
    <h4>Đặt phòng</h4>
    <c:url value="/dat-phong" var="url"/>
    <form:form modelAttribute="booking" method="post" action="${url}" onsubmit="return validateForm();">
       <form:hidden path="bookingId"/>
         <p>Phòng</p>
            <form:select path="roomId" id="roomId">
               <c:forEach var="room" items="${rooms}">
                   <form:option value="${room.roomId}">${room.roomName}</form:option>
               </c:forEach>
            </form:select>

         <p style="color:red;"><form:errors path="roomId"> </form:errors> </p>
           <p>Số người ở</p> <form:input path="numberOfPeople" id="numberOfPeople"/>
           <p style="color:red;"><form:errors path="numberOfPeople"> </form:errors> </p>

           <p>Check-in</p> <form:input type="date" class="mb-3" path="checkIn" id="checkIn" onchange="checkCheckInDate()" />
           <p style="color:red;"><form:errors path="checkIn"> </form:errors> </p>

         <p>Check-out</p> <form:input type="date" class="mb-3" path="checkOut" id="checkOut" />
         <p style="color:red;"><form:errors path="checkOut"> </form:errors> </p>

          <p>Yêu cầu</p> <form:input path="requiredSpecial" id="requiredSpecial"/>
          <p style="color:red;"><form:errors path="requiredSpecial"> </form:errors> </p>

          <!-- Thẻ form:form cho đối tượng Customer -->
          <form:form modelAttribute="customer" method="post">
                 <form:hidden path="customerId"/>

                 <p>Tên khách hàng</p> <form:input path="name" id="name"/>
                 <p style="color:red;"><form:errors path="name"> </form:errors> </p>

                 <p>Email</p> <form:input path="email" id="email"/>
                 <p style="color:red;"><form:errors path="email"> </form:errors> </p>

                 <p>Số điện thoại</p> <form:input path="phoneNumber" id="phoneNumber"/>
                 <p style="color:red;"><form:errors path="phoneNumber"> </form:errors> </p>

                 <p>Giới tính</p>
                 <form:select path="gender">
                    <form:option value="male">Nam</form:option>
                    <form:option value="female">Nữ</form:option>
                 </form:select>
                  <p><p><button type="submit" class="btn btn-sm rounded-pill btn-primary">Thêm</button>
                  <button type="button" value="Hủy" class="btn btn-sm rounded-pill btn-danger" onclick="history.go(-1)">Hủy</button>
             </form:form>
    </form:form>
    <%@ include file="/WEB-INF/views/inc/scripts.jsp" %>

    <script>
    function validateForm() {
        var roomId = document.getElementById("roomId").value;
        var numberOfPeople = document.getElementById("numberOfPeople").value;
        var checkIn = document.getElementById("checkIn").value;
        var checkOut = document.getElementById("checkOut").value;
        var requiredSpecial = document.getElementById("requiredSpecial").value;
        var name = document.getElementById("name").value;
        var email = document.getElementById("email").value;
        var phoneNumber = document.getElementById("phoneNumber").value;

        if (roomId === "") {
            alert("Vui lòng chọn phòng");
            return false;
        }
        if (numberOfPeople === "") {
            alert("Vui lòng nhập số người ở");
            return false;
        }
        if (numberOfPeople <= 0) {
            alert("Số người ở phải lớn hơn 0");
            return false;
        }
        if (checkIn === "") {
            alert("Vui lòng chọn ngày Check-in");
            return false;
        }
        if (checkOut === "") {
            alert("Vui lòng chọn ngày Check-out");
            return false;
        }
        if (checkOut <= checkIn) {
            alert("Check-out phải sau Check-in");
            return false;
        }
        if (name === "") {
            alert("Vui lòng nhập tên khách hàng");
            return false;
        }
        if (email === "") {
            alert("Vui lòng nhập email");
            return false;
        }
        if (phoneNumber === "") {
            alert("Vui lòng nhập số điện thoại");
            return false;
        }
        return true;
    }
    function checkCheckInDate() {
        var today = new Date();
        var checkInDate = new Date(document.getElementById("checkIn").value);
        if (checkInDate < today) {
            alert("Vui lòng chọn ngày Check-in từ ngày hiện tại trở đi");
            document.getElementById("checkIn").value = "";
        }
    }
    </script>
</body>
</html>
