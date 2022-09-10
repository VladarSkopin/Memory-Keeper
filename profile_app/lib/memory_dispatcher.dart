import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pip_view/pip_view.dart';
import 'package:profile_app/image_dispatcher.dart';
import 'package:profile_app/memories_list.dart';
import 'package:profile_app/profile_manager.dart';
import 'package:provider/provider.dart';
import 'package:water_drop/water_drop.dart';


enum Menu { itemOne, itemTwo, itemThree, itemFour}

class MemoryDispatcher extends StatefulWidget {
  final MemoryCard memory;
  final int memoryIndex;

  const MemoryDispatcher(
      {Key? key, required this.memory, required this.memoryIndex})
      : super(key: key);

  @override
  State<MemoryDispatcher> createState() => _MemoryDispatcherState();
}

class _MemoryDispatcherState extends State<MemoryDispatcher> {

  //String _selectedMenu = '';

  @override
  Widget build(BuildContext context) {
    final colorGradient = Provider.of<ProfileManager>(context, listen: false).darkMode ? Colors.black : Colors.orange[100];
    String idx = (widget.memoryIndex + 1).toString();

    return PIPView(
      floatingHeight: 400,
      floatingWidth: 200,
      builder: (context, isFloating) {
        return Scaffold(
          backgroundColor: colorGradient,
          appBar: AppBar(
            title: Text('Memory Card   # $idx'),
            /* // FOR FUTURE !!! !!! !!!
            actions: [
              PopupMenuButton<Menu>(
                // Callback that sets the selected popup menu item.
                  onSelected: (Menu item) {
                    setState(() {
                      _selectedMenu = item.name;
                    });
                  },
                  itemBuilder: (BuildContext context) => <PopupMenuEntry<Menu>>[
                    const PopupMenuItem<Menu>(
                      value: Menu.itemOne,
                      child: Text('Edit card'),
                    ),
                    const PopupMenuItem<Menu>(
                      value: Menu.itemTwo,
                      child: Text('Change card\'s photo'),
                    ),
                    const PopupMenuItem<Menu>(
                      value: Menu.itemThree,
                      child: Text('Change card color'),
                    ),
                    const PopupMenuItem<Menu>(
                      value: Menu.itemFour,
                      child: Text('Delete the card'),
                    ),
                  ])
            ],
             */
          ),
          body: SafeArea(
            child: GestureDetector(
              onPanUpdate: (details) {
                // detect swipe up
                if (details.delta.dy < 0) {
                  PIPView.of(context)!.presentBelow(BackgroundScreen());
                }
              },
              child: Card(
                elevation: 10,
                shadowColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.0)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //const SizedBox(height: 40),
                    Card(
                      elevation: 12,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.fade,
                                  child: ImageDispatcher(imgUrl: widget.memory.imgUrl)
                              )
                          );
                        },
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image(image: AssetImage(widget.memory.imgUrl))),
                      ),
                    ),
                    MaterialButton(
                      padding: const EdgeInsets.only(
                          top: 20, bottom: 20, left: 5, right: 5),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      color: Theme.of(context).primaryColor,
                      child: Text(widget.memory.description,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Monospace')),
                      onPressed: () {
                        PIPView.of(context)!.presentBelow(BackgroundScreen());
                        //PIPView.of(context)!.presentBelow(Memories());
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class BackgroundScreen extends StatefulWidget {

  @override
  State<BackgroundScreen> createState() => _BackgroundScreenState();
}



class _BackgroundScreenState extends State<BackgroundScreen> with SingleTickerProviderStateMixin {


  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 1000)
    )..repeat(reverse: true);
  }

  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body:
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              final move = _animationController.value * 40;
              return WaterDrop(
                params: [
                  WaterDropParam(top: 50 + move, height: 70, left: 100, width: 50),
                  WaterDropParam(top: 10 + move, height: 100, left: 280, width: 100),
                  WaterDropParam(top: 155 + move, height: 35, left: 135, width: 35),
                  WaterDropParam(top: 135 + move, height: 40, left: 250, width: 30),
                  WaterDropParam(top: 20 + move, height: 40, left: 20, width: 40),
                  WaterDropParam(top: 140 + move, height: 50, left: 15, width: 40),
                  WaterDropParam(top: 20 + move, height: 30, left: 200, width: 30),
                  WaterDropParam(top: 120 + move, height: 20, left: 360, width: 20),
                ],
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/river.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          )

      ),
    );
  }
}
