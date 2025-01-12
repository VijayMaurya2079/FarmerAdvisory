import 'package:farmer/import.dart';

class AppContainer extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget child;
  final Widget? floatingActionButton;
  AppContainer(
      {super.key, this.appBar, required this.child, this.floatingActionButton});
  final appCtrl = Get.find<AppController>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: appBar,
      body: Stack(
        fit: StackFit.expand,
        children: [
          child,
          Obx(() => DBServices.call.isLoading.value
              ? LoadingAnimationWidget.inkDrop(
                  color: Theme.of(context).colorScheme.primary,
                  size: 30,
                )
              : const SizedBox.shrink())
        ],
      ),
      floatingActionButton: floatingActionButton,
    );
  }
}
