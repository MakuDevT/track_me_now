class ApiUtil {
  static String getBaseUrl({bool? noSuffix}) {
    var baseUrl = 'http://localhost:4000';
    if (noSuffix != null && noSuffix) return baseUrl;
    return '$baseUrl/api';
  }
}
