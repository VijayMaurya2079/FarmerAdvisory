import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:farmer/import.dart';
import 'package:farmer/model/result.dart';
import 'package:farmer/screens/chat.dart';
import 'package:farmer/screens/crop/crops.dart';
import 'package:farmer/screens/crop/my_crops.dart';
import 'package:farmer/screens/disease/crop_list.dart';
import 'package:farmer/screens/faq/faq_crops.dart';
import 'package:farmer/screens/map.dart';
import 'package:farmer/screens/map_distillation.dart';
import 'package:farmer/screens/marketplace/marketplace.dart';
import 'package:farmer/screens/menu.dart';
import 'package:farmer/screens/notification.dart';
import 'package:farmer/screens/process/process_type.dart';
import 'package:farmer/screens/profile.dart';
import 'package:farmer/screens/weather_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends GetView<AppController> {
  const HomeScreen({super.key});

  BoxDecoration hasImage(url) {
    return BoxDecoration(
        image: DecorationImage(image: NetworkImage(url), fit: BoxFit.cover));
  }

  BoxDecoration dontHaveImage() {
    return BoxDecoration(color: Colors.green.shade200);
  }

  @override
  Widget build(BuildContext context) {
    controller.checkForUpdate();
    return AppContainer(
      appBar: AppBar(
        leadingWidth: 0,
        leading: const SizedBox.shrink(),
        title: Row(
          children: [
            Image.asset(LOGO, height: 40),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                "CSIR-Aroma",
                style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        actions: [
          SizedBox(
            width: 110,
            child: Obx(
              () => DropdownButtonHideUnderline(
                child: DropdownButton2<String>(
                  isExpanded: true,
                  isDense: true,
                  dropdownStyleData: const DropdownStyleData(
                    decoration: BoxDecoration(color: Colors.green),
                  ),
                  iconStyleData:
                      const IconStyleData(iconEnabledColor: Colors.white),
                  style: const TextStyle(color: Colors.white),
                  items: ["Hindi", "English"]
                      .map(
                        (String e) => DropdownMenuItem<String>(
                          value: e,
                          child: Text(
                            e,
                            style: const TextStyle(
                              color: Colors.white,
                              overflow: TextOverflow.clip,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  value: controller.selectedLanguage.value,
                  onChanged: (String? value) async {
                    final lang = value.toString().substring(0, 2).toLowerCase();
                    await context.setLocale(Locale(lang));
                    Get.updateLocale(Locale(lang));
                    controller.selectedLanguage.value = value ?? "English";
                    await DBServices.call.updateLanguage(value ?? "English");
                  },
                ),
              ),
            ),
          ),
          Stack(
            children: [
              InkWell(
                onTap: () => Get.to(NotificationScreen()),
                child: const Icon(Icons.notifications),
              ),
              Obx(() => controller.unreadN.value > 0
                  ? Positioned(
                      right: 8,
                      top: 0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: const BoxDecoration(color: Colors.red),
                          child: Center(
                            child: Text(
                              controller.unreadN.value.toString(),
                              style: TextStyle(
                                  color: Colors.white, fontSize: 8.sp),
                            ),
                          ),
                        ),
                      ),
                    )
                  : const SizedBox())
            ],
          ),
          SizedBox(width: 2.w),
          InkWell(
            onTap: () => Get.to(MenuScreen(), fullscreenDialog: true),
            child: const Icon(
              Icons.settings,
              color: Colors.white,
            ),
          ),
          SizedBox(width: 2.w),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Obx(
              () => Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Obx(
                          () => GestureDetector(
                            onTap: () => Get.to(const ProfileScreen()),
                            child: CircleAvatar(
                              radius: 22,
                              backgroundColor: Colors.green.shade800,
                              child: CircleAvatar(
                                radius: 20,
                                backgroundImage: NetworkImage(
                                    "${controller.profilePic}?${DateTime.now().microsecondsSinceEpoch}"),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          controller.name.value,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.green.shade800,
                          ),
                        ),
                      ],
                    ),
                    const WeatherScreen(),
                  ],
                ),
              ),
            ),
            Obx(
              () => CarouselSlider(
                options: CarouselOptions(
                  height: 150.0,
                  viewportFraction: 0.99,
                  autoPlay: true,
                ),
                items: controller.advertisementList.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return InkWell(
                        onTap: () async {
                          if (i["url"] != "" && i["url"] != null) {
                            await launchUrl(
                              Uri.parse(i["url"]),
                              mode: LaunchMode.inAppBrowserView,
                            );
                          }
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(horizontal: 1.0),
                          decoration: i["imagename"] == ""
                              ? dontHaveImage()
                              : hasImage(i["imagename"]),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: i["imagename"] == ""
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        i["heading"],
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(i["text"]),
                                    ],
                                  )
                                : const SizedBox(),
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
            Obx(
              () => Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  childAspectRatio: 1 / 1.6,
                  children: [
                    dashboardCard(
                      tr("dashboard.crops"),
                      ICON_CROPS,
                      screen: Crops(),
                    ),
                    dashboardCard(
                      tr("dashboard.disease"),
                      ICON_DISEASE,
                      screen: CropList(),
                    ),
                    dashboardCard(
                      tr("dashboard.krishi_mitra"),
                      ICON_KRISHI_MITRA,
                      screen: ChatScreen(),
                    ),
                    dashboardCard(
                      tr("dashboard.market_place"),
                      ICON_MARKET_PLACE,
                      screen: Marketplace(),
                    ),
                    if (controller.type.value == "Farmer")
                      dashboardCard(
                        tr("dashboard.my_crops"),
                        ICON_MY_CROPS,
                        screen: MyCrops(),
                      ),
                    if (controller.type.value == "Farmer")
                      dashboardCard(
                        tr("dashboard.faq"),
                        ICON_HELP,
                        screen: FaqScreen(),
                      ),
                    dashboardCard(
                      tr("dashboard.process"),
                      ICON_PROCESS,
                      screen: const ProcessType(),
                    ),
                    if (controller.type.value == "Farmer")
                      dashboardCard(
                        tr("dashboard.distillation"),
                        ICON_DISTILLATION,
                        screen: MapDistillationScreen(),
                      ),
                    dashboardCard(
                      tr("dashboard.map"),
                      ICON_MAP,
                      screen: MapScreen(),
                    ),
                  ],
                ),
              ),
            ),
            FutureBuilder(
              future: DBServices.call.getDisclaimer(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text("Loading...");
                } else if (!snapshot.hasData) {
                  return const SizedBox();
                }
                Result? result = snapshot.data;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Disclaimer",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 9.sp),
                        ),
                        Text(result!.data["text"].toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 9.sp))
                      ]),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  Widget dashboardCard(String title, String icon, {Widget? screen}) {
    return InkWell(
      onTap: () => Get.to(screen),
      child: Column(
        children: [
          Container(
            height: 120,
            width: Get.width / 3.5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey.shade100,
              border: Border.all(color: Colors.grey.shade300, width: 2),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(icon),
            ),
          ),
          const SizedBox(height: 4),
          Container(
            height: 60,
            width: Get.width / 3.5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey.shade100,
              border: Border.all(color: Colors.grey.shade300, width: 2),
            ),
            child: Center(
              child: Text(
                title,
                overflow: TextOverflow.clip,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.green.shade800,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
