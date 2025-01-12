import 'package:farmer/import.dart';
import 'package:farmer/model/result.dart';

class MarketplaceBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MarketplaceController());
  }
}

class MarketplaceController extends GetxController {
  final cropCtrl = TextEditingController();
  final verityNameCtrl = TextEditingController();
  final requirementCtrl = TextEditingController();

  final RxList list = [].obs;
  final RxList market = [].obs;
  final RxList myItems = [].obs;

  final RxString cropID = "".obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    getCropList();
  }

  getCropList() async {
    Result result = await DBServices.call.crops();
    if (result.status) {
      list(result.data);
    }
  }

  postRequirement() async {
    final data = {
      "crop_id": cropID.value,
      "verity_name": verityNameCtrl.text,
      "quantity": requirementCtrl.text,
      "quantity_for": "Purchase"
    };
    Result result = await DBServices.call.addRequirement(data);
    if (result.status) {
      cropCtrl.text = verityNameCtrl.text = requirementCtrl.text = "";
      cropID.value = "";
      Get.back();
    } else {
      utility.showSnackbar(title: "Error", message: result.message);
    }
  }

  sellRequirement() async {
    final data = {
      "crop_id": cropID.value,
      "verity_name": verityNameCtrl.text,
      "quantity": requirementCtrl.text,
      "quantity_for": "Sell"
    };
    Result result = await DBServices.call.saleProduct(data);
    if (result.status) {
      cropCtrl.text = verityNameCtrl.text = requirementCtrl.text = "";
      cropID.value = "";
      getMyItems();
      Get.back();
    } else {
      utility.showSnackbar(title: "Error", message: result.message);
    }
  }

  getMyItems() async {
    Result result = await DBServices.call.getMyItems();
    if (result.status) {
      myItems(result.data);
    }
  }

  deleteMyItem(data) async {
    Result result = await DBServices.call.deleteMarketItem(data);
    if (result.status) {
      getMyItems();
      Get.back();
    } else {
      utility.showSnackbar(title: "Error", message: result.message);
    }
  }

  getMarketDemand(String? id) async {
    Result result = id == ""
        ? await DBServices.call.getMarketDemand()
        : await DBServices.call.getMarketDemandByCrop(id);
    if (result.status) {
      market.value = result.data;
    }
  }

  getMarket(String? id) async {
    Result result = id == ""
        ? await DBServices.call.getMarket()
        : await DBServices.call.getMarketByCrop(id);
    if (result.status) {
      market.value = result.data;
    }
  }
}
