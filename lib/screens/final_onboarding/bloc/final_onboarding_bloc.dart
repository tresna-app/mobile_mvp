import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'final_onboarding_event.dart';
part 'final_onboarding_state.dart';

class FinalOnboardingBloc
    extends Bloc<FinalOnboardingEvent, FinalOnboardingState> {
  FinalOnboardingBloc() : super(FinalOnboardingInitial());

  final pageController = PageController(initialPage: 0);

  @override
  Stream<FinalOnboardingState> mapEventToState(
    FinalOnboardingEvent event,
  ) async* {
    if (event is TabBarTappedEvent) {
      yield NextTabBarPageState();
    }
  }
}
