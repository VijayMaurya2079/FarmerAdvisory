import 'package:farmer/import.dart';
import 'package:farmer/screens/profile.dart';
import 'package:url_launcher/url_launcher.dart';

class MenuScreen extends StatelessWidget {
  MenuScreen({Key? key}) : super(key: key);

  final appCtrl = Get.find<AppController>();
  @override
  Widget build(BuildContext context) {
    return AppContainer(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: const SizedBox(),
        actions: [
          IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.close),
            color: Colors.black,
          )
        ],
      ),
      child: SizedBox(
        width: Get.width,
        height: Get.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () => Get.off(const ProfileScreen()),
              child: const Text("Profile"),
            ),
            TextButton(
                onPressed: () {
                  launchUrl(
                      Uri.parse(
                          "https://cimapfarmer.bitoapps.in/privacy_policy.html"),
                      mode: LaunchMode.inAppWebView);
                },
                child: const Text("Privacy Policy")),
            TextButton(
                onPressed: () {
                  launchUrl(
                      Uri.parse("https://cimapfarmer.bitoapps.in/info.html"),
                      mode: LaunchMode.inAppWebView);
                },
                child: const Text("Info")),
            TextButton(
                onPressed: () {
                  appCtrl.logout();
                },
                child: const Text("Logout"))
          ],
        ),
      ),
    );
  }
}
