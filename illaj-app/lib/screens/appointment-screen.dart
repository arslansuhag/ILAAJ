import 'package:animated_rating_stars/animated_rating_stars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:illaj_app/mongoDatabase/apihelper.dart';
import 'package:illaj_app/mongoDatabase/mongodb.dart';
import 'package:illaj_app/res/components/appointment-card.dart';
import 'package:illaj_app/utils/app-utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  final MongoDataBase mongoDataBase = MongoDataBase();
  // List to store appointment data
  List appointments = [];

  // Function to fetch appointment data
  Future<void> fetchAppointments() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userId = prefs.getString('id');
      List result = await ApiHelper.getbypatient(userId!);
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
  void initState() {
    super.initState();
    // Call fetchAppointments when the screen is first created
    fetchAppointments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
              // Get.back();
            },
            icon: const Icon(Icons.arrow_back)),
        centerTitle: true,
        title: Text(
          'My Appointment',
          style: TextStyle(fontSize: 17.sp),
        ),
      ),
      // backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: appointments.isEmpty
            ? const Center(
                // Show CircularProgressIndicator if appointments are still loading
                child: CircularProgressIndicator())
            : appointments.isNotEmpty
                ? ListView.builder(
                    itemCount: appointments.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return AppointmentCard(
                          date: appointments[index]['date'],
                          name: appointments[index]['doctorName'],
                          time: appointments[index]['time'],
                          status: appointments[index]['status'],
                          onCancel: () {
                            _cancelAppointment(appointments[index]['_id']);
                          },
                          rate: () async {
                            await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Dialog(
                                    child: ratingdialog(
                                      did: appointments[index]['doctorId'],
                                      id: appointments[index]['_id'],
                                    ),
                                  );
                                });
                            fetchAppointments();
                            setState(() {});
                          });
                    })
                : const Center(
                    // Show CircularProgressIndicator if appointments are still loading
                    child: Text('No Appointment Booked')),
      ),
    );
  }
}

class ratingdialog extends StatefulWidget {
  ratingdialog({super.key, required this.id, required this.did});
  String id;
  String did;

  @override
  State<ratingdialog> createState() => _ratingdialogState();
}

class _ratingdialogState extends State<ratingdialog> {
  double rating = 0.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          20.verticalSpace,
          AnimatedRatingStars(
            initialRating: int.parse(prefs.getString('itemrating')!) /
                int.parse(prefs.getString("itemuser")!),
            minRating: 0.0,
            maxRating: 5.0,
            filledColor: Colors.amber,
            emptyColor: Colors.grey,
            filledIcon: Icons.star,
            halfFilledIcon: Icons.star_half,
            emptyIcon: Icons.star_border,
            onChanged: (double ratings) {
              rating = ratings;
              setState(() {});
            },
            displayRatingValue: true,
            interactiveTooltips: true,
            customFilledIcon: Icons.star,
            customHalfFilledIcon: Icons.star_half,
            customEmptyIcon: Icons.star_border,
            starSize: 20,
            animationDuration: const Duration(milliseconds: 300),
            animationCurve: Curves.easeInOut,
            readOnly: false,
          ),
          20.verticalSpace,
          ElevatedButton(
              onPressed: () async {
                if (rating == 0.0) {
                  AppUtils.snackBar("Rating", "Rating is required",
                      const Duration(seconds: 2));
                } else {
                  bool c = await ApiHelper.updatedoctorrating(
                      widget.did, rating.toString());
                  bool cc = await ApiHelper.updateappointment(widget.id,
                      status: "rating done");
                  Navigator.pop(context);
                }
              },
              child: const Text('Add Rating')),
        ],
      ),
    );
  }
}
