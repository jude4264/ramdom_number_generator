import 'package:flutter/material.dart';
import 'package:ramdom_number_generator/component/number_row.dart';
import 'package:ramdom_number_generator/constant/color.dart';

class SettingScreen extends StatefulWidget {
  final int MaxNumber;
  const SettingScreen({required this.MaxNumber, Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  double maxNumber = 1000;
  @override
  void initState() {
    super.initState();
    maxNumber = widget.MaxNumber.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_COLOR,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 5.0,
            horizontal: 16.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _body(
                maxNumber: maxNumber,
              ),
              _footer(
                maxNumber: maxNumber,
                onChanged: onNavigatorChanged,
                onPressed: onSaveButtonPress,
              )
            ],
          ),
        ),
      ),
    );
  }

  void onNavigatorChanged(double val) {
    setState(() {
      maxNumber = val;
    });
  }

  void onSaveButtonPress() {
    Navigator.of(context).pop(maxNumber.toInt());
  }
}

class _body extends StatelessWidget {
  final double maxNumber;
  const _body({required this.maxNumber, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: NumberRow(
        number: maxNumber.toInt(),
      ),
    );
  }
}

class _footer extends StatelessWidget {
  final double maxNumber;
  final ValueChanged<double>? onChanged;
  final VoidCallback? onPressed;
  const _footer(
      {required this.maxNumber,
      required this.onChanged,
      required this.onPressed,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Slider(
          value: maxNumber,
          min: 1000,
          max: 100000,
          onChanged: onChanged,
        ),
        ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            primary: RED_COLOR,
          ),
          child: Text("Save"),
        )
      ],
    );
  }
}
