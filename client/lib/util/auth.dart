// ignore: unused_import
import 'pb.dart' if (dart.library.html) 'pb_web.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

late PocketBase pb;

const String pocketbase_url = 'https://fumble.dyscott.xyz';

class AuthProvider extends ChangeNotifier {
  bool _loading = true;
  bool get loading => _loading;

  RecordModel? user;
  bool get isAuthenticated => pb.authStore.isValid;

  AuthProvider() {
    initPB();
  }

  void initPB() async {
    // Initialize PocketBase
    final prefs = await SharedPreferences.getInstance();

    final store = AsyncAuthStore(
      save: (String data) async => prefs.setString('pb_auth', data),
      initial: prefs.getString('pb_auth'),
    );

    pb = create_pb(pocketbase_url, store);

    pb.authStore.onChange.listen((event) {
      notifyListeners();
    });

    _loading = false;
    notifyListeners();
  }

  // Launch the Discord OAuth2 flow
  Future<void> signInDiscord() async {
    final res =
        await pb.collection('users').authWithOAuth2('discord', (url) async {
      await launchUrl(url);
    });
    user = res.record;

    notifyListeners();
  }

  // Sign in with a provided email and password
  Future<void> signInEmail(String email, String password) async {
    final res = await pb.collection('users').authWithPassword(email, password);
    user = res.record;
    notifyListeners();
  }

  // Sign up with a provided email and password
  Future<void> signUpEmail(String email, String password) async {
    await pb.collection('users').create(body: {
      'email': email,
      'password': password,
      'passwordConfirm': password,
    });
    notifyListeners();
  }

  // Sync the user data from the server (may be needed after a profile update)
  Future<void> syncUser() async {
    try {
      user = await pb.collection('users').getOne(pb.authStore.model.id);
    } catch (e) {
      user = null;
    }
    notifyListeners();
  }

  // Sign out the current user
  void signOut() {
    pb.authStore.clear();
    user = null;
    notifyListeners();
  }
}
