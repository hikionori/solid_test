part of 'locale_cubit.dart';

// ignore: public_member_api_docs
class LocaleState extends Equatable {
  final Locale _locale;

  // ignore: public_member_api_docs
  Locale get locale => _locale;

  @override
  List<Object> get props => [_locale];

  // ignore: public_member_api_docs
  const LocaleState({required Locale locale}) : _locale = locale;
}
