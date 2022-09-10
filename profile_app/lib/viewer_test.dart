import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'dart:math';

class ImageViewerTest extends StatefulWidget {
  @override
  State<ImageViewerTest> createState() => _ImageViewerTestState();
}

const double min = pi * -2;
const double max = pi * 2;

const double minScale = 0.03;
const double defScale = 0.1;
const double maxScale = 0.6;

class _ImageViewerTestState extends State<ImageViewerTest> {
  late PhotoViewControllerBase controller;
  late PhotoViewScaleStateController scaleStateController;
  int calls = 0;

  @override
  void initState() {
    controller = PhotoViewController(initialScale: defScale);

    scaleStateController = PhotoViewScaleStateController();
    super.initState();
  }


  @override
  void dispose() {
    controller.dispose();
    scaleStateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back, shadows: [
              Shadow(color: Colors.white, offset: Offset(0.5, 2), blurRadius: 8)
            ]),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Stack(children: [
                Positioned.fill(
                  child: PhotoView(
                    controller: controller,
                    scaleStateController: scaleStateController,
                    imageProvider: const AssetImage('assets/alicia.jpg'),
                    backgroundDecoration: const BoxDecoration(
                        gradient: LinearGradient(
                            colors: <Color>[Colors.white, Colors.grey],
                            stops: [0.1, 2.0])),
                    //basePosition: const Alignment(0.5, 0.0),
                    //minScale: PhotoViewComputedScale.contained * 0.8,
                    //maxScale: PhotoViewComputedScale.covered * 1.1,
                    //initialScale: PhotoViewComputedScale.covered * 0.5,
                    initialScale: minScale * 1.5,
                    minScale: minScale,
                    maxScale: maxScale,
                    //disableGestures: true,
                    enableRotation: true,
                  ),
                ),
                Positioned(
                    bottom: 0,
                    height: 290,
                    left: 0,
                    right: 0,
                    child: StreamBuilder(
                        stream: controller.outputStateStream,
                        initialData: controller.value,
                        //builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {  },
                        builder: _streamBuild))
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _streamBuild(BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.hasError || !snapshot.hasData) {
      return Container();
    }
    final PhotoViewControllerValue value = snapshot.data;
    return Column(
      children: <Widget>[
        Text("Rotation ${value.rotation}",
        style: const TextStyle(color: Colors.white)),
        SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: Colors.orange,
              thumbColor: Colors.orange
            ),
            child: Slider(
              value: value.rotation.clamp(min, max),
                min: min,
              max: max,
              onChanged: (double newRotation) {
                controller.rotation = newRotation;
              },
            )),
        Text("Scale ${value.scale}",
        style: const TextStyle(color: Colors.white)
        ),
        SliderTheme(
            data: SliderTheme.of(context).copyWith(
                activeTrackColor: Colors.orange,
                thumbColor: Colors.orange
            ),
            child: Slider(
              value: value.scale!.clamp(minScale, maxScale),
              min: minScale,
              max: maxScale,
              onChanged: (double newScale) {
                controller.scale = newScale;
              },
            )),
        /*
        Text("Position ${value.position.dx}",
            style: const TextStyle(color: Colors.white)
        ),
        SliderTheme(
            data: SliderTheme.of(context).copyWith(
                activeTrackColor: Colors.orange,
                thumbColor: Colors.orange
            ),
            child: Slider(
              value: value.position.dx,
              min: -1000.0,
              max: 1000.0,
              onChanged: (double newPosition) {
                controller.position = Offset(newPosition, controller.position.dy);
              },
            )),
         */
        Text(
          "ScaleState ${scaleStateController.scaleState}",
          style: const TextStyle(color: Colors.white),
        )
      ],
    );
  }
}
