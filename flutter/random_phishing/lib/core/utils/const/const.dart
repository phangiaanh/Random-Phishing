import 'package:flutter/material.dart';
import 'package:random_phishing/features/detect_phishing_url/presentation/blocs/detect_phishing_url_bloc.dart';
import 'package:random_phishing/features/detect_phishing_url/presentation/pages/detect_phishing_url_page.dart';
import 'package:random_phishing/features/list_phishing_history/presentation/pages/list_phishing_history_page.dart';

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

class DefinedReasons {
  static String httpsReason = "https protocol";
  static String protocolReason = "not https protocol";
}

class DataSourceUser {
  static Map user = {
    "watermelon_admin": {"pass": "11", "role": "admin"},
    "watermelon_user": {
      "pass": "11",
      "role": "user",
      "color": Colors.amber[100]
    },
    "watermelon_user2": {
      "pass": "11",
      "role": "user",
      "color": Colors.amber[200]
    },
    "watermelon_user3": {
      "pass": "11",
      "role": "user",
      "color": Colors.amber[300]
    },
    "watermelon_user4": {
      "pass": "11",
      "role": "user",
      "color": Colors.amber[400]
    },
    "watermelon_user5": {
      "pass": "11",
      "role": "user",
      "color": Colors.amber[500]
    },
  };
}

class PermissionNavigationByRole {
  static Map role = {
    DefinedRole.RoleAdmin: [
      // {"icon": Icon(Icons.security_sharp), "label": Text('Phishing Detector')},
      {
        "icon": Icon(Icons.verified_user_sharp),
        "label": Text('User Manager'),
        "page": Placeholder()
      },
      {
        "icon": Icon(Icons.history_sharp),
        "label": Text('Phishing History'),
        "page": ListPhishingHistoryPage()
      },
      {
        "icon": Icon(Icons.model_training_sharp),
        "label": Text('Model'),
        "page": Placeholder()
      },
      {"icon": Icon(Icons.logout_sharp), "label": Text('Logout')},
    ],
    DefinedRole.RoleGuest: [
      {
        "icon": Icon(Icons.security_sharp),
        "label": Text('Phishing Detector'),
        "page": DetectPhishingUrlExtendPage()
      },
      {
        "icon": Icon(Icons.app_registration_sharp),
        "label": Text('Register'),
        "page": Placeholder()
      },
    ],
    DefinedRole.RoleUser: [
      {
        "icon": Icon(Icons.security_sharp),
        "label": Text('Phishing Detector'),
        "page": DetectPhishingUrlExtendPage()
      },
      {
        "icon": Icon(Icons.history_sharp),
        "label": Text('Phishing History'),
        "page": ListPhishingHistoryPage()
      },
      {
        "icon": Icon(Icons.logout_sharp),
        "label": Text('Logout'),
        "page": Placeholder()
      },
    ],
  };
}
