

import 'package:flutter/material.dart';

class TestStackWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Testing Stack')),
        body: Center(
          child: Container(
            width: 250,
            height: 250,
            color: Colors.blueGrey,
            margin: EdgeInsets.all(20.0),
            child: Stack(
              children: <Widget>[
                Positioned(
                    top: 50,
                    left: 50,
                    child: Container(
                      width: 200,
                      height: 100,
                      color: Colors.green,
                    )),
                Positioned(
                    top: 70,
                    left: 70,
                    child: Container(
                      width: 120,
                      height: 230,
                      color: Colors.yellow,
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

}