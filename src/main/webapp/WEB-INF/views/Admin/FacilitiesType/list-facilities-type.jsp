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
    <title>Quản lý khách sạn</title>
    <%@ include file="/WEB-INF/views/inc/links.jsp" %>
</head>
<body class="bg-white">
    <%@ include file="/WEB-INF/views/inc/header.jsp" %>
    <div class="container-fluid" id="main-content">
        <div class="row">
            <div class="col-lg-10 ms-auto p-4 overflow-hidden">
                <h3 class="mb-4">Quản lý loại cơ sở vật chất</h3>

                <div class="card border-0 shadow-sm mb-4">
                    <div class="card-body">

                        <div class="text-end mb-4">
                            <c:url var="urlAddFacilitiesType" value="/them-loai-co-so-vat-chat"/>
                            <a href="${urlAddFacilitiesType}" class="btn btn-success rounded-pill shadow-none btn-sm">
                               Thêm loại cơ sở vật chất
                            </a>
                        </div>

                        <div class="table-responsive-md" style="height: 450px; overflow-y: scroll; overflow-x:scroll;">
                             <!-- Bảng loại cơ sở vật chất -->
                            <table class="table bg-white table-hover border">
                                <thead class="sticky-top">
                                    <tr class="bg-dark text-light">
                                    <th>Mã loại cơ sở vật chất</th>
                                    <th>Tên loại  cơ sở vật chất</th>
                                    <th></th>
                                    <th></th>
                                    </tr>
                                </thead>
                                   <c:forEach var="facilitiesType" items="${facilitiesTypes}">
                                        <tr>
                                            <td>${facilitiesType.id}</td>
                                            <td>${facilitiesType.facilitiesTypeName}</td>
                                            <th><a href="<c:url value='/xoa-loai-co-so-vat-chat/id=${facilitiesType.id}'/>" class="btn btn-sm rounded-pill btn-danger" onclick="return confirmDelete();"/>Xóa</th>
                                            <th><a href="<c:url value='/sua-loai-co-so-vat-chat/id=${facilitiesType.id}'/>" class="btn btn-sm rounded-pill btn-primary"/>Sửa</th>
                                        </tr>
                                   </c:forEach>
                            </table>
                        </div>
                    </div>
                </div>

       <script>
            function confirmDelete() {
            var result = confirm('Cảnh Báo : Nếu bạn đồng ý xóa đồng nghĩa bạn sẽ xóa các phòng có loại phòng này!Bạn có đồng ý?');
            if (result === true) {
                window.location.href = "list-facilities-type.jsp";
                return true;
            } else {
                return false;
            }
        }
       </script>
    <%@ include file="/WEB-INF/views/inc/scripts.jsp" %>
</body>
</html>