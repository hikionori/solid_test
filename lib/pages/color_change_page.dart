import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:solid_test/color_change_consts.dart';
import 'package:solid_test/cubit/locale_cubit.dart';
import 'package:solid_test/cubit/theme_cubit.dart';

/// A page that changes its background color and text color
class ColorChangePage extends StatefulWidget {
  // ignore: public_member_api_docs
  const ColorChangePage({super.key});

  @override
  State<ColorChangePage> createState() => _ColorChangePageState();
}

class _ColorChangePageState extends State<ColorChangePage> {
  Color _bgColor = Colors.white;
  Color _textColor = Colors.black;

  void _handleChangeColor() {
    setState(() {
      // Generate a random color.
      // We use bitwise OR to combine a random number with the base black color.
      // This ensures that the generated color will not be completely black.
      _bgColor = Color(
        (Random().nextInt(ColorChangeConsts.baseWhite)) |
            ColorChangeConsts.baseBlack,
      );

      // Compute the luminance of the background color.
      // Luminance is a measure of the perceived brightness of a color.
      // If the luminance is greater than a certain threshold,
      // we choose black as the text color.
      // Otherwise, we choose white.
      _textColor =
          _bgColor.computeLuminance() > ColorChangeConsts.luminanceThreshold
              ? Colors.black
              : Colors.white;
    });
  }

  void _handleChangeTheme() {
    final themeCubit = BlocProvider.of<ThemeCubit>(context);
    themeCubit.toggleTheme();
  }

  void _handleChangeLocale() {
    const supportedLocales = AppLocalizations.supportedLocales;

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
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
                  final localeCubit = BlocProvider.of<LocaleCubit>(context);
                  localeCubit.changeLocale(locale);
                  Navigator.pop(context);
                },
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final String? helloWorld = AppLocalizations.of(context)?.helloWorld;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            GestureDetector(
              onTap: _handleChangeColor,
              onDoubleTap: _handleChangeTheme,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                color: _bgColor,
                height: double.infinity,
                width: double.infinity,
              ),
            ),
            Text(
              helloWorld ?? 'Hello, World!',
              style: TextStyle(
                color: _textColor,
                fontSize: 24,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _handleChangeLocale,
        child: const Icon(Icons.language),
      ),
    );
  }
}
