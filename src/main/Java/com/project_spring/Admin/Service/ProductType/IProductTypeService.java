package com.project_spring.Admin.Service.ProductType;

import com.project_spring.Admin.Model.ProductType;

import java.util.List;

public interface IProductTypeService {
    boolean addProductType(ProductType productType);

    boolean deleteProductType(int id);

    boolean updateProductType(ProductType productType);

    int isExistProdcutType(ProductType productType);
    List<ProductType> listAllProductType();
    ProductType findProductTypeById(int id);
}
