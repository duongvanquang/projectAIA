import 'package:flutter/material.dart';
import '../theme/color_theme.dart';

class HorizontalOrLine extends StatelessWidget {
  final String? label;
  final double? height;
  const HorizontalOrLine({Key? key, this.label, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              child: Divider(
                color: ColorsTheme.primaryBlack,
                height: height,
              ),
            ),
          ),
          Text(
            label!,
            style: Theme.of(context)
                .textTheme
                .headline5!
                .copyWith(color: ColorsTheme.secondaryGrey),
          ),
          Expanded(
            child: Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: Divider(
                  color: Colors.black,
                  height: height,
                )),
          ),
        ],
      );
}
