import 'package:easy_localization/easy_localization.dart';
import 'package:farmer/screens/auth/verify_mobile.dart';

import '../../import.dart';

class ChooseProfile extends StatefulWidget {
  const ChooseProfile({Key? key}) : super(key: key);

  @override
  State<ChooseProfile> createState() => _ChooseProfileState();
}

class _ChooseProfileState extends State<ChooseProfile> {
  final appCtrl = Get.find<AppController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "profile.title",
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ).tr(),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              bottom: 10.h,
              child: Opacity(
                opacity: 0.05,
                child: Image.asset(
                  "assets/profile_type.png",
                  width: 100.w,
                ),
              ),
            ),
            Positioned(
              top: 16.h,
              left: 2.w,
              right: 2.w,
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 1,
                shrinkWrap: true,
                mainAxisSpacing: 2.h,
                crossAxisSpacing: 2.w,
                children: [
                  profileCard(tr("profile.farmer"), ICON_KISHAN, "Farmer"),
                  profileCard(tr("profile.buyer"), ICON_BUYER, "Buyer")
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(VerifyMobileScreen()),
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }

  Widget profileCard(String title, String icon, String profile) {
    return Obx(
      () => Column(
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(100),
            onTap: () => appCtrl.selectedUserType.value = profile,
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage(icon),
                ),
                CircleAvatar(
                  radius: 60,
                  backgroundColor: appCtrl.selectedUserType.value == profile
                      ? Colors.green.withOpacity(0.6)
                      : Colors.transparent,
                ),
              ],
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
              color: appCtrl.selectedUserType.value == icon
                  ? Colors.green.shade800
                  : Colors.grey,
            ),
          )
        ],
      ),
    );
  }
}
