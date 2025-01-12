import 'package:farmer/import.dart';

class AppTextFormField extends StatelessWidget {
  final String? initialValue;
  final String? title;
  final String? hintText;
  final Widget? leading;
  final Widget? suffix;
  final int? lines;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final FormFieldValidator<String>? onValidate;
  final ValueChanged<String>? onChanged;
  final FormFieldSetter<String>? onSave;

  const AppTextFormField({
    super.key,
    this.initialValue,
    this.title = "",
    this.hintText,
    this.leading,
    this.suffix,
    this.lines = 1,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.controller,
    this.onValidate,
    this.onChanged,
    this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title!.isNotEmpty)
            Text(
              title!,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade600,
              ),
            ),
          TextFormField(
            initialValue: initialValue,
            controller: controller,
            obscureText: obscureText ?? false,
            keyboardType: keyboardType,
            maxLines: lines,
            style: TextStyle(fontSize: 12.sp),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey.shade200.withOpacity(0.5),
              prefixIcon: leading,
              suffixIcon: suffix,
              hintText: hintText,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
              disabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                    Radius.circular(controlBorderRadius)),
                borderSide: BorderSide(
                  color: Colors.grey.shade100.withOpacity(0.5),
                  width: 0,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  Radius.circular(controlBorderRadius),
                ),
                borderSide: BorderSide(
                  color: Colors.green.shade100.withOpacity(0.2),
                  width: 1,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  Radius.circular(controlBorderRadius),
                ),
                borderSide: BorderSide(
                  color: Colors.grey.shade400,
                  width: 1,
                ),
              ),
              errorMaxLines: 2,
              floatingLabelBehavior: FloatingLabelBehavior.never,
            ),
            validator: onValidate,
            onChanged: onChanged,
            onSaved: onSave,
          ),
        ],
      ),
    );
  }
}

class AppDateFormField extends StatelessWidget {
  final String? initialValue;
  final String? title;
  final String? hintText;
  final Widget? leading;
  final Widget? suffix;
  final int? lines;
  final bool? obscureText;
  final bool acceptPastDate;
  final bool acceptFutureDate;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final FormFieldValidator<String>? onValidate;
  final ValueChanged<String>? onChanged;
  final FormFieldSetter<String>? onSave;

  const AppDateFormField({
    super.key,
    this.initialValue,
    this.title = "",
    this.hintText,
    this.leading,
    this.suffix,
    this.lines = 1,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.controller,
    this.onValidate,
    this.onChanged,
    this.onSave,
    this.acceptPastDate = true,
    this.acceptFutureDate = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != "")
            Text(
              title ?? "",
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade600,
              ),
            ),
          GestureDetector(
            onTap: () async {
              controller!.text = await utility.selectedDate(
                context,
                acceptFutureDate: acceptFutureDate,
                acceptPastDate: acceptPastDate,
              );
            },
            child: AbsorbPointer(
              absorbing: true,
              child: TextFormField(
                initialValue: initialValue,
                controller: controller,
                obscureText: obscureText ?? false,
                keyboardType: keyboardType,
                maxLines: lines,
                style: TextStyle(fontSize: 12.sp),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade200.withOpacity(0.2),
                  prefixIcon: leading,
                  suffixIcon: suffix,
                  hintText: hintText,
                  contentPadding: const EdgeInsets.all(8),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(controlBorderRadius),
                    ),
                    borderSide: BorderSide(
                        color: Colors.grey.shade100.withOpacity(0.5), width: 0),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(controlBorderRadius),
                    ),
                    borderSide: BorderSide(
                        color: Colors.green.shade100.withOpacity(0.2),
                        width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(controlBorderRadius),
                    ),
                    borderSide:
                        BorderSide(color: Colors.grey.shade400, width: 1),
                  ),
                  errorMaxLines: 2,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                ),
                validator: onValidate,
                onChanged: onChanged,
                onSaved: onSave,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AppTimeFormField extends StatelessWidget {
  final String? initialValue;
  final String? title;
  final String? hintText;
  final Widget? leading;
  final Widget? suffix;
  final int? lines;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final FormFieldValidator<String>? onValidate;
  final ValueChanged<String>? onChanged;
  final FormFieldSetter<String>? onSave;

  const AppTimeFormField({
    super.key,
    this.initialValue,
    this.title = "",
    this.hintText,
    this.leading,
    this.suffix,
    this.lines = 1,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.controller,
    this.onValidate,
    this.onChanged,
    this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != "")
            Text(
              title ?? "",
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade600,
              ),
            ),
          GestureDetector(
            onTap: () async {
              controller!.text = await utility.selectedTime(context);
            },
            child: AbsorbPointer(
              absorbing: true,
              child: TextFormField(
                initialValue: initialValue,
                controller: controller,
                obscureText: obscureText ?? false,
                keyboardType: keyboardType,
                maxLines: lines,
                style: TextStyle(fontSize: 12.sp),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade200.withOpacity(0.2),
                  prefixIcon: leading,
                  suffixIcon: suffix,
                  hintText: hintText,
                  contentPadding: const EdgeInsets.all(8),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(
                        color: Colors.grey.shade100.withOpacity(0.5), width: 0),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(controlBorderRadius),
                    ),
                    borderSide: BorderSide(
                        color: Colors.green.shade100.withOpacity(0.2),
                        width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(controlBorderRadius),
                    ),
                    borderSide:
                        BorderSide(color: Colors.grey.shade400, width: 1),
                  ),
                  errorMaxLines: 2,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                ),
                validator: onValidate,
                onChanged: onChanged,
                onSaved: onSave,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ReportTextFormField extends StatelessWidget {
  final String? initialValue;
  final String? title;
  final String? hintText;
  final Widget? leading;
  final Widget? suffix;
  final int? lines;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final FormFieldValidator<String>? onValidate;
  final ValueChanged<String>? onChanged;
  final FormFieldSetter<String>? onSave;

  ReportTextFormField({
    this.initialValue,
    this.title,
    this.hintText,
    this.leading,
    this.suffix,
    this.lines = 1,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.controller,
    this.onValidate,
    this.onChanged,
    this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      controller: controller,
      obscureText: obscureText ?? false,
      keyboardType: keyboardType,
      maxLines: lines,
      decoration: InputDecoration(
        isDense: true,
        filled: true,
        fillColor: Colors.white,
        prefixIcon: leading,
        suffixIcon: suffix,
        hintText: title,
        contentPadding: const EdgeInsets.all(12),
        // border: InputBorder.none,
        border: OutlineInputBorder(
          borderSide: const BorderSide(width: 2, color: Colors.white),
          borderRadius: BorderRadius.circular(12),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      validator: onValidate,
      onChanged: onChanged,
      onSaved: onSave,
    );
  }
}
