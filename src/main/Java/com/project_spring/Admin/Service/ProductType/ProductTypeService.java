package com.project_spring.Admin.Service.ProductType;

import com.project_spring.Admin.DAO.ProductType.ProductTypeDao;
import com.project_spring.Admin.Model.Product;
import com.project_spring.Admin.Model.ProductType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProductTypeService implements IProductTypeService{
    @Autowired
    ProductTypeDao productTypeDao;

    @Override
    public boolean addProductType(ProductType productType) {
        if(isValid(productType) && productTypeDao.isExistProdcutType(productType) == 0) {
            return productTypeDao.addProductType(productType);
        }
        return false;
    }

    @Override
    public boolean deleteProductType(int id) {
        if(productTypeDao.isDeleted(id) == 0) {
            return productTypeDao.deleteProductType(id);
        }
        return false;
    }

    public boolean updateProductType(ProductType productType) {
        List<ProductType> productTypes = productTypeDao.listAllProductType();
        for(int i = 0; i < productTypes.size(); ++i) {
            if(productTypes.get(i).getProductTypeId() != productType.getProductTypeId() && productTypes.get(i).getName().equals(productType.getName())) {
                return false;
            }
        }
        if(isValid(productType)) {
            return productTypeDao.updateProductType(productType);
        }
        return false;
    }

    @Override
    public int isExistProdcutType(ProductType productType) {
        return productTypeDao.isExistProdcutType(productType);
    }

    @Override
    public List<ProductType> listAllProductType() {
        return productTypeDao.listAllProductType();
    }

    @Override
    public ProductType findProductTypeById(int id) {
        return productTypeDao.findProductTypeById(id);
    }

    private boolean isValid(ProductType productType) {
        return productType.getName().length() <= 100 && productType.getDescription().length() <= 100;
    }
}
