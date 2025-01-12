import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

enum AlertType { success, error, warning }

class Utility {
  String randomString(int lenght) {
    var r = Random();
    const chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(lenght, (index) => chars[r.nextInt(chars.length)])
        .join();
  }

  String randomNumber(int lenght) {
    var r = Random();
    const chars = '0123456789';
    return List.generate(lenght, (index) => chars[r.nextInt(chars.length)])
        .join();
  }

  // String removeHTMLTag(String html) {
  //   var unescape = HtmlUnescape();
  //   RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
  //   String parsedString =
  //       html.replaceAll(exp, '').replaceAll("\n", '').replaceAll("\r", '');
  //   parsedString = unescape.convert(parsedString);
  //   return parsedString.length > 400
  //       ? parsedString.substring(0, 400)
  //       : parsedString;
  // }

  Future<void> launchInBrowser(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<String> selectedDate(
    context, {
    int startYear = 1990,
    bool acceptFutureDate = true,
    bool acceptPastDate = true,
  }) async {
    DateTime today =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    DateTime lastDate =
        acceptFutureDate ? DateTime(DateTime.now().year + 2) : today;
    DateTime startDate = acceptPastDate
        ? DateTime(startYear)
        : DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day);

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: startDate,
      lastDate: lastDate,
    );
    if (picked != null) {
      return DateFormat("yyyy-MM-dd").format(picked).toString();
    } else {
      return "";
    }
  }

  Future<String> selectedTime(context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.input,
    );
    if (picked != null) {
      return "${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}"
          .toString();
    } else {
      return "";
    }
  }

  Future<String> selectedDOB(context) async {
    return selectedDate(context, acceptFutureDate: false);
  }

  // String openFileInGooleDrive(String url) {
  //   final filename = basename(url);
  //   final ext = filename.split(".")[1].toLowerCase();
  //   if (['pdf', 'ppt', 'pptx', 'doc', 'docx', 'xls', 'xlsx'].contains(ext)) {
  //     return "https://docs.google.com/viewer?embedded=true&url=$url";
  //   } else {
  //     return url;
  //   }
  // }

  Future<void> showSnackbar({
    required String title,
    required String message,
    AlertType type = AlertType.success,
  }) async {
    Get.snackbar(
      title,
      message,
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(8),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: type == AlertType.success
          ? Colors.green.shade800
          : type == AlertType.error
              ? Colors.red.shade800
              : Colors.amber.shade800,
      colorText: Colors.white,
    );
  }
}

final utility = Utility();
