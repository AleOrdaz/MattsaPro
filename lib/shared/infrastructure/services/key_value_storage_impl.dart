import 'package:shared_preferences/shared_preferences.dart';
import '../../../features/auth/domain/models/user.dart';
import 'key_value_storage.dart';

class KeyValueStorageImpl extends KeyValueStorage {
  Future<SharedPreferences> getSharedPrefs() async {
    return await SharedPreferences.getInstance();
  }

  @override
  Future<T?> getValue<T>(String key) async {
    final prefs = await getSharedPrefs();

    switch (T) {
      case int:
        return prefs.getInt(key) as T?;

      case String:
        return prefs.getString(key) as T?;

      case bool:
        return prefs.getBool(key) as T?;
      default:
        throw UnimplementedError(
            'Get no implemeneted for type ${T.runtimeType}');
    }
  }

  @override
  Future<bool> removeKeyValue(String key) async {
    final prefs = await getSharedPrefs();
    return await prefs.remove(key);
  }

  @override
  Future<void> setKeyValue<T>(String key, T value) async {
    final prefs = await getSharedPrefs();

    switch (T) {
      case int:
        prefs.setInt(key, value as int);
        break;
      case String:
        prefs.setString(key, value as String);
        break;
      case bool:
        prefs.setBool(key, value as bool);
        break;
      case User:
        prefs.setString(key, value as String);
        break;
      default:
        throw UnimplementedError(
            'Set no implemeneted for type ${T.runtimeType}');
    }
  }
}
