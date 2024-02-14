import 'package:pocketbase/pocketbase.dart';

PocketBase create_pb(String pocketbase_url, AsyncAuthStore authStore) {
  return PocketBase(
    pocketbase_url,
    authStore: authStore,
  );
}