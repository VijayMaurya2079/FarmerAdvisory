import 'package:easy_localization/easy_localization.dart';
import 'package:farmer/model/result.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '/import.dart';

class ResetPasswordScreen extends StatelessWidget {
  final AuthCtrl controller;
  final RxBool isLoading;
  final Function onStepChange;

  ResetPasswordScreen({
    Key? key,
    required this.controller,
    required this.isLoading,
    required this.onStepChange,
  }) : super(key: key);

  final passwordCtrl = TextEditingController();
  final npasswordCtrl = TextEditingController();

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
          child: AppTextFormField(
            hintText: "Enter new password",
            controller: passwordCtrl,
            obscureText: true,
            onValidate: validate.requireValidation,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: AppTextFormField(
            hintText: "Verify new password",
            controller: npasswordCtrl,
            obscureText: true,
            onValidate: (value) =>
                validate.confirmPasswordValidation(value, passwordCtrl.text),
          ),
        ),
        Obx(
          () => isLoading.value
              ? const CircularProgressIndicator()
              : AppElevatedButton(
                  size: 300,
                  "Reset Password",
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
    );
  }

  Future<void> validatePhoneOTP(auth) async {
    isLoading.value = true;

    final data = {
      "mobile_number": controller.loginCtrl.text,
      "password": passwordCtrl.text
    };
    Result result = await DBServices.call.forgotPassword(data);
    isLoading.value = false;
    if (result.status) {
      utility.showSnackbar(
          title: "Success", message: "Password updated successfully");
      Future.delayed(const Duration(milliseconds: 400), () {
        Get.offNamed("login");
      });
    } else {
      isLoading.value = false;
      utility.showSnackbar(
        title: "Error",
        message: result.message,
        type: AlertType.error,
      );
    }
  }
}
