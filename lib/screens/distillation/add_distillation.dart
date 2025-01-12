import 'package:easy_localization/easy_localization.dart';
import 'package:farmer/controller/distillation_ctrl.dart';
import 'package:farmer/import.dart';
import 'package:farmer/widgets/custome_dropdown.dart';

class AddDistillation extends StatelessWidget {
  AddDistillation({Key? key}) : super(key: key);
  final distillationCtrl = Get.find<DistillationController>();
  final formState = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      appBar: AppBar(
        title: Text(
          "distillation.add",
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ).tr(),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formState,
          child: Column(children: [
            AppDropdown(
              title: tr("distillation.dd_state"),
              controller: distillationCtrl.stateCtrl,
              list: distillationCtrl.state,
              displayField: "state_name",
              filter: (value) => true,
              onChanged: (value) {
                distillationCtrl.stateID.value =
                    value["pk_utm_state_id"].toString();
              },
            ),
            AppDropdown(
              title: tr("distillation.dd_district"),
              controller: distillationCtrl.districtCtrl,
              list: distillationCtrl.district,
              displayField: "city_name",
              filter: (value) =>
                  value["fk_utm_state_id"].toString() ==
                  distillationCtrl.stateID.value.toString(),
              onChanged: (value) {
                distillationCtrl.districtID.value =
                    value["pk_utm_city_id"].toString();
              },
            ),
            AppTextFormField(
              title: tr("distillation.dd_address"),
              keyboardType: TextInputType.multiline,
              lines: 3,
              controller: distillationCtrl.addressCtrl,
            ),
            AppTextFormField(
              title: tr("distillation.dd_pincode"),
              controller: distillationCtrl.pincodeCtrl,
            ),
            AppElevatedButton(
                "Submit", () => distillationCtrl.addDistillation())
          ]),
        ),
      ),
    );
  }
}
