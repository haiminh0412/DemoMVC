package com.project_spring.Admin.Model;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotEmpty;

@Entity
@Table(name="roomtype")
public class RoomType {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int roomTypeId;

    @NotEmpty
    @Column
    private String typeName;

    @NotEmpty
    @Column
    private String description;

    public RoomType() {
    }

    public RoomType(int roomTypeId, String typeName, String description) {
        this.roomTypeId = roomTypeId;
        this.typeName = typeName;
        this.description = description;
    }

    public void setRoomTypeId(int roomTypeId) {
        this.roomTypeId = roomTypeId;
    }

    public int getRoomTypeId() {
        return roomTypeId;
    }

    public String getTypeName() {
        return typeName;
    }

    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}