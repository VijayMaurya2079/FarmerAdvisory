import 'package:farmer/import.dart';
import 'package:farmer/widgets/emptry_container.dart';
import 'package:flutter_html/flutter_html.dart';

class ProcessDetail extends StatelessWidget {
  final String id;
  ProcessDetail({Key? key, required this.id}) : super(key: key);

  final appCtrl = Get.find<AppController>();

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      appBar: AppBar(),
      child: FutureBuilder<dynamic>(
          future: appCtrl.getProcessDetail(id),
          builder: (context, snapshot) {
            final data = snapshot.data;
            return data == null
                ? const EmptryContainer()
                : SingleChildScrollView(
                    child: ListTile(
                      title: Text(
                        data["heading"].toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(children: [
                        if (data["image_url"] != null)
                          Image.network(data["image_url"]),
                        Html(data: data["content"].toString()),
                      ]),
                    ),
                  );
          }),
    );
  }
}
