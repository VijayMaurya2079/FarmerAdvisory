import 'package:farmer/import.dart';
import 'package:farmer/model/result.dart';

class DiseaseController extends GetxController {
  final RxList diseaseList = [].obs;

  getDiseaseList(String cid) async {
    Result result = await DBServices.call.diseaseList(cid);
    if (result.status) {
      diseaseList.value = result.data;
    }
  }
}
