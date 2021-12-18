import 'package:global_configuration/global_configuration.dart';

class AppInit {
  Future<void> init() async {
    await GlobalConfiguration().loadFromAsset('appconfig');
  }
}
