import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'locale_state.dart';

// ignore: public_member_api_docs
class LocaleCubit extends Cubit<LocaleState> {
  // ignore: public_member_api_docs
  LocaleCubit() : super(const LocaleState(locale: Locale('en', 'US')));

  // ignore: public_member_api_docs
  void changeLocale(Locale locale) {
    emit(LocaleState(locale: locale));
  }
}
