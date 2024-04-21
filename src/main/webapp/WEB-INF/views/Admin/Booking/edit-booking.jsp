<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="java.util.Base64" %>
<%@ page isELIgnored="false" %>
<%@ page import="org.apache.tomcat.util.http.fileupload.*" %>
<%@page session="false" %>
<%@ page import="java.util.Base64" %>
<html>
<head>
    <title>Sửa Đặt phòng</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <%@ include file="/WEB-INF/views/inc/links.jsp" %>
    <link rel="stylesheet" href="<c:url value='/resource/css/edit-facilities-type.css'/>">
    <script>
        function validateForm() {
            var numberOfPeople = document.forms["bookingForm"]["numberOfPeople"].value;
            var totalAmount = document.forms["bookingForm"]["totalAmount"].value;
            var checkIn = new Date(document.forms["bookingForm"]["checkIn"].value);
            var checkOut = new Date(document.forms["bookingForm"]["checkOut"].value);

            // Kiểm tra số người và tổng tiền
            if (numberOfPeople == "" || numberOfPeople == "0") {
                alert("Vui lòng nhập số người ở hợp lệ.");
                return false;
            }
            if (totalAmount == "" || totalAmount == "0") {
                alert("Vui lòng nhập tổng tiền hợp lệ.");
                return false;
            }

            // Kiểm tra ngày check-in và check-out
            var today = new Date();
            today.setHours(0, 0, 0, 0); // Đặt giờ 0:00:00:00 của ngày hiện tại
            if (checkIn < today || checkOut < today) {
                alert("Ngày check-in và check-out phải là ngày hiện tại hoặc sau này.");
                return false;
            }
            if (checkIn >= checkOut) {
                alert("Ngày check-out phải sau ngày check-in.");
                return false;
            }
            return true;
        }
    </script>
</head>

<body class="bg-white">
    <%@ include file="/WEB-INF/views/inc/header.jsp" %>
    <h4>Sửa Đặt phòng</h4>
    <c:url value="/sua-dat-phong" var="url"/>
    <form:form modelAttribute="booking" method="post" action="${url}" name="bookingForm" onsubmit="return validateForm()">
         <form:hidden path="bookingId"/>
           <p>Phòng</p>
              <form:select path="roomId">
                 <c:forEach var="room" items="${rooms}">
                     <form:option value="${room.roomId}">${room.roomName}</form:option>
                 </c:forEach>
              </form:select>
           <p style="color:red;"><form:errors path="roomId"> </form:errors> </p>

           <p>Số người ở</p> <form:input path="numberOfPeople"/>
           <p style="color:red;"><form:errors path="numberOfPeople"> </form:errors> </p>

          <p>Check-in</p> <form:input type="date" id="date-buy" name="date-buy" class="mb-3" path="checkIn" />
          <p style="color:red;"><form:errors path="checkIn"> </form:errors> </p>

          <p>Check-out</p> <form:input type="date" id="date-buy" name="date-buy" class="mb-3" path="checkOut" />
          <p style="color:red;"><form:errors path="checkOut"> </form:errors> </p>

          <p>Yêu cầu</p> <form:input path="requiredSpecial"/>
          <p style="color:red;"><form:errors path="requiredSpecial"> </form:errors> </p>

          <p>Tổng tiền</p> <form:input path="totalAmount"/>
          <p style="color:red;"><form:errors path="totalAmount"> </form:errors> </p>

          <!-- Thẻ form:form cho đối tượng Customer -->
          <form:form modelAttribute="customer" method="post">
                 <form:hidden path="customerId"/>

                 <p>Tên khách hàng</p> <form:input path="name"/>
                 <p style="color:red;"><form:errors path="name"> </form:errors> </p>

                 <p>Email</p> <form:input path="email"/>
                 <p style="color:red;"><form:errors path="email"> </form:errors> </p>

                 <p>Số điện thoại</p> <form:input path="phoneNumber"/>
                 <p style="color:red;"><form:errors path="phoneNumber"> </form:errors> </p>

                 <p>Giới tính</p>
                 <form:select path="gender">
                    <form:option value="male">Nam</form:option>
                    <form:option value="female">Nữ</form:option>
                 </form:select>
                  <p><p><button type="submit" class="btn btn-sm rounded-pill btn-primary">Sửa</button>
                  <button type="button" value="Hủy" class="btn btn-sm rounded-pill btn-danger" onclick="history.go(-1)">Hủy</button>
             </form:form>
    </form:form>
    <%@ include file="/WEB-INF/views/inc/scripts.jsp" %>
</body>
</html>
