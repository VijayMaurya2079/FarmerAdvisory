import 'package:farmer/import.dart';

class StorageService extends GetxService {
  static StorageService get to => Get.find();
  late GetStorage _box;

  Future<StorageService> init() async {
    _box = GetStorage();
    _box.writeIfNull("unreadN", 0);
    return this;
  }

  Future<void> write(key, dynamic value) async {
    return await _box.write(key, value);
  }

  Future<dynamic> read(key) async {
    return _box.read(key);
  }

  Future<void> delete(key) async {
    return await _box.remove(key);
  }

  bool has(key) {
    return _box.hasData(key);
  }

  Future<void> removeAll() async {
    return await _box.erase();
  }
}
