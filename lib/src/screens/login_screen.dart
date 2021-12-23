import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviesaia/src/route_name/route_name.dart';

import '../blocs/user/user_bloc.dart';
import '../blocs/user/user_event.dart';
import '../blocs/user/user_state.dart';
import '../enum/enums_firebase.dart';
import '../theme/color_theme.dart';
import '../widgtes/custom_divider.dart';
import '../widgtes/custom_image_login.dart';
import '../app_dependencies.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var _email = '';
  var _password = '';
  String? _textEmailError;
  String? _textPasswordError;
  @override
  Widget build(BuildContext context) => Scaffold(
          body: Stack(
        fit: StackFit.expand,
        children: [
          const ImageBackgoundLogin(),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 200, 30, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tr('login.email'),
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(color: ColorsTheme.secondaryGrey),
                ),
                BlocBuilder<UserBloc, UserState>(
                  bloc: AppDependencies.injector.get<UserBloc>(),
                  builder: (context, state) {
                    _checkLogin(context, state);
                    return TextField(
                      cursorColor: ColorsTheme.greenColor,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) => _email = value,
                      decoration: InputDecoration(
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: ColorsTheme.secondaryGrey,
                            ),
                          ),
                          contentPadding:
                              const EdgeInsets.only(top: 15, bottom: 5),
                          isDense: true,
                          errorText: _textEmailError),
                      style: Theme.of(context)
                          .textTheme
                          .headline4!
                          .copyWith(color: ColorsTheme.primaryWhite),
                    );
                  },
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Text(
                      tr('login.password'),
                      style: Theme.of(context)
                          .textTheme
                          .headline5!
                          .copyWith(color: ColorsTheme.secondaryGrey),
                    ),
                    const Spacer(),
                    const Icon(Icons.ac_unit,
                        size: 20, color: ColorsTheme.secondaryGrey)
                  ],
                ),
                BlocBuilder<UserBloc, UserState>(
                  bloc: AppDependencies.injector.get<UserBloc>(),
                  builder: (context, state) {
                    _checkLogin(context, state);
                    return TextField(
                      cursorColor: ColorsTheme.greenColor,
                      obscureText: true,
                      onChanged: (value) => _password = value,
                      decoration: InputDecoration(
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: ColorsTheme.secondaryGrey,
                            ),
                          ),
                          contentPadding:
                              const EdgeInsets.only(top: 15, bottom: 5),
                          isDense: true,
                          errorText: _textPasswordError),
                      style: Theme.of(context)
                          .textTheme
                          .headline4!
                          .copyWith(color: ColorsTheme.primaryWhite),
                    );
                  },
                ),
                const SizedBox(height: 30),
                SizedBox(
                  height: 65,
                  width: double.infinity,
                  child: TextButton(
                      onPressed: () => _checkButtonLogin(context),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            ColorsTheme.primaryWhite),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        )),
                      ),
                      child: Text(
                        tr('login.sigin'),
                        style: Theme.of(context)
                            .textTheme
                            .headline3!
                            .copyWith(color: ColorsTheme.redColor),
                      )),
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    tr('login.forgotpassword'),
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(color: ColorsTheme.secondaryGrey),
                  ),
                ),
                const SizedBox(height: 30),
                const HorizontalOrLine(
                  label: 'or Sign In using',
                  height: 10,
                ),
                const SizedBox(height: 30),
                SizedBox(
                  height: 65,
                  width: double.infinity,
                  child: TextButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            ColorsTheme.bluefeacbook),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        )),
                      ),
                      child: Text(
                        tr('login.facebook'),
                        style: Theme.of(context)
                            .textTheme
                            .headline3!
                            .copyWith(color: ColorsTheme.primaryWhite),
                      )),
                ),
                const SizedBox(height: 20),
                const HorizontalOrLine(
                  label: 'or',
                  height: 10,
                ),
                const SizedBox(height: 30),
                SizedBox(
                  height: 65,
                  width: double.infinity,
                  child: TextButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            ColorsTheme.redColor),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        )),
                      ),
                      child: Text(
                        tr('login.google'),
                        style: Theme.of(context)
                            .textTheme
                            .headline3!
                            .copyWith(color: ColorsTheme.primaryWhite),
                      )),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(tr('login.donthaveaccount'),
                        style: Theme.of(context)
                            .textTheme
                            .headline5!
                            .copyWith(color: ColorsTheme.secondaryGrey)),
                    const SizedBox(width: 10),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(RouteName.signup);
                        },
                        child: Text(tr('login.signup'),
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(color: ColorsTheme.primaryWhite)))
                  ],
                )
              ],
            ),
          )
        ],
      ));
  void _checkLogin(BuildContext context, UserState state) {
    switch (state.runtimeType) {
      case UserEmailSubmitFailure:
        _textEmailError = tr('login.invalidemail');
        _textPasswordError = null;
        break;
      case UserPasswordSubmitFailure:
        _textPasswordError = tr('login.accountnotfound');
        _textEmailError = null;
        break;
      case UserAuthFailure:
        state as UserAuthFailure;
        _textEmailError = null;
        _textPasswordError = null;
        if (state.exception == FirebaseCode.userNotFound.code) {
          _textEmailError = tr('login.invalidemail');
        } else if (state.exception == FirebaseCode.userWrongPassword.code) {
          _textPasswordError = tr('login.incorrectpassword');
        }
        break;
      case UserLoginSuccess:
        _textEmailError = null;
        _textPasswordError = null;
        Future.delayed(const Duration(microseconds: 200),
            () => Navigator.of(context).pushNamed(RouteName.onboading));
    }
  }

  void _checkButtonLogin(BuildContext context) {
    AppDependencies.injector
        .get<UserBloc>()
        .add(UserLoginButtonSubmitted(email: _email, password: _password));
  }
}
