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
    <title>Sửa đơn vị</title>
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

       // Chuyển đổi giá trị số sang kiểu số nguyên
       const id = parseInt(parameterValue);

        const API_URL = 'http://localhost:8080/DemoMVC/find-unit/unitId='+id;
        $.getJSON(API_URL, function(unit) {
            // Gán các giá trị thuộc tính của productType vào các biến riêng
            var unitId = unit.unitId;
            var unitName = unit.name;
            var unitDescription = unit.description;

            // Gán giá trị vào các trường input trên form
           document.getElementById("name").value = unit.name;
           document.getElementById("description").value = unit.description;
        });
    });
</script>

<body class="bg-white">
    <%@ include file="/WEB-INF/views/inc/header.jsp" %>
    <div class="container-fluid" id="main-content">
        <div class="row">
            <div class="col-lg-10 ms-auto p-4 overflow-hidden">
                <h3 class="mb-4">Sửa đơn vị</h3>

                <form id="editUnitForm">
                    <div class="form-group">
                        <label for="name">Tên đơn vị:</label>
                        <input type="text" class="form-control" id="name" name="name">
                    </div>
                    <div class="form-group">
                        <label for="description">Mô tả:</label>
                        <input type="text" class="form-control" id="description" name="description">
                    </div>
                    <button type="button" class="btn btn-primary" onclick="editUnit()">Xác nhận sửa</button>
                    <button type="button" class="btn btn-sm rounded-pill btn-danger" onclick="history.go(-1)">Hủy</button>
                </form>
            </div>
        </div>
    </div>

<script>
    function editUnit() {
        var name = $("#name").val();
        var description = $("#description").val();
        var unitId = "<c:out value='${unit.unitId}'/>";

         if(name.length == 0) {
           alert("Vui lòng không để trống");
           return;
         }

        var unitData = {
            "name": name,
            "description": description
        };

        // Thay đổi đường dẫn API và phương thức HTTP tương ứng thành PUT
        axios.put('http://localhost:8080/DemoMVC/edit-unit/unitId=' + unitId, unitData)
            .then(function (response) {
                console.log(response.data);
                alert("Sửa đơn vị thành công!");
                window.location.href = 'http://localhost:8080/DemoMVC/danh-sach-loai-don-vi';
                // Redirect or update UI as needed
            })
            .catch(function (error) {
                console.log(error);
                alert("Sửa đơn vị không thành công!");
            });
    }
</script>


    <%@ include file="/WEB-INF/views/inc/scripts.jsp" %>
</body>
</html>
