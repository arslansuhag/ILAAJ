// ignore_for_file: prefer_typing_uninitialized_variables, deprecated_member_use, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:illaj_app/mongoDatabase/mongodb.dart';
import 'package:illaj_app/res/colors/app-colors.dart';
import 'package:illaj_app/res/components/custom-text-field-widget.dart';
import 'package:illaj_app/res/components/round-button.dart';
import 'package:image_picker/image_picker.dart';

class UpdateHelathArticles extends StatefulWidget {
  String id;
  var title;
  var description;
  String image;
  UpdateHelathArticles({
    super.key,
    required this.id,
    required this.title,
    required this.description,
    required this.image,
  });

  @override
  State<UpdateHelathArticles> createState() => _UpdateHelathArticlesState();
}

class _UpdateHelathArticlesState extends State<UpdateHelathArticles> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController desController = TextEditingController();

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  MongoDataBase mongoDataBase = MongoDataBase();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    titleController.text = widget.title;
    desController.text = widget.description;
    _image = XFile(widget.image);
  }

//---------------------Backend Part Continue-----------------//

//  Funtion for pick image from gallery
  XFile? _image;

  Future<void> _pickImage() async {
    final XFile? image =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    _image = image;

    // Save the picked image to a temporary location
    if (_image != null) {
      // Now, you can use tempImagePath for uploading to MongoDB
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    // var path = imageFile?.path;

    return Scaffold(
        key: _globalKey,
        // drawer: const DrawerWidget(),
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back)),
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            'Update Health Articles',
            style: TextStyle(fontSize: 17.sp),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 25),
          width: width,
          height: height,
          // constraints: BoxConstraints(maxHeight: double.infinity),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      // scrollDirection: Axis.vertical,
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
                                            image: NetworkImage(widget.image)),
                                        border: Border.all(
                                            width: 1.5,
                                            color: const Color(0xff0E6D53))),
                                  )
                                : Container(
                                    margin: const EdgeInsets.only(bottom: 20),
                                    height: height * 0.2,
                                    width: width,
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          width: 1.5,
                                          color: AppColors.blaclColor),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                            widget.image,
                                          )),
                                    ),
                                    child: const Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
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
                                  )),
                        CustomTextFieldWidget(
                            controller: titleController, hintText: 'Title'),
                        SizedBox(height: 10.h),
                        CustomTextFieldWidget(
                            controller: desController,
                            hintText: 'Description',
                            maxLines: 5),
                        SizedBox(height: 30.h),
                        RoundButton(
                            buttonColor: AppColors.greenColor,
                            width: 120.w,
                            title: 'Update',
                            onPressed: () {
                              print("Widget ID: ${widget.id}");
                              mongoDataBase.updateArticle(
                                widget.id,
                                titleController.text,
                                desController.text,
                                _image!.path,
                              );
                            })
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
