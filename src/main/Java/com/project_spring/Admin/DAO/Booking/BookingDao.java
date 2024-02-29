package com.project_spring.Admin.DAO.Booking;

import com.project_spring.Admin.Model.Booking;

import java.util.List;

public class BookingDao implements IBookingDao{

    @Override
    public boolean addBooking(Booking booking) {
        return false;
    }

    @Override
    public boolean deleteBooking(int id) {
        return false;
    }

    @Override
    public boolean updateBooking(Booking booking) {
        return false;
    }

    @Override
    public List<Booking> displayAllBooking() {
        return null;
    }

    @Override
    public Booking findBookingById(int id) {
        return null;
    }
}
