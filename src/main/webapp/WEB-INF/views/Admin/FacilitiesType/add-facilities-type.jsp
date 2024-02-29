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
    <title>Thêm loại cơ sở vật chất</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <%@ include file="/WEB-INF/views/inc/links.jsp" %>
    <link rel="stylesheet" href="<c:url value='/resource/css/edit-facilities-type.css'/>">
</head>
<body class="bg-white">
    <%@ include file="/WEB-INF/views/inc/header.jsp" %>
    <c:url value="/them-loai-co-so-vat-chat" var="url"/>
    <form:form modelAttribute="facilitiesType" method="post" action="${url}">
        <p>Mã loại cơ sở vật chất</p> <form:input path="id" id="facilities-type" name="facilities-type"/>
        <p style="color:red;"><form:errors path="id"> </form:errors> </p>

        <p>Tên loại cơ sở vật chất</p> <form:input path="facilitiesTypeName" id="facilities-type" name="facilities-type"/>
        <p style="color:red;"><form:errors path="facilitiesTypeName"> </form:errors> </p>

        <p><p><button type="submit" class="btn btn-sm rounded-pill btn-primary">Thêm</button>
        <button type="button" value="Hủy" class="btn btn-sm rounded-pill btn-danger" onclick="history.go(-1)">Hủy</button>
    </form:form>
    <%@ include file="/WEB-INF/views/inc/scripts.jsp" %>
</body>
</html>