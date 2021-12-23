import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviesaia/src/app_dependencies.dart';

import '../blocs/user/user_bloc.dart';
import '../blocs/user/user_event.dart';
import '../blocs/user/user_state.dart';
import '../enum/enums_firebase.dart';
import '../theme/color_theme.dart';
import '../widgtes/custom_divider.dart';
import '../widgtes/custom_image_login.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  var _email = '';
  var _password = '';
  var _fullName = '';
  String? _textEmailError;
  String? _textPasswordError;
  String? _textFullNameError;

  @override
  Widget build(BuildContext context) => Scaffold(
          body: Stack(
        fit: StackFit.expand,
        children: [
          const ImageBackgoundLogin(),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 150, 30, 0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tr('signup.name'),
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(color: ColorsTheme.secondaryGrey),
                  ),
                  BlocBuilder<UserBloc, UserState>(
                    bloc: AppDependencies.injector.get<UserBloc>(),
                    builder: (context, state) {
                      _checkSignUp(context, state);
                      return TextField(
                        cursorColor: ColorsTheme.greenColor,
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) => _fullName = value,
                        decoration: InputDecoration(
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: ColorsTheme.secondaryGrey,
                              ),
                            ),
                            contentPadding:
                                const EdgeInsets.only(top: 15, bottom: 5),
                            isDense: true,
                            errorText: _textFullNameError),
                        style: Theme.of(context)
                            .textTheme
                            .headline4!
                            .copyWith(color: ColorsTheme.primaryWhite),
                      );
                    },
                  ),
                  const SizedBox(height: 30),
                  Text(
                    tr('signup.email'),
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(color: ColorsTheme.secondaryGrey),
                  ),
                  BlocBuilder<UserBloc, UserState>(
                    bloc: AppDependencies.injector.get<UserBloc>(),
                    builder: (context, state) {
                      _checkSignUp(context, state);
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
                        tr('signup.password'),
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
                      _checkSignUp(context, state);
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
                        onPressed: () => checkButtonSignUp(context),
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
                          tr('signup.signup'),
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
                      tr('signup.forgotpassword'),
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
                          tr('signup.facebook'),
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
                          tr('signup.google'),
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
                      Text(tr('signup.donthaveaccount'),
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(color: ColorsTheme.secondaryGrey)),
                      const SizedBox(width: 10),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed('/');
                          },
                          child: Text(tr('signup.sigin'),
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4!
                                  .copyWith(color: ColorsTheme.primaryWhite)))
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ));

  void _checkSignUp(BuildContext context, UserState state) {
    switch (state.runtimeType) {
      case UserFullNameSubmitFailure:
        _textFullNameError = tr('signup.invalidfullname');
        _textEmailError = null;
        _textPasswordError = null;
        break;
      case UserEmailSubmitFailure:
        _textEmailError = tr('signup.invalidemail');
        _textFullNameError = null;
        _textPasswordError = null;
        break;
      case UserPasswordSubmitFailure:
        _textPasswordError = tr('signup.invalidpassword');
        _textFullNameError = null;
        _textEmailError = null;
        break;
      case UserAuthFailure:
        state as UserAuthFailure;
        if (state.exception == FirebaseCode.userAlreadyExists.code) {
          _textEmailError = tr('signup.existaccount');
          _textFullNameError = null;
          _textPasswordError = null;
        }
        break;
      case UserSignupSuccess:
        _textEmailError = null;
        _textPasswordError = null;
        _textFullNameError = null;
        Future.delayed(const Duration(milliseconds: 200),
            () => Navigator.of(context).pushNamed('/'));
        break;
    }
  }

  void checkButtonSignUp(BuildContext context) {
    AppDependencies.injector.get<UserBloc>().add(UserSignupButtonSubmitted(
        email: _email.trim(), password: _password, fullname: _fullName));
  }
}
