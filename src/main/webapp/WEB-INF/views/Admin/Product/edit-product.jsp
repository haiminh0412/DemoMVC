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
    <title>Sửa sản phẩm</title>
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

<body class="bg-white">
    <%@ include file="/WEB-INF/views/inc/header.jsp" %>
    <div class="container-fluid" id="main-content">
        <div class="row">
            <div class="col-lg-10 ms-auto p-4 overflow-hidden">
                <h3 class="mb-4">Sửa sản phẩm</h3>

                <form id="addProductForm">
                    <div class="form-group">
                        <label for="name">Tên sản phẩm:</label>
                        <input type="text" class="form-control" id="name" name="name">
                    </div>
                    <div class="form-group">
                          <label for="productType">Loại sản phẩm:</label>
                          <select class="form-control" id="productType" name="productType" >
                             <option selected>${product.producType.name}</option>
                              <c:forEach items="${productTypes}" var="productType">
                                  <option value="${productType.productTypeId}">${productType.name}</option>
                              </c:forEach>
                          </select>
                    </div>
                    <div class="form-group">
                      <label for="unit">Đơn vị tính:</label>
                      <select class="form-control" id="unit" name="unit">
                          <option selected>${product.unit.name}</option>
                          <c:forEach items="${units}" var="unit">
                              <option value="${unit.unitId}">${unit.name}</option>
                          </c:forEach>
                      </select>
                    </div>
                    <div class="form-group">
                        <label for="dateAdd">Ngày thêm:</label>
                        <input type="date" class="form-control" id="dateAdd" name="dateAdd" value="<c:out value='${product.dateAdd}'/>">
                    </div>
                    <div class="form-group">
                        <label for="expired">Ngày hết hạn:</label>
                        <input type="date" class="form-control" id="expired" name="expired" value="<c:out value='${product.expired}'/>">
                    </div>
                    <div class="form-group">
                        <label for="quantity">Số lượng:</label>
                        <input type="number" class="form-control" id="quantity" name="quantity" min = "1">
                    </div>
                    <div class="form-group">
                        <label for="price">Giá bán:</label>
                        <input type="number" class="form-control" id="price" name="price" min = "1">
                    </div>
                    <div class="form-group">
                        <label for="capitalPrice">Giá vốn:</label>
                        <input type="number" class="form-control" id="capitalPrice" name="capitalPrice" min = "1">
                    </div>
                    <div class="form-group">
                        <label for="status">Trạng thái:</label>
                        <select class="form-control" id="status" name="status">
                            <option value="Bán">Bán</option>
                            <option value="Ngừng bán">Ngừng bán</option>
                            <!-- Thêm các trạng thái khác nếu cần -->
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="description">Mô tả:</label>
                        <textarea class="form-control" id="description" name="description"> /> </textarea>
                    </div>

                    <button type="button" class="btn btn-primary" onclick="editProduct()">Xác nhận sửa</button>
                    <button type="button" value="Hủy" class="btn btn-sm rounded-pill btn-danger" onclick="history.go(-1)">Hủy</button>
                </form>
            </div>
        </div>
    </div>

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

        const API_URL = 'http://localhost:8080/DemoMVC/find-product/productId=' + id;
        $.getJSON(API_URL, function(product) {
            // Gán giá trị vào các trường input trên form
            document.getElementById("name").value = product.name;
            document.getElementById("productType").value = product.productType.name;
            document.getElementById("unit").value = product.unit.name;
            document.getElementById("quantity").value = product.quantity;
            document.getElementById("price").value = product.price;
            document.getElementById("capitalPrice").value = product.capitalPrice;
            document.getElementById("status").value = product.status;
            document.getElementById("description").value = product.description;
        });
    });

    function editProduct() {
        const productId = "<c:out value='${product.productId}'/>";
        const name = $("#name").val();
        const productTypeId = $("#productType").val();
        const unitId = $("#unit").val();
        const dateAdd = $("#dateAdd").val();
        const expired = $("#expired").val();
        const quantity = $("#quantity").val();
        const price = $("#price").val();
        const capitalPrice = $("#capitalPrice").val();
        const status = $("#status").val();
        const description = $("#description").val();

        if(name.length == 0) {
            alert("Vui lòng không để trống");
            return;
        }

        if(quantity <= 0) {
            alert("Số lượng phải lớn hơn 0");
            return;
        }

        // Kiểm tra giá và giá vốn không âm
        if (price <= 0 || capitalPrice <= 0) {
            alert("Giá bán và giá vốn phải là số không âm.");
            return;
        }

        if(price <= capitalPrice) {
            alert("Giá bán phải lớn hơn giá vốn");
            return;
        }

        // Kiểm tra ngày hết hạn phải sau ngày thêm
        if (dateAdd >= expired) {
            alert("Ngày hết hạn phải sau ngày thêm.");
            return;
        }

        const IDUNIT = "<c:out value='${product.unit.unitId}'/>";

        // Lấy thông tin đơn vị từ API
        const unitAPI = 'http://localhost:8080/DemoMVC/find-unit/unitId=' + IDUNIT;
        $.getJSON(unitAPI, function(unitData) {
            // Tạo đối tượng unit từ dữ liệu API
            var unit = {
                "unitId": unitData.unitId,
                "name": unitData.name,
                "description": unitData.description
            };

             const IDPRODUCTYPE = "<c:out value='${product.productType.productTypeId}'/>";

            // Lấy thông tin loại sản phẩm từ API
            const productTypeAPI = 'http://localhost:8080/DemoMVC/find-product-type/productTypeId=' + IDPRODUCTYPE;
            $.getJSON(productTypeAPI, function(productTypeData) {
                // Tạo đối tượng productType từ dữ liệu API
                var productType = {
                    "productTypeId": productTypeData.productTypeId,
                    "name":  productTypeData.name,
                    "description": productTypeData.description
                };


                // Tạo đối tượng product với thông tin đã lấy được
                var productData = {
                    "name": name,
                    "producType": productType,
                    "unit": unit,
                    "dateAdd": dateAdd,
                    "expired": expired,
                    "quantity": quantity,
                    "price": price,
                    "capitalPrice": capitalPrice,
                    "status": status,
                    "description": description
                };


                // Gửi yêu cầu POST để thêm sản phẩm mới
                axios.put('http://localhost:8080/DemoMVC/edit-product/productId=' + productId, productData)
                    .then(function (response) {
                        console.log(response.data);
                        alert("Sửa thành công!");
                        window.location.href = 'http://localhost:8080/DemoMVC/danh-sach-san-pham';
                    })
                    .catch(function (error) {
                        console.log(error);
                        alert("Lỗi xảy ra khi sửa!");
                    });
            });
        });
    }


    var usedNames = {};
    $("select > option").each(function () {
        if(usedNames[this.text]) {
            $(this).remove();
        } else {
            usedNames[this.text] = this.value;
        }
    });
</script>

    <%@ include file="/WEB-INF/views/inc/scripts.jsp" %>
</body>
</html>
