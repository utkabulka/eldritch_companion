/* Eldritch Companion, an assitant app for Eldritch Horror
Copyright (C) 2024 Roman Zubin

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>. */

import 'package:eldritch_companion/common/constants.dart';
import 'package:eldritch_companion/common/theme.dart';
import 'package:eldritch_companion/models/app_settings_model.dart';
import 'package:eldritch_companion/pages/randomiser/investigator_randomiser.dart';
import 'package:eldritch_companion/pages/randomiser/randomiser_page.dart';
import 'package:eldritch_companion/models/game_data_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

GoRouter router() {
  return GoRouter(
    initialLocation: '/randomiser',
    routes: [
      GoRoute(
        path: '/randomiser',
        builder: (context, state) => const RandomiserPage(),
        routes: [
          GoRoute(
            path: 'investigator',
            builder: (context, state) => const InvestigatorRandomiser(),
          ),
        ],
      ),
    ],
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      theme: appTheme,
      home: const MainPage(title: 'Home Page'),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.title});

  final String title;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider(create: (context) => GameDataModel()),
          Provider(create: (context) => AppSettingsModel())
        ],
        child: MaterialApp.router(
          theme: appTheme,
          routerConfig: router(),
        ));
  }
}
