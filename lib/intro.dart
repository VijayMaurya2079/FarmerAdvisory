import 'package:farmer/screens/auth/language.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'import.dart';

class IntroScreen extends GetView<AuthCtrl> {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Colors.blue.shade900,
                Colors.blue.shade100,
                Colors.white,
              ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
            ),
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Image.asset(LOGO),
                SizedBox(height: 4.h),
                Text(
                  "CSIR-Aroma".toUpperCase(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28.sp,
                    letterSpacing: 3.0,
                    color: Colors.blue.shade900,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 4.h),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    border: Border.all(color: Colors.blue.shade800, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    onTap: () async {
                      await FirebaseAuth.instance.signOut();
                      Get.toNamed("login");
                    },
                    leading: const Icon(Icons.arrow_forward_rounded),
                    title: Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    border: Border.all(color: Colors.blue.shade800, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    onTap: () async {
                      await FirebaseAuth.instance.signOut();
                      Get.to(const Language());
                    },
                    leading: const Icon(Icons.arrow_forward_rounded),
                    title: Text(
                      "Don't have account ? Register now",
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
