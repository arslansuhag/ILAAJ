import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:outline_search_bar/outline_search_bar.dart';

import '../main.dart';
import '../mongoDatabase/apihelper.dart';
import '../res/colors/app-colors.dart';
import '../res/components/custom-text-field-widget.dart';
import '../res/components/round-button.dart';
import '../utils/app-utils.dart';
import 'labs-screen.dart';

class PharmaciesScreen extends StatefulWidget {
  const PharmaciesScreen({super.key});

  @override
  State<PharmaciesScreen> createState() => _PharmaciesScreenState();
}

class _PharmaciesScreenState extends State<PharmaciesScreen> {
  TextEditingController quantity = TextEditingController();
  TextEditingController search = TextEditingController();
  TextEditingController prices = TextEditingController();
  TextEditingController pricee = TextEditingController();

  List data = [];
  @override
  void initState() {
    getdata();
    super.initState();
  }

  void getdata() async {
    data.clear();
    List l = await ApiHelper.allmarket();
    l.forEach((element) {
      if (element['type'] == 'pharmacy') {
        data.add(element);
      }
    });
    setState(() {});
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
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Pharmacies',
          style: TextStyle(fontSize: 17.sp),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: OutlineSearchBar(
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
                ),
                InkWell(
                    onTap: () => filterdialog(context),
                    child: const Icon(
                      Icons.filter_alt_rounded,
                      size: 30,
                    )),
                5.horizontalSpace,
              ],
            ),
            Expanded(
                child: data == []
                    ? const CircularProgressIndicator()
                    : ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (BuildContext context, int index) {
                          if (data[index]['type'] == 'pharmacy') {
                            if (search.text.isEmpty) {
                              if (applyfil) {
                                return pricefilter(context, data, index);
                              } else {
                                return orderlistdata(
                                    snapshot: data, index: index);
                              }
                            } else {
                              if (data[index]['title']
                                  .toString()
                                  .toLowerCase()
                                  .contains(search.text.toLowerCase())) {
                                if (applyfil) {
                                  return pricefilter(context, data, index);
                                } else {
                                  return orderlistdata(
                                      snapshot: data, index: index);
                                }
                              } else {
                                return const SizedBox.shrink();
                              }
                            }
                          } else {
                            return const SizedBox.shrink();
                          }
                        },
                      ))
          ],
        ),
      ),
    );
  }

  Widget pricefilter(BuildContext context, List snapshot, int index) {
    if (prices.text.isEmpty && pricee.text.isEmpty) {
      return orderlistdata(snapshot: snapshot, index: index);
    } else if (prices.text.isNotEmpty && pricee.text.isEmpty) {
      if (int.parse(data[index]['price']) >= int.parse(prices.text)) {
        return orderlistdata(snapshot: snapshot, index: index);
      } else {
        return const SizedBox.shrink();
      }
    } else if (prices.text.isEmpty && pricee.text.isNotEmpty) {
      if (int.parse(data[index]['price']) <= int.parse(pricee.text)) {
        return orderlistdata(snapshot: snapshot, index: index);
      } else {
        return const SizedBox.shrink();
      }
    } else {
      if (int.parse(data[index]['price']) <= int.parse(pricee.text) &&
          (int.parse(data[index]['price']) >= int.parse(prices.text))) {
        return orderlistdata(snapshot: snapshot, index: index);
      } else {
        return const SizedBox.shrink();
      }
    }
  }

  List<String> mode = [
    'on delivery',
    'credit card',
    "Debit card",
  ];
  String m = 'on delivery';

  Widget orderlistdata({required List snapshot, required int index}) {
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
                      image: NetworkImage(data[index]['img']),
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
                  child: List.of(data[index]['wishlist'])
                          .contains(prefs.getString("id")!)
                      ? InkWell(
                          onTap: () async {
                            await ApiHelper.removewishlist(
                                data[index]["_id"], prefs.getString('id')!);
                            getdata();
                          },
                          child: const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                        )
                      : InkWell(
                          onTap: () async {
                            await ApiHelper.addwishlist(
                                data[index]["_id"], prefs.getString('id')!);
                            getdata();
                          },
                          child: const Icon(
                            Icons.star_outline,
                            color: Colors.amber,
                          ),
                        ),
                ),
                Text(
                  data[index]['title'],
                  style: TextStyle(
                      fontSize: 15.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
                3.verticalSpace,
                Text(
                  data[index]['des'],
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
                  "Rs " + data[index]['price'],
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
                      adddialog(context, data, index);
                    }),
              ],
            ),
          )
        ],
      ),
    );
  }

  void adddialog(BuildContext context, List snapshot, int index) {
    quantity.clear();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.white,
            child: Container(
                width: double.infinity,
                color: Colors.white,
                padding: const EdgeInsets.all(10),
                child: Material(
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
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
                          items: mode
                              .map<DropdownMenuItem<String>>((String value) {
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
                                data[index]["_id"],
                                prefs.getString('id')!,
                                quantity.text,
                                m);
                            AppUtils.hideprogress(context);
                            if (c) {
                              Navigator.pop(context);
                              Navigator.pop(context);
                              AppUtils.snackBar(
                                  "Oder", "Order Placed", Duration(seconds: 1));
                            } else {
                              Navigator.pop(context);
                              AppUtils.snackBar("Error", "Try again later",
                                  Duration(seconds: 1));
                            }
                          }
                        }),
                  ]),
                )),
          );
        });
  }

  void filterdialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: Container(
              padding: const EdgeInsets.all(10),
              color: Colors.white,
              child: ListView(
                shrinkWrap: true,
                children: [
                  const Text(
                    "Price Filter",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  CustomTextFieldWidget(
                      keyboardType: TextInputType.number,
                      controller: prices,
                      hintText: 'Price Start'),
                  5.verticalSpace,
                  CustomTextFieldWidget(
                      keyboardType: TextInputType.number,
                      controller: pricee,
                      hintText: 'Price End'),
                  5.verticalSpace,
                  InkWell(
                      onTap: () => lowtohigh(),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.green,
                        ),
                        child: const Center(
                            child: Text(
                          "Low to high",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )),
                      )),
                  5.verticalSpace,
                  InkWell(
                      onTap: () => highttolow(),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.green,
                        ),
                        child: const Center(
                            child: Text(
                          "high to low",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )),
                      )),
                  5.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: InkWell(
                            onTap: () => applyfilter(),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.green,
                              ),
                              child: const Center(
                                  child: Text(
                                "Apply",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )),
                            )),
                      ),
                      applyfil
                          ? Expanded(
                              child: InkWell(
                                  onTap: () => canclefilter(),
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.red,
                                    ),
                                    child: const Center(
                                        child: Text(
                                      "Cancel",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )),
                                  )))
                          : const SizedBox.shrink(),
                    ],
                  ),
                  5.verticalSpace,
                ],
              ),
            ),
          );
        });
  }

  bool applyfil = false;
  void applyfilter() {
    Navigator.pop(context);
    applyfil = true;
    setState(() {});
  }

  void canclefilter() {
    prices.clear();
    pricee.clear();
    Navigator.pop(context);
    applyfil = false;
    setState(() {});
  }

  void lowtohigh() {
    data.sort(
        (a, b) => (int.parse(a['price'])).compareTo(int.parse(b['price'])));
    Navigator.pop(context);
    setState(() {});
  }

  void highttolow() {
    data.sort(
        (a, b) => (int.parse(b['price'])).compareTo(int.parse(a['price'])));
    Navigator.pop(context);
    setState(() {});
  }
}
