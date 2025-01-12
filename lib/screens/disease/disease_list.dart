import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:farmer/controller/disease_ctrl.dart';
import 'package:farmer/import.dart';
import 'package:farmer/screens/disease/disease_detail.dart';
import 'package:farmer/widgets/emptry_container.dart';

class DiseaseList extends StatelessWidget {
  final dynamic crop;
  DiseaseList({Key? key, required this.crop}) : super(key: key);
  final diseasetrl = Get.put(DiseaseController());

  @override
  Widget build(BuildContext context) {
    diseasetrl.getDiseaseList(crop["pk_faa_crop_id"]);

    return AppContainer(
      appBar: AppBar(
        title: Text(crop["crop_name"]).tr(),
      ),
      child: Obx(
        () => diseasetrl.diseaseList.isEmpty
            ? const EmptryContainer()
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: [
                    ...diseasetrl.diseaseList.map((x) => dashboardCard(x))
                  ],
                ),
              ),
      ),
    );
  }

  Widget dashboardCard(dynamic diseases) {
    return InkWell(
      onTap: () => Get.to(
          DiseaseDetail(cropName: crop["crop_name"], diseases: diseases)),
      child: Column(
        children: [
          diseases["images"].length == 0
              ? Container(
                  height: 200.0,
                  width: Get.width,
                  color: Colors.green.shade50,
                )
              : CarouselSlider(
                  options: CarouselOptions(height: 200.0, aspectRatio: 1),
                  items: diseases["images"].map<Widget>((i) {
                    return Image.network(
                      i["image_file"],
                      fit: BoxFit.cover,
                      width: Get.width,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.green,
                        );
                      },
                    );
                  }).toList(),
                ),
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            child: Text(
              diseases["common_name"],
              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400),
            ),
          )
        ],
      ),
    );
  }
}
