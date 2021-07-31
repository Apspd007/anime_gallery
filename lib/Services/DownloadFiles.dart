import 'dart:isolate';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class MyDownloader extends StatefulWidget {
  final String fileUrl;
  MyDownloader({required this.fileUrl});

  @override
  _MyDownloaderState createState() => _MyDownloaderState();
}

class _MyDownloaderState extends State<MyDownloader> {


  
  Future<void> downloadFileFromUrl({required String fileUrl}) async {
    final status = Permission.storage.request();
    if (await status.isGranted) {
      final exterDir = await getExternalStorageDirectory();
      if (exterDir != null) {
        FlutterDownloader.enqueue(
          url: fileUrl,
          savedDir: exterDir.path,
          showNotification: true,
          openFileFromNotification: true,
        );
      } else
        print('null exterDir : $exterDir');
    } else {
      print('Permission Denied!');
    }
  }

  ReceivePort _port = ReceivePort();

  @override
  void initState() {
    super.initState();
    print('initiated');
    WidgetsBinding.instance!.addPostFrameCallback(
        (_) => downloadFileFromUrl(fileUrl: widget.fileUrl));
    // downloadFileFromUrl(fileUrl: widget.fileUrl);

    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      // ignore: unused_local_variable
      String id = data[0];
      // ignore: unused_local_variable
      DownloadTaskStatus status = data[1];
      // ignore: unused_local_variable
      int progress = data[2];
      setState(() {});
    });

    FlutterDownloader.registerCallback(downloadCallback);
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort? send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send!.send([id, status, progress]);
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   downloadFileFromUrl(fileUrl: widget.fileUrl);
  // }

  @override
  Widget build(BuildContext context) {
    return Center();
  }
}
