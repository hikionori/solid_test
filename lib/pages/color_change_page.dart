import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:solid_test/color_change_consts.dart';
import 'package:solid_test/widgets/change_locale_widget.dart';

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
      // generate using random color HSV
      _bgColor = Color((Random().nextDouble() * 0xFFFFFF).toInt() << 0)
          .withOpacity(1.0);

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
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                color: _bgColor,
                height: double.infinity,
                width: double.infinity,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: (helloWorld ?? "Hello World").split('').map((char) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                  child: Text(
                    char,
                    key: ValueKey<String>(char),
                    style: TextStyle(
                      color: _textColor,
                      fontSize: 24,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
      floatingActionButton: ChangeLocaleWidget(),
    );
  }
}
