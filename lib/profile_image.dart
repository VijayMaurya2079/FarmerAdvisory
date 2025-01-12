import 'package:easy_localization/easy_localization.dart';
import 'package:farmer/model/result.dart';
import 'package:farmer/widgets/uploader.dart';

import 'import.dart';

class ProfileImage extends StatefulWidget {
  final String id;
  const ProfileImage({Key? key, required this.id}) : super(key: key);

  @override
  createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "upload_dp.title",
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ).tr(),
      ),
      body: SizedBox(
        width: Get.width,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: Opacity(
                opacity: 0.08,
                child: Image.asset(
                  "assets/profile_bg.png",
                  width: 100.w,
                ),
              ),
            ),
            Positioned(
              top: 80,
              left: (Get.width / 2) - 120,
              child: Uploader(
                action: (value) async {
                  final data = {"pk_frm_customer_id": widget.id, "dp": value};
                  Result result = await DBServices.call.updateDP(data);
                  if (result.status) {
                    Get.offAllNamed("home");
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed("home"),
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
}
