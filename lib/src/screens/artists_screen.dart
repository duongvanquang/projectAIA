import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/person/person_bloc.dart';
import '../blocs/person/person_event.dart';
import '../blocs/person/person_state.dart';
import '../widgtes/custom_header.dart';
import '../widgtes/item_person.dart';

class ArtistsScreen extends StatelessWidget {
  const ArtistsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<PersonBloc>().add(PersonStartted());
    return SafeArea(
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size(double.infinity, 200),
            child: CustomHeader(title: tr('artists.headertitle')),
          ),
          body: BlocBuilder<PersonBloc, PersonState>(
            builder: (context, state) {
              if (state is PersonLoadInProgress) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is PersonLoadInSuccess) {
                return GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 0.4,
                            mainAxisSpacing: 0.5),
                    itemCount: state.personModel.length,
                    itemBuilder: (context, index) {
                      final item = state.personModel[index];
                      return ItemPerson(personModel: item);
                    });
              }
              return const SizedBox.shrink();
            },
          )),
    );
  }
}
