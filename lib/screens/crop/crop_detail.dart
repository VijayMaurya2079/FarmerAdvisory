import 'package:easy_localization/easy_localization.dart';
import 'package:farmer/controller/crop_ctrl.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../import.dart';

class CropDetail extends StatelessWidget {
  final String cropName;
  final String cropId;
  CropDetail({Key? key, required this.cropId, required this.cropName})
      : super(key: key);

  final cropCtrl = Get.find<CropController>();

  @override
  Widget build(BuildContext context) {
    cropCtrl.getCropDetail(cropId);
    return AppContainer(
      appBar: AppBar(
        title: Text(cropName),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
          child: Obx(
            () => cropCtrl.cropDetail.value["crop_name"].toString() == ""
                ? const SizedBox()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              color: Theme.of(context).colorScheme.tertiary,
                              height: 60,
                              width: 60,
                              child: Image.network(
                                cropCtrl.cropDetail.value["crop_icon_image"],
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.asset(ICON_CROPS);
                                },
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            (cropCtrl.cropDetail.value["crop_name"] ?? "")
                                .toString()
                                .toUpperCase(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp,
                                color: Colors.green.shade800),
                          ),
                        ],
                      ),
                      SizedBox(height: 2.h),
                      Stack(
                        children: [
                          Container(
                            width: Get.width,
                            height: 200,
                            decoration:
                                const BoxDecoration(color: Colors.black12),
                            child: Image.network(
                              "${cropCtrl.cropDetail.value["crop_icon_image"] ?? ""}",
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  ICON_CROPS,
                                  color: Colors.white12,
                                );
                              },
                            ),
                          ),
                          Positioned(
                            right: 5,
                            bottom: 5,
                            child: IconButton(
                              icon: Icon(
                                Icons.favorite,
                                color:
                                    cropCtrl.cropDetail.value["my_favorite"] ==
                                            1
                                        ? Colors.red
                                        : Colors.white,
                                size: 30.sp,
                              ),
                              onPressed: () async {
                                await DBServices.call.addFavorite(cropCtrl
                                    .cropDetail.value["pk_faa_crop_id"]
                                    .toString());
                                cropCtrl.getCropDetail(cropId);
                              },
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        "crop_detail.common_name",
                        style: TextStyle(
                            color: Colors.green.shade800,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700),
                      ).tr(),
                      Text(
                        cropCtrl.cropDetail.value["vernacular_name"] ?? "",
                        style: TextStyle(fontSize: 12.sp),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        "crop_detail.botanical_name",
                        style: TextStyle(
                            color: Colors.green.shade800,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700),
                      ).tr(),
                      Text(
                        cropCtrl.cropDetail.value["botanical_name"] ?? "",
                        style: TextStyle(
                            fontSize: 12.sp, fontStyle: FontStyle.italic),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        "crop_detail.crop_description",
                        style: TextStyle(
                            color: Colors.green.shade800,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700),
                      ).tr(),
                      Html(
                          data:
                              ("${cropCtrl.cropDetail.value["crop_description"] ?? ""}")),
                      SizedBox(height: 2.h),
                      Text(
                        "crop_detail.popular_variety",
                        style: TextStyle(
                            color: Colors.green.shade800,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700),
                      ).tr(),
                      SizedBox(height: 2.h),
                      Column(
                        children: [
                          ...cropCtrl.cropDetail.value["varity"].map(
                            (v) => Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 4),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Chip(
                                        backgroundColor:
                                            const Color(0xffffa200),
                                        elevation: 0,
                                        labelStyle: const TextStyle(
                                            color: Colors.white),
                                        label: Text(v["varity_name"] ?? ""),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 30.w,
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.defaultDialog(
                                          title: "${v["varity_name"] ?? ""}",
                                          titleStyle: const TextStyle(
                                            color: Color(0xff8e050c),
                                            fontWeight: FontWeight.w800,
                                          ),
                                          content: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text.rich(
                                                TextSpan(children: [
                                                  TextSpan(
                                                    text: tr(
                                                        "know_more.botanical_name"),
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  const TextSpan(text: " "),
                                                  TextSpan(
                                                      text:
                                                          "${v["botanical_name"] ?? ""}"),
                                                ]),
                                              ),
                                              Text.rich(
                                                TextSpan(children: [
                                                  TextSpan(
                                                    text:
                                                        tr("know_more.detail"),
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  const TextSpan(text: " "),
                                                  TextSpan(
                                                      text:
                                                          "${v["variety_detials"] ?? ""}"),
                                                ]),
                                              ),
                                              const SizedBox(height: 20),
                                              if (v["variety_image_name"] !=
                                                  null)
                                                Image.network(
                                                    "${v["variety_image_name"] ?? ""}")
                                            ],
                                          ),
                                        );
                                      },
                                      child: const Text(
                                        "Know More",
                                        style: TextStyle(color: Colors.blue),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        "crop_detail.suitable_states_of_india",
                        style: TextStyle(
                            color: Colors.green.shade800,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700),
                      ).tr(),
                      Text(cropCtrl.cropDetail.value["state"]
                          .map((s) => s["state_name"] ?? "")
                          .join(',')),
                      SizedBox(height: 2.h),
                      Text(
                        "crop_detail.suitable_soil_type",
                        style: TextStyle(
                            color: Colors.green.shade800,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700),
                      ).tr(),
                      ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          ...cropCtrl.cropDetail.value["soil"].map(
                            (s) => Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 4),
                              child: Text(s["type_name"] ?? ""),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 2.h),
                      ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          ...cropCtrl.cropDetail.value["segment"].map(
                            (s) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${s["segment_name"] ?? ""}",
                                  style: TextStyle(
                                      color: Colors.green.shade800,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w700),
                                ),
                                Html(data: s["segment_details"] ?? ""),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        "crop_detail.crop_images",
                        style: TextStyle(
                            color: Colors.green.shade800,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700),
                      ).tr(),
                      Divider(
                          color: Theme.of(context)
                              .colorScheme
                              .tertiary
                              .withOpacity(0.2)),
                      GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 3,
                        crossAxisSpacing: 2,
                        mainAxisSpacing: 2,
                        children: [
                          ...cropCtrl.cropDetail.value["media"]
                              .where((x) => x["media_type"] == "Image")
                              .map(
                                (m) => Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color:
                                        Theme.of(context).colorScheme.tertiary,
                                  ),
                                  child: Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      Image.network(
                                        m["media_file"],
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Image.asset(ICON_CROPS);
                                        },
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        left: 0,
                                        right: 0,
                                        child: Container(
                                          height: 40,
                                          decoration: BoxDecoration(
                                            color:
                                                Colors.green.withOpacity(0.8),
                                            borderRadius:
                                                const BorderRadius.only(
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10),
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              m["media_title"],
                                              maxLines: 2,
                                              overflow: TextOverflow.clip,
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                        ],
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
