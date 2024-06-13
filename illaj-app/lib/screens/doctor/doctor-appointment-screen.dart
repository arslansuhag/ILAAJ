import 'package:bson/bson.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:illaj_app/mongoDatabase/apihelper.dart';
import 'package:illaj_app/mongoDatabase/mongodb.dart';
import 'package:illaj_app/res/components/doctor/doctor-appointment-receiving-card.dart';
import 'package:illaj_app/res/components/doctor/dr-drawer-widget.dart';
import 'package:illaj_app/screens/doctor/upload-health-articles.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DoctorAppointmentScreen extends StatefulWidget {
  DoctorAppointmentScreen({super.key, this.d = true});
  bool d;

  @override
  State<DoctorAppointmentScreen> createState() =>
      _DoctorAppointmentScreenState();
}

class _DoctorAppointmentScreenState extends State<DoctorAppointmentScreen> {
  final MongoDataBase mongoDataBase = MongoDataBase();
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  List appointments = [];
  bool appointmentsLoading = false;

  @override
  void initState() {
    super.initState();
    fetchAppointments();
  }

  // Function to fetch appointment data
  Future<void> fetchAppointments() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var result = await ApiHelper.getbydoctor(prefs.getString('id')!);
      print(result);
      setState(() {
        appointments = result;
      });
    } catch (e) {
      print("Error fetching appointments from MongoDB: $e");
    }
  }

  void _cancelAppointment(String appointmentId) async {
    try {
      await ApiHelper.deleteappointment(appointmentId);
      await fetchAppointments();
    } catch (e) {
      print("Error canceling appointment: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _key,
        drawer: widget.d?const DoctorDrawerWidget():null,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Appointments',
            style: TextStyle(fontSize: 17.sp),
          ),
        ),
        backgroundColor: Colors.grey[200],
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: appointments.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : appointments.isNotEmpty
                  ? ListView.builder(
                      itemCount: appointments.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return ReceivedAppointmentCard(
                            date: appointments[index]['date'],
                            name: appointments[index]['patientName'].toString(),
                            time: appointments[index]['time'],
                            status: appointments[index]['status'],
                            id: appointments[index]['patientID'].toString(),
                            onCancel: () {
                              _cancelAppointment(appointments[index]['_id']);
                            },
                            onupdate: () async {
                              bool c = await ApiHelper.updateappointment(
                                  appointments[index]['_id']);
                              fetchAppointments();
                              setState(() {});
                            });
                      },
                    )
                  : const Center(
                      child: Text('No Appointments'),
                    ),
        ));
  }
}
