import 'package:farmer/import.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthCtrl());
  }
}

class AuthCtrl extends GetxController {
  final countryCtrl = TextEditingController(text: "+91");
  final loginCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final npasswordCtrl = TextEditingController();
  final RxString appVersion = "".obs;
  RxString formType = "Login".obs;

  @override
  Future<void> onReady() async {
    super.onReady();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appVersion(packageInfo.version);
  }

  // login() async {
  //   if (loginCtrl.text.isEmpty || passwordCtrl.text.isEmpty) return;
  //   Result result = await DBServices.call.login({
  //     "user_id": loginCtrl.text,
  //     "password": passwordCtrl.text,
  //   });
  //   if (result.status) {
  //     await StorageService.to.write("id", result.data["pk_usm_user_id"]);
  //     await StorageService.to.write("name", result.data["user_name"]);

  //     Get.offAllNamed("home");
  //     utility.showSnackbar(title: "Login Success", message: result.message);
  //   } else {
  //     utility.showSnackbar(
  //         title: "Login Fail", message: result.message, type: AlertType.error);
  //   }
  // }

  logout() async {
    await StorageService.to.delete("user");
    await StorageService.to.delete("id");
    Get.offAllNamed("login");
  }
}
