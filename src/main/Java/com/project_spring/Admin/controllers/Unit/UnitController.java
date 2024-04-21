package com.project_spring.Admin.controllers.Unit;

import com.project_spring.Admin.Model.ProductType;
import com.project_spring.Admin.Model.Unit;
import com.project_spring.Admin.Service.Unit.UnitService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
public class UnitController {
    @Autowired
    UnitService unitService;

    @GetMapping(value = "/list-unit")
    public @ResponseBody ResponseEntity<?> listAllUnitAPI() {
        try {
            List<Unit> units = unitService.listAllUnit();
            return ResponseEntity.ok(units);
        } catch (Exception e) {
            // Xử lý ngoại lệ
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Xay ra loi: " + e.getMessage());
        }
    }

//    @GetMapping(value = "/list-unit")
//    public @ResponseBody List<Unit> listAllUnitAPI() {
//        List<Unit> units = unitService.listAllUnit();
//        return units;
//    }

    @GetMapping(value = "/find-unit/unitId={unitId}")
    public @ResponseBody Unit findUnitAPI(@PathVariable("unitId") int unitId) {
        Unit unit = unitService.findUnitById(unitId);
        return unit;
    }

    @GetMapping(value = "/danh-sach-loai-don-vi")
    public String listAllUnit() {
        return "Admin/Unit/list-unit";
    }


    @DeleteMapping(value = "/xoa-don-vi/unitId={unitId}")
    public @ResponseBody ResponseEntity<?> deleteUnitAPI(@PathVariable("unitId") int unitId) {
        try {
            Unit unit = unitService.findUnitById(unitId);
            unit.setUnitId(unitId);
            if(unitService.deleteUnit(unitId)) {
                return ResponseEntity.ok(unit);
            }
            // tra ve status 204 No Content: Yêu cầu xóa thành công và không có dữ liệu nào được trả về.
            return new ResponseEntity<>(unit, HttpStatus.NO_CONTENT);

        } catch (Exception e) {
            // Xử lý ngoại lệ
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Xay ra loi: " + e.getMessage());
        }
    }

//    @DeleteMapping(value = "/xoa-don-vi/unitId={unitId}")
//    public @ResponseBody Unit deleteUnitAPI(@PathVariable("unitId") int unitId) {
//        Unit unit = unitService.findUnitById(unitId);
//        unit.setUnitId(unitId);
//        unitService.deleteUnit(unitId);
//        return unit;
//    }


    @GetMapping(value = "/them-don-vi")
    public String addUnit() {
        return "Admin/Unit/add-unit";
    }

    @PostMapping(value = "/add-unit")
    public @ResponseBody ResponseEntity<?> addUnitAPI(@RequestBody Unit unit) {
        try {
            if(unitService.addUnit(unit)) {
                return new ResponseEntity<>(unit, HttpStatus.OK);
            }
            return new ResponseEntity<>(unit, HttpStatus.BAD_REQUEST);
        } catch (Exception e) {
            // Xử lý ngoại lệ
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Xay ra loi: " + e.getMessage());
        }
    }

//    @PostMapping(value = "/add-unit")
//    public @ResponseBody Unit addUnitAPI(@RequestBody Unit unit) {
//        unitService.addUnit(unit);
//        return unit;
//    }

    @GetMapping(value = "/sua-don-vi/unitId={unitId}")
    public String editUnit(HttpServletRequest httpServletRequest, @PathVariable("unitId") int unitId) {
        Unit unit = unitService.findUnitById(unitId);
        httpServletRequest.setAttribute("unit", unit);
        return "Admin/Unit/edit-unit";
    }

    @PutMapping(value = "/edit-unit/unitId={unitId}")
    public @ResponseBody ResponseEntity<?> editUnitAPI(@PathVariable("unitId") int unitId, @RequestBody Unit unit) {
        try {
            unit.setUnitId(unitId);
            if(unitService.updateUnit(unit)) {
                return ResponseEntity.ok(unit);
            }
            return new ResponseEntity<>(unit, HttpStatus.BAD_REQUEST);
        } catch (Exception e) {
            // Xử lý ngoại lệ
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Xay ra loi: " + e.getMessage());
        }
    }

//    @PutMapping(value = "/edit-unit/unitId={unitId}")
//    public @ResponseBody Unit editUnitAPI(@PathVariable("unitId") int unitId, @RequestBody Unit unit) {
//        unit.setUnitId(unitId);
//        unitService.updateUnit(unit);
//        return unit;
//    }
}