import 'package:momentum/momentum.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String AUTH_TOKEN = 'AUTH_TOKEN';

class OrStorageService extends MomentumService {
  /// Local Storage Shared Prefs
  SharedPreferences? _sharedPreferences;

  /// Initialize the service
  Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  /// Get the stored Auth Token
  String? get authToken => _sharedPreferences?.getString(AUTH_TOKEN);

  /// Store the Auth Token
  Future<void> setToken(String token) async {
    await _sharedPreferences?.setString(AUTH_TOKEN, token);
  }

  /// Remove auth token upon Log Out
  Future<void> removeAuthToken() async {
    await _sharedPreferences?.remove(AUTH_TOKEN);
  }
}
