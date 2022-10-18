import 'dart:io';
// import 'package:file_picker/file_picker.dart';
import 'package:flutter_document_picker/flutter_document_picker.dart';
import 'package:image_picker/image_picker.dart';

File img;
final picker = ImagePicker();

Future<File> imgFromGallery() async {
  final image = await picker.getImage(source: ImageSource.gallery);
  if (image != null) {
    img = File(image.path);
    return img;
  }
  return null;
}

Future<String> getMultipleFileSelected() async {
  // FlutterDocumentPickerParams params = FlutterDocumentPickerParams(
  //   allowedFileExtensions: ['mwfbak'],
  //   allowedUtiTypes: ['com.sidlatau.example.mwfbak'],
  //   allowedMimeTypes: ['application/*'],
  //   invalidFileNameSymbols: ['/'],
  // );
  String data = await FlutterDocumentPicker.openDocument();
  print(data + "From get Image");
  return data;
}
