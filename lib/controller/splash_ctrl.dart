import 'package:farmer/import.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashCtrl());
  }
}

class SplashCtrl extends GetxController {
  @override
  Future<void> onReady() async {
    super.onReady();
    final user = await StorageService.to.read("id");
    if (user != null) {
      Future.delayed(
        const Duration(milliseconds: 400),
        () => Get.offAllNamed("home"),
      );
    } else {
      Future.delayed(
        const Duration(milliseconds: 900),
        () => Get.offAllNamed("intro"),
      );
    }
  }
}
