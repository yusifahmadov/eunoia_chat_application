import 'package:eunoia_chat_application/features/main/presentation/utility/custom_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/extensions/localization_extension.dart';
import '../../../main/presentation/utility/custom_input_decoration.dart';
import '../../../main/presentation/widgets/text_form_field.dart';
import '../cubit/contact_cubit.dart';
import 'contact_provider.dart';
import 'contact_provider_state.dart';

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
        actions: const [],
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
                centerTitle: true,
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
            buildWhen: (previous, current) =>
                previous != current &&
                (current is ContactInitial ||
                    current is ContactsLoaded ||
                    current is ContactsLoading ||
                    current is ContactsError),
            builder: (context, state) {
              if (context.state.contactCubit.fetchedData.isEmpty) {
                return SliverFillRemaining(
                  child: Center(
                    child: Transform.scale(
                      scale: 1.5,
                      child: LottieBuilder.asset(
                        'assets/lottie/search.json',
                        repeat: true,
                      ),
                    ),
                  ),
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
                        leading: CustomCachedNetworkImage(
                            containerHeight: 50,
                            containerWidth: 50,
                            imageUrl: contact.profilePhoto ?? ""),
                        tileColor: Theme.of(context).colorScheme.surface,
                        title: Text(
                            context.state.contactCubit.fetchedData[index].username ?? "",
                            style: Theme.of(context).textTheme.bodyLarge),
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
