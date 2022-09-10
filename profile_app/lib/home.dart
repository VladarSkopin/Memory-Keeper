import 'package:flutter/material.dart';
import 'package:profile_app/memories.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:profile_app/profile_manager.dart';
import 'package:provider/provider.dart';


class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    const colorizeColors = [
      Colors.purple,
      Colors.blue,
      Colors.yellow,
      Colors.red,
    ];

    const colorizeTextStyle = TextStyle(
      fontSize: 50.0,
      fontFamily: 'Horizon',
      fontWeight: FontWeight.bold
    );

    final backColor = Provider.of<ProfileManager>(context, listen: false).darkMode ? Colors.grey[900] : Colors.amberAccent[100];

    return Scaffold(
       backgroundColor: backColor,
      appBar: AppBar(title: const Text("Love you"),
      ),
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            SizedBox(
              //width: 250.0,
              height: 50.0,
              child: AnimatedTextKit(
                  animatedTexts: [
                    ColorizeAnimatedText('I LOVE YOU',
                    textStyle: colorizeTextStyle,
                    colors: colorizeColors,
                    speed: Duration(milliseconds: 300)),
                    ColorizeAnimatedText('MY DEAR',
                        textStyle: colorizeTextStyle,
                        colors: colorizeColors,
                        speed: Duration(milliseconds: 300)),
                    ColorizeAnimatedText('KITTY CAT!',
                        textStyle: colorizeTextStyle,
                        colors: colorizeColors,
                        speed: Duration(milliseconds: 300))
                  ],
                  pause: Duration(milliseconds: 100),
                  isRepeatingAnimation: true,
                  totalRepeatCount: 100,
                ),
            ),
            const SizedBox(height: 4),
            AvatarGlow(
              startDelay: const Duration(milliseconds: 1000),
              //glowColor: Colors.blueAccent,
              glowColor: Colors.red,
              endRadius: 160.0,
              //shape: BoxShape.circle,
              duration: const Duration(milliseconds: 2000),
              repeat: true,
              showTwoGlows: true,
              repeatPauseDuration: const Duration(milliseconds: 300),
              child: MaterialButton(
                splashColor: Colors.red,
                elevation: 20,
                shape:
                /*
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(60),
                  side: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 4.0
                  ),
                ),
                */
                const CircleBorder(
                  side: BorderSide(
                      //color: Theme.of(context).primaryColor,
                    color: Colors.lightBlue,
                    width: 4.0
                  ),
                ),

                //shape: ContinuousRectangleBorder(),
                //shape: StadiumBorder(),
                /*
                shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                 */
                color: Colors.orange,
                child: Container(
                  width: 200.0,
                    height: 200.0,
                    alignment: Alignment.center,
                    child: const Text('WELCOME',
                    style: TextStyle(
                      fontSize: 36.0,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ))
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => Memories()));
                },
              ),
            )
          ],
        ),
      )),
    );
  }
}
