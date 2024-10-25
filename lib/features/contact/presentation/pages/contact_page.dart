import 'package:cached_network_image/cached_network_image.dart';
import 'package:eunoia_chat_application/core/extensions/localization_extension.dart';
import 'package:eunoia_chat_application/features/contact/presentation/cubit/contact_cubit.dart';
import 'package:eunoia_chat_application/features/contact/presentation/pages/contact_provider.dart';
import 'package:eunoia_chat_application/features/contact/presentation/pages/contact_provider_state.dart';
import 'package:eunoia_chat_application/features/main/presentation/utility/custom_input_decoration.dart';
import 'package:eunoia_chat_application/features/main/presentation/widgets/custom_svg_icon.dart';
import 'package:eunoia_chat_application/features/main/presentation/widgets/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

extension _AdvancedContext on BuildContext {
  ContactProviderState get state => ContactProvider.of(this);
}

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.localization?.contacts ?? ""),
        actions: [
          IconButton(
            icon: const CustomSvgIcon(text: 'add-outline'),
            onPressed: () {
              context.go('/contacts');
            },
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            sliver: SliverAppBar(
              centerTitle: true,
              stretch: true,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: CustomTextField(
                  onChanged: (value) async {
                    context.state.search(
                      onChanged: () async {
                        context.state.searchContacts(query: value);
                      },
                    );
                  },
                  decoration: CustomInputDecoration(
                      context: context, hintText: context.localization?.search),
                ),
              ),
            ),
          ),
          BlocBuilder<ContactCubit, ContactState>(
            bloc: context.state.contactCubit,
            builder: (context, state) {
              if (context.state.contactCubit.fetchedData.isEmpty) {
                return SliverFillRemaining(
                  child: Center(child: Text(context.localization?.search ?? "")),
                );
              }

              return SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                sliver: SliverList.builder(
                    itemCount: context.state.contactCubit.fetchedData.length,
                    itemBuilder: (context, index) {
                      final contact = context.state.contactCubit.fetchedData[index];

                      return ListTile(
                        onTap: () async {
                          context.state.checkContact(id: contact.id);
                        },
                        leading: CircleAvatar(
                          radius: 23,
                          child: contact.profilePhoto != null
                              ? CachedNetworkImage(imageUrl: contact.profilePhoto!)
                              : SvgPicture.asset('assets/icons/no-profile-picture.svg'),
                        ),
                        tileColor: Theme.of(context).colorScheme.surface,
                        title: Text(
                            context.state.contactCubit.fetchedData[index].username ?? "",
                            style: Theme.of(context).textTheme.headlineLarge),
                        subtitle: Text(
                            context.state.contactCubit.fetchedData[index].bio ?? "",
                            style: Theme.of(context).textTheme.bodyMedium),
                      );
                    }),
              );
            },
          ),
        ],
      ),
    );
  }
}
