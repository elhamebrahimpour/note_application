import 'package:flutter/material.dart';
import 'package:note_application/constants/color_constant.dart';

class TestValueListenableWidget extends StatelessWidget {
  TestValueListenableWidget({Key? key}) : super(key: key);

  ValueNotifier _valueNotifier = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: ValueListenableBuilder(
                valueListenable: _valueNotifier,
                builder: ((context, value, child) {
                  return Text(
                    '$value',
                    style: TextStyle(
                        fontSize: 24,
                        color: blackColor,
                        fontWeight: FontWeight.bold),
                  );
                }),
              ),
            ),
            SizedBox(
              height: 32,
            ),
            ElevatedButton(
              onPressed: () {
                _valueNotifier.value = _valueNotifier.value + 1;
              },
              child: Text('add counter'),
            ),
          ],
        ),
      ),
    );
  }
}
