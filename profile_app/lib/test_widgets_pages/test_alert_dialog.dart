import 'package:flutter/material.dart';

class TestAlertDialog extends StatefulWidget {
  @override
  State<TestAlertDialog> createState() => _TestAlertDialogState();
}

class _TestAlertDialogState extends State<TestAlertDialog> {
  String answer = ' ';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Alert Dialog')),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  showMyAlertDialog(context);
                },
                child: const Text('Question')),
            const SizedBox(width: 5),
            Text('Answer: $answer')
          ],
        ),
      ),
    );
  }

  showMyAlertDialog(BuildContext context) {
    AlertDialog dialog = AlertDialog(
      title: const Text('Election 2024'),
      content: const Text('Will you vote for Trump?'),
      actions: [
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop("Yes, of course!");
            },
            child: const Text("Yes")),
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context, "No f#cking way!");
            },
            child: const Text("No"))
      ],
    );

    // Call showDialog function to show dialog
    Future futureValue = showDialog(
        context: context,
        builder: (BuildContext context) {
          return dialog;
        });
    Stream stream = futureValue.asStream();
    stream.listen((var data) {
      String answerValue = data;
      setState(() {
        answer = answerValue;
      });
    });
  }
}
