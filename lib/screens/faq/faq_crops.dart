import 'package:easy_localization/easy_localization.dart';
import 'package:farmer/controller/crop_ctrl.dart';
import 'package:farmer/import.dart';
import 'package:farmer/screens/faq/faq_list.dart';
import 'package:farmer/widgets/emptry_container.dart';

class FaqScreen extends StatelessWidget {
  FaqScreen({Key? key}) : super(key: key);
  final cropCtrl = Get.find<CropController>();
  final appCtrl = Get.find<AppController>();

  @override
  Widget build(BuildContext context) {
    cropCtrl.getCropList();
    return AppContainer(
      appBar: AppBar(title: const Text("faq.title").tr()),
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, left: 4, right: 4),
        child: Obx(
          () => cropCtrl.cropList.isEmpty
              ? const EmptryContainer()
              : ListView(
                  shrinkWrap: true,
                  children: [...cropCtrl.cropList.map((x) => dashboardCard(x))],
                ),
        ),
      ),
    );
  }

  Widget dashboardCard(dynamic crop) {
    return InkWell(
      onTap: () {
        appCtrl.faqList([]);
        Get.to(FaqList(cid: crop["pk_faa_crop_id"]));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 120,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.shade100,
                border: Border.all(color: Colors.grey.shade300, width: 2),
              ),
              child: Image.network(
                crop["crop_icon_image"] ?? "",
                fit: BoxFit.fill,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(ICON_CROPS, color: Colors.grey.shade200);
                },
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    crop["crop_name"] ?? "",
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      color: Colors.green.shade800,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    crop["vernacular_name"] ?? "",
                    style: TextStyle(fontSize: 12.sp),
                  ),
                  Text(
                    crop["botanical_name"] ?? "",
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
