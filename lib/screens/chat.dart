import 'package:easy_localization/easy_localization.dart';
import 'package:farmer/controller/chat_ctrl.dart';
import 'package:farmer/import.dart';
import 'package:farmer/widgets/uploader.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({Key? key}) : super(key: key);
  final chatCtrl = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    chatCtrl.getMyChat();
    return AppContainer(
      appBar: AppBar(title: const Text("chat.title").tr()),
      child: Column(children: [
        Obx(
          () => Expanded(
            child: ListView(
              controller: chatCtrl.scrollCtrl,
              children: [
                ...chatCtrl.myChatList.map(
                  (e) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onLongPress: () async {
                        if (e["sender_id"] == "Admin") return;
                        Get.defaultDialog(
                            content: const Text("Continue to delete chat"),
                            actions: [
                              AppSmallElevatedButton("Ok", () async {
                                await DBServices.call
                                    .deleteChat(e["chat_id"].toString());
                                chatCtrl.myChatList.remove(e);
                                Get.back();
                              }),
                              AppSmallElevatedButton(
                                "Cancel",
                                () async {
                                  Get.back();
                                },
                                color: Colors.grey,
                              )
                            ]);
                      },
                      child: ChatBubble(
                        backGroundColor: e["receiver_id"] == "Admin"
                            ? Colors.blue
                            : Colors.grey,
                        alignment: e["receiver_id"] == "Admin"
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        clipper: ChatBubbleClipper2(
                          type: e["receiver_id"] == "Admin"
                              ? BubbleType.sendBubble
                              : BubbleType.receiverBubble,
                        ),
                        child: e["content_type"] == "Text"
                            ? Text(
                                e["content"].toString(),
                                style: const TextStyle(color: Colors.white),
                              )
                            : Image.network(e["content"].toString()),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: TextField(
                  controller: chatCtrl.textCtrl,
                  decoration: InputDecoration(
                    suffix: IconButton(
                      onPressed: () => chatCtrl.sendChat(),
                      icon: const Icon(Icons.send),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
            Uploader(
              action: (value) async {
                final result = await DBServices.call.uploadChatImage(value);
                if (result.toString() != "200") {
                  utility.showSnackbar(title: "Error", message: result);
                } else {
                  await chatCtrl.getMyChat();
                  chatCtrl.scrollCtrl.animateTo(
                    chatCtrl.scrollCtrl.position.maxScrollExtent,
                    duration: const Duration(seconds: 2),
                    curve: Curves.fastOutSlowIn,
                  );
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Icon(Icons.image, size: 30.sp),
              ),
            )
          ],
        )
      ]),
    );
  }
}
