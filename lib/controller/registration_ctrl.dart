import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(RegisterCtrl());
  }
}

class RegisterCtrl extends GetxController {
  final String preferedLanguage = "English";
  final String customerType = "Farmer";
  final nameCtrl = TextEditingController();
  final mobileCtrl = TextEditingController();
  final stateCtrl = TextEditingController();
  final regionCtrl = TextEditingController();
  final districtCtrl = TextEditingController();
  final aadharCtrl = TextEditingController();

  @override
  Future<void> onReady() async {
    super.onReady();
  }

  register() async {}
}
