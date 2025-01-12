import 'package:easy_localization/easy_localization.dart';
import 'package:farmer/screens/auth/choose_profile.dart';

import '../../import.dart';

class Language extends StatefulWidget {
  const Language({Key? key}) : super(key: key);

  @override
  State<Language> createState() => _LanguageState();
}

class _LanguageState extends State<Language> {
  final appCtrl = Get.put(AppController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "language.title",
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ).tr(),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              bottom: 10.h,
              child: Opacity(
                opacity: 0.05,
                child: Image.asset(
                  "assets/language.jpg",
                  width: 100.w,
                ),
              ),
            ),
            Positioned(
              top: 16.h,
              left: 2.w,
              right: 2.w,
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 1,
                shrinkWrap: true,
                mainAxisSpacing: 2.h,
                crossAxisSpacing: 2.w,
                children: [
                  languageCard(tr("Hindi"), "hi.jpg"),
                  languageCard(tr("English"), "en.jpg")
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Get.to(const ChooseProfile());
        },
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }

  Widget languageCard(String title, String language) {
    return Obx(
      () => Column(
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(100),
            onTap: () async {
              final lang = language.toString().substring(0, 2).toLowerCase();
              await context.setLocale(Locale(lang));
              Get.updateLocale(Locale(lang));
              appCtrl.selectedLanguage.value = title;
            },
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage("assets/$language"),
                ),
                CircleAvatar(
                  radius: 60,
                  backgroundColor: appCtrl.selectedLanguage.value == title
                      ? Colors.green.withOpacity(0.6)
                      : Colors.transparent,
                ),
              ],
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
              color: appCtrl.selectedLanguage.value == language
                  ? Colors.green.shade800
                  : Colors.grey,
            ),
          )
        ],
      ),
    );
  }
}
