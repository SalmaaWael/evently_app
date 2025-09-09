import 'package:evently_app/core/colors_manager.dart';
import 'package:flutter/material.dart';

import '../../core/widgets/custom_text_form_feild.dart';
import '../../l10n/app_localizations.dart';
import '../home/event_items.dart';

class Favorite extends StatelessWidget {
  const Favorite({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            CustomTextFormFeild(
              hint: AppLocalizations.of(context)!.search,
              hintstyle: TextStyle(color: Theme.of(context).hintColor),

              prefixIcon: Icons.search,
              prefixIconColor: ColorsManager.blue,
            ),

            Expanded(
              child: ListView.builder(
                itemCount: 20,
                itemBuilder: (context, index) => EventItem(),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
