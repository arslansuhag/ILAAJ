import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:illaj_app/main.dart';

import '../mongoDatabase/apihelper.dart';
import '../res/components/custom-text-field-widget.dart';

class registersos extends StatefulWidget {
  registersos({super.key, this.data = const {}, this.update = false});
  Map data;
  bool update;

  @override
  State<registersos> createState() => _registersosState();
}

class _registersosState extends State<registersos> {
  TextEditingController name = TextEditingController();
  TextEditingController number = TextEditingController();

  @override
  void initState() {
    if (widget.data.isNotEmpty) {
      name.text = widget.data['name'];
      number.text = widget.data['number'];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register SOS"),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              CustomTextFieldWidget(
                controller: name,
                hintText: 'Name',
              ),
              10.verticalSpace,
              CustomTextFieldWidget(
                keyboardType: TextInputType.number,
                maxLength: 11,
                controller: number,
                hintText: 'Number',
              ),
              10.verticalSpace,
              InkWell(
                onTap: () {
                  if(widget.update){
                    ApiHelper.updateemergence(widget.data['_id'], name.text, number.text);
                  } else {
                    ApiHelper.registeremergence(
                        prefs.getString("id")!, name.text, number.text);
                  }
                  Navigator.pop(context);
                },
                child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.green),
                    child: Center(
                        child: Text(
                      widget.update ? "Update" : "Register",
                      style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                    ))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
