import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';
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

    pb = PocketBase('http://192.168.0.72:8090', authStore: store);

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

class DiscordSignInButton extends StatelessWidget {
  final VoidCallback onPressed;

  const DiscordSignInButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF5865F2), // Discord's primary color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0)
      ),
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/discord-logo.png', // Replace with your Discord logo image asset
              height: 30.0,
            ),
            const SizedBox(width: 10.0),
            const Text(
              'Sign in with Discord',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
