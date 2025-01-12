import 'package:easy_localization/easy_localization.dart';
import 'package:farmer/import.dart';
import 'package:farmer/widgets/emptry_container.dart';
import 'package:flutter_html/flutter_html.dart';

class FaqList extends StatelessWidget {
  final String cid;
  FaqList({Key? key, required this.cid}) : super(key: key);
  final appCtrl = Get.find<AppController>();

  @override
  Widget build(BuildContext context) {
    appCtrl.getFaq(cid);
    return AppContainer(
      appBar: AppBar(title: const Text("faq.title").tr()),
      child: Obx(
        () => appCtrl.faqList.isEmpty
            ? const EmptryContainer()
            : ListView(children: [
                ...appCtrl.faqList.map(
                  (e) => Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: ListTile(
                      onTap: () {
                        Get.to(
                          Scaffold(
                            appBar: AppBar(),
                            body: Container(
                              alignment: Alignment.center,
                              child: ListTile(
                                  title: Text(
                                    e["question"] ?? "",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14.sp),
                                  ),
                                  subtitle: Html(data: e["answer"].toString())),
                            ),
                          ),
                          fullscreenDialog: true,
                        );
                      },
                      title: Text(e["question"] ?? ""),
                      trailing: const Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                )
              ]),
      ),
    );
  }
}
