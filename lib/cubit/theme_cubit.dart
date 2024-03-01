import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

// ignore: public_member_api_docs
class ThemeCubit extends Cubit<ThemeMode> {
  // ignore: public_member_api_docs
  ThemeCubit() : super(ThemeMode.light);

  // ignore: public_member_api_docs
  void toggleTheme() {
    emit(state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light);
  }
}
