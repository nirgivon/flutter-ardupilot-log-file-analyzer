import 'dart:io';

import 'package:file_picker/file_picker.dart';

Future<File?> openLogFile() async {
  File? file;

  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: [
      'log',
    ],
  );

  if (result != null) {
    file = File(result.files.single.path!);
  }
  return file;
}
