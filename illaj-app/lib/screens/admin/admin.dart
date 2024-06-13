import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:illaj_app/main.dart';
import 'package:illaj_app/screens/admin/admin_doctor.dart';
import 'package:illaj_app/screens/admin/admin_users.dart';
import 'package:illaj_app/screens/admin/adminorders.dart';
import 'package:illaj_app/screens/login-screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:outline_search_bar/outline_search_bar.dart';

import '../../mongoDatabase/apihelper.dart';
import '../../res/assets/images.dart';
import '../../res/colors/app-colors.dart';
import '../../res/components/categories-widget.dart';
import '../../res/components/custom-text-field-widget.dart';
import '../../res/components/round-button.dart';
import '../../utils/app-utils.dart';
import 'adminfeedback.dart';

class Admin extends StatefulWidget {
  const Admin({super.key});

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  TextEditingController search = TextEditingController();
  String cat = "lab";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.greenColor,
        leading: InkWell(
          onTap: () {
            prefs.remove("id");
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
              ModalRoute.withName('/LoginScreen'),
            );
          },
          child: const Icon(
            Icons.logout,
            color: Colors.white,
          ),
        ),
        title: const Text('Admin',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            5.verticalSpace,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  10.verticalSpace,
                  Text("Welcome to Admin Panel",
                      style: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.bold)),
                  3.verticalSpace,
                ],
              ),
            ),
            10.verticalSpace,
            SizedBox(
              width: double.infinity,
              height: 90,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  CategoriesWidget(
                    title: "Feedback",
                    icon: Image.asset(
                      ImageAssets.feedback,
                      height: 30.h,
                    ),
                    onTap: () async {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return const adminfeedback();
                      }));
                    },
                  ),
                  CategoriesWidget(
                    title: "Orders",
                    icon: Image.asset(
                      ImageAssets.order,
                      height: 30.h,
                    ),
                    onTap: () async {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const adminorders(),
                        ),
                      );
                    },
                  ),
                  CategoriesWidget(
                    title: "Add New",
                    icon: Image.asset(
                      ImageAssets.addnew,
                      height: 30.h,
                    ),
                    onTap: () async {
                      await showDialog(
                          context: context,
                          builder: (BuildContext context) => Dialog(
                                child: addnew(),
                              ));
                      setState(() {});
                    },
                  ),
                  CategoriesWidget(
                    title: "Users",
                    icon: Image.asset(
                      ImageAssets.user,
                      height: 30.h,
                    ),
                    onTap: () async {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const admin_users(),
                        ),
                      );
                    },
                  ),
                  CategoriesWidget(
                    title: "Doctors",
                    icon: Image.asset(
                      ImageAssets.doctor0,
                      height: 30.h,
                    ),
                    onTap: () async {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const admindoctor(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            5.verticalSpace,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  10.verticalSpace,
                  Text("All Avaliable Products",
                      style: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.bold)),
                  3.verticalSpace,
                ],
              ),
            ),
            OutlineSearchBar(
              margin: const EdgeInsets.fromLTRB(10, 8, 10, 0),
              backgroundColor: Colors.white,
              borderRadius: BorderRadius.circular(10),
              borderColor: Colors.green,
              borderWidth: 2,
              cursorColor: Colors.green,
              clearButtonColor: Colors.greenAccent,
              clearButtonIconColor: Colors.white,
              hintText: "Search here",
              ignoreSpecialChar: true,
              searchButtonIconColor: Colors.green,
              textEditingController: search,
              onKeywordChanged: (String val) {
                setState(() {});
              },
            ),
            Row(
              children: [
                btn("lab"),
                btn("pharmacy"),
              ],
            ),
            Expanded(
              child: FutureBuilder(
                future: ApiHelper.allmarket(),
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
                          if (snapshot.data[index]['type'] == cat) {
                            if (search.text.isEmpty) {
                              return listdata(context, snapshot, index);
                            } else if (snapshot.data[index]['title']
                                .contains(search.text)) {
                              return listdata(context, snapshot, index);
                            } else {
                              return const SizedBox.shrink();
                            }
                          } else {
                            return const SizedBox.shrink();
                          }
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
          ],
        ),
      ),
    );
  }

  Widget btn(String title) {
    return InkWell(
      onTap: () {
        cat = title;
        setState(() {});
      },
      child: Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: title == cat ? Colors.green : Colors.white,
            border: Border.all(color: Colors.green, width: 1),
          ),
          child: Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: title == cat ? Colors.white : Colors.green),
          )),
    );
  }

  Widget listdata(BuildContext context, AsyncSnapshot snapshot, int index) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(10.h),
      constraints: const BoxConstraints(maxHeight: double.infinity),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            offset: const Offset(0, 3),
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 4),
      ], color: AppColors.white, borderRadius: BorderRadius.circular(12.r)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              height: 110.h,
              width: double.infinity.w,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(snapshot.data[index]['img']),
                      fit: BoxFit.cover),
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12.r))),
          Padding(
            padding: EdgeInsets.all(10.h),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        snapshot.data[index]['title'],
                        style: TextStyle(
                            height: 1.2,
                            fontSize: 15.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                      3.verticalSpace,
                      Text(
                        snapshot.data[index]['des'],
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                            height: 1.2,
                            fontSize: 10.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w400),
                      ),
                      3.verticalSpace,
                      Text(
                        snapshot.data[index]['type'],
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                            height: 1.2,
                            fontSize: 12.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      3.verticalSpace,
                      Text(
                        "Rs " + snapshot.data[index]['price'],
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                            height: 1.2,
                            fontSize: 12.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                5.horizontalSpace,
                Column(
                  children: [
                    InkWell(
                        onTap: () async {
                          bool c = await ApiHelper.deletemarket(
                              snapshot.data[index]['_id']);
                          setState(() {});
                        },
                        child: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        )),
                    InkWell(
                        onTap: () async {
                          await showDialog(
                              context: context,
                              builder: (BuildContext context) => Dialog(
                                    child: addnew(
                                      data: snapshot.data[index],
                                    ),
                                  ));
                          setState(() {});
                        },
                        child: const Icon(
                          Icons.edit,
                          color: Colors.green,
                        )),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class addnew extends StatefulWidget {
  addnew({super.key, this.data = const {}});
  Map data;

  @override
  State<addnew> createState() => _addnewState();
}

class _addnewState extends State<addnew> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController desController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  String v = "lab";
  List<String> types = ["lab", "pharmacy"];

  String imgurl = "";
  bool update = false;
  @override
  void initState() {
    if (widget.data.isNotEmpty) {
      nameController.text = widget.data['title'];
      desController.text = widget.data['des'];
      priceController.text = widget.data['price'];
      v = widget.data['type'];
      imgurl = widget.data['img'];
      update = true;
    }
    super.initState();
  }

  XFile? _image;
  Future<void> _pickImage() async {
    final XFile? image =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    _image = image;
    if (_image != null) {}
    setState(() {});
  }

  Future<void> updateArticle(
      String title, String description, String price) async {
    AppUtils.displayprogress(context);
    String url = imgurl;
    if (_image != null) {
      url = await uploadImageToFirebaseStorage();
    }
    bool c = await ApiHelper.updatemarket(
        widget.data['_id'], title, description, url, v, price);
    AppUtils.hideprogress(context);
    if (c) {
      nameController.clear();
      desController.clear();
      priceController.clear();
      _image = null;
      AppUtils.snackBar(
          'Admin', 'Data Updated Successfully', const Duration(seconds: 2));
      Navigator.pop(context);
      setState(() {});
      print("Article updated successfully.");
    } else {
      AppUtils.snackBar('Admin', 'Try again later', const Duration(seconds: 2));
    }
  }

  Future<void> saveArticle(
      String title, String description, String price) async {
    try {
      AppUtils.displayprogress(context);
      String imageUrl = await uploadImageToFirebaseStorage();
      bool c = await ApiHelper.registermarket(
          nameController.text, desController.text, imageUrl, v, price);
      AppUtils.hideprogress(context);
      if (c) {
        nameController.clear();
        desController.clear();
        priceController.clear();
        _image = null;
        AppUtils.snackBar(
            'Admin', 'Data Saved Successfully', const Duration(seconds: 2));
        Navigator.pop(context);
        setState(() {});
        print("Article saved successfully.");
      } else {
        AppUtils.snackBar(
            'Admin', 'Try again later', const Duration(seconds: 2));
      }
    } catch (e) {
      AppUtils.hideprogress(context);
      print("Error saving article to MongoDB: $e");
    }
  }

  Future<String> uploadImageToFirebaseStorage() async {
    try {
      final FirebaseStorage storage = FirebaseStorage.instance;
      final Reference storageReference = storage.ref().child(
          'health_articles/${DateTime.now().millisecondsSinceEpoch}.jpg');

      await storageReference.putFile(File(_image!.path));

      return await storageReference.getDownloadURL();
    } catch (e) {
      print("Error uploading image to Firebase Storage: $e");
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView(
        shrinkWrap: true,
        children: [
          InkWell(
              onTap: _pickImage,
              child: _image != null
                  ? Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      height: height * 0.2,
                      width: width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: FileImage(File(
                                _image!.path,
                              ))),
                          border: Border.all(
                              width: 1.5, color: const Color(0xff0E6D53))),
                    )
                  : imgurl == ''
                      ? Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          height: height * 0.2,
                          width: width,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  width: 1.5, color: AppColors.blaclColor)),
                          child: const Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add_a_photo_outlined,
                                  size: 40,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'Add Image',
                                  style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          ),
                        )
                      : Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          height: height * 0.2,
                          width: width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  width: 1.5, color: const Color(0xff0E6D53))),
                          child: Image.network(
                            imgurl,
                            fit: BoxFit.cover,
                          ),
                        )),
          DropdownButton<String>(
            value: v,
            onChanged: (String? newValue) {
              setState(() {
                v = newValue!;
              });
            },
            items: types.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          CustomTextFieldWidget(controller: nameController, hintText: 'Title'),
          SizedBox(height: 10.h),
          CustomTextFieldWidget(
              controller: desController, hintText: 'Description', maxLines: 5),
          SizedBox(height: 10.h),
          CustomTextFieldWidget(
              controller: priceController,
              hintText: 'Price',
              keyboardType: TextInputType.number),
          SizedBox(height: 30.h),
          RoundButton(
              buttonColor: AppColors.greenColor,
              width: 120.w,
              title: update ? 'Update' : 'Upload',
              onPressed: () {
                if (nameController.text.isEmpty ||
                    desController.text.isEmpty ||
                    priceController.text.isEmpty) {
                  AppUtils.snackBar("Error", "All Fields are required",
                      const Duration(seconds: 2));
                } else if (_image == null) {
                  AppUtils.snackBar(
                      "Error", "Add a image", const Duration(seconds: 2));
                } else {
                  if (update) {
                    updateArticle(nameController.text, desController.text,
                        priceController.text);
                  } else {
                    saveArticle(nameController.text, desController.text,
                        priceController.text);
                  }
                }
              })
        ],
      ),
    );
  }
}
