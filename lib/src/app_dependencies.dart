import 'package:flutter_simple_dependency_injection/injector.dart';

import 'blocs/dependencies.dart';
import 'services/dependencies_services.dart';

class AppDependencies {
  static Injector injector = Injector();

  Injector initialise() {
    DependencieService.initialise(injector);

    DependenciesBloc.initialise(injector);

    return injector;
  }
}
