
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:profile_app/circle_image.dart';
import 'package:profile_app/memories_list.dart';
import 'package:profile_app/profile_screen.dart';
import 'package:profile_app/user.dart';
import 'memory_dispatcher.dart';
import 'package:profile_app/profile_manager.dart';
import 'package:provider/provider.dart';


class Memories extends StatelessWidget {
  const Memories({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final colorGradient = Provider.of<ProfileManager>(context, listen: false).darkMode ? Colors.black : Colors.orange[100];
    final colorGradient1 = Provider.of<ProfileManager>(context, listen: false).darkMode ? Colors.black : Colors.yellowAccent;
    final colorGradient2 = Provider.of<ProfileManager>(context, listen: false).darkMode ? Colors.black : Colors.orange;

    return SafeArea(
      child: Scaffold(
        //backgroundColor: colorGradient,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                colorGradient1,
                colorGradient2
              ]
            )
          ),
          child: GridView.builder(
            itemCount: MemoryCard.memories.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, crossAxisSpacing: 7.0, mainAxisSpacing: 7.0),
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () {
                        Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              duration: const Duration(milliseconds: 300),
                            child: MemoryDispatcher(memory: MemoryCard.memories[index], memoryIndex: index)
                          )
                        );
                    },
                    child: buildMemoryCard(MemoryCard.memories[index], context));
              }),
        ),
        floatingActionButton: FloatingActionButton.extended(
          label: const Text('Add Card', style: TextStyle(fontWeight: FontWeight.w900)),
          icon: const Icon(Icons.add),
          elevation: 6,
          onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => ProfileScreen(
                      user: User(
                        firstName: 'Alicia',
                        lastName: 'Zhao',
                        profileImageUrl: 'assets/alicia.jpg',
                      ))));
        },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        endDrawer: Drawer(
          elevation: 8,
          shape: const StadiumBorder(),
          //width: MediaQuery.of(context).size.width / 1.5,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              /*
              DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.orange
                  ),
                child: Text('Profile'),
              ),
               */
              Container(
                decoration: const BoxDecoration(
                    color: Colors.orange
                ),
                child: UserAccountsDrawerHeader(
                  currentAccountPicture: GestureDetector(
                    onTap: () {
                      Navigator.pop(context); // to close the Drawer on tap
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => ProfileScreen(
                                  user: User(
                                    firstName: 'Alicia',
                                    lastName: 'Zhao',
                                    profileImageUrl: 'assets/alicia.jpg',
                                  ))));

                    },
                    child: const CircleImage(
                      imageProvider: AssetImage('assets/alicia.jpg'),
                      imageRadius: 80.0,
                    ),
                  ),
                  accountName: const Text('Alicia Zhao',
                  style: TextStyle(fontSize: 18)),
                  accountEmail: const Text(''),
                ),
              ),
              ListTile(
                title: const Text('Dark mode'),
                trailing: Switch(
                  inactiveThumbColor: Colors.blue,
                  inactiveTrackColor: Colors.amber,
                  activeColor: Colors.red,
                  //value: widget.user.darkMode,
                  value: Provider.of<ProfileManager>(context, listen: false).darkMode,
                  onChanged: (value) {
                    Provider.of<ProfileManager>(context, listen: false).darkMode =
                        value;
                  },
                ),
              ),
              Container(
                color: colorGradient,
                height: 12,
              ),
              ListTile(
                leading: const Icon(Icons.wallpaper_rounded),
                title: Text("${MemoryCard.memories.length} memory cards in total "),
              ),
              Container(
                color: colorGradient,
                height: 4,
              ),
              ListTile(
                leading: const Icon(Icons.favorite_outline_sharp),
                title: Text("13 favourite memory cards"),
              ),
              Container(
                color: colorGradient,
                height: 4,
              ),
              ListTile(
                leading: const Icon(Icons.content_paste_search),
                title: Text("13 memory cards created by you so far"),
              ),
              Container(
                color: colorGradient,
                height: 4,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMemoryCard(MemoryCard memory, BuildContext context) {
    return Card(
      elevation: 6,
      shadowColor: Colors.blueAccent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Expanded(
                child: Container(
                  constraints: BoxConstraints.expand(
                    width: MediaQuery.of(context).size.width / 2,
                    height: MediaQuery.of(context).size.width / 4,
                  ),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      //color: Colors.blueGrey[400],
                      borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        image: AssetImage(memory.imgUrl),
                      fit: BoxFit.cover
                    )
                  ),
                  //child:
                      /*
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child:
                        Image(image: AssetImage(memory.imgUrl)),
                  ),
                       */
                )
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(memory.description,
                style: const TextStyle(
                    fontSize: 15
                )),
            )],
        ),
      ),
    );
  }

}