import 'import.dart';

class SplashScreen extends GetView<SplashCtrl> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: Get.width,
            height: Get.height,
            decoration: const BoxDecoration(
              color: Colors.white,
              // image: DecorationImage(
              //   image: AssetImage("assets/banner-2.jpg"),
              //   fit: BoxFit.cover,
              //   colorFilter: ColorFilter.mode(Colors.black, BlendMode.dstOver),
              //   opacity: 0.5,
              // ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 2,
              child: LinearProgressIndicator(
                backgroundColor: Colors.white,
                valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
          ),
          Positioned(
            left: 30.w,
            right: 30.w,
            top: 40.h,
            child: const SizedBox(),
          ),
        ],
      ),
    );
  }
}
