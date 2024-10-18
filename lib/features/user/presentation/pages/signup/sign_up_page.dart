import 'package:eunoia_chat_application/core/constant/empty_box.dart';
import 'package:eunoia_chat_application/features/main/presentation/utility/custom_border_radius.dart';
import 'package:eunoia_chat_application/features/main/presentation/utility/custom_input_decoration.dart';
import 'package:eunoia_chat_application/features/main/presentation/widgets/custom_button.dart';
import 'package:eunoia_chat_application/features/main/presentation/widgets/custom_svg_icon.dart';
import 'package:eunoia_chat_application/features/main/presentation/widgets/custom_text_field_v2.dart';
import 'package:eunoia_chat_application/features/main/presentation/widgets/text_form_field.dart';
import 'package:eunoia_chat_application/features/main/presentation/widgets/themed_container.dart';
import 'package:eunoia_chat_application/features/user/presentation/pages/signup/signup_provider.dart';
import 'package:eunoia_chat_application/features/user/presentation/pages/signup/signup_provider_state.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

extension _AdvancedContext on BuildContext {
  SignupProviderState get inherited => SignupProvider.of(this);
}

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Sign Up Account",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const Text("Enter your personal data to create your account"),
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
                const _SignUpButton(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Theme.of(context).colorScheme.onSurface)),
                    TextButton(
                        onPressed: () {
                          context.pop();
                        },
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.all(0),
                          minimumSize: const Size(0, 0),
                        ),
                        child:
                            Text("Log in", style: Theme.of(context).textTheme.bodyLarge))
                  ],
                )
              ],
            ),
          ),
        ));
  }
}

class _SignUpButton extends StatelessWidget {
  const _SignUpButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextButton(
      onPressed: () {
        context.inherited.register();
      },
      text: "Signup",
      maxSize: true,
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
            Expanded(
              child: CustomTextFieldWithTopPlaceHolder(
                  customTextField: CustomTextField(
                      onChanged: (value) async {
                        context.inherited.userRegisterHelper = context
                            .inherited.userRegisterHelper
                            .copyWith(firstName: value);
                      },
                      decoration:
                          CustomInputDecoration(context: context, hintText: "eg. Yusif")),
                  text: "First Name"),
            ),
            const EmptyWidthBox(width: 20),
            Expanded(
              child: CustomTextFieldWithTopPlaceHolder(
                  customTextField: CustomTextField(
                      onChanged: (value) async {
                        context.inherited.userRegisterHelper = context
                            .inherited.userRegisterHelper
                            .copyWith(lastName: value);
                      },
                      decoration: CustomInputDecoration(
                          context: context, hintText: "eg. Ahmadov")),
                  text: "Last Name"),
            ),
          ],
        ),
        const EmptyHeightBox(
          height: 20,
        ),
        CustomTextFieldWithTopPlaceHolder(
            customTextField: CustomTextField(
                onChanged: (value) async {
                  context.inherited.userRegisterHelper =
                      context.inherited.userRegisterHelper.copyWith(email: value);
                },
                decoration: CustomInputDecoration(
                    context: context, hintText: "eg. johnheight@gmail.com")),
            text: "Email"),
        const EmptyHeightBox(
          height: 20,
        ),
        CustomTextFieldWithTopPlaceHolder(
            customTextField: CustomTextField(
                onChanged: (value) async {
                  context.inherited.userRegisterHelper =
                      context.inherited.userRegisterHelper.copyWith(password: value);
                },
                obscureText: true,
                decoration: CustomInputDecoration(
                    context: context, hintText: "Enter your password")),
            text: "Password"),
        const EmptyHeightBox(
          height: 20,
        ),
        CustomTextFieldWithTopPlaceHolder(
            customTextField: CustomTextField(
                validatorF: (p0) {
                  if (p0 != context.inherited.userRegisterHelper.password) {
                    return "Passwords do not match";
                  }
                  return null;
                },
                obscureText: true,
                decoration: CustomInputDecoration(
                    context: context, hintText: "Confirm your password")),
            text: "Confirm Password"),
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
        const SizedBox(width: 10),
        Expanded(
          child: ThemedContainer(
            decoration: BoxDecoration(
              borderRadius: CustomBorderRadius.radius12(),
            ),
            padding: const EdgeInsets.all(12),
            child: const Row(
              children: [
                CustomSvgIcon(text: "logo-github"),
                SizedBox(
                  width: 10,
                ),
                Text("Github"),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
