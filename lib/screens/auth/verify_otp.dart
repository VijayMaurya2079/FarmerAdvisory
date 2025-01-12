import 'package:easy_localization/easy_localization.dart';
import 'package:farmer/model/result.dart';
import 'package:farmer/screens/auth/complete_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pinput/pinput.dart';
import '/import.dart';

class VerifyOTPScreen extends GetView<AuthCtrl> {
  VerifyOTPScreen({super.key});
  final pinController = TextEditingController();
  final RxBool isLoading = false.obs;

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Image.asset("assets/otp.png"),
                SizedBox(height: 2.h),
                Text(
                  "Phone Verification",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
                ),
                const Text(
                    "We need to register your phone before getting started !"),
                SizedBox(height: 4.h),
                Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Pinput(controller: pinController, length: 6),
                      ),
                      Obx(
                        () => isLoading.value
                            ? const CircularProgressIndicator()
                            : AppElevatedButton(
                                size: 300,
                                tr("otp.btn_verify"),
                                () => validatePhoneOTP(auth),
                              ),
                      ),
                      TextButton(
                        onPressed: () async {
                          Get.back();
                        },
                        child: const Text("otp.btn_resend").tr(),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> validatePhoneOTP(FirebaseAuth auth) async {
    isLoading.value = true;
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: LoginScreen.verificationId,
        smsCode: pinController.text,
      );
      UserCredential user = await auth.signInWithCredential(credential);
      Result result =
          await DBServices.call.checkUser(user.user!.phoneNumber.toString());
      isLoading.value = false;
      if (!result.status) {
        Get.to(CompleteProfile(
            uid: user.user!.uid, mobile: controller.loginCtrl.text));
      } else {
        await StorageService.to.write("id", result.data);
        Get.offAllNamed("home");
      }
    } catch (e) {
      isLoading.value = false;
      utility.showSnackbar(
        title: "Error",
        message: e.toString(),
      );
    }
  }
}
