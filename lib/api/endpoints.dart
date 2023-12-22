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
  static Map<String, String> headers(
      {String? token,
      String? xDid,
      String? identity,
      String contentType = "application/json"}) {
    return {
      'Authorization': token ?? "",
      'X-DID': xDid ?? "",
      'identity': identity ?? "",
      //'Content-Type': contentType,
      'Accept': 'application/json',
    };
  }
}
