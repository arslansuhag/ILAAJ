import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:illaj_app/mongoDatabase/apihelper.dart';
import 'package:illaj_app/mongoDatabase/mongodb.dart';
import 'package:illaj_app/res/components/drawer-widget.dart';
import 'package:illaj_app/res/components/health-articles-widget.dart';

class HealthArticles extends StatefulWidget {
  const HealthArticles({super.key});

  @override
  State<HealthArticles> createState() => _HealthArticlesState();
}

class _HealthArticlesState extends State<HealthArticles> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  MongoDataBase mongoDataBase = MongoDataBase();

  Future<List> fetchDataFromMongoDB() async {
    try {
      return await ApiHelper.allhealthArticlestouser();
    } catch (e) {
      print("Error fetching data from MongoDB: $e");
      return []; // Return an empty list in case of an error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        drawer: const DrawerWidget(),
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.back();
                // Get.back();
              },
              icon: const Icon(Icons.arrow_back)),
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
            future: fetchDataFromMongoDB(),
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
                List articles = snapshot.data as List;

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
                    return HealthArticleCard(
                      title: article['title'],
                      uid: article['uid'],
                      description: article['description'],
                      image: article['imageUrl'],
                    );
                  },
                );
              }
            },
          ),
        ));
  }
}
