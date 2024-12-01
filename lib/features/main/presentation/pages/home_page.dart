import 'package:eunoia_chat_application/features/main/presentation/widgets/themed_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constant/constants.dart';
import '../../../authentication/presentation/cubit/authentication_cubit.dart';

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
            child: ThemedContainer(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Appearance',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Theme.of(context).colorScheme.onSurface),
                ),
                const SizedBox(
                  height: 50,
                ),
                StreamBuilder(
                    stream: mainCubit.isLightMode,
                    builder: (context, snapshot) {
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InkWell(
                            onTap: () {
                              mainCubit.updateTheme(true);
                            },
                            child: ThemedContainer(
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.surfaceContainer,
                                boxShadow: mainCubit.themeValue == true
                                    ? [
                                        BoxShadow(
                                          color: Theme.of(context).colorScheme.primary,
                                          blurRadius: 10,
                                          spreadRadius: 1,
                                        )
                                      ]
                                    : null,
                                border: mainCubit.themeValue == true
                                    ? Border.all(
                                        color: Theme.of(context).colorScheme.primary,
                                        width: 2)
                                    : null,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                                child: Column(
                                  children: [
                                    const Text("Light"),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    SvgPicture.asset(
                                      'assets/icons/sunny-outline.svg',
                                      width: 30,
                                      color: Theme.of(context).colorScheme.primary,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: () {
                              mainCubit.updateTheme(false);
                            },
                            child: ThemedContainer(
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.surfaceContainer,
                                boxShadow: mainCubit.themeValue == false
                                    ? [
                                        BoxShadow(
                                          color: Theme.of(context).colorScheme.primary,
                                          blurRadius: 10,
                                          spreadRadius: 1,
                                        )
                                      ]
                                    : null,
                                border: mainCubit.themeValue == false
                                    ? Border.all(
                                        color: Theme.of(context).colorScheme.primary,
                                        width: 2)
                                    : null,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                                child: Column(
                                  children: [
                                    const Text("Dark"),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    SvgPicture.asset('assets/icons/moon-outline.svg',
                                        width: 30,
                                        color: Theme.of(context).colorScheme.primary),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    })
              ],
            ),
          ),
        )),
      ),
    );
  }
}
