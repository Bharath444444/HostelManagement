package HostelManagement;

public class Booking {
    private int id;
    private int studentId;
  
    private String checkinDate;
    private String feeStatus;
    private String roomNumber;
    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getStudentId() { return studentId; }
    public void setStudentId(int studentId) { this.studentId = studentId; }

    public String getRoomNumber() {
        return roomNumber;
    }

    public void setRoomNumber(String roomNumber) {
        this.roomNumber = roomNumber;
    }

    public String getCheckinDate() { return checkinDate; }
    public void setCheckinDate(String checkinDate) { this.checkinDate = checkinDate; }

    public String getFeeStatus() { return feeStatus; }
    public void setFeeStatus(String feeStatus) { this.feeStatus = feeStatus; }
}
