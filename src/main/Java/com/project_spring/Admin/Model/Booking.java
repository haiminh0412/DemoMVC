package com.project_spring.Admin.Model;

import java.sql.Date;

public class Booking {
    private int bookingId;
    private int customerId;
    private Customer customer;
    private int roomId;
    private Room room;
    private Date checkIn;
    private Date checkOut;
    private int numberOfPeople;
    private String requiredSpecial;
    private String totalAmount;
    private String status;
    private String PaymentStatus;

    public Booking() {
    }

    public Booking(int bookingId, int customerId, Customer customer, int roomId, Room room, Date checkIn, Date checkOut, int numberOfPeople, String requiredSpecial, String totalAmount, String status, String paymentStatus) {
        this.bookingId = bookingId;
        this.customerId = customerId;
        this.customer = customer;
        this.roomId = roomId;
        this.room = room;
        this.checkIn = checkIn;
        this.checkOut = checkOut;
        this.numberOfPeople = numberOfPeople;
        this.requiredSpecial = requiredSpecial;
        this.totalAmount = totalAmount;
        this.status = status;
        PaymentStatus = paymentStatus;
    }

    public int getBookingId() {
        return bookingId;
    }

    public void setBookingId(int bookingId) {
        this.bookingId = bookingId;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    public int getRoomId() {
        return roomId;
    }

    public void setRoomId(int roomId) {
        this.roomId = roomId;
    }

    public Room getRoom() {
        return room;
    }

    public void setRoom(Room room) {
        this.room = room;
    }

    public Date getCheckIn() {
        return checkIn;
    }

    public void setCheckIn(Date checkIn) {
        this.checkIn = checkIn;
    }

    public Date getCheckOut() {
        return checkOut;
    }

    public void setCheckOut(Date checkOut) {
        this.checkOut = checkOut;
    }

    public int getNumberOfPeople() {
        return numberOfPeople;
    }

    public void setNumberOfPeople(int numberOfPeople) {
        this.numberOfPeople = numberOfPeople;
    }

    public String getRequiredSpecial() {
        return requiredSpecial;
    }

    public void setRequiredSpecial(String requiredSpecial) {
        this.requiredSpecial = requiredSpecial;
    }

    public String getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(String totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getPaymentStatus() {
        return PaymentStatus;
    }

    public void setPaymentStatus(String paymentStatus) {
        PaymentStatus = paymentStatus;
    }
}