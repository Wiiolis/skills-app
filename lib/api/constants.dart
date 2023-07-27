class ApiConstants {
  static String baseUrl = 'https://gamma.staging.candena.de/api/v1/';
  static late String userEndpoint;
  static late String clinicalSkills;

  static initializeUserEndpoint(int userId) {
    userEndpoint = 'users/$userId';
  }

  static initializeClinicalSkills(int moduleVersionId) {
    clinicalSkills = 'modules/$moduleVersionId/clinical_skills';
  }
}
