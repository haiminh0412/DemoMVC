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
    <link rel="stylesheet" href="<c:url value='/resource/css/edit-facilities-type.css'/>">
    <%@ include file="/WEB-INF/views/inc/links.jsp" %>
    <title>Sửa loại cơ sở vật chất</title>
</head>
<body class="bg-white">
    <%@ include file="/WEB-INF/views/inc/header.jsp" %>
    <p>Sửa loại cơ sở vật chất</p>
    <c:url value="/sua-loai-co-so-vat-chat" var="url"/>
    <form:form modelAttribute="facilitiesType" method="post" action="${url}">
        <form:hidden path="id"/>
        <p>Tên loại cơ sở vật chất</p> <form:input path="facilitiesTypeName"/>
        <p style="color:red;"><form:errors path="facilitiesTypeName"> </form:errors> </p>
        <p><p><button type="submit">Sửa</button>
    </form:form>
    <%@ include file="/WEB-INF/views/inc/scripts.jsp" %>
</body>
</html>