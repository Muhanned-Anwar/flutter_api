
class ApiSettings {

  static const _BASE_URL = 'http://demo-api.mr-dev.tech/';

  static const _API_URL = _BASE_URL + 'api/';
  static const IMAGES_URL = _BASE_URL + 'images/';

  static const USERS = _API_URL + 'users';
  static const CATEGORIES = _API_URL + 'categories';
  static const LOGIN = _API_URL + 'students/auth/login';
  static const LOGOUT = _API_URL + 'students/auth/logout';
  static const REGISTER = _API_URL + 'students/auth/register';
  static const FORGET_PASSWORD = _API_URL + 'students/auth/forget-password';
  static const RESET_PASSWORD = _API_URL + 'students/auth/reset-password';

  static const IMAGES = _API_URL + 'student/images/{id}';
}