import 'dart:convert';

import '../model/movies_configuration.dart';
import '../utils/rest_client.dart';

class ConfigurationServices {
  Future<ConfigurationModel> getImageConfiguration() async {
    final bodyConfiguration =
        await HttpClientServices.httpClient().getData('/3/configuration');
    final Map getConfiguration = json.decode(bodyConfiguration);
    return ConfigurationModel.fromJson(getConfiguration['images']);
  }
}
