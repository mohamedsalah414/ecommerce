import 'dart:io';

import 'package:ecommercebusiness/src/core/utils/helper_extenstions.dart';
import 'package:ecommercebusiness/src/core/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class UploadImagePage extends ConsumerStatefulWidget {
  const UploadImagePage({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => _UploadImageState();
}

class _UploadImageState extends ConsumerState<UploadImagePage> {
  var _image;
  var imagePicker;
  var path;

  @override
  void initState() {
    super.initState();
    imagePicker = ImagePicker();
  }

  bool switchCameraOrGallery = false;
  String type = 'gallery';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(),
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const TextWidget(txt: 'Switch between camera and gallery'),
                SwitchListTile(
                  title: TextWidget(txt: type.capitalize()),
                  value: switchCameraOrGallery,
                  onChanged: (value) {
                    setState(() {
                      switchCameraOrGallery = value;
                      type = value ? 'camera' : 'gallery';
                    });
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () async {
                      print('tapped');
                      var source = type == 'camera'
                          ? ImageSource.camera
                          : ImageSource.gallery;
                      XFile image = await imagePicker.pickImage(
                          source: source,
                          imageQuality: 50,
                          preferredCameraDevice: CameraDevice.front);
                      setState(() {
                        print('pathhhhhh' + image.path);
                        path = image.path;
                        _image = File(image.path);
                      });
                    },
                    child: _image != null
                        ? Image.file(
                            _image,
                            width: 200.0,
                            height: 200.0,
                            fit: BoxFit.fitHeight,
                          )
                        : const CircleAvatar(
                            radius: 150,
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                ),
                Visibility(
                  visible: path != null,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height / 19,
                    width: MediaQuery.of(context).size.width / 2,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop(_image);
                      },
                      child: const Text(
                        'Upload',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
