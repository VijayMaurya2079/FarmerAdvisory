import 'package:easy_localization/easy_localization.dart';
import 'package:farmer/controller/marketplace_ctrl.dart';
import 'package:farmer/import.dart';
import 'package:farmer/screens/marketplace/avilable_in_market.dart';
import 'package:farmer/screens/marketplace/market_demand.dart';
import 'package:farmer/screens/marketplace/post_requirement.dart';
import 'package:farmer/screens/marketplace/sale_in_market.dart';

class Marketplace extends StatelessWidget {
  Marketplace({Key? key}) : super(key: key);
  final appCtrl = Get.find<AppController>();
  final marketplaceCtrl = Get.put(MarketplaceController());

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      appBar: AppBar(title: const Text("market_place.title").tr()),
      child: Obx(
        () => Column(children: [
          if (appCtrl.type.value == "Farmer")
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppElevatedButton(tr("market_place.sale"), () {
                marketplaceCtrl.getMyItems();
                Get.to(SaleInMarket());
              }, size: 300),
            ),
          if (appCtrl.type.value == "Farmer")
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppElevatedButton(
                  tr("market_place.demand"), () => Get.to(MarketDemand()),
                  size: 300),
            ),
          if (appCtrl.type.value == "Buyer")
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppElevatedButton(tr("market_place.requirement"), () {
                marketplaceCtrl.getMyItems();
                Get.to(PostRequirement());
              }, size: 300),
            ),
          if (appCtrl.type.value == "Buyer")
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppElevatedButton(
                  tr("market_place.market"), () => Get.to(AvilableInMarket()),
                  size: 300),
            ),
        ]),
      ),
    );
  }
}
