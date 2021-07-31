import 'package:anime_list/Routes/Pages/SearchResult.dart';
import 'package:anime_list/Widgets/TagButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageDescribtion extends StatefulWidget {
  final dynamic engName;

  final dynamic japName;

  final dynamic characters;
  final dynamic tags;

  ImageDescribtion({
    required this.engName,
    required this.japName,
    required this.characters,
    required this.tags,
  });

  @override
  _ImageDescribtionState createState() => _ImageDescribtionState();
}

class _ImageDescribtionState extends State<ImageDescribtion> {
  @override
  void initState() {
    super.initState();
    // print(widget.engName.runtimeType);
    // print(widget.japName.runtimeType);
    children = listoOfChildrens();
    // children.addAll(showTags());
  }

  late final List<Widget> children;

  List<Widget> showCharacterTags() {
    final List list = widget.characters;
    final List<Widget> children = [];
    list.forEach((element) {
      children.add(TagButton(
          text: element,
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => SearchResult(
                      searchTerm: element,
                    )));
          }));
    });
    return children;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }

  List<Widget> listoOfChildrens() {
    return [
      Row(
        children: [
          Text(
            'Anime: ',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          Wrap(
            spacing: 10.0,
            runSpacing: 5.0,
            children: showAnimeTags(),
          ),
        ],
      ),
      SizedBox(height: 20.h),
      Text(
        'Characters:',
        style: TextStyle(
          color: Colors.black87,
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      Wrap(
        spacing: 10.0,
        runSpacing: 5.0,
        children: showCharacterTags(),
      ),
      Text(
        'Tags:',
        style: TextStyle(
          color: Colors.black87,
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      Wrap(
        spacing: 10.0,
        runSpacing: 5.0,
        children: showThemeTags(),
      ),
    ];
  }

  List<Widget> showThemeTags() {
    final List list = widget.tags;
    final List<Widget> children = [];
    list.forEach((element) {
      children.add(TagButton(
          text: element,
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => SearchResult(
                      searchTerm: element,
                    )));
          }));
    });
    return children;
  }

  List<Widget> showAnimeTags() {
    if (widget.engName is List) {
      final List list = widget.engName;
      final List<Widget> children = [];
      list.forEach((element) {
        children.add(TagButton(
            text: element,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => SearchResult(
                        searchTerm: element,
                      )));
            }));
      });
      return children;
    } else {
      return [
        TagButton(
            text: widget.engName,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => SearchResult(
                        searchTerm: widget.engName,
                      )));
            })
      ];
    }
  }
}
