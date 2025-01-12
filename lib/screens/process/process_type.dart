import 'package:easy_localization/easy_localization.dart';
import 'package:farmer/import.dart';
import 'package:farmer/screens/process/process.dart';

class ProcessType extends StatelessWidget {
  const ProcessType({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      appBar: AppBar(),
      child: SizedBox(
        height: Get.height,
        width: Get.width,
        child: Column(
          children: [
            const SizedBox(height: 120),
            typeButtom("process_tech_pro.products", "Product",
                "assets/icon/product.png"),
            typeButtom("process_tech_pro.processing", "Process",
                "assets/icon/process.png"),
            typeButtom("process_tech_pro.units", "Technology",
                "assets/icon/technologies.png"),
          ],
        ),
      ),
    );
  }

  Widget typeButtom(title, name, icons) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () => Get.to(ProcessScreen(title: title, processType: name)),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.green.shade50,
                Colors.green.shade200,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            border: Border.all(color: Colors.green),
          ),
          child: ListTile(
            leading: Image.asset(
              icons,
              width: 40,
              height: 40,
              fit: BoxFit.cover,
              colorBlendMode: BlendMode.dstIn,
            ),
            title: Text(
              tr(title),
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
