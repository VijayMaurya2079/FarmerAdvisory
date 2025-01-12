import 'package:farmer/import.dart';

import '../model/result.dart';

class DistillationController extends GetxController {
  final stateCtrl = TextEditingController();
  final districtCtrl = TextEditingController();
  final pincodeCtrl = TextEditingController();
  final addressCtrl = TextEditingController();

  final RxString stateID = "".obs;
  final RxString districtID = "".obs;
  final RxBool hasDistillationUnit = false.obs;

  final RxList distillationList = [].obs;
  List state = [];
  List region = [];
  List district = [];

  @override
  Future<void> onInit() async {
    super.onInit();
    getLocations();
  }

  getLocations() {
    DBServices.call.location().then((Result result) {
      state = result.data["state"];
      region = result.data["region"];
      district = result.data["city"];
    });
  }

  addDistillation() async {
    final id = await StorageService.to.read("id");
    final data = {
      "state_id": stateID.value,
      "city_id": districtID.value,
      "pincode": pincodeCtrl.text,
      "address": addressCtrl.text,
      "ins_by": id,
    };
    Result result = await DBServices.call.addDistillation(data);
    if (result.status) {
      stateCtrl.text =
          districtCtrl.text = pincodeCtrl.text = addressCtrl.text = "";
      Get.back();
      getDistillationList();
    }
  }

  getDistillationList() async {
    Result result = await DBServices.call.distillationUnits();
    if (result.status) {
      distillationList.value = result.data;
    }
  }
}
