import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:illaj_app/mongoDatabase/apihelper.dart';
import 'package:illaj_app/res/components/doctor/doctor-health-article-card.dart';
import 'package:illaj_app/res/components/doctor/dr-drawer-widget.dart';
import 'package:illaj_app/screens/doctor/health-article-update-screen.dart';
import 'package:illaj_app/screens/doctor/upload-health-articles.dart';

import '../../main.dart';

class DoctorHealthArticles extends StatefulWidget {
  const DoctorHealthArticles({super.key});

  @override
  State<DoctorHealthArticles> createState() => _DoctorHealthArticlesState();
}

class _DoctorHealthArticlesState extends State<DoctorHealthArticles> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _key,
        drawer: const DoctorDrawerWidget(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(() => const UploadHelathArticles());
          },
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          leading: Padding(
            padding: EdgeInsets.only(left: 10.w),
            child: Row(
              children: [
                Expanded(
                    child: GestureDetector(
                        onTap: () {
                          _key.currentState!.openDrawer();
                        },
                        child: const Icon(Icons.menu))),
              ],
            ),
          ),
          centerTitle: true,
          title: Text(
            'Health Articles',
            style: TextStyle(fontSize: 17.sp),
          ),
        ),
        backgroundColor: Colors.grey[200],
        body: Padding(
          padding: EdgeInsets.all(12.h),
          child: FutureBuilder(
            future: ApiHelper.allhealthArticles(prefs.getString("id")!),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text("Error: ${snapshot.error}"),
                );
              } else {
                // Check if data is not null and is of the expected type
                List articles = snapshot.data!;

                if (articles.isEmpty) {
                  // Data is empty, handle accordingly (maybe show a message)
                  return const Center(
                    child: Text("No data available."),
                  );
                }

                return ListView.builder(
                  itemCount: articles.length,
                  itemBuilder: (context, index) {
                    var article = articles[index];
                    return DoctorHealthArticleCard(
                      title: article['title'],
                      description: article['description'],
                      image: article['imageUrl'],
                      onDelete: () async {
                        // Convert ObjectId to String
                        bool s = await ApiHelper.deletehealthArticles(
                            article["_id"]);
                        if (s) {
                          setState(() {});
                        }
                      },
                      onEdit: () {
                        Get.to(() => UpdateHelathArticles(
                              id: article['_id'].toString(),
                              title: article['title'],
                              description: article['description'],
                              image: article['imageUrl'],
                            ));
                      },
                    );
                  },
                );
              }
            },
          ),
        ));
  }
}
