import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:farmer/import.dart';

class Uploader extends StatefulWidget {
  final Function action;
  final Widget? child;
  const Uploader({super.key, required this.action, this.child});

  @override
  UploaderState createState() => UploaderState();
}

class UploaderState extends State<Uploader> {
  Rx<File> pickedfile = File("").obs;
  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await Get.bottomSheet(
          Container(
            height: 180,
            decoration: const BoxDecoration(color: Colors.white),
            child: Column(
              children: [
                ListTile(
                  title: const Text("From Gallery"),
                  onTap: () => openCamera(source: ImageSource.gallery),
                ),
                ListTile(
                  title: const Text("From Camera"),
                  onTap: () => openCamera(source: ImageSource.camera),
                ),
                ListTile(
                  leading: const Icon(Icons.delete),
                  title: const Text("Remove Image"),
                  onTap: () {
                    pickedfile.value = File("");
                    Get.back();
                  },
                )
              ],
            ),
          ),
        );
      },
      child: widget.child ??
          Stack(
            children: [
              Obx(
                () => CircleAvatar(
                  radius: 122,
                  backgroundColor: Colors.green.shade800,
                  child: pickedfile.value.path == ""
                      ? const CircleAvatar(
                          radius: 120,
                          backgroundColor: Colors.grey,
                        )
                      : CircleAvatar(
                          radius: 120,
                          backgroundImage: FileImage(pickedfile.value),
                        ),
                ),
              ),
              Positioned(
                right: 20,
                top: 20,
                child: Icon(
                  Icons.camera,
                  size: 35,
                  color: Colors.green.shade800,
                ),
              ),
            ],
          ),
    );
  }

  openCamera({ImageSource source = ImageSource.camera}) async {
    XFile? file = await picker.pickImage(
      source: source,
      maxHeight: 500,
      imageQuality: 80,
    );
    Get.back();
    List<int> imageBytes = await file!.readAsBytes();
    final base64 = base64Encode(imageBytes);
    pickedfile.value = File(file.path);

    setState(() {});
    return widget.action(base64);
  }
}
