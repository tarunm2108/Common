import 'package:get_storage/get_storage.dart';

const String keyLocation = 'keyLocation';

class SharedPre {
  static final SharedPre instance = SharedPre._internal();

  factory SharedPre() => instance;

  SharedPre._internal();
  ///Keys
  static const loginUser = 'loginUser';
  static const isLogin = 'isLogin';
  static const deviceToken = 'deviceToken';

  Future<void> setValue(String key, dynamic value) async {
    final storage = GetStorage();
    return storage.write(key, value);
  }

  String getStringValue(String key, {String? defaultValue}) {
    final storage = GetStorage();
    return storage.read<String>(key) ?? defaultValue ?? '';
  }

  bool getBoolValue(String key, {bool defaultValue = false}) {
    final storage = GetStorage();
    return storage.read<bool>(key) ?? false;
  }

  int getIntValue(String key, {int? defaultValue}) {
    final storage = GetStorage();
    return storage.read<int>(key) ?? defaultValue ?? -1;
  }

  double getDoubleValue(String key, {double? defaultValue}) {
    final storage = GetStorage();
    return storage.read<double>(key) ?? defaultValue ?? -1;
  }

  Future<void> clearAll() async {
    return await GetStorage().erase();
  }

  /// call this method like this
  ///var data= sp.getObj("key);
  ///Login loginData= Logindata.fromjson(data);
  Map<String, dynamic> getObj(String key) {
    final prefs = GetStorage();
    return prefs.read<Map<String, dynamic>>(key) ?? {};
  }
}
