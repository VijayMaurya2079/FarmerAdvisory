import 'package:farmer/import.dart';

class EmptryContainer extends StatelessWidget {
  const EmptryContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.maxFinite,
      width: double.maxFinite,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(
          Icons.folder_open,
          size: 60.sp,
          color: Colors.grey.shade300,
        ),
        Text(
          "Record Not Found",
          style: TextStyle(fontSize: 14.sp, color: Colors.grey.shade300),
        )
      ]),
    );
  }
}
