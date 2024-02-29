package com.project_spring.Admin.DAO.Room;

import com.project_spring.Admin.Model.Room;

import java.sql.Blob;
import java.util.List;

public interface IRoomDao {
    boolean addRoom(Room room);

    boolean deleteRoom(int roomId);

    boolean updateRoom(Room room);

    boolean isExistRoom(Room room);

    boolean findRoomByRoomType(int id);

    Room finhRoomById(int id);

    List<Room> displayAllRoom();
    Blob getImageByRoomId(int roomId);
}
