class ApiUtil {
  static String getBaseUrl({bool? noSuffix}) {
    var baseUrl = 'https://trackmenow.onrender.com';
    if (noSuffix != null && noSuffix) return baseUrl;
    return '$baseUrl/api';
  }
}
