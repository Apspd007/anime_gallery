import 'package:anime_list/Model/UserDataModel.dart';
import 'package:anime_list/Services/AuthenticationService.dart';
import 'package:anime_list/Widgets/LoadingState.dart';
import 'package:anime_list/Widgets/TagButton.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:anime_list/Designs/Materials/Colors.dart';
import 'package:anime_list/Model/AnimeJsonModel.dart';
import 'package:anime_list/Model/SearchSuggestions.dart';
import 'package:anime_list/Routes/Pages/SearchResult.dart';
import 'package:anime_list/Services/FirestoreDatabase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late SuggestionsBoxController suggestionsBoxController;
  final _formKey = GlobalKey<FormState>();
  bool typing = false;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    suggestionsBoxController = SuggestionsBoxController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Database _database = Provider.of<Database>(context);
    final user = Provider.of<LocalUser>(context);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.black26,
    ));
    // final padding = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: EdgeInsets.only(top: 32.3.h),
        child: StreamBuilder<DocumentSnapshot<Object?>>(
            stream: _database.getUserDataAsStream(user.uid),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.connectionState == ConnectionState.active) {
                  Map<String, dynamic> _data =
                      snapshot.data!.data() as Map<String, dynamic>;
                  UserDataModel data = userDataModelFromJson(_data);
                  return Column(
                    children: [
                      searchAppBar(_database, user),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(top: 20.0, left: 20.0),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: children(data, _database, user),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return Center(
                    child: LoadingState.defaultGifLoading(),
                  );
                }
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              } else {
                return Center(child: LoadingState.defaultGifLoading());
              }
            }),
      ),
    );
  }

  //ADDING TAG BUTTON ON BODY
  List<Widget> children(
      UserDataModel userDataModel, Database database, LocalUser user) {
    List<Widget> widgetChildren = [];
    final keywords = userDataModel.userData.searchedKeywords;
    keywords.forEach((element) {
      widgetChildren.add(TagButton(
          text: element,
          backgroundColor: Colors.white,
          elevation: 5,
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => SearchResult(
                      searchTerm: element,
                    )));
          }));
    });

    return widgetChildren;
  }

  Container searchAppBar(Database _database, LocalUser user) {
    return Container(
      height: 130.h,
      padding: EdgeInsets.symmetric(horizontal: 45.w),
      width: double.infinity,
      decoration: BoxDecoration(color: Colors.black26),
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
                return Center(
                  child: SizedBox(
                    height: 48.h,
                    width: 280.w,
                    child: DecoratedBoxTransition(
                      decoration: DecorationTween(
                              begin: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30.r)),
                              end: boxDecoration())
                          .animate(_controller),
                      child: typeAhead(data, _database, user, context),
                    ),
                  ),
                );
              } else {
                return demoTextField();
              }
            } else if (snapshot.hasError) {
              return Center(
                child: Text((snapshot.error).toString()),
              );
            } else {
              return demoTextField();
            }
          }),
    );
  }

  TypeAheadField<String> typeAhead(AnimeJsonModel data, Database _database,
      LocalUser user, BuildContext context) {
    return TypeAheadField(
      key: _formKey,
      suggestionsBoxController: suggestionsBoxController,
      debounceDuration: Duration(milliseconds: 210),
      hideOnLoading: true,
      textFieldConfiguration: textFieldConfiguration(),
      suggestionsCallback: (pattern) {
        List<String> li = [];
        if (pattern == '') return li;
        return SearchSuggestions.getThemeSuggestions(data, pattern);
      },
      itemBuilder: (context, suggestion) {
        return ListTile(
          title: Text(suggestion.toString()),
        );
      },
      onSuggestionSelected: (String searchTerm) {
        _controller.reverse();
        _database.updateUser(user.uid, 'UserData.searchedThemeKeywords',
            FieldValue.arrayUnion([searchTerm]));
        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => SearchResult(
                  searchTerm: searchTerm,
                )));
      },
      suggestionsBoxDecoration: SuggestionsBoxDecoration(
        hasScrollbar: false,
        borderRadius: BorderRadius.circular(20.r),
      ),
      noItemsFoundBuilder: (_) {
        return SizedBox(
          height: 170.h,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/wallpaper/placeholder/nothing.gif',
                  scale: 4.r,
                ),
                SizedBox(height: 6.h),
                Text(
                  'I\'ve Got Nothing...',
                  style: GoogleFonts.comfortaa(
                    fontSize: 10.sp,
                    color: Colors.black87,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  TextFieldConfiguration textFieldConfiguration() {
    return TextFieldConfiguration(
        onTap: () {
          _controller.forward();
        },
        onSubmitted: (_) {
          _controller.reverse();
        },
        cursorWidth: 1.8,
        cursorColor: DefaultUIColors.appBarColor,
        cursorRadius: Radius.circular(5.r),
        maxLines: 1,
        style: GoogleFonts.comfortaa(
          fontSize: 19.sp,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: 'Search...',
          contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.r),
              borderSide: BorderSide.none),
        ));
  }

  BoxDecoration boxDecoration() {
    return BoxDecoration(boxShadow: [
      BoxShadow(
        color: Colors.black45,
        blurRadius: 5,
        spreadRadius: 1,
      ),
    ], borderRadius: BorderRadius.circular(30.r));
  }

  Center demoTextField() {
    return Center(
      child: SizedBox(
        height: 48.h,
        width: 280.w,
        child: TextField(
            cursorWidth: 1.8,
            cursorColor: DefaultUIColors.appBarColor,
            maxLines: 1,
            style: GoogleFonts.comfortaa(
              fontSize: 19.sp,
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: 'Search...',
              contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.r),
                  borderSide: BorderSide.none),
            )),
      ),
    );
  }
}
