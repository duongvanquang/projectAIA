import 'package:bloc/bloc.dart';

import './user_event.dart';
import './user_state.dart';
import '../../enum/enums_firebase.dart';
import '../../services/user_services.dart';
import '../../utils/validators.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserServices? userServices;
  UserBloc({required this.userServices}) : super(UserInitial());
  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    switch (event.runtimeType) {
      case UserSignupButtonSubmitted:
        final userSubmit = event as UserSignupButtonSubmitted;
        try {
          yield UserLoadInProgress();
          if (Validators.isValidEmail(userSubmit.email) &&
              Validators.isValidPassword(userSubmit.password) &&
              (userSubmit.fullname.isNotEmpty &&
                  userSubmit.fullname.trim().length >= 2)) {
            final status = await userServices!
                .signUp(userSubmit.email, userSubmit.password);
            if (status == FirebaseCode.signUpSuccess.code) {
              yield UserSignupSuccess();
            } else {
              yield UserAuthFailure(status);
            }
          } else if (userSubmit.fullname.trim().length < 2) {
            yield UserFullNameSubmitFailure();
          } else if (!Validators.isValidEmail(userSubmit.email)) {
            yield UserEmailSubmitFailure();
          } else if (!Validators.isValidPassword(userSubmit.password)) {
            yield UserPasswordSubmitFailure();
          }
        } on Exception {
          yield UserSignupFailure();
        }
        break;
      case UserLoginButtonSubmitted:
        final userSubmit = event as UserLoginButtonSubmitted;
        try {
          if (Validators.isValidEmail(userSubmit.email) &&
              Validators.isValidPassword(userSubmit.password)) {
            final status = await userServices!
                .signIn(userSubmit.email, userSubmit.password);
            if (status == FirebaseCode.loginSuccess.code) {
              yield UserLoginSuccess();
            } else {
              yield UserAuthFailure(status);
            }
          } else if (!Validators.isValidEmail(userSubmit.email)) {
            yield UserEmailSubmitFailure();
          } else if (!Validators.isValidPassword(userSubmit.password)) {
            yield UserPasswordSubmitFailure();
          }
        } on Exception {
          yield UserLoginFailure();
        }
    }
  }
}
