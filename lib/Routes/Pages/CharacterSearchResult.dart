







/////////////////////////////////////////////
///
///
///
/// DEPRECATED ;)
///
///
////////////////////////////////////////////





// import 'package:anime_list/Designs/Materials/Colors.dart';
// import 'package:anime_list/Model/AnimeJsonModel.dart';
// import 'package:anime_list/Features/Listing/AnimesListing.dart';
// import 'package:anime_list/Services/FirestoreDatabase.dart';
// import 'package:anime_list/Widgets/GetImage.dart';
// import 'package:anime_list/Widgets/LoadingState.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// import 'package:provider/provider.dart';
// // import 'package:flutter_screenutil/flutter_screenutil.dart';

// class CharacterSearchResult extends StatefulWidget {
//   final String characterName;
//   final String animeName;
//   CharacterSearchResult({
//     required this.characterName,
//     required this.animeName,
//   });

//   @override
//   _CharacterSearchResultState createState() => _CharacterSearchResultState();
// }

// class _CharacterSearchResultState extends State<CharacterSearchResult> {
//   @override
//   Widget build(BuildContext context) {
//     Database _database = Provider.of<Database>(context);

//     SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
//       statusBarColor: DefaultUIColors.appBarColor,
//     ));
//     // final padding = MediaQuery.of(context).padding.top;
//     return Container(
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [
//               Color(0xFFF6BEE5),
//               Color(0xFFD1FFFD),
//             ]),
//       ),
//       child: Scaffold(
//         backgroundColor: Colors.transparent,
//         appBar: AppBar(
//           backgroundColor: DefaultUIColors.appBarColor,
//         ),
//         body: FutureBuilder<DocumentSnapshot<Object?>>(
//             future: _database.getAnimesAsFuture(),
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {
//                 if (snapshot.connectionState == ConnectionState.done) {
//                   Map<String, dynamic> _data =
//                       snapshot.data!.data() as Map<String, dynamic>;

//                   AnimeJsonModel data =
//                       animeJsonModelFromJson(_data, widget.animeName);

//                   final characterList = AnimeListing.getAnimeSearchResult(
//                       data, widget.characterName);

//                   return CustomScrollView(slivers: [
//                     imageGrid(context, characterList),
//                   ]);
//                 } else {
//                   return Center(child: LoadingState.defaultGifLoading());
//                 }
//               } else if (snapshot.hasError) {
//                 return Center(
//                   child: Text((snapshot.error).toString()),
//                 );
//               } else {
//                 return Center(child: LoadingState.defaultGifLoading());
//               }
//             }),
//       ),
//     );
//   }

//   SliverPadding imageGrid(
//       BuildContext context, List<Anime> snapshot) {
//     // final bool dataSaver = Provider.of<AppSettingsConfig>(context).saveData;
//     // print('dataSaver: $dataSaver');
//     return SliverPadding(
//       padding: const EdgeInsets.all(10.0),
//       sliver: SliverStaggeredGrid.countBuilder(
//           crossAxisCount: 3,
//           crossAxisSpacing: 10.0,
//           mainAxisSpacing: 10.0,
//           staggeredTileBuilder: (index) => StaggeredTile.fit(1),
//           itemCount: snapshot.length,
//           itemBuilder: (BuildContext context, int index) {
//             return GetImage(
//               animeNameEng: snapshot[index].animeNameEng,
//               animeNameJap: snapshot[index].animeNameJap,
//               characterName: snapshot[index].characterName,
//               previewImage: snapshot[index].previewImage,
//               image: snapshot[index].image,
//               imageSource: snapshot[index].imageSource,
//             );
//           }),
//     );
//   }
// }
