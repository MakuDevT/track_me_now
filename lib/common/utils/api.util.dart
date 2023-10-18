class ApiUtil {
  static String getBaseUrl({bool? noSuffix}) {
    var baseUrl = 'http://192.168.1.88:4000';
    if (noSuffix != null && noSuffix) return baseUrl;
    return '$baseUrl/api';
  }
}
