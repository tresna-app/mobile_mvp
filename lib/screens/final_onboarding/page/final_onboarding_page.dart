import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_mvp/screens/final_onboarding/bloc/final_onboarding_bloc.dart';
import 'package:mobile_mvp/screens/final_onboarding/widget/final_onboarding_content.dart';
import 'package:mobile_mvp/screens/tab_bar/page/tab_bar_page.dart';

class FinalOnboardingPage extends StatelessWidget {
  const FinalOnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  BlocProvider<FinalOnboardingBloc> _buildBody(BuildContext context) {
    return BlocProvider<FinalOnboardingBloc>(
      create: (BuildContext context) => FinalOnboardingBloc(),
      child: BlocConsumer<FinalOnboardingBloc, FinalOnboardingState>(
        listenWhen: (_, currState) => currState is NextTabBarPageState,
        listener: (context, state) {
          if (state is NextTabBarPageState) {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const TabBarPage()));
          }
        },
        buildWhen: (_, currState) => currState is FinalOnboardingInitial,
        builder: (context, state) {
          return const FinalOnboardingContent();
        },
      ),
    );
  }
}
