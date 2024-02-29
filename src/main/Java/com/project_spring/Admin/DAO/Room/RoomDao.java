package com.project_spring.Admin.DAO.Room;

import com.project_spring.Admin.Model.Room;
import com.project_spring.Admin.Model.RoomType;
import com.project_spring.Admin.Service.RoomType.RoomTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.sql.Blob;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
public class RoomDao implements IRoomDao {
    @Autowired
    JdbcTemplate jdbcTemplate;

    @Autowired
    RoomTypeService roomTypeService;

    @Override
    public boolean addRoom(Room room) {
        String query = "INSERT INTO ROOM (RoomName, RoomTypeId, Image, PricePerNight, Area, Quantity) VALUES (?, ?, load_file('C:\\\\ProgramData\\\\MySQL\\\\MySQL Server 8.0\\\\Uploads\\\\" + room.getPathImage() + "'), ?, ?, ?)";
        return jdbcTemplate.update(query, room.getRoomName(), room.getRoomType().getRoomTypeId(), room.getPricePerNight(), room.getArea(), room.getQuantity()) > 0;
    }

    @Override
    public boolean deleteRoom(int roomId) {
        String query = "DELETE FROM ROOM WHERE RoomId = ?";
        return jdbcTemplate.update(query, roomId) > 0;
    }

    @Override
    public boolean updateRoom(Room room) {
        String query = "UPDATE Room SET RoomName = ?, PricePerNight = ?, Quantity = ?, RoomTypeId = ?, Area = ?, Image = load_file('C:\\\\ProgramData\\\\MySQL\\\\MySQL Server 8.0\\\\Uploads\\\\" + room.getPathImage() + "'), status = ? WHERE RoomId = ?";
        return jdbcTemplate.update(query, room.getRoomName(), room.getPricePerNight(), room.getQuantity(), room.getRoomTypeId(), room.getArea(), room.getStatus(), room.getRoomId()) > 0;
    }

    @Override
    public boolean isExistRoom(Room room) {
        return false;
    }

    @Override
    public boolean findRoomByRoomType(int id) {
        String query = "SELECT * FROM Room WHERE RoomTypeId = ?";
        return jdbcTemplate.query(query, new Object[]{id}, new RowMapper<Room>() {
            @Override
            public Room mapRow(ResultSet rs, int rowNum) throws SQLException {
                Room room = new Room();
                room.setRoomId(rs.getInt("RoomId"));
                room.setRoomName(rs.getString("RoomName"));
                room.setPricePerNight(rs.getDouble("PricePerNight"));
                room.setArea(rs.getDouble("Area"));
                room.setQuantity(rs.getInt("Quantity"));
                room.setStatus(rs.getString("status"));
                room.setImage(rs.getBytes("Image"));
                room.setRoomTypeId(rs.getInt("RoomTypeId"));
                RoomType roomType = roomTypeService.findRoomTypeById(rs.getInt("RoomTypeId"));
                room.setRoomType(roomType);
                return room;
            }
        }).size() > 0;
    }

    @Override
    public Room finhRoomById(int id) {
        String query = "SELECT * FROM Room WHERE RoomId = ?";
        return jdbcTemplate.queryForObject(query, new Object[]{id}, new RowMapper<Room>() {
            @Override
            public Room mapRow(ResultSet rs, int rowNum) throws SQLException {
                Room room = new Room();
                room.setRoomId(rs.getInt("RoomId"));
                room.setRoomName(rs.getString("RoomName"));
                room.setPricePerNight(rs.getDouble("PricePerNight"));
                room.setArea(rs.getDouble("Area"));
                room.setQuantity(rs.getInt("Quantity"));
                room.setStatus(rs.getString("status"));
                room.setImage(rs.getBytes("Image"));
                room.setRoomTypeId(rs.getInt("RoomTypeId"));
                RoomType roomType = roomTypeService.findRoomTypeById(rs.getInt("RoomTypeId"));
                room.setRoomType(roomType);
                return room;
            }
        });
    }

    @Override
    public List<Room> displayAllRoom() {
        String query = "SELECT * FROM Room";
        return jdbcTemplate.query(query, new Object[]{}, new RowMapper<Room>() {
            @Override
            public Room mapRow(ResultSet rs, int rowNum) throws SQLException {
                Room room = new Room();
                room.setRoomId(rs.getInt("RoomId"));
                room.setRoomName(rs.getString("RoomName"));
                room.setPricePerNight(rs.getDouble("PricePerNight"));
                room.setArea(rs.getDouble("Area"));
                room.setQuantity(rs.getInt("Quantity"));
                room.setStatus(rs.getString("status"));
                room.setImage(rs.getBytes("Image"));
                RoomType roomType = roomTypeService.findRoomTypeById(rs.getInt("RoomTypeId"));
                room.setRoomType(roomType);
                return room;
            }
        });
    }

    @Override
    public Blob getImageByRoomId(int roomId) {
        String query = "SELECT Image FROM Room WHERE RoomId = ?";
        Blob imageRoom = jdbcTemplate.queryForObject(query, new Object[] { roomId }, Blob.class);
        return imageRoom;
    }
}