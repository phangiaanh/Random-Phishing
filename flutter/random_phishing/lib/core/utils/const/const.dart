import 'package:flutter/material.dart';

class ConstParameters {
  static String LoginPage = '/';
  static String HomePage = '/homepage';
  static String CheckPhishingPage = '/check';
  static String HistoryPage = '/history';
  static String RegistrationPage = '/registation';
  static String UserManagementPage = '/user';
  static String ModelManagementPage = '/model';
}

class DefinedRole {
  static String RoleUser = "user";
  static String RoleAdmin = "admin";
  static String RoleGuest = "guest";
}

class DataSourceUser {
  static Map user = {
    "watermelon_admin": {"pass": "Bachkhoamt", "role": "admin"},
    "watermelon_user": {"pass": "Bachkhoamt", "role": "user"},
  };
}

class PermissionNavigationByRole {
  static Map role = {
    DefinedRole.RoleAdmin: [
      {"icon": Icon(Icons.security_sharp), "label": Text('Phishing Detector')},
      {"icon": Icon(Icons.history_sharp), "label": Text('Phishing History')},
      {"icon": Icon(Icons.model_training_sharp), "label": Text('Model')},
      {"icon": Icon(Icons.verified_user_sharp), "label": Text('User Manager')},
      {"icon": Icon(Icons.logout_sharp), "label": Text('Logout')},
    ],
    DefinedRole.RoleGuest: [
      {"icon": Icon(Icons.security_sharp), "label": Text('Phishing Detector')},
      {"icon": Icon(Icons.app_registration_sharp), "label": Text('Register')},
    ],
    DefinedRole.RoleUser: [
      {"icon": Icon(Icons.security_sharp), "label": Text('Phishing Detector')},
      {"icon": Icon(Icons.history_sharp), "label": Text('Phishing History')},
      {"icon": Icon(Icons.logout_sharp), "label": Text('Logout')},
    ],
  };
}
