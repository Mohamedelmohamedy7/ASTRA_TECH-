import 'package:shared_preferences/shared_preferences.dart';

// ignore: camel_case_types
class globalAccountData {
  static SharedPreferences? _preferences;

  static const _username = 'username';
  static const _loginInState = 'LogInState';
  static const _email = 'email';
  static const _id = 'UID';
  static const _state = 'State';
  static const _address = 'Address';
  static const _city = 'City';
  static const _contactNumber = 'contactNumber';
  static const _keyCivilId = 'civilId';
  static const _postalCode = 'postalCode';
  static const _latitude = 'latitude';
  static const _longitude = 'longitude';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setUsername(String username) async =>
      await _preferences?.setString(_username, username);

  static String? getUsername() => _preferences?.getString(_username);

  static Future setLatitude(String latitude) async =>
      await _preferences?.setString(_latitude, latitude);
  static String? getLatitude() => _preferences?.getString(_latitude);

  static Future setCivilId(String civilId) async =>
      await _preferences?.setString(_keyCivilId, civilId);

  static String? getCivilId() => _preferences?.getString(_keyCivilId);


  static Future setLongitude(String longitude) async =>
      await _preferences?.setString(_longitude, longitude);

  static String? getLongitude() => _preferences?.getString(_longitude);

  static Future setLoginInState(bool loginInState) async =>
      await _preferences?.setBool(_loginInState, loginInState);

  static bool? getLoginInState() => _preferences?.getBool(_loginInState);

  static Future setEmail(String email) async =>
      await _preferences?.setString(_email, email);

  static String? getEmail() => _preferences?.getString(_email);

  static Future setId(String id) async =>
      await _preferences?.setString(_id, id);

  static String? getId() => _preferences?.getString(_id);

  static Future setState(String state) async =>
      await _preferences?.setString(_state, state);

  static String? getState() => _preferences?.getString(_state);

  static Future setPostalCode(String postalCode) async =>
      await _preferences?.setString(_postalCode, postalCode);

  static String? getPostalCode() => _preferences?.getString(_postalCode);

  static Future setAddress(String address) async =>
      await _preferences?.setString(_address, address);

  static String? getAddress() => _preferences?.getString(_address);

  static Future setCity(String city) async =>
      await _preferences?.setString(_city, city);

  static String? getCity() => _preferences?.getString(_city);

  static Future setPhoneNumber(String contactNumber) async =>
      await _preferences?.setString(_contactNumber, contactNumber);

  static String? getPhoneNumber() => _preferences!.getString(_contactNumber)!;

  // static Future setBirthday(DateTime dateOfBirth) async {
  //   final birthday = dateOfBirth.toIso8601String();
  //   return await _preferences?.setString(_keyBirthday, birthday);
  // }
  //
  // static DateTime? getBirthday() {
  //   final birthday = _preferences!.getString(_keyBirthday);
  //   return birthday == null ? null : DateTime.tryParse(birthday);
  // }
}
