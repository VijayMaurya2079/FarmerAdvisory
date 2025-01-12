import 'package:easy_localization/easy_localization.dart';
import 'package:farmer/widgets/custome_title.dart';
import 'package:photo_view/photo_view.dart';

import '../../import.dart';

class DiseaseDetail extends StatelessWidget {
  final String cropName;
  final dynamic diseases;
  const DiseaseDetail(
      {Key? key, required this.cropName, required this.diseases})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      appBar: AppBar(title: Text(cropName)),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(
              //   diseases["disease_name"].toString().toUpperCase(),
              //   style: TextStyle(
              //     fontWeight: FontWeight.bold,
              //     fontSize: 16.sp,
              //   ),
              // ),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  ...diseases["images"].map<Widget>((i) {
                    return InkWell(
                      onTap: () => Get.bottomSheet(
                        barrierColor: Colors.transparent,
                        PhotoView(
                          customSize: Size(Get.width, Get.height),
                          basePosition: Alignment.center,
                          imageProvider: NetworkImage(i["image_file"]),
                        ),
                      ),
                      child: SizedBox(
                        height: 120,
                        width: 120,
                        child: Image.network(
                          i["image_file"],
                          fit: BoxFit.fill,
                          width: Get.width,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              ICON_CROPS,
                              color: Colors.grey.shade200,
                            );
                          },
                        ),
                      ),
                    );
                  })
                ],
              ),
              CustomeTitle(
                title: tr("disease.name"),
                value: diseases["common_name"].toString(),
              ),
              CustomeTitle(
                title: tr("disease.symptoms"),
                value: diseases["disease_detials"].toString(),
              ),
              // CustomeTitle(
              //   title: "Infection Type",
              //   value: diseases["infection_type"].toString(),
              // ),
              CustomeTitle(
                title: tr("disease.management"),
                value: diseases["organic_remedy"].toString(),
              ),
              // CustomeTitle(
              //   title: "Inorganic Remedy",
              //   value: diseases["inorganic_remedy"].toString(),
              // ),
              // CustomeTitle(
              //   title: "How To Apply",
              //   value: diseases["how_to_apply"].toString(),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
