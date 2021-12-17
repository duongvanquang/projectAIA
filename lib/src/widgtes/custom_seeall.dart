import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../theme/color_theme.dart';

class CustomSeeAll extends StatelessWidget {
  final String? title;
  const CustomSeeAll({required this.title, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Text(title!,
              style: Theme.of(context)
                  .textTheme
                  .headline3!
                  .copyWith(color: ColorsTheme.primaryBlack)),
          const Spacer(),
          Text(tr('discoverscreen.seeall'),
              style: Theme.of(context)
                  .textTheme
                  .headline4!
                  .copyWith(color: ColorsTheme.blueColor)),
          const SizedBox(width: 15),
          const Icon(
            Icons.skip_next,
            size: 32,
            color: ColorsTheme.blueColor,
          )
        ],
      );
}
