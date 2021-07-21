import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:anime_list/Designs/Materials/Colors.dart';
import 'package:anime_list/Model/AnimeJsonModel.dart';
import 'package:anime_list/Model/SearchSuggestions.dart';
import 'package:anime_list/Routes/Pages/SearchResult.dart';
import 'package:anime_list/Services/FirestoreDatabase.dart';
import 'package:anime_list/Widgets/GetImage.dart';
import 'package:anime_list/Widgets/LoadingState.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchImage extends StatefulWidget {
  @override
  _SearchImageState createState() => _SearchImageState();
}

class _SearchImageState extends State<SearchImage> {
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
        child: Column(
          children: [
            Container(
              height: 130.h,
              padding: EdgeInsets.symmetric(horizontal: 45),
              width: double.infinity,
              decoration: BoxDecoration(color: DefaultUIColors.appBarColor),
              child: FutureBuilder<DocumentSnapshot<Object?>>(
                  future: _database.getAllImagesAsFuture(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        Map<String, dynamic> _data =
                            snapshot.data!.data() as Map<String, dynamic>;
                        AnimeJsonModel data =
                            animeJsonModelFromJson(_data, 'all_images');
                        // AnimeListing.getAnimeSearchResult(data, 'Yamato (One Piece)');
                        SearchSuggestions.getSuggestions(data, 'pattern');
                        return Center(
                          child: SizedBox(
                            height: 48,
                            width: 280.w,
                            child: TypeAheadField(
                              getImmediateSuggestions: false,
                              hideSuggestionsOnKeyboardHide: true,
                              debounceDuration: Duration(milliseconds: 500),
                              textFieldConfiguration:
                                  TextFieldConfiguration(
                                      cursorWidth: 1.8,
                                      cursorColor: DefaultUIColors.appBarColor,
                                      maxLines: 1,
                                      style: GoogleFonts.comfortaa(
                                        fontSize: 19,
                                      ),
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        hintText: 'Search...',
                                        contentPadding:
                                            EdgeInsets.symmetric(
                                                horizontal: 20),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.r),
                                            borderSide: BorderSide.none),
                                      )),
                              suggestionsCallback: (pattern) =>
                                  SearchSuggestions.getSuggestions(
                                      data, pattern),
                              itemBuilder: (context, suggestion) {
                                return ListTile(
                                  title: Text(suggestion.toString()),
                                  // subtitle: Text(),
                                );
                              },
                              onSuggestionSelected: (String searchTerm) {
                                print(searchTerm);
                                Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (_) => SearchResult(
                                            searchTerm: searchTerm)));
                              },
                            ),
                          ),
                        );
                      } else {
                        return Center(
                            child: LoadingState.defaultGifLoading());
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
          ],
        ),
      ),
    );
  }

  // SliverAppBar appBar() {
  //   return SliverAppBar(
  //     floating: true,
  //     expandedHeight: 70.h,
  //     toolbarHeight: 50.h,
  //     backgroundColor: DefaultUIColors.appBarColor,
  //     actions: [

  //     ],
  //   );
  // }

  SliverPadding imageGrid(BuildContext context, AnimeJsonModel snapshot) {
    // final bool dataSaver = Provider.of<AppSettingsConfig>(context).saveData;
    // print('dataSaver: $dataSaver');
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
