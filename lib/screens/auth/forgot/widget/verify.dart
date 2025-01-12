import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pinput/pinput.dart';
import '/import.dart';

class VerifyMobileForResetScreen extends StatelessWidget {
  final RxBool isLoading;
  final Function onStepChange;

  VerifyMobileForResetScreen({
    Key? key,
    required this.isLoading,
    required this.onStepChange,
  }) : super(key: key);

  final pinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    return Column(
      children: [
        SizedBox(height: 2.h),
        Text(
          "Enter OTP",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
        ),
        const Text("We need to register your phone before getting started !"),
        SizedBox(height: 4.h),
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
            onStepChange("mobile");
          },
          child: const Text("otp.btn_resend").tr(),
        )
      ],
    );
  }

  Future<void> validatePhoneOTP(auth) async {
    isLoading.value = true;
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: LoginScreen.verificationId,
        smsCode: pinController.text,
      );
      UserCredential user = await auth.signInWithCredential(credential);
      if (user.user != null) {
        isLoading.value = false;
        onStepChange("addpassword");
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
