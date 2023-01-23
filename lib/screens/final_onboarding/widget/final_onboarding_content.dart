import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_mvp/core/const/color_constants.dart';
import 'package:mobile_mvp/core/const/path_constants.dart';
import 'package:mobile_mvp/core/const/text_constants.dart';
import 'package:mobile_mvp/screens/final_onboarding/bloc/final_onboarding_bloc.dart';

class FinalOnboardingContent extends StatelessWidget {
  const FinalOnboardingContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(PathConstants.finalOnboardingBackground),
            fit: BoxFit.fitWidth),
      ),
      child: Stack(
        children: [
          _createMainData(context),
          BlocBuilder<FinalOnboardingBloc, FinalOnboardingState>(
            buildWhen: (_, currState) => currState is NextTabBarPageState,
            builder: (context, state) {
              if (state is NextTabBarPageState) {
                return const SizedBox();
              }
              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }

  Widget _createMainData(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: SizedBox(
        width: size.width,
        child: Column(
          children: [
            _createLogo(),
            const SizedBox(height: 34),
            _createTitle(),
            const SizedBox(height: 50),
            _createText(),
            const SizedBox(height: 20),
            _createImage(),
            const Spacer(),
            _createButton(context),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _createLogo() {
    return Image.asset(
      PathConstants.whiteLogo,
      scale: 2.75,
    );
  }

  Widget _createTitle() {
    return const Text(
      TextConstants.finalOnboardingTitle,
      style: TextStyle(
          fontSize: 40.0,
          fontWeight: FontWeight.bold,
          color: ColorConstants.white),
      textAlign: TextAlign.center,
    );
  }

  Widget _createText() {
    return const Text(
      TextConstants.finalOnboardingText,
      style: TextStyle(fontSize: 22.0, color: ColorConstants.white),
      textAlign: TextAlign.center,
    );
  }

  Widget _createImage() {
    return Image.asset(
      PathConstants.finalOnboarding,
      scale: 1.25,
    );
  }

  Widget _createButton(BuildContext context) {
    final bloc = BlocProvider.of<FinalOnboardingBloc>(context);
    return SizedBox(
      child: RawMaterialButton(
        fillColor: ColorConstants.white,
        shape: const CircleBorder(),
        onPressed: () {
          bloc.add(TabBarTappedEvent());
        },
        child: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Icon(
            Icons.east_rounded,
            size: 24.0,
            color: ColorConstants.primary,
          ),
        ),
      ),
    );
  }
}
