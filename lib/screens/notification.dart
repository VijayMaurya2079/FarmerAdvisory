import 'package:farmer/import.dart';
import 'package:farmer/model/result.dart';
import 'package:farmer/widgets/emptry_container.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({Key? key}) : super(key: key);
  final appCtrl = Get.find<AppController>();

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      appBar: AppBar(title: const Text("Notification")),
      child: FutureBuilder(
          future: DBServices.call.getNotifications(),
          builder: (contex, snapshot) {
            if (snapshot.hasData &&
                snapshot.connectionState == ConnectionState.done) {
              Result? result = snapshot.data;
              if (result!.status) {
                StorageService.to.write("unreadN", 0);
                appCtrl.unreadN.value = 0;
                return ListView(
                  children: [
                    ...result.data.map(
                      (x) => Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 2.0,
                          vertical: 8,
                        ),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 15,
                            ),
                            child: ListTile(
                              title: Text(
                                x["notification_text"] ?? "",
                                textAlign: TextAlign.justify,
                              ),
                              subtitle: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    x["ins_date"] ?? "",
                                    style: TextStyle(fontSize: 9.sp),
                                  )),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                );
              }
              return const EmptryContainer();
            }
            return const EmptryContainer();
          }),
    );
  }
}
