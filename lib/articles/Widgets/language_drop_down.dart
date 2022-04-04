import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../l10n/l10n.dart';
import '../../l10n/locale_provider.dart';

// class LanguageWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final locale = Localizations.localeOf(context);
//     //final flag = L10n.getFlag(locale.languageCode);

//     return Center(
//       child: CircleAvatar(
//         backgroundColor: Colors.white,
//         radius: 72,
//         child: Text(
//           flag,
//           style: TextStyle(fontSize: 80),
//         ),
//       ),
//     );
//   }
// }

class LanguagePickerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocaleProvider>(context);
    final locale = provider.locale;

    return DropdownButtonHideUnderline(
      child: DropdownButton(
        value: locale,
        icon: Container(width: 12),
        items: L10n.all.map(
          (locale) {
            final lang = L10n.getLanguage(locale.languageCode);

            return DropdownMenuItem(
              child: Center(
                child: Text(
                  lang,
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
              value: locale,
              onTap: () {
                final provider =
                    Provider.of<LocaleProvider>(context, listen: false);

                // ignore: cascade_invocations
                provider.setLocale(locale);
              },
            );
          },
        ).toList(),
        onChanged: (_) {},
      ),
    );
  }
}
