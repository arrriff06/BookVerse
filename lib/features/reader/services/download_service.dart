import 'dart:io';

import 'package:dio/dio.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';

class DownloadService {
  static Future<void> downloadPdf({
    required String url,
    required String fileName,
  }) async {
    final directory = await getApplicationDocumentsDirectory();

    final filePath = "${directory.path}/$fileName.pdf";

    await Dio().download(
      url,
      filePath,
    );

    await OpenFilex.open(filePath);
  }
}