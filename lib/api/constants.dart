class ApiConstants {
  static String baseUrl = 'https://gamma.staging.candena.de/api/v1/';
  static String currentUsersEndpoint = 'users/current/info';
  static late String userEndpoint;

  static initializeUserEndpoint(int userId) {
    userEndpoint = 'users/$userId';
  }
}
