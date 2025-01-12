import 'package:farmer/import.dart';

import '../model/result.dart';

class ChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ChatController());
  }
}

class ChatController extends GetxController {
  final textCtrl = TextEditingController();
  final scrollCtrl = ScrollController();

  final RxList myChatList = [].obs;
  final Rx<dynamic> cropDetail = Rx(null);

  getMyChat() async {
    Result result = await DBServices.call.myChat();
    if (result.status) {
      textCtrl.text = "";
      myChatList.value = result.data;
      Future.delayed(const Duration(milliseconds: 200), () {
        scrollCtrl.animateTo(
          scrollCtrl.position.maxScrollExtent,
          duration: const Duration(seconds: 2),
          curve: Curves.fastOutSlowIn,
        );
      });
    }
  }

  sendChat() async {
    if (textCtrl.text.trim() == "") return;
    Result result = await DBServices.call.sendChat(textCtrl.text);
    if (result.status) {
      getMyChat();
    }
  }
}
