import 'dart:async';

import 'package:get_storage/get_storage.dart';

class Storage {
  static final box = GetStorage();

  //read login value
  bool getLoginValue() {
    if (box.read('login') == null || box.read('login') == false) {
      return false;
    }

    return true;
  }

  //write login value
  Future<void> setLoginValue() async {
    await box.write('login', true);
  }

  //read uid
  String getUid() {
    return box.read('uid');
  }

  //write uid
  Future<void> setUid(String uid) async {
    return box.write('uid', uid);
  }

  //read first_time
  bool getFirstTime() {
    if (box.read('is_first') == null || box.read('is_first') == true) {
      return true;
    } else {
      return false;
    }
  }

  //write first_time
  Future<void> setFirstTime() async {
    await box.write('is_first', false);
  }

  // switch theme
  Future<void> setTheme() async {
    if (box.read('is_dark') == true) {
      await box.write('is_dark', false);
    } else {
      await box.write('is_dark', true);
    }
  }

  // get theme
  bool getTheme() {
    if (box.read('is_dark') == null || box.read('is_dark') == false) {
      return false;
    }

    return true;
  }
}
