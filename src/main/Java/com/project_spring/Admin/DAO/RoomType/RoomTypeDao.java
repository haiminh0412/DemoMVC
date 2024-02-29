package com.project_spring.Admin.DAO.RoomType;

import com.project_spring.Admin.Model.RoomType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
public class RoomTypeDao implements IRoomTypeDao {
    @Autowired
    JdbcTemplate jdbcTemplate;

    @Override
    public boolean addRoomType(RoomType roomType) {
        String query = "INSERT INTO RoomType(TypeName, Description) VALUE(?, ?)";
        return jdbcTemplate.update(query, roomType.getTypeName(), roomType.getDescription()) > 0;
    }

    @Override
    public boolean deleteRoomType(int roomTypeId) {
        String query = "DELETE FROM RoomType WHERE RoomTypeId = ?";
        return jdbcTemplate.update(query, roomTypeId) > 0;
    }

    @Override
    public boolean updateRoomType(RoomType roomType) {
        String query = "UPDATE RoomType SET TypeName = ?, Description = ? WHERE RoomTypeId = ?";
        return jdbcTemplate.update(query, roomType.getTypeName(), roomType.getDescription(), roomType.getRoomTypeId()) > 0;
    }

    @Override
    public boolean isExistRoomType(RoomType roomType) {
        return false;
    }

    @Override
    public List<RoomType> displayAllRoomType() {
        String query = "SELECT * FROM roomtype";
        List<RoomType> roomTypes = jdbcTemplate.query(query, new Object[]{}, new RowMapper<RoomType>() {
            @Override
            public RoomType mapRow(ResultSet rs, int rowNum) throws SQLException {
                RoomType roomType = new RoomType();
                roomType.setRoomTypeId(rs.getInt("RoomTypeId"));
                roomType.setTypeName(rs.getString("TypeName"));
                roomType.setDescription(rs.getString("Description"));
                return roomType;
            }
        });
        return roomTypes;
    }

    @Override
    public RoomType findRoomTypeById(int id) {
        String query = "SELECT * FROM roomtype WHERE RoomTypeId = ?";
//        return jdbcTemplate.queryForObject(query, new Object[] {id}, new RowMapper<RoomType>() {
//            @Override
//            public RoomType mapRow(ResultSet rs, int rowNum) throws SQLException {
//                RoomType roomType = new RoomType();
//                roomType.setRoomTypeId(rs.getInt("RoomTypeId"));
//                roomType.setTypeName(rs.getString("TypeName"));
//                roomType.setDescription(rs.getString("Description"));
//                return roomType;
//            }
//        });
         RoomType roomType = jdbcTemplate.queryForObject(query,new Object[] {id}, new BeanPropertyRowMapper<>(RoomType.class));
         return roomType;
    }
}