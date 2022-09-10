
import 'package:flutter/material.dart';

class TestSimpleDialog extends StatefulWidget {
  @override
  State<TestSimpleDialog> createState() => _TestSimpleDialogState();
}

class _TestSimpleDialogState extends State<TestSimpleDialog> {

  ProgrammingLanguage? selectedLanguage;

  var languages = [
    ProgrammingLanguage('JavaScript', 67.7),
    ProgrammingLanguage("HTML/CSS", 63.1),
    ProgrammingLanguage("SQL", 57.4),
    ProgrammingLanguage("Python", 44.1),
    ProgrammingLanguage("Java", 40.2),
    ProgrammingLanguage("Bash/Shell/PowerShell", 33.1),
    ProgrammingLanguage("C#", 31.4),
    ProgrammingLanguage("PHP", 57.4),
    ProgrammingLanguage("Typescript", 25.4),
    ProgrammingLanguage("C++", 23.9),
    ProgrammingLanguage("C", 21.8),
    ProgrammingLanguage("GO", 8.8)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Simple Dialog')),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    showMyAlertDialog(context);
                  },
                  style: ElevatedButton.styleFrom(
                    shadowColor: Colors.amber,
                    elevation: 6.0,
                      shape: const StadiumBorder(
                        side: BorderSide(color: Colors.white, width: 2),
                      ),
                  ),
                  child: const Text('Select a language',
                  style: TextStyle(fontWeight: FontWeight.bold))),
              const SizedBox(height: 50),
              Text('Selected Language: ${selectedLanguage == null ? '?' : selectedLanguage!.name}',
              style: const TextStyle(fontSize: 16))
            ],
          ),
      ),
    );
  }

  showMyAlertDialog(BuildContext context) {
    //final javascript = ProgrammingLanguage('JavaScript', 67.7);
    //final htmlCss = ProgrammingLanguage("HTML/CSS", 63.1);
    //final sql = ProgrammingLanguage("SQL", 57.4);


    // A list of dialog options
    var itemList = languages.map( (lang) => SimpleDialogOption(
      onPressed: () {
        Navigator.pop(context, lang);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(lang.name),
          Text(lang.percent.toString(), style: const TextStyle(color: Colors.red))
        ],
      ),
    )).toList();

    SimpleDialog dialog = SimpleDialog(
      shape: BeveledRectangleBorder(
        side: const BorderSide(
          color: Colors.blueGrey,
          width: 2
        ),
        borderRadius: BorderRadius.circular(20)
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          Icon(Icons.code),
          Text('Select a Language:'),
        ],
      ),
      children: itemList
      /*
      <Widget>[
        SimpleDialogOption(
          onPressed: () {
            Navigator.pop(context, javascript);
          },
          child: Text(javascript.name),
        ),
        SimpleDialogOption(
          onPressed: () {
            Navigator.pop(context, htmlCss);
          },
          child: Text(htmlCss.name),
        ),
        SimpleDialogOption(
          onPressed: () {
            Navigator.pop(context, sql);
          },
          child: Text(sql.name),
        )
      ],
       */
    );

    Future futureValue = showDialog(
        context: context,
        builder: (BuildContext context) {
          return dialog;
        }
    );

    futureValue.then( (language) => {
      setState(() {
        selectedLanguage = language;
      })
    });
  }
}



class ProgrammingLanguage {
  String name;
  double percent;

  ProgrammingLanguage(this.name, this.percent);
}