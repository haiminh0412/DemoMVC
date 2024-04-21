package com.project_spring.Admin.Service.Product;

import com.project_spring.Admin.DAO.Product.ProductDao;
import com.project_spring.Admin.Model.Product;
import com.project_spring.Admin.Model.Unit;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProductService implements IProductService{
    @Autowired
    ProductDao productDao;


    @Override
    public boolean addProduct(Product product) {
      //  if(isValid(product) && productDao.isExistProdcut(product) == 0) {
            return productDao.addProduct(product);
      //  }
     //   return false;
    }

    @Override
    public boolean deleteProduct(int id) {
        return productDao.deleteProduct(id);
    }

    @Override
    public boolean updateProduct(Product product) {
        List<Product> products = productDao.listAllProduct();
//        for(int i = 0; i < products.size(); ++i) {
//            if(products.get(i).getProductId() != product.getProductId() && products.get(i).getName().equals(product.getName())) {
//                return false;
//            }
//        }
        if(isValid(product)) {
            return productDao.updateProduct(product);
        }
        return false;
    }

    @Override
    public int isExistProdcut(Product product) {
        return productDao.isExistProdcut(product);
    }

    @Override
    public List<Product> listAllProduct() {
        return productDao.listAllProduct();
    }

    @Override
    public Product findProductById(int id) {
        return productDao.findProductById(id);
    }

    private boolean isValid(Product product) {
        return product.getName().length() <= 100 && product.getDescription().length() <= 100 &&
                product.getQuantity() >= 1 &&
                product.getPrice() >= product.getCapitalPrice() && product.getDateAdd().compareTo(product.getExpired()) <= 0;
    }
}
