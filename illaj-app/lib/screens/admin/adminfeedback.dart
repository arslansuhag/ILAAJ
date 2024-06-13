import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../mongoDatabase/apihelper.dart';
import '../chatroom-screen.dart';

class adminfeedback extends StatelessWidget {
  const adminfeedback({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
        centerTitle: true,
        title: Text(
          'Feedback',
          style: TextStyle(fontSize: 17.sp),
        ),
      ),
      backgroundColor: Colors.grey[200],
        body: FutureBuilder(
          future: ApiHelper.allchatbydid("aa"),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              print(snapshot.data);
              if (snapshot.data.toString() == '[]') {
                return const Center(
                  child: Text("No Data"),
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () async {
                        Get.to(() => ChatRoomScreen(
                          id: snapshot.data[index]['_id'],
                          isadmin: true,
                        ));
                      },
                      child: Container(
                        padding: EdgeInsets.all(10.sp),
                        margin: EdgeInsets.all(10.sp),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.green[100],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FutureBuilder(
                              future: ApiHelper.getoneuser(
                                  snapshot.data[index]['uid']),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot2) {
                                if (snapshot2.hasData) {
                                  return Text(
                                    snapshot2.data['name'],
                                    style: TextStyle(fontSize: 17.sp),
                                  );
                                } else if (snapshot2.hasError) {
                                  return const Icon(
                                    Icons.error,
                                  );
                                } else {
                                  return const CircularProgressIndicator();
                                }
                              },
                            ),
                            Text(snapshot.data[index]['date']
                                .toString()
                                .substring(0, 10)),
                          ],
                        ),
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
        ));
  }
}
