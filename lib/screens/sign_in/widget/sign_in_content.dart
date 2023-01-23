import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_mvp/core/const/color_constants.dart';
import 'package:mobile_mvp/core/const/path_constants.dart';
import 'package:mobile_mvp/core/const/text_constants.dart';
import 'package:mobile_mvp/core/service/validation_service.dart';
import 'package:mobile_mvp/screens/common_widgets/external_login_button.dart';
import 'package:mobile_mvp/screens/common_widgets/fitness_button.dart';
import 'package:mobile_mvp/screens/common_widgets/fitness_loading.dart';
import 'package:mobile_mvp/screens/common_widgets/fitness_text_field.dart';
import 'package:mobile_mvp/screens/sign_in/bloc/sign_in_bloc.dart';

class SignInContent extends StatelessWidget {
  const SignInContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(PathConstants.signInBackground),
            fit: BoxFit.fitWidth),
      ),
      child: Stack(
        children: [
          _createMainData(context),
          BlocBuilder<SignInBloc, SignInState>(
            buildWhen: (_, currState) =>
                currState is LoadingState ||
                currState is ErrorState ||
                currState is NextFinalOnboardingPageState,
            builder: (context, state) {
              if (state is LoadingState) {
                return _createLoading();
              } else if (state is ErrorState ||
                  state is NextFinalOnboardingPageState) {
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
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: SingleChildScrollView(
        child: SizedBox(
          height: height - 30 - MediaQuery.of(context).padding.bottom,
          child: Column(
            children: [
              const SizedBox(height: 20),
              _createTitle(),
              const SizedBox(height: 25),
              _createExternalLogin(context),
              const SizedBox(height: 50),
              _createLoginText(),
              const SizedBox(height: 20),
              _createForm(context),
              const SizedBox(height: 20),
              _createForgotPasswordButton(context),
              const SizedBox(height: 40),
              _createSignInButton(context),
              const Spacer(),
              _createDoNotHaveAccountText(context),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _createLoading() {
    return FitnessLoading();
  }

  Widget _createTitle() {
    return const Center(
      child: Text(
        TextConstants.signIn,
        style: TextStyle(
          color: ColorConstants.textBlack,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _createLoginText() {
    return const Text(
      TextConstants.loginWithEmail,
      style: TextStyle(
        color: ColorConstants.signUpGrey,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _createExternalLogin(BuildContext context) {
    final bloc = BlocProvider.of<SignInBloc>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: BlocBuilder<SignInBloc, SignInState>(
        builder: (context, state) {
          return Column(
            children: [
              ExternalLoginButton(
                title: TextConstants.continueWithFacebook,
                iconPath: PathConstants.facebookWhite,
                backgroundColor: ColorConstants.blue,
                titleColor: ColorConstants.white,
                onTap: () {
                  // TO DO: Add external login functionality for FB

                  // FocusScope.of(context).unfocus();
                  // bloc.add(SignUpTappedEvent());
                },
              ),
              const SizedBox(height: 20),
              ExternalLoginButton(
                title: TextConstants.continueWithGoogle,
                iconPath: PathConstants.google,
                backgroundColor: ColorConstants.white,
                titleColor: ColorConstants.loadingBlack,
                onTap: () {
                  // TO DO: Add external login functionality for Google

                  // FocusScope.of(context).unfocus();
                  // bloc.add(SignUpTappedEvent());
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _createForm(BuildContext context) {
    final bloc = BlocProvider.of<SignInBloc>(context);
    return BlocBuilder<SignInBloc, SignInState>(
      buildWhen: (_, currState) => currState is ShowErrorState,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FitnessTextField(
              title: TextConstants.email,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              placeholder: TextConstants.emailPlaceholder,
              controller: bloc.emailController,
              errorText: TextConstants.emailErrorText,
              isError: state is ShowErrorState
                  ? !ValidationService.email(bloc.emailController.text)
                  : false,
              onTextChanged: () {
                bloc.add(OnTextChangeEvent());
              },
            ),
            const SizedBox(height: 20),
            FitnessTextField(
              title: TextConstants.password,
              placeholder: TextConstants.passwordPlaceholderSignIn,
              controller: bloc.passwordController,
              errorText: TextConstants.passwordErrorText,
              isError: state is ShowErrorState
                  ? !ValidationService.password(bloc.passwordController.text)
                  : false,
              obscureText: true,
              onTextChanged: () {
                bloc.add(OnTextChangeEvent());
              },
            ),
          ],
        );
      },
    );
  }

  Widget _createForgotPasswordButton(BuildContext context) {
    final bloc = BlocProvider.of<SignInBloc>(context);
    return GestureDetector(
      child: const Padding(
        padding: EdgeInsets.only(left: 21),
        child: Text(
          TextConstants.forgotPassword,
          style: TextStyle(
            fontSize: 14,
            color: ColorConstants.textBlack,
          ),
        ),
      ),
      onTap: () {
        FocusScope.of(context).unfocus();
        bloc.add(ForgotPasswordTappedEvent());
      },
    );
  }

  Widget _createSignInButton(BuildContext context) {
    final bloc = BlocProvider.of<SignInBloc>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: BlocBuilder<SignInBloc, SignInState>(
        buildWhen: (_, currState) =>
            currState is SignInButtonEnableChangedState,
        builder: (context, state) {
          return FitnessButton(
            title: TextConstants.signIn,
            isEnabled: state is SignInButtonEnableChangedState
                ? state.isEnabled
                : false,
            onTap: () {
              FocusScope.of(context).unfocus();
              bloc.add(SignInTappedEvent());
            },
          );
        },
      ),
    );
  }

  Widget _createDoNotHaveAccountText(BuildContext context) {
    final bloc = BlocProvider.of<SignInBloc>(context);
    return Center(
      child: RichText(
        text: TextSpan(
          text: TextConstants.doNotHaveAnAccount,
          style: const TextStyle(
            color: ColorConstants.textBlack,
            fontSize: 14,
          ),
          children: [
            TextSpan(
              text: " ${TextConstants.signUp}",
              style: const TextStyle(
                color: ColorConstants.primaryColor,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  bloc.add(SignUpTappedEvent());
                },
            ),
          ],
        ),
      ),
    );
  }
}
