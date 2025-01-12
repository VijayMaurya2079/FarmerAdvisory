import 'package:easy_localization/easy_localization.dart';
import 'package:farmer/import.dart';

class AvilableInMarketDetail extends StatelessWidget {
  final dynamic detail;
  const AvilableInMarketDetail({Key? key, required this.detail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      appBar: AppBar(title: Text(detail["crop_name"])),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            detail["crop_name"] ?? "",
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
          ),
          const Divider(color: Colors.grey, thickness: 1.0),
          orgLabel(tr("market_detail.verity_name"), detail["verity_name"]),
          orgLabel(tr("market_detail.quantity_required"), detail["quantity"]),
          SizedBox(height: 20.sp),
          Text(
            tr("market_detail.seller_detail"),
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
          ),
          const Divider(color: Colors.grey, thickness: 1.0),
          orgLabel(tr("market_detail.name"), detail["customer_name"]),
          orgLabel(tr("market_detail.mobile_number"), detail["mobile_number"]),
        ]),
      ),
    );
  }

  Widget orgLabel(title, value) {
    return (value == null || value == "")
        ? const SizedBox()
        : Text.rich(
            TextSpan(children: [
              TextSpan(
                text: title,
                style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
              ),
              const TextSpan(text: " "),
              TextSpan(
                text: value ?? "",
                style: TextStyle(fontSize: 12.sp),
              ),
            ]),
          );
  }
}
