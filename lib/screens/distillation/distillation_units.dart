import 'package:easy_localization/easy_localization.dart';
import 'package:farmer/controller/distillation_ctrl.dart';
import 'package:farmer/import.dart';
import 'package:farmer/screens/distillation/add_distillation.dart';
import 'package:farmer/widgets/emptry_container.dart';

class DistillationUnits extends StatelessWidget {
  DistillationUnits({Key? key}) : super(key: key);
  final distillationCtrl = Get.put(DistillationController());

  @override
  Widget build(BuildContext context) {
    distillationCtrl.getDistillationList();
    return AppContainer(
      appBar: AppBar(
        title: Text(
          "distillation.title",
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ).tr(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(AddDistillation()),
        child: const Icon(Icons.add),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, left: 4, right: 4),
        child: Obx(
          () => distillationCtrl.distillationList.isEmpty
              ? const EmptryContainer()
              : ListView(
                  shrinkWrap: true,
                  children: [
                    ...distillationCtrl.distillationList.map(
                      (x) => Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.black12,
                              width: 1,
                            ),
                          ),
                        ),
                        child: ListTile(
                          title: Text(
                              "${x["address"]},${x["city_name"]},${x["state_name"]}"),
                          subtitle: Text("Pincode ${x["pincode"]}"),
                        ),
                      ),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
