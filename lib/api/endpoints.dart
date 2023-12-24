class EndPoint {
  EndPoint._();

  static const String baseApiUrl = 'https://umlcc.chd-staging.tech/api/app/';

  // Auth
  static const String authUrl = '${baseApiUrl}auth/';
  static const String loginUrl = '${authUrl}login';
  static const String registerUrl = '${authUrl}register';
  static const String verifyUrl = '${authUrl}verify';

  // Account and Profile
  static const String accountUrl = '${baseApiUrl}account/';
  static const String meUrl = '${accountUrl}me';

  // Products
  static const String productsUrl = '${baseApiUrl}products';

  // Headers
  static Map<String, dynamic> headers({
    String? token,
    String? identity,
  }) {
    Map<String, dynamic> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    if (token != null) {
      headers['Authorization'] = token;
    }
    if (identity != null) {
      headers['X-DID'] = identity;
    }
    return headers;
  }
}
