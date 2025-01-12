import 'package:farmer/controller/auth_ctrl.dart';
import 'package:farmer/import.dart';
import 'package:url_launcher/url_launcher.dart';

class BottomBanner extends StatelessWidget {
  final AuthCtrl controller;
  const BottomBanner(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Theme.of(context).primaryColor, width: 15),
        ),
      ),
      height: 80,
      width: Get.width,
      child: Column(
        children: [
          Obx(
            () => Text(
              "VERSION ${controller.appVersion.value}",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 6.sp,
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "Privacy Policy ",
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              GestureDetector(
                onTap: () async {
                  final uri =
                      Uri.parse("https://aipamusic.com/privacy-policy.aspx");
                  if (!await launchUrl(uri)) {
                    throw Exception(
                        'Could not launch https://aipamusic.com/privacy-policy.aspx');
                  }
                },
                child: Text(
                  "click here",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "Powered By ",
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              Text(
                "Bito Technologies Private Limited",
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
