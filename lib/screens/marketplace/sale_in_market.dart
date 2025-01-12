import 'package:easy_localization/easy_localization.dart';
import 'package:farmer/controller/marketplace_ctrl.dart';
import 'package:farmer/import.dart';
import 'package:farmer/widgets/custome_dropdown.dart';

class SaleInMarket extends StatelessWidget {
  SaleInMarket({Key? key}) : super(key: key);
  final marketplaceCtrl = Get.find<MarketplaceController>();
  final remarkCtrl = TextEditingController();
  final fromState = GlobalKey<FormState>();
  final isChecked = false.obs;

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      appBar: AppBar(title: const Text("sale.title").tr()),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              key: fromState,
              child: Column(children: [
                AppDropdown(
                  title: tr("sale.crop_name"),
                  list: marketplaceCtrl.list,
                  displayField: "crop_name",
                  filter: (value) => true,
                  onChanged: (value) =>
                      marketplaceCtrl.cropID(value["pk_faa_crop_id"]),
                  onValidate: validate.requireValidation,
                  controller: marketplaceCtrl.cropCtrl,
                ),
                AppTextFormField(
                  title: tr("sale.varity_name"),
                  onValidate: validate.requireValidation,
                  controller: marketplaceCtrl.verityNameCtrl,
                ),
                AppTextFormField(
                  title: tr("sale.enter_quantity"),
                  onValidate: validate.requireValidation,
                  controller: marketplaceCtrl.requirementCtrl,
                ),
                Obx(
                  () => CheckboxListTile(
                    value: isChecked.value,
                    controlAffinity: ListTileControlAffinity.leading,
                    title: const Text("sale.condition").tr(),
                    onChanged: (value) => isChecked(value),
                  ),
                ),
                AppSmallElevatedButton("Submit", () async {
                  if (isChecked.value) {
                    marketplaceCtrl.sellRequirement();
                  } else {
                    utility.showSnackbar(
                        title: 'Warning',
                        message: "Kindly accept condition and try again.",
                        type: AlertType.warning);
                  }
                }),
                const Text(
                  "**Crop will be removed after 30 days",
                  style: TextStyle(color: Colors.red),
                ),
              ]),
            ),
            SizedBox(height: 4.w),
            Text(
              "Submitted Crop Quantity",
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
            ),
            Obx(
              () => Expanded(
                child: ListView(
                  children: [
                    ...marketplaceCtrl.myItems.map(
                      (x) => Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          border: Border.all(
                            color: Colors.grey.shade200,
                            width: 1,
                          ),
                        ),
                        child: ListTile(
                          title: Text.rich(
                            TextSpan(children: [
                              TextSpan(text: tr("sale.crop_name")),
                              const TextSpan(text: ": "),
                              TextSpan(text: x["crop_name"] ?? ""),
                            ]),
                          ),
                          //Text(x["verity_name"]),
                          subtitle: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text.rich(
                                      TextSpan(children: [
                                        TextSpan(text: tr("sale.verity_name")),
                                        const TextSpan(text: ": "),
                                        TextSpan(text: x["verity_name"] ?? ""),
                                      ]),
                                    ),
                                    Text.rich(
                                      TextSpan(children: [
                                        TextSpan(text: tr("sale.quantity")),
                                        const TextSpan(text: ": "),
                                        TextSpan(text: x["quantity"] ?? ""),
                                      ]),
                                    ),
                                    Text.rich(
                                      TextSpan(children: [
                                        TextSpan(text: tr("sale.ins_date")),
                                        const TextSpan(text: ": "),
                                        TextSpan(text: x["ins_date"] ?? ""),
                                      ]),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  Get.defaultDialog(
                                      title: "Delete Sale Crop",
                                      content: Column(
                                        children: [
                                          AppTextFormField(
                                              controller: remarkCtrl,
                                              keyboardType:
                                                  TextInputType.multiline,
                                              lines: 3,
                                              title: "Enter Remark*")
                                        ],
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Get.back(),
                                          child: const Text("Cancel"),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            if (remarkCtrl.text
                                                .trim()
                                                .isNotEmpty) {
                                              marketplaceCtrl.deleteMyItem({
                                                "remark": remarkCtrl.text,
                                                "id": x["id"].toString(),
                                              });
                                            }
                                          },
                                          child: const Text("Ok"),
                                        )
                                      ]);
                                },
                                icon: const Icon(Icons.delete),
                              )
                            ],
                          ),
                          // Text(x["quantity"]),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
