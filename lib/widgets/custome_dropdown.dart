import 'package:farmer/import.dart';

class AppDropdown extends StatelessWidget {
  final List<dynamic> list;
  final String title;
  final String displayField;
  // final String valueField;
  final Function filter;
  final dynamic selectedValue;
  final Widget? leading;
  final Widget? clear;
  final TextEditingController controller;
  final FormFieldValidator<dynamic>? onValidate;
  final ValueChanged onChanged;
  final FormFieldSetter<dynamic>? onSave;

  const AppDropdown({
    super.key,
    required this.list,
    required this.title,
    required this.displayField,
    // required this.valueField,
    required this.onChanged,
    required this.filter,
    this.selectedValue,
    this.leading,
    this.clear,
    required this.controller,
    this.onValidate,
    this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title.isNotEmpty)
            Text(
              title,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade600,
              ),
            ),
          GestureDetector(
            onTap: () async {
              await Get.bottomSheet(
                Container(
                  height: 60.h,
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 4,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              title,
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            clear ?? const SizedBox.shrink()
                          ],
                        ),
                      ),
                      const Divider(),
                      Expanded(
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            ...list.where((e) => filter(e) ?? true).map(
                                  (e) => ListTile(
                                    onTap: () {
                                      Get.back();
                                      controller.text = e[displayField] ?? "";
                                      onChanged(e);
                                    },
                                    title: Text(e[displayField] ?? ""),
                                  ),
                                )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            child: AbsorbPointer(
              child: TextFormField(
                controller: controller,
                style: TextStyle(fontSize: 12.sp),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade200.withOpacity(0.5),
                  prefixIcon: leading,
                  suffixIcon: const Icon(Icons.arrow_drop_down),
                  contentPadding: const EdgeInsets.all(8),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(controlBorderRadius),
                    ),
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
                onSaved: onSave,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AppDropdown02 extends StatelessWidget {
  final List<dynamic>? list;
  final String? title;
  final String? displayField;
  final String? valueField;
  final dynamic selectedValue;
  final FormFieldValidator<dynamic>? onValidate;
  final ValueChanged<dynamic>? onChanged;
  final FormFieldSetter<dynamic>? onSave;

  const AppDropdown02({
    super.key,
    this.list,
    this.title,
    this.displayField,
    this.valueField,
    this.selectedValue,
    this.onChanged,
    this.onValidate,
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
          DropdownButtonFormField(
            isDense: true,
            value: selectedValue,
            style: const TextStyle(color: Colors.black),
            items: list!
                .map<DropdownMenuItem<dynamic>>(
                  (e) => DropdownMenuItem(
                    value: e[valueField],
                    child: Text(
                      e[displayField].toString(),
                      overflow: TextOverflow.visible,
                    ),
                  ),
                )
                .toList(),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey.shade200.withOpacity(0.2),
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
                    color: Colors.green.shade100.withOpacity(0.2), width: 1),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  Radius.circular(controlBorderRadius),
                ),
                borderSide: BorderSide(color: Colors.grey.shade400, width: 1),
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

class AppDropdownForArray extends StatelessWidget {
  final List? list;
  final String? title;
  final String? selectedValue;
  final FormFieldValidator<dynamic>? onValidate;
  final ValueChanged<dynamic>? onChanged;
  final FormFieldSetter<dynamic>? onSave;

  const AppDropdownForArray({
    super.key,
    this.list,
    this.title,
    this.selectedValue,
    this.onChanged,
    this.onValidate,
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
          DropdownButtonFormField(
            isDense: true,
            value: selectedValue,
            style: const TextStyle(color: Colors.black),
            items: list!
                .map<DropdownMenuItem<dynamic>>(
                  (e) => DropdownMenuItem(
                    value: e,
                    child: Text(
                      e.toString(),
                      overflow: TextOverflow.visible,
                      style: TextStyle(fontSize: 12.sp),
                    ),
                  ),
                )
                .toList(),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey.shade200.withOpacity(0.2),
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
                    color: Colors.green.shade100.withOpacity(0.2), width: 1),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  Radius.circular(controlBorderRadius),
                ),
                borderSide: BorderSide(color: Colors.grey.shade400, width: 1),
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
