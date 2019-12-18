import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class PhotoSelector extends StatefulWidget {

  final Function(File imageSelected) onImageSelected;

  PhotoSelector({Key key, this.onImageSelected}) : super(key: key);

  @override
  _PhotoSelectorState createState() => _PhotoSelectorState();
}

class _PhotoSelectorState extends State<PhotoSelector> {
  /// Active image file
  File _imageFile;

  /// Cropper plugin
  Future<void> _cropImage() async {
    File cropped = await ImageCropper.cropImage(
        sourcePath: _imageFile.path,
        // ratioX: 1.0,
        // ratioY: 1.0,
        // maxWidth: 512,
//         maxHeight: 512,
        );

    setState(() {
      _imageFile = cropped ?? _imageFile;
    });

    Navigator.pop(context);
    widget.onImageSelected(_imageFile);
  }

  /// Select an image via gallery or camera
  Future<void> _pickImage(ImageSource source) async {
    File selected = await ImagePicker.pickImage(source: source);

    setState(() {
      _imageFile = selected;
    });

    _cropImage();
  }

  /// Remove image
  void _clear() {
    setState(() => _imageFile = null);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130.0,
      child: ListView(
        children: <Widget>[
          ListTile(
            title: const Text('Cámara'),
            leading: Icon(Icons.photo_camera),
            onTap: () {
              _pickImage(ImageSource.camera);
            },
          ),
          ListTile(
            title: const Text('Galería'),
            leading: Icon(Icons.photo_album),
            onTap: () {
              _pickImage(ImageSource.gallery);
            },
          ),
        ],
      ),
    );
  }
}
