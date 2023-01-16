import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_mvp/core/const/color_constants.dart';
import 'package:mobile_mvp/core/const/data_constants.dart';
import 'package:mobile_mvp/core/const/path_constants.dart';
import 'package:mobile_mvp/core/const/text_constants.dart';
import 'package:mobile_mvp/screens/onboarding/bloc/onboarding_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class OnboardingContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<OnboardingBloc>(context);
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(PathConstants.vector),
              alignment: Alignment.topCenter),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex:
                  5, // Flex adds more rows and change the size of each component
              child: _createPageView(bloc.pageController, bloc),
            ),
            Expanded(
              flex: 2,
              child: _createStatic(bloc),
            ),
          ],
        ),
      ),
    );
  }

  Widget _createPageView(PageController controller, OnboardingBloc bloc) {
    return PageView(
      scrollDirection: Axis.horizontal,
      controller: controller,
      children: DataConstants.onboardingTiles,
      onPageChanged: (index) {
        bloc.add(PageSwipedEvent(index: index));
      },
    );
  }

  Widget _createStatic(OnboardingBloc bloc) {
    return Column(
      children: [
        const SizedBox(
          height: 30,
        ),
        BlocBuilder<OnboardingBloc, OnboardingState>(
          buildWhen: (_, currState) => currState is PageChangedState,
          builder: (context, state) {
            return DotsIndicator(
              dotsCount: 3,
              position: bloc.pageIndex.toDouble(),
              decorator: const DotsDecorator(
                color: Colors.grey,
                activeColor: ColorConstants.primaryColor,
              ),
            );
          },
        ),
        const Spacer(),
        BlocBuilder<OnboardingBloc, OnboardingState>(
          buildWhen: (_, currState) => currState is PageChangedState,
          builder: (context, state) {
            final percent = _getPercent(bloc.pageIndex);
            return TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0, end: percent),
                duration: const Duration(milliseconds: 750),
                builder: (context, value, _) => CircularPercentIndicator(
                      radius: 35,
                      backgroundColor: ColorConstants.primary,
                      progressColor: Colors.white,
                      percent: 1 - value,
                      center: Material(
                        shape: const CircleBorder(),
                        color: ColorConstants.primary,
                        child: RawMaterialButton(
                          shape: const CircleBorder(),
                          onPressed: () {
                            bloc.add(PageChangedEvent());
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Icon(
                              Icons.east_rounded,
                              size: 24.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ));
          },
        ),
        const SizedBox(height: 20),
        RichText(
          text: TextSpan(
            text: TextConstants.alreadyHaveAccount,
            style: const TextStyle(
              color: ColorConstants.textBlack,
              fontSize: 16,
              fontWeight: FontWeight.w300, // Light
            ),
            children: [
              TextSpan(
                text: " ${TextConstants.signIn}",
                style: const TextStyle(
                  color: ColorConstants.primaryColor,
                  fontSize: 16,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    bloc.add(SignInTappedEvent());
                  },
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  double _getPercent(int pageIndex) {
    switch (pageIndex) {
      case 0:
        return 0.25;
      case 1:
        return 0.65;
      case 2:
        return 1;
      default:
        return 0;
    }
  }
}
