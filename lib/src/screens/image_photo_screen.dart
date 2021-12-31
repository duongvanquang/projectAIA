import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviesaia/src/widgtes/zoom_image.dart';

import '../app_dependencies.dart';
import '../blocs/configuration/configuration_bloc.dart';
import '../blocs/configuration/configuration_state.dart';
import '../blocs/person_id/personid_bloc.dart';
import '../blocs/person_id/personid_state.dart';
import '../model/movies_configuration.dart';
import '../route_name/route_name.dart';
import '../theme/color_theme.dart';

class ImagePhotoScreen extends StatelessWidget {
  const ImagePhotoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(
            'Photo Album',
            style: Theme.of(context)
                .textTheme
                .headline4!
                .copyWith(color: ColorsTheme.primaryBlack),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back_ios,
                size: 32,
                color: Colors.blue,
              )),
        ),
        body: Container(
          color: Colors.grey,
          child: BlocBuilder<PersonidBloc, PersonidState>(
            bloc: AppDependencies.injector.get<PersonidBloc>(),
            builder: (context, state) {
              if (state is PersonIdLoadInProgress) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is PersonIdLoadInSuccess) {
                final itemId = state.personId;
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 15, bottom: 10),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                itemId.name!,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline3!
                                    .copyWith(color: ColorsTheme.primaryBlack),
                              ),
                              Text(itemId.knownForDepartment!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(
                                          color: ColorsTheme.primaryBlack)),
                            ],
                          ),
                          const Spacer(),
                          Text('${itemId.popularity!}',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(color: ColorsTheme.primaryBlack))
                        ],
                      ),
                    ),
                    Expanded(
                      child: GridView.builder(
                          padding: EdgeInsets.zero,
                          physics: const BouncingScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4, mainAxisExtent: 150),
                          itemCount: state.personId.personImage!.length,
                          itemBuilder: (context, index) {
                            final itemImge = state.personId.personImage![index];
                            return BlocBuilder<ConfigurationBloc,
                                ConfigurationState>(
                              bloc: AppDependencies.injector
                                  .get<ConfigurationBloc>(),
                              builder: (context, state) {
                                if (state is ConfigurationStartSuccess) {
                                  return InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => ZoomImgae(
                                                  image: itemImge.filePath,
                                                )),
                                      );
                                    },
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          '''${state.configurationModel.getPosterSize(PosterSize.medium)}${itemImge.filePath}''',
                                      height: 250,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) =>
                                          const Center(
                                        child: SizedBox(
                                          child: Center(
                                              child:
                                                  CircularProgressIndicator()),
                                        ),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Container(
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: AssetImage(
                                                'assets/images/img_not_found.png'),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                return const SizedBox.shrink();
                              },
                            );
                          }),
                    ),
                  ],
                );
              }
              return Container();
            },
          ),
        ),
      );
}
