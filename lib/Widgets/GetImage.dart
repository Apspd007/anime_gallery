import 'dart:ui';
import 'package:anime_list/Routes/Pages/ImageDetailPage.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'dart:isolate';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class GetImage extends StatefulWidget {
  final String previewImage;
  final String image;
  final String imageSource;
  final dynamic characterName;
  final dynamic animeNameEng;
  final dynamic animeNameJap;
  final dynamic tags;
  GetImage({
    required this.animeNameEng,
    required this.animeNameJap,
    required this.characterName,
    required this.previewImage,
    required this.image,
    required this.imageSource,
    required this.tags,
  });

  @override
  _GetImageState createState() => _GetImageState();
}

class _GetImageState extends State<GetImage> {
  ReceivePort _port = ReceivePort();
  late Image _myImage;

  @override
  void initState() {
    super.initState();
    _myImage = Image.network(widget.previewImage);
    WidgetsBinding.instance!
        .addPostFrameCallback((timeStamp) => precacheImageData());
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

  Future<void> downloadFileFromUrl({required String fileUrl}) async {
    final status = Permission.storage.request();
    if (await status.isGranted) {
      final exterDir = await getExternalStorageDirectory();
      if (exterDir != null) {
        FlutterDownloader.enqueue(
          url: fileUrl,
          savedDir: '/storage/emulated/0/',
          showNotification: true,
          openFileFromNotification: true,
        );
      } else
        print('null exterDir : $exterDir');
    } else {
      print('Permission Denied!');
    }
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

  void precacheImageData() async {
    await cacheImage(context, widget.previewImage);
  }

  Future cacheImage(BuildContext context, String url) =>
      precacheImage(CachedNetworkImageProvider(url), context);

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   precacheImage(_myImage.image, context);
  // }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: 100, minWidth: 100),
          child: cachedImages()),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => ImageDetail(
                    animeNameEng: widget.animeNameEng,
                    animeNameJap: widget.animeNameJap,
                    characterName: widget.characterName,
                    image: widget.image,
                    imageSource: widget.imageSource,
                    previewImage: widget.previewImage,
                    tags: widget.tags,
                    onPressed: () {
                      downloadFileFromUrl(fileUrl: widget.image);
                    },
                  )),
        );
      },
      onLongPress: () {},
    );
  }

  Image cachedImages() {
    return Image(
      image: _myImage.image,
      fit: BoxFit.cover,
      errorBuilder:
          (BuildContext context, Object object, StackTrace? stackTrace) {
        return Image.asset('assets/wallpaper/placeholder/image.jpg');
      },
      loadingBuilder:
          (BuildContext context, Widget child, ImageChunkEvent? progress) {
        if (progress != null)
          return SizedBox(
            child: Image.asset('assets/wallpaper/placeholder/image.jpg'),
          );
        return DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: child,
          ),
        );
      },
    );
  }
}
