import 'package:easy_localization/easy_localization.dart';
import 'package:farmer/controller/marketplace_ctrl.dart';
import 'package:farmer/import.dart';
import 'package:farmer/screens/marketplace/avilable_in_market_detail.dart';
import 'package:farmer/widgets/custome_dropdown.dart';
import 'package:farmer/widgets/emptry_container.dart';

class AvilableInMarket extends StatelessWidget {
  AvilableInMarket({Key? key}) : super(key: key);
  final marketplaceCtrl = Get.find<MarketplaceController>();

  @override
  Widget build(BuildContext context) {
    marketplaceCtrl.getMarket("");
    return AppContainer(
      appBar: AppBar(title: const Text("market.title").tr()),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: AppDropdown(
                    title: tr("market.crop_name"),
                    list: marketplaceCtrl.list,
                    displayField: "crop_name",
                    filter: (value) => true,
                    onChanged: (value) => marketplaceCtrl.cropID.value =
                        value["pk_faa_crop_id"].toString(),
                    onValidate: validate.requireValidation,
                    controller: marketplaceCtrl.cropCtrl,
                  ),
                ),
                IconButton(
                  onPressed: () =>
                      marketplaceCtrl.getMarket(marketplaceCtrl.cropID.value),
                  icon: Icon(Icons.send, size: 30.sp),
                )
              ],
            ),
          ),
          Expanded(
            child: Obx(
              () => marketplaceCtrl.market.isEmpty
                  ? const EmptryContainer()
                  : ListView(children: [
                      ...marketplaceCtrl.market.map(
                        (e) => Container(
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
                            onTap: () =>
                                Get.to(AvilableInMarketDetail(detail: e)),
                            title: Text(e["crop_name"] ?? ""),
                            subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text.rich(
                                    TextSpan(children: [
                                      TextSpan(text: tr("market.sold_by")),
                                      const TextSpan(text: ": "),
                                      TextSpan(text: e["customer_name"] ?? ""),
                                    ]),
                                  ),
                                  Text.rich(
                                    TextSpan(children: [
                                      TextSpan(text: tr("market.available")),
                                      const TextSpan(text: ": "),
                                      TextSpan(text: e["quantity"] ?? "r"),
                                    ]),
                                  ),
                                  Text.rich(
                                    TextSpan(children: [
                                      TextSpan(text: tr("market.ins_date")),
                                      const TextSpan(text: ": "),
                                      TextSpan(text: e["ins_date"] ?? "r"),
                                    ]),
                                  )
                                ]),
                          ),
                        ),
                      )
                    ]),
            ),
          ),
        ],
      ),
    );
  }
}
