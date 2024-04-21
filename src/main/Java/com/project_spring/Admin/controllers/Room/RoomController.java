package com.project_spring.Admin.controllers.Room;

import com.project_spring.Admin.Model.*;
import com.project_spring.Admin.Service.Room.RoomService;
import com.project_spring.Admin.Service.RoomType.RoomTypeService;
import com.project_spring.Admin.Validator.RoomValidator;
import jakarta.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.Base64;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class RoomController {
    @Autowired
    RoomService roomService;

    @Autowired
    RoomTypeService roomTypeService;

    @Autowired
    RoomValidator roomValidator;

    @GetMapping(value = "/list-room")
    public @ResponseBody ResponseEntity<?> listAllRoomAPI() {
        try {
            List<Room> rooms = roomService.displayAllRoom();
            return ResponseEntity.ok(rooms);
        } catch (Exception e) {
            // Xử lý ngoại lệ
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Xay ra loi: " + e.getMessage());
        }
    }

    @DeleteMapping(value="/xoa-phong/id={id}")
    public  @ResponseBody ResponseEntity<?> deleteRoomAPI( @PathVariable(name="id") int id) {
        Room room = roomService.finhRoomById(id);
        roomService.deleteRoom(id);
        return ResponseEntity.ok(room);
    }

    @PostMapping(value = "/add-room")
    public @ResponseBody ResponseEntity<?> addRoomAPI(@RequestBody Room room) {
        try {
            roomService.addRoom(room);
            return ResponseEntity.ok(room);
        } catch (Exception e) {
            // Xử lý ngoại lệ
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Xay ra loi: " + e.getMessage());
        }
    }

    @RequestMapping(value = "/danh-sach-phong", method = RequestMethod.GET)
    public String displayAllRooms(HttpServletRequest httpServletRequest) {
        List<Room> rooms = roomService.displayAllRoom();

        httpServletRequest.setAttribute("rooms", rooms);
//        httpServletRequest.setAttribute("base64_RoomImage", base64Image);

        return "Admin/Room/list-room";
    }

    @RequestMapping(value = "/them-phong", method = RequestMethod.GET)
    public String addRoom(HttpServletRequest httpServletRequest) {
        Room room = new Room();
        httpServletRequest.setAttribute("room", room);

        List<RoomType> roomTypes = roomTypeService.displayAllRoomType();
        httpServletRequest.setAttribute("roomTypes", roomTypes);

        return "Admin/Room/add-room";
    }

    @RequestMapping(value = "/them-phong", method = RequestMethod.POST)
    public String addRoom(HttpServletRequest httpServletRequest, @ModelAttribute("room") @Valid Room room,
                                BindingResult bindingResult) throws Exception {
      //  roomValidator.validate(room, bindingResult);
//        if(bindingResult.hasErrors()) {
//            return "Admin/Room/add-room";
//        }

        RoomType roomType = roomTypeService.findRoomTypeById(room.getRoomTypeId());
        room.setRoomType(roomType);
        boolean result = roomService.addRoom(room);
        return result ? "redirect:/danh-sach-phong" : "Admin/Room/add-room";
    }

    @RequestMapping(value = "/xoa-phong/id={id}", method = RequestMethod.GET)
    public String deleteRoom(HttpServletRequest httpServletRequest, @PathVariable(name="id") int id) {
        boolean result = roomService.deleteRoom(id);
        return "redirect:/danh-sach-phong";
    }

    @RequestMapping(value = "/sua-phong/id={id}", method = RequestMethod.GET)
    public String editFacilities(HttpServletRequest httpServletRequest, @PathVariable(name="id") int id) {
        Room room = roomService.finhRoomById(id);
        RoomType roomType = roomTypeService.findRoomTypeById(room.getRoomTypeId());
        room.setRoomType(roomType);
        httpServletRequest.setAttribute("room", room);

        List<RoomType> roomTypes = roomTypeService.displayAllRoomType();
        httpServletRequest.setAttribute("roomTypes", roomTypes);

        return "Admin/Room/edit-room";
    }

    @RequestMapping(value = "/sua-phong", method = RequestMethod.POST)
    public String editRoom(HttpServletRequest httpServletRequest, @ModelAttribute("room") Room room,
                                 BindingResult bindingResult) {
        if(bindingResult.hasErrors()) {
            return "Admin/Room/edit-room";
        }
        boolean result = roomService.updateRoom(room);
        return "redirect:/danh-sach-phong";
    }


}