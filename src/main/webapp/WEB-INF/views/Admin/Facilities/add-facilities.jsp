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
    <title>Thêm cơ sở vật chất</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <%@ include file="/WEB-INF/views/inc/links.jsp" %>
    <link rel="stylesheet" href="<c:url value='/resource/css/edit-facilities-type.css'/>">
</head>

<body class="bg-white">
    <%@ include file="/WEB-INF/views/inc/header.jsp" %>
    <h4>Thêm cơ sở vật chất</h4>
    <c:url value="/them-co-so-vat-chat" var="url"/>
    <form:form modelAttribute="facilities" method="post" action="${url}">
         <form:hidden path="id"/>

         <p>Tên cơ sở vật chất</p> <form:input path="name"/>
         <p style="color:red;"><form:errors path="name"> </form:errors> </p>

         <p>Giá cơ sở vật chất</p> <form:input path="price"/>
         <p style="color:red;"><form:errors path="price"> </form:errors> </p>

         <p>Số lượng</p> <form:input path="quantity"/>
         <p style="color:red;"><form:errors path="quantity"> </form:errors> </p>

         <p>Ngày mua</p>
         <form:input type="date" id="date-buy" name="date-buy" class="mb-3" path="date_buy" />
         <p style="color:red;"><form:errors path="date_buy"> </form:errors> </p>

         <p>Trạng thái</p>
         <form:select path="status">
            <form:option value="Hoạt động">Hoạt động</form:option>
            <form:option value="Bảo trì">Bảo trì</form:option>
            <form:option value="Hỏng">Hỏng</form:option>
         </form:select>
         <p style="color:red;"><form:errors path="status"> </form:errors> </p>

         <p>Hãng sản xuất</p> <form:input path="manufacturer"/>
         <p style="color:red;"><form:errors path="manufacturer"> </form:errors> </p>

         <p>Loại cơ sở vật chất</p>
            <form:select path="facilitiesTypeId">
               <c:forEach var="facilitiesType" items="${facilitiesTypes}">
                   <form:option value="${facilitiesType.id}">${facilitiesType.facilitiesTypeName}</form:option>
               </c:forEach>
            </form:select>
         <p style="color:red;"><form:errors path="facilitiesTypeId"> </form:errors> </p>

        <p><p><button type="submit" class="btn btn-sm rounded-pill btn-primary">Thêm</button>
        <button type="button" value="Hủy" class="btn btn-sm rounded-pill btn-danger" onclick="history.go(-1)">Hủy</button>
    </form:form>
    <%@ include file="/WEB-INF/views/inc/scripts.jsp" %>
</body>
</html>