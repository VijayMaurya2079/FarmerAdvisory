import 'package:easy_localization/easy_localization.dart';
import 'package:farmer/model/result.dart';
import 'package:farmer/screens/auth/forgot/forgot_password.dart';
import 'package:farmer/screens/auth/language.dart';
import '/import.dart';

class LoginScreen extends GetView<AuthCtrl> {
  LoginScreen({super.key});
  static String verificationId = "";
  final RxBool isLoading = false.obs;

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
                  "Login by Phone Number",
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
                Container(
                  height: 55,
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: controller.passwordCtrl,
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Password",
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Obx(
                  () => isLoading.value
                      ? const CircularProgressIndicator()
                      : AppElevatedButton("Login", () async {
                          FocusScope.of(context).unfocus();
                          signInWithPhone();
                        }, size: 300),
                ),
                TextButton(
                  onPressed: () => Get.to(ForgotPasswordScreen()),
                  child: const Text("Forgot Passwrod"),
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
      Result result = await DBServices.call.login({
        "mobile_number": controller.loginCtrl.text,
        "password": controller.passwordCtrl.text,
      });
      if (result.status) {
        await StorageService.to.write("id", result.data["pk_frm_customer_id"]);
        await StorageService.to.write("unreadN", 0);
        isLoading.value = false;
        Get.offAndToNamed("home");
      } else {
        isLoading.value = false;
        utility.showSnackbar(
          title: "Error",
          message: result.message,
          type: AlertType.error,
        );
      }
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
