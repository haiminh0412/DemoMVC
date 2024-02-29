package com.project_spring.Admin.controllers.FacilitiesType;

import com.project_spring.Admin.Model.FacilitiesType;
import com.project_spring.Admin.Model.RoomType;
import com.project_spring.Admin.Service.FacilitiesType.FacilitiesTypeService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.validation.Valid;
import java.util.List;

@Controller
public class FacilitiesTypeController {
    @Autowired
    FacilitiesTypeService facilitiesTypeService;


    @RequestMapping(value = "/danh-sach-loai-co-so-vat-chat", method = RequestMethod.GET)
    public String displayAllFacilitiesType(HttpServletRequest httpServletRequest) {
        List<FacilitiesType> facilitiesTypes = facilitiesTypeService.displayAllFacilitiesType();
        httpServletRequest.setAttribute("facilitiesTypes", facilitiesTypes);
        return "Admin/FacilitiesType/list-facilities-type";
    }

    @RequestMapping(value = "/them-loai-co-so-vat-chat", method = RequestMethod.GET)
    public String addFacilitiesType(HttpServletRequest httpServletRequest) {
        FacilitiesType facilitiesType = new FacilitiesType();
        httpServletRequest.setAttribute("facilitiesType", facilitiesType);
        return "Admin/FacilitiesType/add-facilities-type";
    }

    @RequestMapping(value = "/them-loai-co-so-vat-chat", method = RequestMethod.POST)
    public String addFacilitiesType(HttpServletRequest httpServletRequest, @ModelAttribute("facilitiesType") @Valid FacilitiesType facilitiesType,
                              BindingResult bindingResult) {
        if(bindingResult.hasErrors()) {
            return "Admin/FacilitiesType/add-facilities-type";
        }
        boolean result = facilitiesTypeService.addFacilitiesType(facilitiesType);
        return result ? "redirect:/danh-sach-loai-co-so-vat-chat" : "Admin/FacilitiesType/add-facilities-type";
    }

    @RequestMapping(value = "/xoa-loai-co-so-vat-chat/id={id}", method = RequestMethod.GET)
    public String deleteFacilitiesType(HttpServletRequest httpServletRequest, @PathVariable(name="id") String id) {
        boolean result = facilitiesTypeService.deleteFacilitiesType(id);
        if(!result) {
            return "Admin/Error/message-error-delete";

        }
        return "redirect:/danh-sach-loai-co-so-vat-chat";
    }

    @RequestMapping(value = "/sua-loai-co-so-vat-chat/id={id}", method = RequestMethod.GET)
    public String editFacilitiesType(HttpServletRequest httpServletRequest, @PathVariable(name="id") String id) {
        FacilitiesType facilitiesType = facilitiesTypeService.findFacilitiesTypeById(id);
        httpServletRequest.setAttribute("facilitiesType", facilitiesType);
        return "Admin/FacilitiesType/edit-facilities-type";
    }


    @RequestMapping(value = "/sua-loai-co-so-vat-chat", method = RequestMethod.POST)
    public String editFacilitiesType(HttpServletRequest httpServletRequest, @ModelAttribute("facilitiesType") FacilitiesType facilitiesType,
                                     BindingResult bindingResult) {
        if(bindingResult.hasErrors()) {
            return "Admin/FacilitiesType/edit-facilities-type";
        }
        boolean result = facilitiesTypeService.updateFacilitiesType(facilitiesType);
        return result ? "redirect:/danh-sach-loai-co-so-vat-chat" : "Admin/FacilitiesType/edit-facilities-type";
    }
}