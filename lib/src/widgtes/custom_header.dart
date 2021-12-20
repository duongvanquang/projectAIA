import 'package:flutter/material.dart';
import '../theme/color_theme.dart';

class CustomHeader extends StatelessWidget {
  final String? title;
  const CustomHeader({Key? key, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              title!,
              style: Theme.of(context)
                  .textTheme
                  .headline3!
                  .copyWith(color: ColorsTheme.secondaryGrey),
            ),
            const SizedBox(width: 130),
            InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed('/search');
                },
                child: const Icon(Icons.search,
                    size: 35, color: ColorsTheme.blueColor))
          ],
        ),
      );
}
