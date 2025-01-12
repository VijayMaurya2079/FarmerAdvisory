import 'package:farmer/import.dart';

class CustomeTitle extends StatelessWidget {
  final String title;
  final String value;
  const CustomeTitle({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 2.h),
        Text(
          title,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.sp,
              color: Colors.green.shade800),
        ),
        Text(
          value,
          style: TextStyle(fontSize: 12.sp),
        ),
      ],
    );
  }
}
