import 'package:flutter/material.dart';
import '../theme/color_theme.dart';

typedef RatingChangeCallback = void Function(double rating);

class StarRating extends StatelessWidget {
  final int starCount;
  final double rating;
  final double? size;
  final Color? color;
  static const double defaultSize = 25;

  const StarRating(
      {this.starCount = 5, this.rating = .0, this.color, this.size});

  Widget _buildStar(BuildContext context, int index) {
    Icon icon;
    if (index >= rating) {
      icon = Icon(
        Icons.star_border,
        size: size ?? defaultSize,
        color: color ?? ColorsTheme.primaryWhite,
      );
    } else if (index > rating - 1 && index < rating) {
      icon = Icon(
        Icons.star_half,
        size: size ?? defaultSize,
        color: color ?? ColorsTheme.primaryWhite,
      );
    } else {
      icon = Icon(
        Icons.star,
        size: size ?? defaultSize,
        color: color ?? ColorsTheme.primaryWhite,
      );
    }
    return icon;
  }

  @override
  Widget build(BuildContext context) => Row(
      children:
          List.generate(starCount, (index) => _buildStar(context, index)));
}
