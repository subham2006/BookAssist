import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'main.dart';

class ImageCapture extends StatefulWidget {
  const ImageCapture({Key key}) : super(key: key);

  @override
  _ImageCaptureState createState() => _ImageCaptureState();
}

class _ImageCaptureState extends State<ImageCapture> {
  File _imageFile;

  Future<void> _pickImage(ImageSource source) async {
    print("11");
    final _picker = ImagePicker();
    print("22");
    PickedFile pickedFile = await _picker.getImage(source: source);
    print("33");

    final File selected = File(pickedFile.path);
    print("69");
    setState(() {
      _imageFile = selected;
    });
    Uploader(file: _imageFile);
  }

  Future<void> _cropImage() async {
    File cropped = await ImageCropper.cropImage(
      sourcePath: _imageFile.path,
      // toolbarColor: Colors.purple,
      // toolbarWidgetColor: Colors.white,
      // toolbarTitle: 'Pateshit',
    );

    setState(() {
      _imageFile = cropped ?? _imageFile;
    });
  }

  void _clear() {
    setState(() {
      _imageFile = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            ),
        bottomNavigationBar: BottomAppBar(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
                icon: Icon(Icons.photo_camera),
                onPressed: () => _pickImage(ImageSource.camera)),
            IconButton(
                icon: Icon(Icons.photo_library),
                onPressed: () => _pickImage(ImageSource.gallery)),
          ],
        )),
        body: ListView(children: <Widget>[
          if (_imageFile != null) ...[
            Image.file(_imageFile,
                width: MediaQuery.of(context).size.width * 0.65,
                height: MediaQuery.of(context).size.height * 0.65),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    // ignore: deprecated_member_use
                    IconButton(
                      icon: Icon(Icons.crop),
                      onPressed: _cropImage,
                    ),
                    // ignore: deprecated_member_use
                    IconButton(
                      icon: Icon(Icons.refresh),
                      onPressed: _clear,
                    ),
                    Uploader(file: _imageFile)
                  ]),
            ),
          ]
        ]));
  }
}

class Uploader extends StatefulWidget {
  final File file;
  const Uploader({Key key, this.file}) : super(key: key);

  @override
  _UploaderState createState() => _UploaderState();
}

class _UploaderState extends State<Uploader> {
  FirebaseStorage storage = FirebaseStorage.instance;
  UploadTask _uploadTask;

  void _startUpload() {
    Navigator.pop(context);
    String filePath = 'uploaded.png';
    setState(() async {
      // Reference ref = storage.ref().child(filePath);
      // UploadTask _uploadTask = ref.putFile(widget.file);
      // print("1");
      // await FirebaseStorage.instance
      //     .ref('uploads/file-to-upload.png')
      //     .putFile(widget.file);
      print("2");
      showInSnackBar("Your question has been sent to your teacher");
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.cloud_upload),
      onPressed: _startUpload,
    );
  }
}

class UploadPage extends StatefulWidget {
  const UploadPage({Key key}) : super(key: key);

  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("done!")));
  }
}
