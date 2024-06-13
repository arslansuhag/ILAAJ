import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../main.dart';
import '../mongoDatabase/apihelper.dart';
import '../res/colors/app-colors.dart';
import '../res/components/custom-text-field-widget.dart';
import '../res/components/round-button.dart';
import '../utils/app-utils.dart';
import 'labs-screen.dart';

class patwishlist extends StatefulWidget {
  const patwishlist({super.key});

  @override
  State<patwishlist> createState() => _patwishlistState();
}

class _patwishlistState extends State<patwishlist> {
  TextEditingController quantity = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Wishlist"),
      ),
      body: SafeArea(
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
                    if (List.of(snapshot.data[index]['wishlist'])
                        .contains(prefs.getString("id")!)) {
                      return orderlistdata(snapshot:snapshot, index:index);
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
    );
  }

  List<String> mode = [
    'on delivery',
    'credit card',
    "Debit card",
  ];
  String m = 'on delivery';

  Widget orderlistdata({required AsyncSnapshot snapshot, required int index}) {
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
                      image: NetworkImage(
                          snapshot.data[index]['img']),
                      fit: BoxFit.cover),
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12.r))),
          Padding(
            padding: EdgeInsets.all(10.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: List.of(snapshot.data[index]['wishlist'])
                      .contains(prefs.getString("id")!)
                      ? InkWell(
                    onTap: () async {
                      await ApiHelper.removewishlist(
                          snapshot.data[index]["_id"],
                          prefs.getString('id')!);
                      setState(() {});
                    },
                    child: const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                  )
                      : InkWell(
                    onTap: () async {
                      await ApiHelper.addwishlist(
                          snapshot.data[index]["_id"],
                          prefs.getString('id')!);
                      setState(() {});
                    },
                    child: const Icon(
                      Icons.star_outline,
                      color: Colors.amber,
                    ),
                  ),
                ),
                Text(
                  snapshot.data[index]['title'],
                  style: TextStyle(
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
                      fontSize: 10.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w400),
                ),
                3.verticalSpace,
                Text(
                  "Rs "+snapshot.data[index]['price'],
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  textDirection: TextDirection.ltr,
                  style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                15.verticalSpace,
                RoundButton(
                    buttonColor: AppColors.greenColor,
                    width: double.infinity,
                    title: 'Order Now',
                    onPressed: () async {
                      adddialog(context, snapshot, index);
                    }),
              ],
            ),
          )
        ],
      ),
    );
  }

  void adddialog(BuildContext context, AsyncSnapshot snapshot, int index) {
    quantity.clear();
    showDialog(context: context, builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.white,
        child: Container(
            width: double.infinity,
            color: Colors.white,
            padding: const EdgeInsets.all(10),
            child: Material(
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    3.verticalSpace,
                    CustomTextFieldWidget(
                        keyboardType: TextInputType.number,
                        controller: quantity,
                        hintText: 'Quantity'),
                    3.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Select Payment mode",
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                              height: 1.2,
                              fontSize: 12.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        DropdownButton<String>(
                          value: m,
                          icon: const Icon(Icons.arrow_downward),
                          iconSize: 24, // Icon size
                          elevation: 16, // Shadow elevation
                          style: const TextStyle(
                              color: Colors.black, fontSize: 16), // Text style
                          items: mode.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              m = newValue!;
                            });
                          },
                        ),
                      ],
                    ),
                    10.verticalSpace,
                    RoundButton(
                        buttonColor: AppColors.greenColor,
                        width: 120.w,
                        title: 'Order Now',
                        onPressed: () async {
                          if (quantity.text.isEmpty) {
                            AppUtils.snackBar("Orders", "Add Quantity",
                                const Duration(seconds: 1));
                          } else {
                            AppUtils.displayprogress(context);
                            bool c = await ApiHelper.registerorder(
                                snapshot.data[index]["_id"],
                                prefs.getString('id')!,
                                quantity.text,
                                m);
                            AppUtils.hideprogress(context);
                            if (c) {
                              Navigator.pop(context);
                              Navigator.pop(context);
                              AppUtils.snackBar("Oder", "Order Placed", Duration(seconds: 1));
                            } else {
                              Navigator.pop(context);
                              AppUtils.snackBar("Error", "Try again later", Duration(seconds: 1));
                            }
                          }
                        }),
                  ]),
            )
        ),
      );
    });
  }


}
