// ignore_for_file: deprecated_member_use

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:illaj_app/mongoDatabase/apihelper.dart';
import 'package:illaj_app/mongoDatabase/mongodb.dart';
import 'package:illaj_app/res/assets/images.dart';
import 'package:illaj_app/res/components/carousel-card.widget.dart';
import 'package:illaj_app/res/components/categories-widget.dart';
import 'package:illaj_app/res/components/custom-text-field-widget.dart';
import 'package:illaj_app/res/components/doctor-card.dart';
import 'package:illaj_app/res/components/drawer-widget.dart';
import 'package:illaj_app/res/components/reuseable-widget.dart';
import 'package:illaj_app/screens/appointment-screen.dart';
import 'package:illaj_app/screens/doctor-detail-screen.dart';
import 'package:illaj_app/screens/health-articles-screen.dart';
import 'package:illaj_app/screens/labs-screen.dart';
import 'package:illaj_app/screens/pharmacies-screen.dart';
import 'package:illaj_app/screens/reminder-screen.dart';
import 'package:illaj_app/screens/sos.dart';

import '../main.dart';
import 'chatroom-screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _anotherWidgetKey = GlobalKey<ScaffoldState>();
  final MongoDataBase mongoDataBase = MongoDataBase();
  List<String> doctorNames = [];
  final List<String> doctorCategoriesList = [
    'Doctor Appointment',
    'Pharmacies',
    'Labs',
    'Health Articles',
    'Reminder',
    "Feedback",
    "SOS"
  ];
  @override
  void initState() {
    super.initState();
    fetchDoctorNames().then((names) {
      setState(() {
        doctorNames = names;
      });
    });
  }

  final List<Widget> iconsList = [
    Image.asset(
      ImageAssets.doctor,
      height: 30.h,
    ),
    Image.asset(
      ImageAssets.pharmacies,
      height: 30.h,
    ),
    Image.asset(
      ImageAssets.labs,
      height: 30.h,
    ),
    Image.asset(
      ImageAssets.health,
      height: 30.h,
    ),
    Image.asset(
      ImageAssets.reminder,
      height: 30.h,
    ),
    Image.asset(
      ImageAssets.feedback,
      height: 30.h,
    ),
    Image.asset(
      ImageAssets.sos,
      height: 30.h,
    ),
  ];

  static const List<Widget> _widgetOptions = <Widget>[
    AppointmentScreen(),
    PharmaciesScreen(),
    LabsScreen(),
    HealthArticles(),
    ReminderScreen(),
    ReminderScreen(),
    sos()
  ];

  Future<List<String>> fetchDoctorNames() async {
    try {
      var doctorsCursor = await ApiHelper.getdoctor();
      List<String> doctorNames =
          doctorsCursor.map((doc) => doc['name'].toString()).toList();
      return doctorNames;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _anotherWidgetKey,
      drawer: const DrawerWidget(),
      backgroundColor: Colors.grey[200],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          30.verticalSpace,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    InkWell(
                        onTap: () {
                          _anotherWidgetKey.currentState!.openDrawer();
                        },
                        child: const Icon(Icons.menu)),
                    10.horizontalSpace,
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Home',
                        style: TextStyle(
                            fontSize: 20.sp, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          5.verticalSpace,
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: CustomTextFieldWidget(
              controller: search,
              hintText: 'Search Doctors',
              onChanged: (value) {setState(() {});},
            ),
          ),
          3.verticalSpace,
          Flexible(
            child: SingleChildScrollView(
              child: Column(
                // shrinkWrap: true,
                // physics: BouncingScrollPhysics(),
                children: [
                  CarouselSlider(
                      items: [
                        Image.asset("assets/bg.jpg"),
                        Image.asset("assets/bg.jpg"),
                        Image.asset("assets/bg.jpg"),
                      ],
                      options: CarouselOptions(
                        height: 160.h,
                        aspectRatio: 16 / 6,
                        viewportFraction: 0.9,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 3),
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: false,
                        enlargeFactor: 0.3,
                        //onPageChanged: (){},
                        scrollDirection: Axis.horizontal,
                      )),
                  const ReUseAbleWidget(
                      leftText: 'Categories', rightText: 'See All'),
                  10.verticalSpace,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: SizedBox(
                      height: 70.h,
                      child: ListView.builder(
                          shrinkWrap: true,
                          primary: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: doctorCategoriesList.length,
                          itemBuilder: (context, index) {
                            return CategoriesWidget(
                              title: doctorCategoriesList[index],
                              icon: iconsList[index],
                              onTap: () async {
                                if (doctorCategoriesList[index] == "Feedback") {
                                  Map c = await ApiHelper.registerchat(prefs.getString("id")!, "aa");
                                  if(c['status']){
                                    Get.to(() => ChatRoomScreen(
                                      id: c['message'],
                                    ));
                                  }
                                } else {
                                  Get.to(() => _widgetOptions[index]);
                                }
                              },
                            );
                          }),
                    ),
                  ),
                  10.verticalSpace,
                  const ReUseAbleWidget(
                      leftText: 'Available Doctor', rightText: 'See All'),
                  10.verticalSpace,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: FutureBuilder(
                      future: mongoDataBase.fetchDoctors(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          // If the Future is still running, show a loading indicator
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          // If there's an error, show the error message
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else if (!snapshot.hasData ||
                            (snapshot.data as List).isEmpty) {
                          // If there is no data, handle accordingly (maybe show a message)
                          return const Center(
                              child: Text("No data available."));
                        } else {
                          // If the Future is complete, display the data
                          List doctors = snapshot.data as List;

                          return SizedBox(
                            height: 150.h,
                            width: double.infinity,
                            child: ListView.builder(
                                shrinkWrap: true,
                                primary: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: doctors.length,
                                itemBuilder: (context, index) {
                                  if(doctors[index]['name'].toString().toLowerCase()
                                      .contains(search.text.toLowerCase())){
                                    return DoctorCard(
                                      title: doctors[index]['name'],
                                      onTap: () {
                                        Get.to(() => DoctorDetailScreen(
                                          doctorId: (doctors[index]['_id'])
                                              .toString(),
                                        ));
                                      },
                                      specialization: doctors[index]['specialization'],
                                      experience: doctors[index]['experience'],
                                      image: doctors[index]['img'],
                                      description: doctors[index]['description'],
                                      itemrating: doctors[index]['itemrating'],
                                      itemuser: doctors[index]['itemuser'],
                                    );
                                  } else {
                                    return const SizedBox.shrink();
                                  }
                                }),
                          );
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
