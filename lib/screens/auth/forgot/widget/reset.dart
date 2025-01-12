import 'package:easy_localization/easy_localization.dart';
import 'package:farmer/import.dart';
import 'package:farmer/model/result.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Reset extends StatelessWidget {
  final AuthCtrl controller;
  final RxBool isLoading;
  final Function onStepChange;

  const Reset({
    Key? key,
    required this.controller,
    required this.isLoading,
    required this.onStepChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(height: 2.h),
      Text(
        "Reset Password",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
      ),
      const Text("We need to register your phone before getting started !"),
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
                      contentPadding: EdgeInsets.symmetric(horizontal: 10)),
                ),
              ),
            ),
            const Text("|", style: TextStyle(fontSize: 33, color: Colors.grey)),
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
        () => isLoading.value
            ? const CircularProgressIndicator()
            : AppElevatedButton("Reset", () async {
                FocusScope.of(context).unfocus();
                signInWithPhone();
              }, size: 300),
      ),
    ]);
  }

  Future<void> signInWithPhone() async {
    try {
      isLoading.value = true;
      Result result =
          await DBServices.call.checkUser(controller.loginCtrl.text);
      if (result.status) {
        await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: "+91${controller.loginCtrl.text}",
          verificationCompleted: (PhoneAuthCredential credential) async {
            isLoading.value = false;
            //await FirebaseAuth.instance.signInWithCredential(credential);
            onStepChange("addpassword");
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
            onStepChange("verify");
          },
          codeAutoRetrievalTimeout: (String verificationId) {
            isLoading.value = false;
          },
        );
      } else {
        isLoading.value = false;
        utility.showSnackbar(
          title: "Error",
          message: "User not registered. Kindly register as a New User.",
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
