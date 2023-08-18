class ApiConstants {
  static String baseUrl = 'https://gamma.staging.candena.de/api/v1/';
  static late String userEndpoint;
  static late String clinicalSkills;
  static String modules = 'module_versions';
  static String instructors = 'clinical_instructors';
  static late String clinicalSkill;

  static initializeUserEndpoint(int userId) {
    userEndpoint = 'users/$userId';
  }

  static initializeClinicalSkills(int moduleVersionId) {
    clinicalSkills = 'modules/$moduleVersionId/clinical_skills';
  }

  static initializeClinicalSkill(int moduleVersionId, int skillId) {
    clinicalSkill = 'modules/$moduleVersionId/clinical_skills/$skillId';
  }
}
