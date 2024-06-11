/* Eldritch Companion, an assitant app for Eldritch Horror
Copyright (C) 2024 Roman Zubin

Full notice can be found at /lib/main.dart file. */

import 'package:eldritch_companion/common/constants.dart';
import 'package:eldritch_companion/pages/randomiser/randomiser_modal_bottom.dart';
import 'package:eldritch_companion/types/cards/game_card.dart';
import 'package:eldritch_companion/types/cards/investigator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eldritch_companion/models/game_data_model.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class RandomiserPage extends StatefulWidget {
  const RandomiserPage({super.key});

  @override
  State<StatefulWidget> createState() => _RandomiserPageState();
}

class _RandomiserPageState extends State<RandomiserPage> {
  int cardsToGenerate = 2;
  bool duplicateCards = false;

  late GameDataModel gameDataModel;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    gameDataModel = Provider.of<GameDataModel>(context);
  }

  void showRandomCards(Type cardType) {
    showMaterialModalBottomSheet(
        expand: false,
        context: context,
        shape: defaultRoundedRectangle,
        builder: (context) => RandomiserModalBottom(
              gameDataModel: gameDataModel,
              cardCount: cardsToGenerate,
              cardType: cardType,
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(
                  child: const Row(
                    children: [
                      Icon(Icons.search),
                      Text('Investigator'),
                    ],
                  ),
                  onPressed: () {
                    showRandomCards(Investigator);
                  },
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () => {},
                    child: const Text('I don\'t do anything :('))
              ],
            )
          ],
        ),
        Column(
          children: [
            Expanded(child: Container()),
            Container(
              decoration: const ShapeDecoration(
                color: Colors.amber,
                shape: defaultRoundedRectangle,
              ),
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      maxLength: 2,
                      enableIMEPersonalizedLearning: false,
                      textAlign: TextAlign.center,
                      controller: TextEditingController(
                          text: cardsToGenerate.toString()),
                      onChanged: (value) {
                        int? parsedValue = int.tryParse(value);
                        if (parsedValue != null) {
                          setState(() {
                            cardsToGenerate = parsedValue;
                          });
                        }
                      },
                    ),
                  ),
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Allow duplicates'),
                      Checkbox(
                          value: duplicateCards,
                          onChanged: (value) {
                            setState(() => duplicateCards = value ?? false);
                          }),
                    ],
                  )),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
