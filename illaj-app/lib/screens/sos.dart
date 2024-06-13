import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:illaj_app/main.dart';
import 'package:illaj_app/mongoDatabase/apihelper.dart';
import 'package:illaj_app/screens/sosregister.dart';
import 'package:illaj_app/utils/app-utils.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class sos extends StatefulWidget {
  const sos({super.key});

  @override
  State<sos> createState() => _sosState();
}

class _sosState extends State<sos> {
  @override
  void initState() {
    _requestLocationPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SOS"),
      ),
      backgroundColor: Colors.amber[30],
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                InkWell(
                    onTap: () async {
                      if (!await launchUrl(Uri.parse('tel:1122'))) {
                        AppUtils.snackBar(
                            "amabulance",
                            "Can not launch try again later",
                            const Duration(seconds: 2));
                      }
                    },
                    child: Container(
                      width: 150,
                      height: 200,
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.amber.shade200,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset("assets/amabulance.jpg")),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Call Amabulance",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                          )
                        ],
                      ),
                    )),
                InkWell(
                  onTap: () async {
                    await Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => registersos(),
                    ));
                    setState(() {});
                  },
                  child: Container(
                    width: 150,
                    height: 200,
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.amber.shade200,
                    ),
                    child: Column(
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset("assets/enum.jpg",height: 105,fit: BoxFit.cover,width: 150,)),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Add Emergency No",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
                child: FutureBuilder(
              future: ApiHelper.allemergencebypat(prefs.getString("id")!),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.toString() == '[]') {
                    return const Center(
                      child: Text("No Data"),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey[100],
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          snapshot.data[index]['name'],
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                        Text(snapshot.data[index]['number']),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          ApiHelper.cancleemergence(
                                              snapshot.data[index]['_id']);
                                          setState(() {});
                                        },
                                        child: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          await Navigator.of(context)
                                              .push(MaterialPageRoute(
                                            builder: (context) => registersos(
                                                data: snapshot.data[index],
                                                update: true),
                                          ));
                                          setState(() {});
                                        },
                                        child: const Icon(
                                          Icons.edit,
                                          color: Colors.green,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              const Divider(),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () async {
                                        if (!await launchUrl(Uri.parse(
                                            'tel:${snapshot.data[index]['number']}'))) {
                                          AppUtils.snackBar(
                                              "number",
                                              "Can not launch try again later",
                                              const Duration(seconds: 2));
                                        }
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.green,
                                        ),
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.call,
                                              color: Colors.white,
                                            ),
                                            5.horizontalSpace,
                                            const Text(
                                              "Call",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  5.horizontalSpace,
                                  Expanded(
                                    child: InkWell(
                                      onTap: () async {
                                        Position? position =
                                            await _getCurrentLocation();
                                        final url =
                                            'sms:${snapshot.data[index]['number']}?body=${"https://www.google.com/maps/@${position!.latitude},${position.longitude}"}';
                                        if (!await launchUrl(Uri.parse(url))) {
                                          AppUtils.snackBar(
                                              "sms",
                                              "Can not launch try again later",
                                              const Duration(seconds: 2));
                                        }
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.green,
                                        ),
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.sms,
                                              color: Colors.white,
                                            ),
                                            5.horizontalSpace,
                                            const Text(
                                              "sms",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  5.horizontalSpace,
                                  Expanded(
                                    child: InkWell(
                                      onTap: () async {
                                        Position? position =
                                            await _getCurrentLocation();
                                        final url =
                                            'whatsapp://send?phone=${snapshot.data[index]['number']}&text=${Uri.encodeFull("https://www.google.com/maps/@${position!.latitude},${position.longitude}")}';
                                        if (!await launchUrl(Uri.parse(url))) {
                                          AppUtils.snackBar(
                                              "sms",
                                              "Can not launch try again later",
                                              const Duration(seconds: 2));
                                        }
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.green,
                                        ),
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.sms_outlined,
                                              color: Colors.white,
                                            ),
                                            5.horizontalSpace,
                                            const Text(
                                              "Whatsapp",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }
                } else if (snapshot.hasError) {
                  return const Icon(
                    Icons.error,
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ))
          ],
          
        ),
        
      ),
    );
  }

  Future<Position?> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return null;
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return null;
      }
    }
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return null;
    }
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
  }

  Future<bool> _requestLocationPermission() async {
    var status = await Permission.locationWhenInUse.request();
    if (status.isGranted) {
      return true;
    } else {
      return false;
    }
  }
}
