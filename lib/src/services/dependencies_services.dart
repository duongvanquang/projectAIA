import 'package:flutter_simple_dependency_injection/injector.dart';
import 'api_services.dart';

import 'configuration_services.dart';
import 'favorities_services.dart';
import 'user_services.dart';

mixin DependencieService {
  static Injector initialise(Injector injector) {
    injector.map<ApiServices>((injector) => ApiServices());
    injector.map<ApiFavorities>((injector) => ApiFavorities());
    injector.map<ConfigurationServices>((injector) => ConfigurationServices());
    injector.map<UserServices>((injector) => UserServices());
    return injector;
  }
}
