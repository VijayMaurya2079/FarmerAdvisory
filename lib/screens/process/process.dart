import 'package:easy_localization/easy_localization.dart';
import 'package:farmer/import.dart';
import 'package:farmer/screens/process/process_detail.dart';
import 'package:farmer/widgets/emptry_container.dart';

class ProcessScreen extends StatelessWidget {
  final String title;
  final String processType;
  ProcessScreen({Key? key, required this.title, required this.processType})
      : super(key: key);
  final appCtrl = Get.find<AppController>();

  @override
  Widget build(BuildContext context) {
    appCtrl.getProcess(processType);
    return AppContainer(
      appBar: AppBar(title: Text(title).tr()),
      child: Obx(
        () => appCtrl.processList.isEmpty
            ? const EmptryContainer()
            : ListView(children: [
                ...appCtrl.processList.map(
                  (e) => Container(
                    margin: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: ListTile(
                      onTap: () => Get.to(
                        ProcessDetail(id: e["id"].toString()),
                        fullscreenDialog: true,
                      ),
                      title: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text(e["heading"]),
                      ),
                      subtitle: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.person, size: 12.sp),
                                Text(e["user_name"]),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.timelapse, size: 12.sp),
                                Text(e["ins_date"]),
                              ],
                            )
                          ]),
                      trailing: const Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                )
              ]),
      ),
    );
  }
}
