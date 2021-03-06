import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../app_dependencies.dart';
import '../blocs/configuration/configuration_bloc.dart';
import '../blocs/configuration/configuration_state.dart';
import '../blocs/person_id/personid_bloc.dart';
import '../blocs/person_id/personid_event.dart';
import '../model/movies_configuration.dart';
import '../model/person_model.dart';
import '../route_name/route_name.dart';
import '../theme/color_theme.dart';

class ItemPerson extends StatelessWidget {
  final PersonModel personModel;
  ItemPerson({required this.personModel, Key? key}) : super(key: key);
  final _personidBloc = AppDependencies.injector.get<PersonidBloc>();

  @override
  Widget build(BuildContext context) {
    _personidBloc.add(PersonIdStartted(id: personModel.id));
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 5,
      margin: const EdgeInsets.all(5),
      child: BlocBuilder<ConfigurationBloc, ConfigurationState>(
          bloc: AppDependencies.injector.get<ConfigurationBloc>(),
          builder: (context, state) {
            if (state is ConfigurationStartSuccess) {
              return InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(RouteName.detailPerson,
                      arguments: {'id': personModel.id});
                },
                child: Column(
                  children: [
                    CachedNetworkImage(
                      imageUrl:
                          '''${state.configurationModel.getProfileSizes(ProfileSize.medium)}${personModel.profilePath}''',
                      width: 200,
                      height: 250,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const Center(
                        child: SizedBox(
                          child: Center(child: CircularProgressIndicator()),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              'assets/images/img_not_found.png',
                            ),
                          ),
                        ),
                      ),
                    ),
                    // SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      child: Text('${personModel.name}',
                          style: Theme.of(context)
                              .textTheme
                              .headline3!
                              .copyWith(color: ColorsTheme.secondaryGrey),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2),
                    ),
                    // SizedBox(height: 15),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          }),
    );
  }
}
