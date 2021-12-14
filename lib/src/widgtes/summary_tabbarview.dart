import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/personid/personid_bloc.dart';
import '../blocs/personid/personid_state.dart';
import '../theme/color_theme.dart';

class SummaryTabbarView extends StatelessWidget {
  const SummaryTabbarView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: ColorsTheme.secondaryGrey,
        body: BlocBuilder<PersonidBloc, PersonidState>(
          builder: (context, state) {
            if (state is PersonIdLoadInProgress) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PersonIdLoadInSuccess) {
              return SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: Text(
                    state.personId.biography!,
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(color: ColorsTheme.primaryBlack),
                  ),
                ),
              );
            }
            return Container();
          },
        ),
      );
}
