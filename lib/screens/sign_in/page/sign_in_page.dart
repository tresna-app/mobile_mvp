import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_mvp/screens/final_onboarding/page/final_onboarding_page.dart';
import 'package:mobile_mvp/screens/forgot_password/page/forgot_password_page.dart';
import 'package:mobile_mvp/screens/sign_in/bloc/sign_in_bloc.dart';
import 'package:mobile_mvp/screens/sign_in/widget/sign_in_content.dart';
import 'package:mobile_mvp/screens/sign_up/page/sign_up_page.dart';
import 'package:mobile_mvp/screens/tab_bar/page/tab_bar_page.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildContext(context),
    );
  }

  BlocProvider<SignInBloc> _buildContext(BuildContext context) {
    return BlocProvider<SignInBloc>(
      create: (BuildContext context) => SignInBloc(),
      child: BlocConsumer<SignInBloc, SignInState>(
        buildWhen: (_, currState) => currState is SignInInitial,
        builder: (context, state) {
          return const SignInContent();
        },
        listenWhen: (_, currState) =>
            currState is NextForgotPasswordPageState ||
            currState is NextSignUpPageState ||
            currState is NextFinalOnboardingPageState ||
            currState is ErrorState,
        listener: (context, state) {
          if (state is NextForgotPasswordPageState) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => const ForgotPasswordPage()));
          } else if (state is NextSignUpPageState) {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => SignUpPage()));
          } else if (state is NextFinalOnboardingPageState) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => const FinalOnboardingPage()));
          } else if (state is ErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
      ),
    );
  }
}
