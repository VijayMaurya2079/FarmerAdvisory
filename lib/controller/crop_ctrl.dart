import 'package:farmer/import.dart';
import 'package:farmer/model/result.dart';

class CropBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CropController());
  }
}

class CropController extends GetxController {
  final RxList cropList = [].obs;
  final RxList myCrops = [].obs;
  final Rx<dynamic> cropDetail = Rx(null);

  getCropList() async {
    cropList([]);
    Result result = await DBServices.call.crops();
    if (result.status) {
      cropList(result.data);
    }
  }

  getMyCrops() async {
    myCrops([]);
    Result result = await DBServices.call.myFavorite();
    if (result.status) {
      myCrops.value = result.data;
    }
  }

  getCropDetail(String cid) async {
    Result result = await DBServices.call.cropDetail(cid);
    if (result.status) {
      cropDetail(result.data);
    }
  }

  setMyFavouritCrop(String cid) async {
    await DBServices.call.addFavorite(cid);
  }

  removeMyFavouritCrop(String cid) async {
    await DBServices.call.removeFavorite(cid);
  }
}
