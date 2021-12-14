import 'package:equatable/equatable.dart';
import '../../model/trending_model.dart';

abstract class OnboardingState extends Equatable {
  const OnboardingState();

  @override
  List<Object> get props => [];
}

class OnboardingInitial extends OnboardingState {}

class OnboardingLoadInProgress extends OnboardingState {}

class OnboardingLoadSuccess extends OnboardingState {
  final List<TrendingModel> trendingModel;
  const OnboardingLoadSuccess({required this.trendingModel});
  @override
  List<Object> get props => [trendingModel];
}

class OnboardingLoadFailure extends OnboardingState {
  final String? error;
  const OnboardingLoadFailure({required this.error});
  @override
  List<Object> get props => [error!];
}
