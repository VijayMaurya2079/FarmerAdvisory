import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CircleButton extends StatelessWidget {
  final IconData? icon;
  final VoidCallback? onPress;
  const CircleButton(this.icon, this.onPress, {super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      style: ElevatedButton.styleFrom(
        elevation: 20,
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(20),
      ),
      child: Icon(
        icon,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}

class AppElevatedButton extends StatelessWidget {
  final String text;
  final double size;
  final VoidCallback onPress;
  const AppElevatedButton(this.text, this.onPress,
      {super.key, this.size = 220});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      child: ElevatedButton(
        onPressed: onPress,
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontFamily: "Alegreya",
            fontSize: 16.sp,
            letterSpacing: 1.5,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class AppElevatedIconButton extends StatelessWidget {
  final String text;
  final double size;
  final VoidCallback onPress;
  const AppElevatedIconButton(this.text, this.onPress,
      {super.key, this.size = 180});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: ElevatedButton.icon(
          onPressed: onPress,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0),
            ),
          ),
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 14.sp,
          ),
          label: Text(
            text,
            style: TextStyle(
                fontFamily: "Alegreya", fontSize: 14.sp, letterSpacing: 1.5),
          ),
        ),
      ),
    );
  }
}

class AppSmallElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPress;
  final Color? color;
  final Color? textColor;

  const AppSmallElevatedButton(
    this.text,
    this.onPress, {
    super.key,
    this.color,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        padding: EdgeInsets.symmetric(vertical: 1.2.h, horizontal: 2.w),
        backgroundColor: color ?? Theme.of(context).colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
          side: BorderSide(
              color: textColor ?? Theme.of(context).colorScheme.primary),
        ),
      ),
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          fontFamily: "Alegreya",
          fontSize: 9.sp,
          letterSpacing: 1.1,
          fontWeight: FontWeight.bold,
          color: textColor ?? Colors.white,
        ),
      ),
    );
  }
}
