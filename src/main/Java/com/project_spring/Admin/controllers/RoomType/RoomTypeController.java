package com.project_spring.Admin.controllers.RoomType;

import com.project_spring.Admin.Model.RoomType;
import com.project_spring.Admin.Service.RoomType.RoomTypeService;
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
public class RoomTypeController {
    @Autowired
    RoomTypeService roomTypeService;

    @RequestMapping(value = "/danh-sach-loai-phong", method = RequestMethod.GET)
    public String displayAllRoomTypes(HttpServletRequest httpServletRequest) {
        List<RoomType> roomTypes = roomTypeService.displayAllRoomType();
        httpServletRequest.setAttribute("roomTypes", roomTypes);
        return "Admin/RoomType/list-room-type";
    }

    @RequestMapping(value = "/them-loai-phong", method = RequestMethod.GET)
    public String addRoomType(HttpServletRequest httpServletRequest) {
        RoomType roomType = new RoomType();
        httpServletRequest.setAttribute("roomType", roomType);
        return "Admin/RoomType/add-room-type";
    }

    @RequestMapping(value = "/them-loai-phong", method = RequestMethod.POST)
    public String addRoomType(HttpServletRequest httpServletRequest, @ModelAttribute("roomType") @Valid RoomType roomType,
                              BindingResult bindingResult) {
        if(bindingResult.hasErrors()) {
            return "Admin/RoomType/add-room-type";
        }
        boolean result = roomTypeService.addRoomType(roomType);
        return result ? "redirect:/danh-sach-loai-phong" : "Admin/RoomType/add-room-type";
    }

    @RequestMapping(value = "/xoa-loai-phong/roomTypeId={roomTypeId}", method = RequestMethod.GET)
    public String deleteRoomType(HttpServletRequest httpServletRequest, @PathVariable(name="roomTypeId") int roomTypeId) {
        boolean result = roomTypeService.deleteRoomType(roomTypeId);
        return "redirect:/danh-sach-loai-phong";
    }

    @RequestMapping(value = "/sua-loai-phong/roomTypeId={roomTypeId}", method = RequestMethod.GET)
    public String editRoomType(HttpServletRequest httpServletRequest, @PathVariable(name="roomTypeId") int roomTypeId) {
        RoomType roomType = roomTypeService.findRoomTypeById(roomTypeId);
        httpServletRequest.setAttribute("roomType", roomType);
        return "Admin/RoomType/edit-room-type";
    }

    @RequestMapping(value = "/sua-loai-phong", method = RequestMethod.POST)
    public String editRoomType(HttpServletRequest httpServletRequest, @ModelAttribute("roomType") RoomType roomType,
                               BindingResult bindingResult) {
        if(bindingResult.hasErrors()) {
            return "Admin/RoomType/edit-room-type";
        }
        boolean result = roomTypeService.updateRoomType(roomType);
        return result ? "redirect:/danh-sach-loai-phong" : "Admin/RoomType/edit-room-type";
    }
}