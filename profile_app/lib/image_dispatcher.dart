import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:profile_app/profile_manager.dart';
import 'dart:math' as math;

import 'package:provider/provider.dart';

class ImageDispatcher extends StatefulWidget {
  final String imgUrl;

  const ImageDispatcher(
      {Key? key,
      required this.imgUrl}) : super(key: key);

  @override
  State<ImageDispatcher> createState() => _ImageDispatcherState();
}

class _ImageDispatcherState extends State<ImageDispatcher> {

  final PhotoViewController _controller = PhotoViewController();
  var _quarterTurns = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final colorGradient1 = Provider.of<ProfileManager>(context, listen: false).darkMode ? Colors.grey[600] : Colors.lightBlue.withOpacity(0.5);
    final colorGradient2 = Provider.of<ProfileManager>(context, listen: false).darkMode ? Colors.grey[900] : Colors.grey[400];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: PhotoView(
        controller: _controller,
        imageProvider: AssetImage(widget.imgUrl),
        //filterQuality: FilterQuality.medium,
        backgroundDecoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: <Color>[colorGradient1!, colorGradient2!],
            //stops: const [0.1, 2.6]
          )
        ),
        minScale: PhotoViewComputedScale.contained * 0.8,
        maxScale: PhotoViewComputedScale.covered * 1.1,
        initialScale: PhotoViewComputedScale.covered * 0.5,
      ),
      floatingActionButton: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton(
              onPressed: () {
                _rotateLeft90Degrees();
              },
              heroTag: null,
              child: const Icon(Icons.rotate_left)
            ),
            FloatingActionButton(
              onPressed: () {
                _rotateRight90Degrees();
              },
              heroTag: null,
              child: const Icon(Icons.rotate_right)
            ),
          ],
        ),
      ),
    );
  }

  void _rotateRight90Degrees() {
    // Set the rotation to either 0, 90, 180 or 270 degrees (value is in radians)
    _quarterTurns = _quarterTurns == 3 ? 0 : _quarterTurns + 1;
    _controller.rotation = math.pi / 2 * _quarterTurns;
  }
  void _rotateLeft90Degrees() {
    // Set the rotation to either 0, 90, 180 or 270 degrees (value is in radians)
    _quarterTurns = _quarterTurns == 3 ? 0 : _quarterTurns - 1;
    _controller.rotation = math.pi / 2 * _quarterTurns;
  }
}