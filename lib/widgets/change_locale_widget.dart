import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:solid_test/cubit/locale_cubit.dart';

/// A widget that allows the user to change the locale.
class ChangeLocaleWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        const supportedLocales = AppLocalizations.supportedLocales;

        showModalBottomSheet(
          context: context,
          builder: (context) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListView.builder(
                  itemCount: supportedLocales.length,
                  itemBuilder: (context, index) {
                    final locale = supportedLocales[index];

                    return ListTile(
                      leading: Image.asset(
                        'assets/flags/${locale.languageCode}.png',
                        width: 32,
                        height: 32,
                      ),
                      title: Text(locale.languageCode),
                      onTap: () {
                        final localeCubit =
                            BlocProvider.of<LocaleCubit>(context);
                        localeCubit.changeLocale(locale);
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            );
          },
        );
      },
      child: const Icon(Icons.language),
    );
  }
}
