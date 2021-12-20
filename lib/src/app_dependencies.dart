import 'package:flutter_simple_dependency_injection/injector.dart';

import 'blocs/dependencies.dart';
import 'services/dependencies_services.dart';

class AppDependencies {
  static Injector injector = AppDependencies().initialise(Injector());

  Injector initialise(Injector injector) {
    DependencieService.initialise(injector);

    Dependencies.initialise(injector);

    return injector;
  }
}
