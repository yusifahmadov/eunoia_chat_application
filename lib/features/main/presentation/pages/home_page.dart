import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constant/constants.dart';
import '../../../authentication/presentation/cubit/authentication_cubit.dart';
import '../widgets/custom_button.dart';

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
