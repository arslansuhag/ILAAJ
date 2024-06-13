// ignore_for_file: must_be_immutable, deprecated_member_use

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:illaj_app/main.dart';
import 'package:illaj_app/mongoDatabase/apihelper.dart';
import 'package:illaj_app/res/components/message-field.dart';
import 'package:image_picker/image_picker.dart';

class ChatRoomScreen extends StatefulWidget {
  var id;
  bool isadmin;
  ChatRoomScreen({super.key, required this.id, this.isadmin = false});

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back)),
        centerTitle: true,
        title: Text(
          'Chats',
          style: TextStyle(fontSize: 17.sp),
        ),
      ),
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: ApiHelper.allchatbyid(widget.id),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data['c'].toString() == '[]') {
                    return const Center(
                      child: Text("No Data"),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data['c'].length,
                      itemBuilder: (BuildContext context, int index) {
                        return Align(
                          alignment: widget.isadmin
                              ? snapshot.data['c'][index]['sendby'] != "aa"
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft
                              : snapshot.data['c'][index]['sendby'] ==
                                      prefs.getString("id")!
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: widget.isadmin
                                  ? snapshot.data['c'][index]['sendby'] != "aa"
                                      ? Colors.green
                                      : Colors.amber
                                  : snapshot.data['c'][index]['sendby'] ==
                                          prefs.getString("id")!
                                      ? Colors.green
                                      : Colors.amber,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                snapshot.data['c'][index].containsKey("img")
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          snapshot.data['c'][index]['img'],
                                        ),
                                      )
                                    : const SizedBox.shrink(),
                                Text(
                                  snapshot.data['c'][index]['mess'].toString(),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 17.sp),
                                ),
                                snapshot.data['c'][index]['sendby'] == "aa"
                                    ? Text(
                                        "Admin",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 10.sp),
                                      )
                                    : FutureBuilder(
                                        future: ApiHelper.getoneuser(snapshot
                                            .data['c'][index]['sendby']),
                                        builder: (BuildContext context,
                                            AsyncSnapshot snapshot) {
                                          if (snapshot.hasData) {
                                            return Text(
                                              "${snapshot.data['name']} ( ${snapshot.data['type']} )",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 10.sp),
                                            );
                                          } else if (snapshot.hasError) {
                                            return const Icon(
                                              Icons.error,
                                            );
                                          } else {
                                            return const CircularProgressIndicator();
                                          }
                                        },
                                      ),
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
            ),
          ),
          MessageField(
            onSend: (messageText) async {
              await ApiHelper.addchat(widget.id, {
                "sendby": widget.isadmin ? "aa" : prefs.getString("id")!,
                "mess": messageText,
                "date": DateTime.now().toString()
              });
              setState(() {});
            },
            onimage: (messageText) async {
              final pickedFile =
                  await ImagePicker().pickImage(source: ImageSource.gallery);
              if (pickedFile != null) {
                final FirebaseStorage storage = FirebaseStorage.instance;
                final Reference storageReference = storage.ref().child(
                    'health_articles/${DateTime.now().millisecondsSinceEpoch}.jpg');
                await storageReference.putFile(File(pickedFile.path));
                String url = await storageReference.getDownloadURL();

                await ApiHelper.addchat(widget.id, {
                  "sendby": widget.isadmin ? "aa" : prefs.getString("id")!,
                  "img": url,
                  "mess": messageText,
                  "date": DateTime.now().toString()
                });
                setState(() {});
              }
            },
          ),
          const SizedBox(
            height: 15,
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
