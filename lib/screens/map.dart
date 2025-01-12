import 'package:easy_localization/easy_localization.dart';
import 'package:farmer/import.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class MapScreen extends StatelessWidget {
  MapScreen({Key? key}) : super(key: key);
  final ctrl = Get.find<AppController>();
  @override
  Widget build(BuildContext context) {
    return AppContainer(
      appBar: AppBar(title: const Text("location_map.title").tr()),
      child: InAppWebView(
        initialUrlRequest: URLRequest(
            url: WebUri(
                'https://cimapfarmer.bitoapps.in/location_pointer.php?user=${ctrl.userId}')),
      ),
    );
  }
}
