import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_mvp/screens/onboarding/bloc/onboarding_bloc.dart';
import 'package:mobile_mvp/screens/onboarding/widget/onboarding_content.dart';
import 'package:mobile_mvp/screens/sign_in/page/sign_in_page.dart';
import 'package:mobile_mvp/screens/sign_up/page/sign_up_page.dart';

class OnboardingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  BlocProvider<OnboardingBloc> _buildBody(BuildContext context) {
    return BlocProvider<OnboardingBloc>(
      create: (BuildContext context) => OnboardingBloc(),
      child: BlocConsumer<OnboardingBloc, OnboardingState>(
        listenWhen: (_, currState) =>
            currState is NextScreenState || currState is NextSignInPageState,
        listener: (context, state) {
          if (state is NextScreenState) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (_) {
                  return SignUpPage();
                },
              ),
            );
          } else if (state is NextSignInPageState) {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => SignInPage()));
          }
        },
        buildWhen: (_, currState) => currState is OnboardingInitial,
        builder: (context, state) {
          return OnboardingContent();
        },
      ),
    );
  }
}
