package com.project_spring.Admin.Service.Unit;

import com.project_spring.Admin.DAO.Unit.UnitDao;
import com.project_spring.Admin.Model.ProductType;
import com.project_spring.Admin.Model.Unit;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UnitService implements IUnitService {
    @Autowired
    UnitDao unitDao;

    @Override
    public boolean addUnit(Unit unit){
        if(isValid(unit) && unitDao.isExistUnit(unit) == 0) {
            return unitDao.addUnit(unit);
        }
        return false;
    }

    @Override
    public boolean deleteUnit(int id) {
        if(unitDao.isDeleted(id) == 0) {
            return unitDao.deleteUnit(id);
        }
        return false;
    }

    @Override
    public boolean updateUnit(Unit unit) {
        List<Unit> units = unitDao.listAllUnit();
        for(int i = 0; i < units.size(); ++i) {
            if(units.get(i).getUnitId() != unit.getUnitId() && units.get(i).getName().equals(unit.getName())) {
                return false;
            }
        }
        if(isValid(unit)) {
            return unitDao.updateUnit(unit);
        }
        return false;
    }

    @Override
    public int isExistUnit(Unit unit) {
        return unitDao.isExistUnit(unit);
    }

    @Override
    public List<Unit> listAllUnit() {
        return unitDao.listAllUnit();
    }

    @Override
    public Unit findUnitById(int id) {
        return unitDao.findUnitById(id);
    }

    private boolean isValid(Unit unit) {
        return  unit.getName().length() <= 100 && unit.getDescription().length() <= 100;
    }
}
