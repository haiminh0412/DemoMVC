package com.project_spring.Admin.Service.Room;

import com.project_spring.Admin.Model.Room;

import java.sql.Blob;
import java.util.List;

public interface IRoomService {
    boolean addRoom(Room room);

    boolean deleteRoom(int roomId);

    boolean updateRoom(Room room);

    boolean findRoomByRoomType(int id);

    Room finhRoomById(int id);

    boolean isExistRoom(Room room);
    List<Room> displayAllRoom();
    Blob getImageByRoomId(int roomId);
}
