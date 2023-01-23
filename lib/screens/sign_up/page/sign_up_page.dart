import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_mvp/screens/final_onboarding/page/final_onboarding_page.dart';
import 'package:mobile_mvp/screens/sign_in/page/sign_in_page.dart';
import 'package:mobile_mvp/screens/sign_up/bloc/signup_bloc.dart';
import 'package:mobile_mvp/screens/sign_up/widget/sign_up_content.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildBody(context));
  }

  BlocProvider<SignUpBloc> _buildBody(BuildContext context) {
    return BlocProvider<SignUpBloc>(
      create: (BuildContext context) => SignUpBloc(),
      child: BlocConsumer<SignUpBloc, SignUpState>(
        listenWhen: (_, currState) =>
            currState is NextFinalOnboardingPageState ||
            currState is NextSignInPageState ||
            currState is ErrorState,
        listener: (context, state) {
          if (state is NextFinalOnboardingPageState) {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const FinalOnboardingPage()));
          } else if (state is NextSignInPageState) {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const SignInPage()));
          } else if (state is ErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        buildWhen: (_, currState) => currState is SignupInitial,
        builder: (context, state) {
          return const SignUpContent();
        },
      ),
    );
  }
}
