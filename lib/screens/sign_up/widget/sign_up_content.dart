import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_mvp/core/const/color_constants.dart';
import 'package:mobile_mvp/core/const/text_constants.dart';
import 'package:mobile_mvp/core/const/path_constants.dart';
import 'package:mobile_mvp/core/service/validation_service.dart';
import 'package:mobile_mvp/screens/common_widgets/external_login_button.dart';
import 'package:mobile_mvp/screens/common_widgets/fitness_button.dart';
import 'package:mobile_mvp/screens/common_widgets/fitness_loading.dart';
import 'package:mobile_mvp/screens/common_widgets/fitness_text_field.dart';
import 'package:mobile_mvp/screens/sign_up/bloc/signup_bloc.dart';

class SignUpContent extends StatelessWidget {
  const SignUpContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(PathConstants.signUpBackground),
              fit: BoxFit.fitWidth),
        ),
        child: Stack(
          children: [
            _createMainData(context),
            BlocBuilder<SignUpBloc, SignUpState>(
              buildWhen: (_, currState) =>
                  currState is LoadingState ||
                  currState is NextFinalOnboardingPageState ||
                  currState is ErrorState,
              builder: (context, state) {
                if (state is LoadingState) {
                  return _createLoading();
                } else if (state is NextFinalOnboardingPageState ||
                    state is ErrorState) {
                  return const SizedBox();
                }
                return const SizedBox();
              },
            ),
          ],
        ),
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
              const SizedBox(height: 40),
              _createSignUpButton(context),
              const Spacer(),
              _createHaveAccountText(context),
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
    return const Text(
      TextConstants.createAccount,
      style: TextStyle(
        color: ColorConstants.textBlack,
        fontSize: 26,
        fontWeight: FontWeight.bold,
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
    final bloc = BlocProvider.of<SignUpBloc>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: BlocBuilder<SignUpBloc, SignUpState>(
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
    final bloc = BlocProvider.of<SignUpBloc>(context);
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (_, currState) => currState is ShowErrorState,
      builder: (context, state) {
        return Column(
          children: [
            FitnessTextField(
              title: TextConstants.username,
              placeholder: TextConstants.userNamePlaceholder,
              controller: bloc.userNameController,
              textInputAction: TextInputAction.next,
              errorText: TextConstants.usernameErrorText,
              isError: state is ShowErrorState
                  ? !ValidationService.username(bloc.userNameController.text)
                  : false,
              onTextChanged: () {
                bloc.add(OnTextChangedEvent());
              },
            ),
            const SizedBox(height: 20),
            FitnessTextField(
              title: TextConstants.email,
              placeholder: TextConstants.emailPlaceholder,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              controller: bloc.emailController,
              errorText: TextConstants.emailErrorText,
              isError: state is ShowErrorState
                  ? !ValidationService.email(bloc.emailController.text)
                  : false,
              onTextChanged: () {
                bloc.add(OnTextChangedEvent());
              },
            ),
            const SizedBox(height: 20),
            FitnessTextField(
              title: TextConstants.password,
              placeholder: TextConstants.passwordPlaceholder,
              obscureText: true,
              isError: state is ShowErrorState
                  ? !ValidationService.password(bloc.passwordController.text)
                  : false,
              textInputAction: TextInputAction.next,
              controller: bloc.passwordController,
              errorText: TextConstants.passwordErrorText,
              onTextChanged: () {
                bloc.add(OnTextChangedEvent());
              },
            ),
            // const SizedBox(height: 20),
            // FitnessTextField(
            //   title: TextConstants.confirmPassword,
            //   placeholder: TextConstants.confirmPasswordPlaceholder,
            //   obscureText: true,
            //   isError: state is ShowErrorState
            //       ? !ValidationService.confirmPassword(
            //           bloc.passwordController.text,
            //           bloc.confirmPasswordController.text)
            //       : false,
            //   controller: bloc.confirmPasswordController,
            //   errorText: TextConstants.confirmPasswordErrorText,
            //   onTextChanged: () {
            //     bloc.add(OnTextChangedEvent());
            //   },
            // ),
          ],
        );
      },
    );
  }

  Widget _createSignUpButton(BuildContext context) {
    final bloc = BlocProvider.of<SignUpBloc>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: BlocBuilder<SignUpBloc, SignUpState>(
        buildWhen: (_, currState) =>
            currState is SignUpButtonEnableChangedState,
        builder: (context, state) {
          return FitnessButton(
            title: TextConstants.signUp,
            isEnabled: state is SignUpButtonEnableChangedState
                ? state.isEnabled
                : false,
            onTap: () {
              FocusScope.of(context).unfocus();
              bloc.add(SignUpTappedEvent());
            },
          );
        },
      ),
    );
  }

  Widget _createHaveAccountText(BuildContext context) {
    final bloc = BlocProvider.of<SignUpBloc>(context);
    return RichText(
      text: TextSpan(
        text: TextConstants.alreadyHaveAccount,
        style: const TextStyle(
          color: ColorConstants.textBlack,
          fontSize: 14,
        ),
        children: [
          TextSpan(
            text: " ${TextConstants.signIn}",
            style: const TextStyle(
              color: ColorConstants.primaryColor,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                bloc.add(SignInTappedEvent());
              },
          ),
        ],
      ),
    );
  }
}
