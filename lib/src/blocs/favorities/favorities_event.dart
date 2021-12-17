import 'package:equatable/equatable.dart';

abstract class FavoritiesEvent extends Equatable {
  const FavoritiesEvent();

  @override
  List<Object> get props => [];
}

class FavoritiesStartted extends FavoritiesEvent {
  final String? userName;
  final String? fullName;
  final String? type;
  final int? moviesId;
  final String? moviesName;
  final String? imagePath;
  final String? dataTimeCreated;
  const FavoritiesStartted(
      {required this.userName,
      required this.fullName,
      required this.type,
      required this.moviesName,
      required this.moviesId,
      required this.imagePath,
      required this.dataTimeCreated});

  @override
  List<Object> get props => [
        userName!,
        fullName!,
        type!,
        moviesName!,
        moviesId!,
        imagePath!,
        dataTimeCreated!
      ];
}
