package com.project_spring.Admin.controllers.ProductType;

import com.project_spring.Admin.Model.ProductType;
import com.project_spring.Admin.Model.Unit;
import com.project_spring.Admin.Service.ProductType.ProductTypeService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
public class ProductTypeController {
    @Autowired
    ProductTypeService productTypeService;

    @GetMapping(value = "/list-product-type")
    public @ResponseBody ResponseEntity<?> listAllProductTypeAPI() {
        try {
            List<ProductType> productTypes = productTypeService.listAllProductType();
            return ResponseEntity.ok(productTypes);
        } catch (Exception e) {
            // Xử lý ngoại lệ
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Xay ra loi: " + e.getMessage());
        }
    }

//    @GetMapping(value = "/list-product-type")
//    public @ResponseBody List<ProductType> listAllProductTypeAPI() {
//        List<ProductType> productTypes = productTypeService.listAllProductType();
//        return productTypes;
//    }

    @GetMapping(value = "/find-product-type/productTypeId={productTypeId}")
    public @ResponseBody ProductType findProductTypeAPI(@PathVariable("productTypeId") int productTypeId) {
        ProductType productType = productTypeService.findProductTypeById(productTypeId);
        return productType;
    }

    @GetMapping(value = "/danh-sach-loai-san-pham")
    public String listAllUnit() {
        return "Admin/ProductType/list-product-type";
    }

//    @DeleteMapping(value = "/xoa-loai-san-pham/productTypeId={productTypeId}")
//    public @ResponseBody ProductType deleteProductTypeAPI(@PathVariable("productTypeId") int productTypeId) {
//        ProductType productType = productTypeService.findProductTypeById(productTypeId);
//        productTypeService.deleteProductType(productTypeId);
//        productType.setProductTypeId(productTypeId);
//        return productType;
//    }

    @DeleteMapping(value = "/xoa-loai-san-pham/productTypeId={productTypeId}")
    public @ResponseBody ResponseEntity<?> deleteProductTypeAPI(@PathVariable("productTypeId") int productTypeId) {
        try {
            ProductType productType = productTypeService.findProductTypeById(productTypeId);
            productType.setProductTypeId(productTypeId);
            if(productTypeService.deleteProductType(productTypeId)) {
                return ResponseEntity.ok(productType);
            }
            return new ResponseEntity<>(productType, HttpStatus.NO_CONTENT);
        } catch (Exception e) {
            // Xử lý ngoại lệ
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Xay ra loi: " + e.getMessage());
        }
    }


    @GetMapping(value = "/them-loai-san-pham")
    public String addProductType() {
        return "Admin/ProductType/add-product-type";
    }

//    @PostMapping(value = "/add-product-type")
//    public @ResponseBody ProductType addProductTypeAPI(@RequestBody ProductType productType) {
//        productTypeService.addProductType(productType);
//        return productType;
//    }

    @PostMapping(value = "/add-product-type")
    public @ResponseBody ResponseEntity<?> addProductTypeAPI(@RequestBody ProductType productType) {
        try {
            if(productTypeService.addProductType(productType)) {
                return ResponseEntity.ok(productType);
            }
            return new ResponseEntity<>(productType, HttpStatus.BAD_REQUEST);
        } catch (Exception e) {
            // Xử lý ngoại lệ
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Xay ra loi: " + e.getMessage());
        }
    }


    @GetMapping(value = "/sua-loai-san-pham/productTypeId={productTypeId}")
    public String editProductType(HttpServletRequest httpServletRequest, @PathVariable("productTypeId") int productTypeId) {
        ProductType productType = productTypeService.findProductTypeById(productTypeId);
        httpServletRequest.setAttribute("productType", productType);
        return "Admin/ProductType/edit-product-type";
    }

//    @PutMapping(value = "/edit-product-type/productTypeId={productTypeId}")
//    public @ResponseBody ProductType editProductTypeAPI(@PathVariable("productTypeId") int productTypeId, @RequestBody ProductType productType) {
//        productType.setProductTypeId(productTypeId);
//        productTypeService.updateProductType(productType);
//        return productType;
//    }

    @PutMapping(value = "/edit-product-type/productTypeId={productTypeId}")
    public @ResponseBody ResponseEntity<?> editProductTypeAPI(@PathVariable("productTypeId") int productTypeId, @RequestBody ProductType productType) {
        try {
            productType.setProductTypeId(productTypeId);
            if(productTypeService.updateProductType(productType)) {
                return ResponseEntity.ok(productType);
            }
            return new ResponseEntity<>(productType, HttpStatus.BAD_REQUEST);
        } catch (Exception e) {
            // Xử lý ngoại lệ
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Xay ra loi: " + e.getMessage());
        }
    }
}
