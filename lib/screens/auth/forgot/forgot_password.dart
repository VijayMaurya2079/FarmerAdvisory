import 'package:farmer/screens/auth/forgot/widget/forgot.dart';
import 'package:farmer/screens/auth/forgot/widget/reset.dart';
import 'package:farmer/screens/auth/forgot/widget/verify.dart';
import 'package:farmer/screens/auth/language.dart';
import '/import.dart';

class ForgotPasswordScreen extends GetView<AuthCtrl> {
  ForgotPasswordScreen({super.key});
  static String verificationId = "";
  final RxBool isLoading = false.obs;
  final RxString step = "mobile".obs;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Obx(
              () => Column(
                children: [
                  Image.asset("assets/login.png"),
                  if (step.value == "mobile")
                    Reset(
                      controller: controller,
                      isLoading: isLoading,
                      onStepChange: updateStep,
                    ),
                  if (step.value == "verify")
                    VerifyMobileForResetScreen(
                      isLoading: isLoading,
                      onStepChange: updateStep,
                    ),
                  if (step.value == "addpassword")
                    ResetPasswordScreen(
                      controller: controller,
                      isLoading: isLoading,
                      onStepChange: updateStep,
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
      ),
    );
  }

  updateStep(ss) {
    step(ss);
  }
}
