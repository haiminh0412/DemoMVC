package com.project_spring.Admin.Model;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;

public class Room {
    private int roomId;
    private String roomName;
    private RoomType roomType;
    private byte[] image;
    private double pricePerNight;
    private double area;
    private int quantity;
    private String status;
    private int roomTypeId;

    private String pathImage;

    public Room() {
    }

    public Room(int roomId, String roomName, RoomType roomType, byte[] image, double pricePerNight, double area, int quantity, String status, int roomTypeId) {
        this.roomId = roomId;
        this.roomName = roomName;
        this.roomType = roomType;
        this.image = image;
        this.pricePerNight = pricePerNight;
        this.area = area;
        this.quantity = quantity;
        this.status = status;
        this.roomTypeId = roomTypeId;
    }

    public int getRoomId() {
        return roomId;
    }

    public void setRoomId(int roomId) {
        this.roomId = roomId;
    }

    public String getRoomName() {
        return roomName;
    }

    public void setRoomName(String roomName) {
        this.roomName = roomName;
    }

    public double getPricePerNight() {
        return pricePerNight;
    }

    public void setPricePerNight(double pricePerNight) {
        this.pricePerNight = pricePerNight;
    }

    public double getArea() {
        return area;
    }

    public void setArea(double area) {
        this.area = area;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public byte[] getImage() {
        return image;
    }

    public void setImage(byte[] image) {
        this.image = image;
    }

    public RoomType getRoomType() {
        return roomType;
    }

    public int getRoomTypeId() {
        return roomTypeId;
    }

    public void setRoomTypeId(int roomTypeId) {
        this.roomTypeId = roomTypeId;
    }

    public String getPathImage() {
        return pathImage;
    }

    public void setPathImage(String pathImage) {
        this.pathImage = pathImage;
    }

    @Bean
    @Autowired
    public void setRoomType(RoomType roomType) {
        this.roomType = roomType;
    }
}