import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:flutter_i18n_json/initialize_i18n.dart' show initializeI18n;
import 'package:flutter_i18n_json/constant.dart' show languages;
import 'package:flutter_i18n_json/localizations.dart'
    show MyLocalizations, MyLocalizationsDelegate;

void main() async {
  Map<String, Map<String, String>> localizedValues = await initializeI18n();
  runApp(App(localizedValues));
}

class App extends StatefulWidget {
  final Map<String, Map<String, String>> localizedValues;
  App(this.localizedValues);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  String _locale = 'en';
  onChangeLanguage() {
    if (_locale == 'en') {
      setState(() {
        _locale = 'fr';
      });
    } else {
      setState(() {
        _locale = 'en';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        locale: Locale(_locale),
        localizationsDelegates: [
          MyLocalizationsDelegate(widget.localizedValues),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: languages.map((language) => Locale(language, '')),
        home: AppBody(this.onChangeLanguage));
  }
}

class AppBody extends StatelessWidget {
  final VoidCallback onChangeLanguage;
  AppBody(this.onChangeLanguage);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(MyLocalizations.of(context).hello),
        ),
        body: new Center(
          child: new Text(MyLocalizations.of(context).greetTo('Nina')),
        ),
        floatingActionButton: new FloatingActionButton(
            child: new Icon(Icons.language), onPressed: onChangeLanguage));
  }
}
