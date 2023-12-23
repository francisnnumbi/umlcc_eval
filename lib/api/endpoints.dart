class EndPoint {
  static const String baseUrl = 'https://umlcc.chd-staging.tech/api/app/';

  // Auth
  static const String authUrl = '${baseUrl}auth/';
  static const String loginUrl = '${authUrl}login';
  static const String registerUrl = '${authUrl}register';
  static const String verifyUrl = '${authUrl}verify';

  // Account and Profile
  static const String accountUrl = '${baseUrl}account/';
  static const String meUrl = '${accountUrl}me';

  // Products
  static const String productsUrl = '${baseUrl}products';

  // Headers
  static Map<String, dynamic> headers({
    String? token,
    String? xDid,
    String? identity,
    String? cookies,
  }) {
    Map<String, dynamic> h = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    if (token != null) {
      h['Authorization'] = token;
    }
    if (xDid != null) {
      h['X-DID'] = xDid;
    }
    if (identity != null) {
      h['identity'] = identity;
    }
    if (cookies != null) {
      h['Cookie'] = cookies;
    }
    return h;
  }
}
