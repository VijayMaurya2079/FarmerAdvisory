import 'package:easy_localization/easy_localization.dart';
import 'package:farmer/controller/crop_ctrl.dart';
import 'package:farmer/screens/crop/crop_detail.dart';
import 'package:farmer/widgets/emptry_container.dart';

import '../../import.dart';

class Crops extends StatelessWidget {
  Crops({Key? key}) : super(key: key);
  final cropCtrl = Get.find<CropController>();

  @override
  Widget build(BuildContext context) {
    cropCtrl.getCropList();
    return AppContainer(
      appBar: AppBar(
        title: Text(
          "dashboard.crops",
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ).tr(),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, left: 4, right: 4),
        child: Obx(
          () => cropCtrl.cropList.isEmpty
              ? const EmptryContainer()
              : GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  childAspectRatio: 1.08,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  children: [...cropCtrl.cropList.map((x) => dashboardCard(x))],
                ),
        ),
      ),
    );
  }

  Widget dashboardCard(dynamic crop) {
    return InkWell(
      onTap: () {
        cropCtrl.cropDetail({"crop_name": ""});
        Get.to(
          CropDetail(
              cropId: crop["pk_faa_crop_id"],
              cropName: crop["crop_name"] ?? ""),
        );
      },
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.shade100,
                border: Border.all(color: Colors.grey.shade300, width: 2),
              ),
              child: Image.network(
                crop["crop_icon_image"],
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(ICON_CROPS, color: Colors.grey.shade200);
                },
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                color: Colors.green.shade600,
                border: Border.all(color: Colors.grey.shade300, width: 2),
              ),
              child: Center(
                child: Text(
                  crop["crop_name"] ?? "",
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.green.shade50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
