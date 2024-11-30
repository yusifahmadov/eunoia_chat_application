import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/constant/constants.dart';
import '../../../../../core/constant/empty_box.dart';
import '../../../../authentication/presentation/cubit/authentication_cubit.dart';
import '../../../../main/presentation/utility/custom_border_radius.dart';
import '../../../../main/presentation/utility/custom_input_decoration.dart';
import '../../../../main/presentation/widgets/custom_button.dart';
import '../../../../main/presentation/widgets/custom_svg_icon.dart';
import '../../../../main/presentation/widgets/custom_text_field_v2.dart';
import '../../../../main/presentation/widgets/text_form_field.dart';
import '../../../../main/presentation/widgets/themed_container.dart';
import 'signin_provider.dart';
import 'signin_provider_state.dart';

extension _AdvancedContext on BuildContext {
  SigninProviderState get state => SigninProvider.of(this);
}

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          heightFactor: kIsWeb ? 2 : 1,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: BlocListener<AuthenticationCubit, AuthenticationState>(
                bloc: authCubit,
                listener: (context, state) {
                  if (state is AuthenticationAuthenticated) {
                    context.go(kIsWeb ? "/home" : "/conversations");
                  }
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Sign In Account",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const Text("Enter your personal data to login your account"),
                    const EmptyHeightBox(
                      height: 30,
                    ),
                    const _SocialButtons(),
                    const EmptyHeightBox(
                      height: 10,
                    ),
                    const _OrDivider(),
                    const EmptyHeightBox(
                      height: 20,
                    ),
                    const _TextFields(),
                    const EmptyHeightBox(
                      height: 20,
                    ),
                    const _SignInButton(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account?",
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: Theme.of(context).colorScheme.onSurface)),
                        TextButton(
                            onPressed: () {
                              context.go('/auth/signup');
                            },
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.all(3),
                              minimumSize: const Size(0, 0),
                            ),
                            child: Text("Sign up",
                                style: Theme.of(context).textTheme.bodyLarge))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

class _SignInButton extends StatelessWidget {
  const _SignInButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        kIsWeb ? const Expanded(child: SizedBox()) : const SizedBox(),
        Expanded(
          child: CustomTextButton(
            onPressed: () {
              context.state.signIn();
            },
            text: "Signin",
            maxSize: true,
          ),
        ),
        kIsWeb ? const Expanded(child: SizedBox()) : const SizedBox(),
      ],
    );
  }
}

class _TextFields extends StatelessWidget {
  const _TextFields({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            kIsWeb ? const Expanded(child: SizedBox()) : const SizedBox(),
            Expanded(
              child: CustomTextFieldWithTopPlaceHolder(
                  customTextField: CustomTextField(
                      controller: context.state.emailController,
                      decoration: CustomInputDecoration(
                          context: context, hintText: "eg. johnheight@gmail.com")),
                  text: "Email"),
            ),
            kIsWeb ? const Expanded(child: SizedBox()) : const SizedBox(),
          ],
        ),
        const EmptyHeightBox(
          height: 20,
        ),
        Row(
          children: [
            kIsWeb ? const Expanded(child: SizedBox()) : const SizedBox(),
            Expanded(
              child: CustomTextFieldWithTopPlaceHolder(
                  customTextField: CustomTextField(
                      controller: context.state.passwordController,
                      obscureText: true,
                      decoration: CustomInputDecoration(
                          context: context, hintText: "Enter your password")),
                  text: "Password"),
            ),
            kIsWeb ? const Expanded(child: SizedBox()) : const SizedBox(),
          ],
        ),
      ],
    );
  }
}

class _OrDivider extends StatelessWidget {
  const _OrDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: Divider(
            height: 2,
            indent: 2,
            thickness: 2,
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Text("Or"),
        SizedBox(
          width: 10,
        ),
        Expanded(child: Divider())
      ],
    );
  }
}

class _SocialButtons extends StatelessWidget {
  const _SocialButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        kIsWeb ? Expanded(flex: 2, child: Container()) : const SizedBox(),
        Expanded(
          child: ThemedContainer(
            decoration: BoxDecoration(
              borderRadius: CustomBorderRadius.radius12(),
            ),
            padding: const EdgeInsets.all(12),
            child: const Row(
              children: [
                CustomSvgIcon(text: "logo-google"),
                SizedBox(
                  width: 10,
                ),
                Text("Google"),
              ],
            ),
          ),
        ),
        kIsWeb ? Expanded(flex: 2, child: Container()) : const SizedBox()
      ],
    );
  }
}
