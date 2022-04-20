// ignore_for_file: use_key_in_widget_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {
  final Function onSelectImage;
  ImageInput(this.onSelectImage);

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storedImage;

  Future<void> takePicture() async {
    var picture = ImagePicker();
    final imageFile = await picture.pickImage(
      source: ImageSource.camera,
      maxHeight: 600,
    );
    if (imageFile == null) {
      return;
    }

    //imageFile is of type XFile, but _storedImage is of type File
    //so .path converts it into type File.
    setState(() {
      _storedImage = File(imageFile.path);
    });

    /*  */
    final appDirectory = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final savedImage =
        await _storedImage.copy('${appDirectory.path}/$fileName');

    widget.onSelectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 175,
          height: 175,
          decoration: BoxDecoration(
            border: Border.all(width: 1.5, color: Colors.grey),
          ),
          child: _storedImage == null
              ? Center(
                  child: Text(
                    'No image captured!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 19,
                    ),
                  ),
                )
              : Image.file(
                  _storedImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: FlatButton.icon(
            icon: Icon(Icons.camera),
            label: Text(
              'Capture Image',
              textAlign: TextAlign.center,
            ),
            textColor: Theme.of(context).primaryColor,
            onPressed: takePicture,
          ),
        ),
      ],
    );
  }
}
