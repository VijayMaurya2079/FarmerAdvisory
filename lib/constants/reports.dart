import 'package:farmer/import.dart';

class ReportMenu {
  String title;
  Widget? screen;
  List<ReportMenu>? submenu;
  ReportMenu({required this.title, this.screen, this.submenu});
}

final reports = [
  ReportMenu(title: "Home", screen: const HomeScreen()),
];
