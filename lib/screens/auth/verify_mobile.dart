import 'package:easy_localization/easy_localization.dart';
import 'package:farmer/model/result.dart';
import 'package:farmer/screens/auth/complete_profile.dart';
import 'package:farmer/screens/auth/language.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:url_launcher/url_launcher.dart';
import '/import.dart';

class VerifyMobileScreen extends GetView<AuthCtrl> {
  VerifyMobileScreen({super.key});
  static String verificationId = "";
  final RxBool isLoading = false.obs;
  final RxBool isConditionAcceptes = false.obs;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Image.asset("assets/login.png"),
                SizedBox(height: 2.h),
                Text(
                  "Phone Verification",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
                ),
                const Text(
                    "We need to register your phone before getting started !"),
                SizedBox(height: 4.h),
                Container(
                  height: 55,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 50,
                        child: AbsorbPointer(
                          absorbing: true,
                          child: TextField(
                            controller: controller.countryCtrl,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 10)),
                          ),
                        ),
                      ),
                      const Text("|",
                          style: TextStyle(fontSize: 33, color: Colors.grey)),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: controller.loginCtrl,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: tr("login.tb_mobile"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Obx(
                  () => CheckboxListTile(
                      value: isConditionAcceptes.value,
                      controlAffinity: ListTileControlAffinity.leading,
                      title: SizedBox(
                        width: 60.w,
                        child: Wrap(
                          children: [
                            Text(
                              "I agree to get updates from CSIR-AROMA",
                              style: TextStyle(fontSize: 10.sp),
                            ),
                            GestureDetector(
                              onTap: () async {
                                await launchUrl(
                                    Uri.parse(
                                        "https://cimapfarmer.bitoapps.in/privacy_policy.html"),
                                    mode: LaunchMode.inAppWebView);
                              },
                              child: const Text(
                                " Privacy & Policys",
                                style: TextStyle(color: Colors.blue),
                              ),
                            )
                          ],
                        ),
                      ),
                      onChanged: (value) {
                        isConditionAcceptes(value);
                      }),
                ),
                Obx(
                  () => isLoading.value
                      ? const CircularProgressIndicator()
                      : AppElevatedButton("Login", () async {
                          if (!isConditionAcceptes.value) {
                            utility.showSnackbar(
                              title: "Warning",
                              message: "Kindly accept terms and condition.",
                              type: AlertType.warning,
                            );
                            return;
                          }
                          if (controller.loginCtrl.text == "") return;
                          FocusScope.of(context).unfocus();
                          signInWithPhone();
                        }, size: 300),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () => Get.to(const Language()),
                  child: const Text("Don't have account? Register here"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signInWithPhone() async {
    try {
      isLoading.value = true;
      Result result =
          await DBServices.call.checkUser(controller.loginCtrl.text);
      if (result.status) {
        isLoading.value = false;
        utility.showSnackbar(
          title: "Verification Fail",
          message: "Mobile number already regestered.",
          type: AlertType.error,
        );
        return;
      }
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "+91${controller.loginCtrl.text}",
        verificationCompleted: (PhoneAuthCredential credential) async {
          isLoading.value = false;
          //await FirebaseAuth.instance.signInWithCredential(credential);
          Get.to(CompleteProfile(uid: "", mobile: controller.loginCtrl.text));
        },
        verificationFailed: (FirebaseAuthException e) {
          isLoading.value = false;
          utility.showSnackbar(
            title: "Verification Fail",
            message: e.message!,
            type: AlertType.error,
          );
        },
        codeSent: (String verificationId, int? resendToken) async {
          isLoading.value = false;
          LoginScreen.verificationId = verificationId;

          Get.toNamed("otp");
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          isLoading.value = false;
        },
      );
    } catch (e) {
      isLoading.value = false;
      utility.showSnackbar(
        title: "Verification Fail",
        message: "Error during phone authentication",
        type: AlertType.error,
      );
    }
  }
}
