import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

late PocketBase pb;

class AuthProvider extends ChangeNotifier {
  bool _loading = true;

  bool get loading => _loading;

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

    pb = PocketBase('http://127.0.0.1:8090', authStore: store);

    pb.authStore.onChange.listen((event) {
      notifyListeners();
    });

    _loading = false;
    notifyListeners();
  }

  bool get isAuthenticated => pb.authStore.isValid;

  Future<void> signIn() async {
    await pb.collection('users').authWithOAuth2('discord', (url) async {
      // or use something like flutter_custom_tabs to make the transitions between native and web content more seamless
      await launchUrl(url);
    });
    notifyListeners();
  }

  void signOut() {
    pb.authStore.clear();
    notifyListeners();
  }
}

class Auth extends StatelessWidget {
  const Auth({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In / Register'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: auth.signIn,
                child: const Text('Sign in with Discord'))
          ],
        ),
      ),
    );
  }
}
