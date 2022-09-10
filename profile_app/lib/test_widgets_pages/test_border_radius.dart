
import 'package:flutter/material.dart';

class TestBorderRadius extends StatefulWidget {

  @override
  State<TestBorderRadius> createState() => _TestBorderRadiusState();
}

class _TestBorderRadiusState extends State<TestBorderRadius> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Containers and Borders')),
      body: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(height: 20),
              Container(
                width: 300,
                height: 150,
                decoration: const ShapeDecoration(
                    color: Colors.green,
                    shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.zero,
                            topLeft: Radius.zero,
                            bottomRight: Radius.circular(20),
                            topRight: Radius.circular(45)
                        )
                    )
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: 300,
                height: 150,
                decoration: const ShapeDecoration(
                    color: Colors.green,
                    shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(40),
                            right: Radius.circular(20)
                        )
                    )
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: 300,
                height: 450,
                decoration: const ShapeDecoration(
                    color: Colors.green,
                    shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(60),
                            topLeft: Radius.zero,
                            topRight: Radius.circular(60),
                            bottomRight: Radius.zero
                        )
                    )
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: 300,
                height: 450,
                decoration: const ShapeDecoration(
                    color: Colors.green,
                    shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.only(
                            //bottomLeft: Radius.zero,
                            topLeft: Radius.circular(90),
                            //topRight: Radius.zero,
                            bottomRight: Radius.circular(90),
                        )
                    )
                ),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(width: 1.0, color: Color(0xFFFFFFFFFF)),
                    left: BorderSide(width: 1.0, color: Color(0xFFFFFFFFFF)),
                    right: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                    bottom: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                  )
                ),
                child: Container(
                  width: 200,
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 2.0),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(width: 1.0, color: Color(0xFFFFDFDFDF)),
                      left: BorderSide(width: 1.0, color: Color(0xFFFFDFDFDF)),
                      right: BorderSide(width: 1.0, color: Color(0xFFFF7F7F7F)),
                      bottom: BorderSide(width: 1.0, color: Color(0xFFFF7F7F7F)),
                    ),
                    color: Color(0xFFBFBFBF),
                  ),
                  child: Text(
                    'OK ' + _selectedIndex.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Color(0xFF000000)),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ]
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        showUnselectedLabels: false,
        selectedIconTheme: const IconThemeData(
          color: Colors.yellowAccent,
          opacity: 1.0,
          size: 30
        ),
        unselectedIconTheme: IconThemeData(
          color: Colors.yellow[200],
          opacity: 1.0,
          size: 15
        ),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.contacts_outlined),
            label: 'Contacts',
            //backgroundColor: Colors.green
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.email),
              label: 'Emails',
              backgroundColor: Colors.red
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
              backgroundColor: Colors.yellow
          )
        ],
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}