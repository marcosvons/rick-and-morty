import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rick_and_morty_challenge/core/constants/dimens.dart';
import 'package:rick_and_morty_challenge/core/constants/string_constants.dart';
import 'package:rick_and_morty_challenge/features/auth/bloc/auth_bloc.dart';
import 'package:rick_and_morty_challenge/features/homepage/views/characters.dart';
import 'package:rick_and_morty_challenge/features/login/views/login.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return AnimatedSplashScreen(
          splash: Lottie.asset(
            AssetConstants.mortySplashAnimation,
          ),
          nextScreen: state.when(
            authenticated: CharactersView.new,
            unauthenticated: LoginView.new,
          ),
          backgroundColor: Theme.of(context).canvasColor,
          splashIconSize: MediaQuery.of(context).size.width * Multipliers.x5,
          splashTransition: SplashTransition.fadeTransition,
          pageTransitionType: PageTransitionType.fade,
        );
      },
    );
  }
}
