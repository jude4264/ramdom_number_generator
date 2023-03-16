import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ramdom_number_generator/component/number_row.dart';
import 'package:ramdom_number_generator/constant/color.dart';
import 'package:ramdom_number_generator/sreen/setting_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<int> randomNumbers = [123, 456, 789];
  int maxNumber = 1000;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_COLOR,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 5.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Hearder(
                  onPressed: onSettingPop,
                ),
                _body(
                  randomNumbers: randomNumbers,
                ),
                _footer(
                  onPressed: onRandomNumberGenerate,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onSettingPop() async {
    final int? result = await Navigator.of(context).push<int>(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return SettingScreen(
            MaxNumber: maxNumber,
          );
        },
      ),
    );
    if (result != null) {
      // print(result);
      setState(() {
        maxNumber = result;
      });
    }
  }

  onRandomNumberGenerate() {
    final rand = Random();

    final Set<int> newNumbers = {};

    while (newNumbers.length != 3) {
      final number = rand.nextInt(maxNumber);
      newNumbers.add(number);
      setState(() {
        randomNumbers = newNumbers.toList();
      });
    }
    ;
  }
}

class _Hearder extends StatelessWidget {
  final VoidCallback onPressed;
  const _Hearder({required this.onPressed, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Random Number Generator',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        IconButton(
          onPressed: onPressed,
          icon: Icon(
            Icons.settings,
            color: RED_COLOR,
          ),
        )
      ],
    );
  }
}

class _body extends StatelessWidget {
  final List<int> randomNumbers;
  const _body({
    required this.randomNumbers,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: randomNumbers
            .asMap()
            .entries
            .map(
              (x) => Padding(
                padding: EdgeInsets.only(bottom: x.key == 2 ? 0 : 16.0),
                child: NumberRow(number: x.value),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _footer extends StatelessWidget {
  final VoidCallback onPressed;
  const _footer({required this.onPressed, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: RED_COLOR,
        ),
        onPressed: onPressed,
        child: Text('Generate!'),
      ),
    );
  }
}
