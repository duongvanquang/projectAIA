import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../services/api_services.dart';
import 'onboarding_event.dart';
import 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final ApiServices? apiServices;
  OnboardingBloc({required this.apiServices}) : super(OnboardingInitial());
  @override
  Stream<OnboardingState> mapEventToState(OnboardingEvent event) async* {
    switch (event.runtimeType) {
      case OnboardingStartted:
        try {
          yield OnboardingLoadInProgress();
          final trendingData = await apiServices!.getTrendingData();
          yield OnboardingLoadSuccess(trendingModel: trendingData);
        } on Exception {
          yield OnboardingLoadFailure(error: tr(''));
        }
    }
  }
}
