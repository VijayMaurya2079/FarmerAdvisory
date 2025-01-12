import 'dart:ui';

import 'package:farmer/controller/crop_ctrl.dart';
import 'package:farmer/import.dart';
import 'package:farmer/model/result.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:in_app_update/in_app_update.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthCtrl());
    Get.lazyPut(() => AppController());
    Get.lazyPut(() => CropController());
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  DartPluginRegistrant.ensureInitialized();
  final appCtrl = Get.find<AppController>();
  GetStorage box = GetStorage();
  box.writeIfNull("unreadN", 0);
  appCtrl.unreadN.value = await box.read("unreadN");
  appCtrl.unreadN.value += 1;
  await box.write("unreadN", appCtrl.unreadN.value);
}

class AppController extends GetxController {
  RxString selectedLanguage = "English".obs;
  RxString selectedUserType = "Farmer".obs;
  RxString mobileNumber = "".obs;
  RxString userId = "".obs;
  RxString profilePic = "".obs;
  RxString name = "".obs;
  RxString type = "".obs;

  RxList faqList = [].obs;
  RxList advertisementList = [].obs;
  RxList processList = [].obs;
  RxInt unreadN = 0.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    final id = await StorageService.to.read("id");
    if (id != null) {
      final result = await DBServices.call.profile();
      if (result.status) {
        userId.value = result.data["pk_frm_customer_id"];
        name.value = result.data["customer_name"];
        type.value = result.data["customer_type"];

        FirebaseMessaging.instance.subscribeToTopic("all");
        if (type.value == "Farmer") {
          FirebaseMessaging.instance.subscribeToTopic("Farmer");
        }
        FirebaseMessaging.instance.getToken().then((value) async {
          await DBServices.call.updateFirebaseToken(value ?? "");
        });
        unreadN.value = await StorageService.to.read("unreadN");
      } else {
        logout();
      }
    }
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      unreadN.value = await StorageService.to.read("unreadN");
      unreadN.value += 1;
      await StorageService.to.write("unreadN", unreadN.value);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      unreadN.value = await StorageService.to.read("unreadN");
      unreadN.value += 1;
      await StorageService.to.write("unreadN", unreadN.value);

      if (message.data["navigation"] == "/notification") {
        Get.toNamed("notification");
      }
      if (message.data["navigation"] == "/chat") {
        Get.toNamed("chat");
      }
    });
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    selectedLanguage.value =
        Get.locale!.languageCode == "hi" ? "Hindi" : "English";
    unreadN.value = await StorageService.to.read("unreadN");
    getProfileDP();
    getAdvertisement();
  }

  Future<void> checkForUpdate() async {
    InAppUpdate.checkForUpdate().then((info) {
      if (info.updateAvailability == UpdateAvailability.updateAvailable) {
        Get.defaultDialog(
            title: "Update Avilable",
            barrierDismissible: false,
            actions: [
              TextButton(
                onPressed: () => Get.back(),
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  InAppUpdate.performImmediateUpdate();
                },
                child: const Text("Update"),
              )
            ]);
      }
    }).catchError((e) {});
  }

  getAdvertisement() async {
    Result result = await DBServices.call.advertisement();
    if (result.status) {
      advertisementList(result.data);
    }
  }

  getFaq(String cid) async {
    Result result = await DBServices.call.faq(cid);
    if (result.status) {
      faqList.value = result.data;
    }
  }

  getProcess(String processType) async {
    Result result = await DBServices.call.process(processType);
    if (result.status) {
      processList.value = result.data;
    }
  }

  getProcessDetail(String id) async {
    Result result = await DBServices.call.processDetail(id);
    return result.data;
  }

  getProfileDP() async {
    Result result = await DBServices.call.dp(userId.value);
    if (result.status) {
      profilePic.value = result.data;
    }
  }

  getProfile() async {
    final result = await DBServices.call.profile();
    if (result.status) {
      userId.value = result.data["pk_frm_customer_id"];
      name.value = result.data["customer_name"];
      type.value = result.data["customer_type"];

      unreadN.value = await StorageService.to.read("unreadN");
    }
  }

  logout() async {
    await StorageService.to.delete("user");
    await StorageService.to.delete("id");
    await FirebaseAuth.instance.signOut();
    Get.offAllNamed("");
  }
}
