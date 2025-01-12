import 'package:farmer/model/result.dart';
import 'package:farmer/screens/profile_edit.dart';
import 'package:farmer/widgets/uploader.dart';

import '../import.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final authCtrl = Get.find<AuthCtrl>();

  final appCtrl = Get.find<AppController>();

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      appBar: AppBar(title: const Text("Profile")),
      child: FutureBuilder(
        future: DBServices.call.profile(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            Result? result = snapshot.data;
            final profile = result!.data;
            return SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Center(
                      child: Uploader(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Obx(
                            () => Image.network(
                              "${appCtrl.profilePic}?${DateTime.now().microsecondsSinceEpoch}",
                              width: 200,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        action: (value) async {
                          final id = await StorageService.to.read("id");
                          final data = {"dp": value, "pk_frm_customer_id": id};
                          await DBServices.call.updateDP(data);
                          appCtrl.getProfileDP();
                        },
                      ),
                    ),
                    Center(
                      child: Uploader(
                        action: (value) async {
                          final id = await StorageService.to.read("id");
                          final data = {"dp": value, "pk_frm_customer_id": id};
                          await DBServices.call.updateDP(data);
                          appCtrl.getProfileDP();
                        },
                        child: Text(
                          "Change Profile Picture",
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.cyan,
                          ),
                        ),
                      ),
                    ),
                    row("Name", profile["customer_name"]),
                    row("Mobile", profile["mobile_number"]),
                    row("State", profile["state_name"]),
                    row("City", profile["city_name"]),
                    row("Aadhar", profile["aadhar_no"]),
                    row(
                        "Has Distillation Unit",
                        profile["has_distillation_unit"].toString() == "0"
                            ? "No"
                            : "Yes"),
                    if (profile["has_distillation_unit"].toString() == "0")
                      row("Distillation Address",
                          profile["distillation_unit_address"]),
                    TextButton(
                        onPressed: () => Get.to(ProfileEdit(profile: profile)),
                        child: const Text("Edit Profile"))
                  ]),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  Widget row(title, value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const TextSpan(text: " "),
            TextSpan(text: value ?? "")
          ],
        ),
      ),
    );
  }
}
