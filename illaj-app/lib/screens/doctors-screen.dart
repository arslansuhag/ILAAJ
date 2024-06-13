import 'package:bson/bson.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:illaj_app/mongoDatabase/mongodb.dart';
import 'package:illaj_app/res/components/doctor-availability-card.dart';
import 'package:illaj_app/res/components/drawer-widget.dart';
import 'package:illaj_app/screens/doctor-detail-screen.dart';

class DoctorsScreen extends StatefulWidget {
  const DoctorsScreen({super.key});

  @override
  State<DoctorsScreen> createState() => _DoctorsScreenState();
}

class _DoctorsScreenState extends State<DoctorsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final MongoDataBase mongoDataBase = MongoDataBase();
  final List<String> doctorsList = [

  ];
  @override
  void initState() {
    super.initState();
    mongoDataBase.fetchDoctors();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const DrawerWidget(),
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            30.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      InkWell(
                          onTap: () {
                            _scaffoldKey.currentState!.openDrawer();
                          },
                          child: const Icon(Icons.menu)),
                      10.horizontalSpace,
                      Text(
                        'Specialists',
                        style: TextStyle(
                            fontSize: 20.sp, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  // Row(
                  //   children: [
                  //     IconButton(
                  //         onPressed: () {
                  //           Get.to(() => const SearchScreen());
                  //         },
                  //         icon: const Icon(
                  //           Icons.search,
                  //           size: 30,
                  //         )),
                  //     IconButton(
                  //         onPressed: () {},
                  //         icon: const Icon(
                  //           Icons.message_rounded,
                  //           size: 30,
                  //         )),
                  //   ],
                  // ),
                ],
              ),
            ),
            // 10.verticalSpace,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: FutureBuilder(
                future: mongoDataBase.fetchDoctors(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // If the Future is still running, show a loading indicator
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    // If there's an error, show the error message
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData ||
                      (snapshot.data as List).isEmpty) {
                    // If there is no data, handle accordingly (maybe show a message)
                    return const Center(child: Text("No data available."));
                  } else {
                    // If the Future is complete, display the data
                    List doctors =
                        snapshot.data as List;

                    return GridView.builder(
                        // physics: NeverScrollableScrollPhysics(),
                        // primary: true,
                        itemCount: doctors.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 15,
                                crossAxisSpacing: 15,
                                childAspectRatio: 0.7),
                        itemBuilder: (context, index) {
                          return DoctorAvailabilityCard(
                            title: doctors[index]['name'],
                            onTap: () {
                              Get.to(() => DoctorDetailScreen(
                                    doctorId:
                                        (doctors[index]['_id'] as String)
                                            .toString(),
                                  ));
                            },
                            specilization: doctors[index]['specialization'],
                            experience: doctors[index]['experience'],
                            image: doctors[index]['img'],
                          );
                        });
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
