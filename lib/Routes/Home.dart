import 'package:anime_list/Designs/Materials/Colors.dart';
import 'package:anime_list/Features/For_HomeScreen/FavoriteImagesFromDB.dart';
import 'package:anime_list/Features/For_HomeScreen/RandomImagesFromDB.dart';
import 'package:anime_list/Model/AnimeJsonModel.dart';
import 'package:anime_list/Features/Listing/AnimesListing.dart';
import 'package:anime_list/Services/FirestoreDatabase.dart';
import 'package:anime_list/Widgets/GetImage.dart';
import 'package:anime_list/Widgets/LoadingState.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isRandomPressed = true;
  bool isFavPressed = false;
  int index = 0;
  void changeSelection(index) {
    switch (index) {
      case 0:
        isRandomPressed = true;
        isFavPressed = false;
        break;
      case 1:
        isFavPressed = true;
        isRandomPressed = false;
        break;
      default:
    }
  }

  @override
  void initState() {
    // WidgetsBinding.instance!.addPostFrameCallback(
    //     (_) => MyRandomAnimeListing.getRandomList(_animeName));
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // MyRandomAnimeListing.getRandomList(_animeName);
  }

  @override
  Widget build(BuildContext context) {
    Database _database = MyFirestoreDatabse();

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: DefaultUIColors.appBarColor,
    ));
    final padding = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: EdgeInsets.only(top: padding),
        child: FutureBuilder<DocumentSnapshot<Object?>>(
            future: _database.getAllImagesAsFuture(),
            builder: (context, snapshot) {
              // print(snapshot);
              if (snapshot.hasData) {
                if (snapshot.connectionState == ConnectionState.done) {
                  Map<String, dynamic> _data =
                      snapshot.data!.data() as Map<String, dynamic>;
                  List<Anime> data =
                      AnimeListing.getRandomList(_data);
                  // MyRandomAnimeListing.getRandom();
                  // AnimeJsonModel data =
                  //     animeJsonModelFromJson(_data, 'Azur Lane');
                  return CustomScrollView(slivers: [
                    appBar(_database),
                    imageGrid(context, data),
                  ]);
                } else {
                  return Center(child: LoadingState.defaultGifLoading());
                }
              } else if (snapshot.hasError) {
                return Center(
                  child: Text((snapshot.error).toString()),
                );
              } else {
                return Center(child: LoadingState.defaultGifLoading());
              }
            }),
      ),
    );
  }

  SliverAppBar appBar(Database database) {
    return SliverAppBar(
      floating: true,
      expandedHeight: 70.h,
      toolbarHeight: 50.h,
      backgroundColor: DefaultUIColors.appBarColor,
      actions: [
        TextButton(
          style: ButtonStyle(
              overlayColor: MaterialStateProperty.all<Color?>(Colors.black26)),
          onPressed: () {
            if (index == 0) return;
            setState(() {
              index = 0;
            });
            changeSelection(index);
          },
          child: RandomImageFromDB(
            isPressed: isRandomPressed,
          ),
        ),
        TextButton(
          style: ButtonStyle(
              overlayColor: MaterialStateProperty.all<Color?>(Colors.black26)),
          onPressed: () {
            if (index == 1) return;
            setState(() {
              index = 1;
            });
            changeSelection(index);
          },
          child: FavoriteImagesFromDB(
            isPressed: isFavPressed,
          ),
        ),
      ],
    );
  }

  SliverPadding imageGrid(BuildContext context, List<Anime> snapshot) {
    // final bool dataSaver = Provider.of<AppSettingsConfig>(context).saveData;
    // print('dataSaver: $dataSaver');
    return SliverPadding(
      padding: const EdgeInsets.all(10.0),
      sliver: SliverStaggeredGrid.countBuilder(
          crossAxisCount: 3,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          staggeredTileBuilder: (index) => StaggeredTile.fit(1),
          itemCount: snapshot.length,
          itemBuilder: (BuildContext context, int index) {
            return GetImage(
              animeNameEng: snapshot[index].animeNameEng,
              animeNameJap: snapshot[index].animeNameJap,
              characterName: snapshot[index].characterName,
              previewImage: snapshot[index].previewImage,
              image: snapshot[index].image,
              imageSource: snapshot[index].imageSource,
            );
          }),
    );
  }
}
