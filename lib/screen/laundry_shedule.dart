import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundry/model/subject_data_model.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';

import '../controller/app_data_controller.dart';
import '../model/fontfamily_model.dart';
import '../utils/Colors.dart';
import '../utils/Custom_widget.dart';

class Laundryshedulescreen extends StatelessWidget {
  Laundryshedulescreen({Key? key}) : super(key: key);

  final AppDataController controller = Get.put(AppDataController());

  @override
  Widget build(BuildContext context) {
    List subjectData = [];

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      controller.getSubjectData();
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Laundry schedule",
          style: TextStyle(
            fontFamily: "Gilroy Bold",
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Get.back(); // Navigate back
          },
        ),
      ),
      body: Column(
        children: [
          GetBuilder<AppDataController>(builder: (controller) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    "Laundry Period",
                    style: TextStyle(
                      fontFamily: "Gilroy Medium",
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  MultiSelectDialogField(
                    //     height: 200,
                    items: controller.dropDownData,
                    title: const Text(
                      "Laundry Period  ",
                      style: TextStyle(color: Colors.black),
                    ),
                    selectedColor: Colors.black,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                      border: Border.all(
                        color: Colors.black,
                        width: 2,
                      ),
                    ),
                    buttonIcon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.blue,
                    ),
                    buttonText: const Text(
                      "Laundry Period  ",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    onConfirm: (results) {
                      subjectData = [];
                      for (var i = 0; i < results.length; i++) {
                        SubjectModel data = results[i] as SubjectModel;
                        print(data.subjectId);
                        print(data.subjectName);
                        subjectData.add(data.subjectId);
                      }
                      print("data $subjectData");

                      //_selectedAnimals = results;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Laundry Day ",
                    style: TextStyle(
                      fontFamily: "Gilroy Medium",
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  MultiSelectDialogField(
                    //     height: 200,
                    items: controller.dropDownData,
                    title: const Text(
                      "Laundry Day ",
                      style: TextStyle(color: Colors.black),
                    ),
                    selectedColor: Colors.black,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                      border: Border.all(
                        color: Colors.black,
                        width: 2,
                      ),
                    ),
                    buttonIcon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.blue,
                    ),
                    buttonText: const Text(
                      "Laundry Day ",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    onConfirm: (results) {
                      subjectData = [];
                      for (var i = 0; i < results.length; i++) {
                        SubjectModel data = results[i] as SubjectModel;
                        print(data.subjectId);
                        print(data.subjectName);
                        subjectData.add(data.subjectId);
                      }
                      print("data $subjectData");

                      //_selectedAnimals = results;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Select Pickup time ",
                    style: TextStyle(
                      fontFamily: "Gilroy Medium",
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  MultiSelectDialogField(
                    //     height: 200,
                    items: controller.dropDownData,
                    title: const Text(
                      "Select Pickup time ",
                      style: TextStyle(color: Colors.black),
                    ),
                    selectedColor: Colors.black,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                      border: Border.all(
                        color: Colors.black,
                        width: 2,
                      ),
                    ),
                    buttonIcon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.blue,
                    ),
                    buttonText: const Text(
                      "Select Pickup time ",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    onConfirm: (results) {
                      subjectData = [];
                      for (var i = 0; i < results.length; i++) {
                        SubjectModel data = results[i] as SubjectModel;
                        print(data.subjectId);
                        print(data.subjectName);
                        subjectData.add(data.subjectId);
                      }
                      print("data $subjectData");

                      //_selectedAnimals = results;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Select Delivery time ",
                    style: TextStyle(
                      fontFamily: "Gilroy Medium",
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  MultiSelectDialogField(
                    //     height: 200,
                    items: controller.dropDownData,
                    title: const Text(
                      "Select Delivery time ",
                      style: TextStyle(color: Colors.black),
                    ),
                    selectedColor: Colors.black,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                      border: Border.all(
                        color: Colors.black,
                        width: 2,
                      ),
                    ),
                    buttonIcon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.blue,
                    ),
                    buttonText: const Text(
                      "Select Delivery time ",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    onConfirm: (results) {
                      subjectData = [];
                      for (var i = 0; i < results.length; i++) {
                        SubjectModel data = results[i] as SubjectModel;
                        print(data.subjectId);
                        print(data.subjectName);
                        subjectData.add(data.subjectId);
                      }
                      print("data $subjectData");

                      //_selectedAnimals = results;
                    },
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  GestButton(
                    Width: Get.size.width,
                    height: 50,
                    buttoncolor: blueColor,
                    margin: EdgeInsets.only(top: 15, left: 30, right: 30),
                    buttontext: "Save".tr,
                    style: TextStyle(
                      fontFamily: FontFamily.gilroyBold,
                      color: WhiteColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
