import 'package:anime_list/Designs/Materials/Colors.dart';
import 'package:anime_list/Model/AnimeJsonModel.dart';
import 'package:anime_list/Services/FirestoreDatabase.dart';
import 'package:anime_list/Widgets/GetImage.dart';
import 'package:anime_list/Widgets/LoadingState.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchResult extends StatefulWidget {
  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
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
            future: _database.getAnimesAsFuture(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.connectionState == ConnectionState.done) {
                  Map<String, dynamic> _data =
                      snapshot.data!.data() as Map<String, dynamic>;
                  AnimeJsonModel data = animeJsonModelFromJson(_data, 'NARUTO');
                  return CustomScrollView(slivers: [
                    appBar(),
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

  SliverAppBar appBar() {
    return SliverAppBar(
      floating: true,
      expandedHeight: 70.h,
      toolbarHeight: 50.h,
      backgroundColor: DefaultUIColors.appBarColor,
      actions: [],
    );
  }

  SliverPadding imageGrid(BuildContext context, AnimeJsonModel snapshot) {
    // final bool dataSaver = Provider.of<AppSettingsConfig>(context).saveData;
    // print('dataSaver: $dataSaver');
    print('animes : ${snapshot.anime.length}');
    return SliverPadding(
      padding: const EdgeInsets.all(10.0),
      sliver: SliverStaggeredGrid.countBuilder(
          crossAxisCount: 3,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          staggeredTileBuilder: (index) => StaggeredTile.fit(1),
          itemCount: snapshot.anime.length,
          itemBuilder: (BuildContext context, int index) {
            return GetImage(
              animeNameEng: snapshot.anime[index].animeNameEng,
              animeNameJap: snapshot.anime[index].animeNameJap,
              characterName: snapshot.anime[index].characterName,
              previewImage: snapshot.anime[index].previewImage,
              image: snapshot.anime[index].image,
              imageSource: snapshot.anime[index].imageSource,
            );
          }),
    );
  }
}
