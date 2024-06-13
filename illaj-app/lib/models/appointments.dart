class Appointment {
  String doctorName;
  String time;
  String date;
  String patientName;
  // Add other fields as necessary

  Appointment(
      {required this.doctorName,
      required this.time,
      required this.date,
      required this.patientName});

  // Define the fromMap method
  factory Appointment.fromMap(Map<String, dynamic> map) {
    return Appointment(
      doctorName: map['doctorName'],
      time: map['time'],
      date: map['date'],
      patientName: map['patientName'],
      // Initialize other fields...
    );
  }
}
