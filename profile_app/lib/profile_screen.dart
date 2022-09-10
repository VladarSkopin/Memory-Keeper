import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:profile_app/profile_manager.dart';
import 'package:profile_app/test_widgets_pages/test_alert_dialog.dart';
import 'package:profile_app/test_widgets_pages/test_alert_dialog_with_title.dart';
import 'package:profile_app/test_widgets_pages/test_border_radius.dart';
import 'package:profile_app/test_widgets_pages/test_simple_dialog.dart';
import 'package:profile_app/test_widgets_pages/test_stack_widget.dart';
import 'package:profile_app/user.dart';
import 'package:provider/provider.dart';
import 'circle_image.dart';
import 'viewer_test.dart';
import 'package:dashed_circle/dashed_circle.dart';
import 'memories_list.dart';

class ProfileScreen extends StatefulWidget {
  final User user;

  const ProfileScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late Animation gap;
  late Animation<double> base;
  late Animation<double> reverse;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 4));
    base = CurvedAnimation(parent: controller, curve: Curves.easeOut);
    reverse = Tween<double>(begin: 0.0, end: -1.0).animate(base);
    gap = Tween<double>(begin: 3.0, end: 0.0).animate(base);
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profileBackgroundColor =
        Provider.of<ProfileManager>(context, listen: false).darkMode
            ? Colors.grey[900]
            : Colors.orange[100];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.check,
            size: 35,
            shadows: [
              Shadow(color: Colors.white, offset: Offset(0.5, 2), blurRadius: 8)
            ],
          ),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Colors.purpleAccent,
              content:
                  //Text('Don\'t close me :3', style: TextStyle(fontSize: 18)),
                  Text('Saved changes',
                      style: TextStyle(color: Colors.white, fontSize: 18)),
              duration: Duration(milliseconds: 2700),
            ));
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: ListView(
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            buildProfile(profileBackgroundColor),
            buildMenu(profileBackgroundColor),
            /*
              MaterialButton(
                  onPressed: () {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.fade,
                        child: TestStackWidget()
                    )
                );
              },
              child: Text("Test a Widget!",
                  style: TextStyle(
                      color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w600
                  )),
                color: Colors.green,
              )
               */
          ],
        ),
      ),
    );
  }

  Widget buildProfile(Color? profileBackgroundColor) {
    //final profileBackgroundColor = Provider.of<ProfileManager>(context, listen: false).darkMode ? Colors.grey[800] : Colors.white;
    return Column(
      children: [
        const SizedBox(height: 16),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.rotate,
                    alignment: Alignment.center,
                    duration: const Duration(milliseconds: 800),
                    child: ImageViewerTest()));
          },
          child: RotationTransition(
            turns: base,
            child: DashedCircle(
              gapSize: gap.value,
              dashes: 40,
              color: const Color(0XFFED4634),
              child: RotationTransition(
                turns: reverse,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: CircleImage(
                    imageProvider: AssetImage(widget.user.profileImageUrl),
                    imageRadius: 80.0,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          widget.user.firstName,
          style: const TextStyle(
              color: Colors.blueAccent, fontSize: 40, fontFamily: 'Canterbury'),
        ),
        Text(
          widget.user.lastName,
          style: const TextStyle(
              color: Colors.lightBlue, fontSize: 40, fontFamily: 'Canterbury'),
        ),
        const SizedBox(height: 14),
        const Divider(
          height: 5,
          thickness: 2,
        ),
      ],
    );
  }

  Widget buildMenu(Color? profileBackgroundColor) {
    return Column(
      children: [
        buildDarkModeRow(profileBackgroundColor),
        const ExpansionTile(
          title: Text(
            'I love you my dear kitten...',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          children: [
            Text('Very much.',
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 30)),
            SizedBox(
              height: 20,
            ),
          ],
        ),
        Container(
          color: profileBackgroundColor,
          height: 12,
        ),
        ListTile(
          leading: const Icon(Icons.wallpaper_rounded),
          //trailing: Text("${MemoryCard.memories.length} memory cards* in total "),
          title: Text("${MemoryCard.memories.length} memory cards in total "),
          subtitle:
              const Text("*Memory card = photo + title + short description"),
        ),
        Container(
          color: profileBackgroundColor,
          height: 4,
        ),
        ListTile(
          leading: Icon(Icons.favorite_outline_sharp),
          title: Text("13 favourite memory cards"),
        ),
        Container(
          color: profileBackgroundColor,
          height: 4,
        ),
        ListTile(
          leading: Icon(Icons.content_paste_search),
          title: Text("13 memory cards created by you so far"),
        ),
        Container(
          color: profileBackgroundColor,
          height: 4,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 20),
          child: MaterialButton(
            onPressed: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.bottomToTop,
                      alignment: Alignment.center,
                      duration: const Duration(milliseconds: 800),
                      child: TestStackWidget()));
            },
            color: Colors.cyan,
            textColor: Colors.white,
            elevation: 8.0,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
            shape: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: Colors.purpleAccent, width: 4),
                borderRadius: BorderRadius.circular(10.0)),
            child: RichText(
              text: const TextSpan(children: [
                TextSpan(
                    text: 'TEST A WIDGET',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
                TextSpan(
                    text: '\n          (Stack)',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700))
              ]),
            ),
          ),
        ),
        Container(
          color: profileBackgroundColor,
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 20),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                gradient: LinearGradient(colors: [Colors.pink, Colors.green])),
            child: MaterialButton(
              onPressed: () {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.bottomToTop,
                        alignment: Alignment.center,
                        duration: const Duration(milliseconds: 800),
                        child: TestBorderRadius()));
              },
              //highlightColor: Colors.white,
              //focusColor: Colors.red,
              //splashColor: Colors.red,
              //color: Colors.greenAccent,
              textColor: Colors.white,
              elevation: 8.0,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
              shape: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.amber, width: 8),
                  borderRadius: BorderRadius.circular(10.0)),
              child: RichText(
                text: const TextSpan(children: [
                  TextSpan(
                      text: 'TEST A WIDGET',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
                  TextSpan(
                      text: '\n       (Container)',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w700))
                ]),
              ),
            ),
          ),
        ),
        Container(
          color: profileBackgroundColor,
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 20),
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.bottomToTop,
                      alignment: Alignment.center,
                      duration: const Duration(milliseconds: 800),
                      child: TestSimpleDialog()));
            },
            style: ElevatedButton.styleFrom(
                elevation: 8.0,
                minimumSize: Size(100, 80),
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(color: Colors.black54, width: 2),
                )),
            child: RichText(
              text: const TextSpan(children: [
                TextSpan(
                    text: 'TEST A WIDGET',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
                TextSpan(
                    text: '\n   (Simple Dialog)',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700))
              ]),
            ),
          ),
        ),
        Container(
          color: profileBackgroundColor,
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 20),
          child: MaterialButton(
            color: Colors.indigo,
            elevation: 8,
            padding: EdgeInsets.all(20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(color: Colors.white, width: 2),
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.bottomToTop,
                      alignment: Alignment.center,
                      duration: const Duration(milliseconds: 800),
                      child: TestAlertDialog()));
            },
            child: RichText(
              text: const TextSpan(children: [
                TextSpan(
                    text: 'TEST A WIDGET',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
                TextSpan(
                    text: '\n   (Alert Dialog)',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700))
              ]),
            ),
          ),
        ),
        Container(
          color: profileBackgroundColor,
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 20),
          child: MaterialButton(
            color: Colors.indigo,
            elevation: 8,
            padding: EdgeInsets.all(20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(color: Colors.white, width: 2),
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.bottomToTop,
                      alignment: Alignment.center,
                      duration: const Duration(milliseconds: 800),
                      child: TestAlertDialogWithTitle()));
            },
            child: RichText(
              text: const TextSpan(children: [
                TextSpan(
                    text: '    TEST A WIDGET',
                    style:
                    TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
                TextSpan(
                    text: '\n(Alert Dialog with a Title)',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700))
              ]),
            ),
          ),
        ),
        Container(
          color: profileBackgroundColor,
          height: 10,
        )
      ],
    );
  }

  Widget buildDarkModeRow(Color? profileBackgroundColor) {
    return Container(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 4, bottom: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Dark Mode',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          Switch(
            inactiveThumbColor: Colors.blue,
            //inactiveTrackColor: Colors.amber,
            inactiveTrackColor: Colors.orange,
            activeColor: Colors.red,
            //value: widget.user.darkMode,
            value: Provider.of<ProfileManager>(context, listen: false).darkMode,
            onChanged: (value) {
              Provider.of<ProfileManager>(context, listen: false).darkMode =
                  value;
            },
          )
        ],
      ),
    );
  }
}
