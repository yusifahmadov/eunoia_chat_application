import 'package:cached_network_image/cached_network_image.dart';
import 'package:eunoia_chat_application/core/constant/constants.dart';
import 'package:eunoia_chat_application/core/constant/empty_box.dart';
import 'package:eunoia_chat_application/core/extensions/localization_extension.dart';
import 'package:eunoia_chat_application/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:eunoia_chat_application/features/main/presentation/widgets/custom_svg_icon.dart';
import 'package:eunoia_chat_application/features/user/presentation/cubit/user_cubit.dart';
import 'package:eunoia_chat_application/features/user/presentation/pages/profile/profile_page_provider.dart';
import 'package:eunoia_chat_application/features/user/presentation/pages/profile/profile_page_provider_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

extension _AdvancedContext on BuildContext {
  ProfilePageProviderState get state => ProfilePageProvider.of(this);
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        body: BlocBuilder<UserCubit, UserState>(
          bloc: context.state.userCubit,
          builder: (context, state) {
            if (state is CurrentUserLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CurrentUserError) {
              return Center(child: Text(state.message));
            } else if (state is CurrentUserSuccess) {
              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    pinned: true,
                    centerTitle: false,
                    actions: [
                      Text(
                        context.localization?.edit ?? "",
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: Theme.of(context).colorScheme.primary),
                      ),
                      const SizedBox(
                        width: 20,
                      )
                    ],
                    title: GestureDetector(
                        onTap: () {
                          authCubit.logout();
                        },
                        child: const CustomSvgIcon(text: 'qr-code-outline')),
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          child: state.user.profilePhoto != null
                              ? CachedNetworkImage(imageUrl: state.user.profilePhoto!)
                              : SvgPicture.asset(
                                  'assets/icons/no-profile-picture.svg',
                                ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          '${state.user.name}',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Text(
                          '@${state.user.username}',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const EmptyHeightBox(),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              ListTile(
                                minTileHeight: 50,
                                leading: const CustomSvgIcon(text: 'camera-outline'),
                                title: Text(
                                    context.localization?.change_profile_photo ?? ""),
                              ),
                              const EmptyHeightBox(
                                height: 10,
                              ),
                              ListTile(
                                minTileHeight: 50,
                                leading: CustomSvgIcon(
                                  text: 'language-outline',
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                title: Text(context.localization?.change_language ?? ""),
                              ),
                              const EmptyHeightBox(
                                height: 30,
                              ),
                              BlocListener<AuthenticationCubit, AuthenticationState>(
                                bloc: authCubit,
                                listener: (context, state) {
                                  if (state is AuthenticationUnauthenticated) {
                                    context.pushReplacement('/auth');
                                  }
                                },
                                child: ListTile(
                                    onTap: () => authCubit.logout(),
                                    minTileHeight: 50,
                                    leading: CustomSvgIcon(
                                      text: 'log-out-outline',
                                      color: Theme.of(context).colorScheme.error,
                                    ),
                                    title: Text(
                                      context.localization?.logout ?? "",
                                    )),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
