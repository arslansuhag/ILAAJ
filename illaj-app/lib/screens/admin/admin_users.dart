import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:illaj_app/mongoDatabase/apihelper.dart';

class admin_users extends StatefulWidget {
  const admin_users({super.key});

  @override
  State<admin_users> createState() => _admin_usersState();
}

class _admin_usersState extends State<admin_users> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Users"),
      ),
      body: SafeArea(
          child: FutureBuilder(
        future: ApiHelper.alluser(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.toString() == '[]') {
              return const Center(
                child: Text("No Data"),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    width: double.infinity,
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset:
                              const Offset(0, 2), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        snapshot.data[index]['img'] == ""
                            ? Image.asset(
                                "assets/user.png",
                                width: 50,
                                height: 50,
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.network(
                                  snapshot.data[index]['img'],
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                ),
                              ),
                        10.horizontalSpace,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                snapshot.data[index]['name'],
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(snapshot.data[index]['email']),
                              Text(
                                snapshot.data[index]['type'],
                                style: const TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        10.horizontalSpace,
                        IconButton(
                            onPressed: () async {
                              bool c = await ApiHelper.deleteuser(
                                  snapshot.data[index]['_id']);
                              setState(() {});
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ))
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
      )),
    );
  }
}
