import 'package:eunoia_chat_application/core/constant/constants.dart';
import 'package:eunoia_chat_application/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:eunoia_chat_application/features/main/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthenticationCubit, AuthenticationState>(
        bloc: authCubit,
        listener: (context, state) {
          if (state is AuthenticationUnauthenticated) {
            context.pushReplacement('/auth');
          }
        },
        child: Center(
          child: CustomTextButton(
              onPressed: () {
                authCubit.logout();
              },
              text: "Log out"),
        ),
      ),
    );
  }
}
