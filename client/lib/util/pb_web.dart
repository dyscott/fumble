import 'package:fetch_client/fetch_client.dart';
import 'package:pocketbase/pocketbase.dart';

PocketBase create_pb(String pocketbase_url, AsyncAuthStore authStore) {
  return PocketBase(
    pocketbase_url,
    authStore: authStore,
    httpClientFactory: () => FetchClient(mode: RequestMode.cors),
  );
}