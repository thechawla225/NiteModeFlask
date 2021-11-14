import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

pdfSender(String? file) async {
  showToast("File Received , Please Wait");
  print("ImageSender Called");
  final basestorage = await getExternalStorageDirectory();

  http.MultipartRequest request = http.MultipartRequest('POST',
      Uri.parse('http://thechawla225.pythonanywhere.com/uploaderMobile'));

  request.files.add(
    await http.MultipartFile.fromPath(
      'file',
      file ?? "file",
      contentType: MediaType('application', 'pdf'),
    ),
  );

  http.StreamedResponse r = await request.send();
  if (r.statusCode == 500) {
    final taskId = await FlutterDownloader.enqueue(
      url: 'https://thechawla225.pythonanywhere.com/receiveMobile',
      savedDir: basestorage!.path,
      fileName: 'DarkFile.pdf',
      showNotification: true,
      openFileFromNotification: true,
    );
    showToast("File Downloading");
  }
}

showToast(message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.black,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
