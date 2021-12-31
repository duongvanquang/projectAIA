import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviesaia/src/theme/color_theme.dart';

import '../app_dependencies.dart';
import '../blocs/configuration/configuration_bloc.dart';
import '../blocs/configuration/configuration_state.dart';
import '../model/movies_configuration.dart';

class ZoomImgae extends StatelessWidget {
  final String? image;
  const ZoomImgae({this.image, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.arrow_back_ios,
                  size: 32,
                  color: ColorsTheme.blueColor,
                ))),
        body: BlocBuilder<ConfigurationBloc, ConfigurationState>(
          bloc: AppDependencies.injector.get<ConfigurationBloc>(),
          builder: (context, state) {
            if (state is ConfigurationStartSuccess) {
              return InteractiveViewer(
                scaleEnabled: false,
                panEnabled: false,
                alignPanAxis: true,
                maxScale: 10,
                child: CachedNetworkImage(
                  imageUrl:
                      '''${state.configurationModel.getPosterSize(PosterSize.big)}${image!}''',
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const Center(
                    child: SizedBox(
                      child: Center(child: CircularProgressIndicator()),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/img_not_found.jpg'),
                      ),
                    ),
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      );
}
