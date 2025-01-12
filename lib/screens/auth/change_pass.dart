import 'package:farmer/import.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final authCtrl = Get.find<AuthCtrl>();
  final formState = GlobalKey<FormState>();

  RxInt selectedIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      appBar: AppBar(title: Image.asset(LOGO, height: 40)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Form(
                key: formState,
                child: Column(children: [
                  Text(
                    "Change Password",
                    style:
                        TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 30),
                  AppTextFormField(
                      title: "Enter Old Password",
                      controller: authCtrl.passwordCtrl,
                      obscureText: true,
                      onValidate: validate.requireValidation),
                  AppTextFormField(
                      title: "Enter New Password",
                      controller: authCtrl.npasswordCtrl,
                      obscureText: true,
                      onValidate: validate.requireValidation),
                  AppTextFormField(
                    title: "Confirm New Password",
                    onValidate: (value) => validate.confirmPasswordValidation(
                      value,
                      authCtrl.passwordCtrl.text,
                    ),
                  ),
                  // AppSmallElevatedButton("Update Password", () async {
                  //   formState.currentState!.save();
                  //   if (formState.currentState!.validate()) {
                  //     await authCtrl.chnagePassword();
                  //   }
                  // })
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
