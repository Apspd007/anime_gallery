import 'package:anime_list/Routes/Pages/CharacterSearchResult.dart';
import 'package:anime_list/Widgets/TagButon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageDescribtion extends StatefulWidget {
  final String engName;

  final String japName;

  final dynamic tags;

  ImageDescribtion({
    required this.engName,
    required this.japName,
    required this.tags,
  });

  @override
  _ImageDescribtionState createState() => _ImageDescribtionState();
}

class _ImageDescribtionState extends State<ImageDescribtion> {
  @override
  void initState() {
    super.initState();
    children = listoOfChildrens();
    children.addAll(showTags());
  }

  late final List<Widget> children;

  List<Widget> showTags() {
    if (widget.tags is List) {
      final List list = widget.tags;
      final List<Widget> children = [];
      list.forEach((element) {
        children.add(TagButton(
            text: element,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => CharacterSearchResult(
                        characterName: element,
                        animeName: widget.engName,
                      )));
            }));
      });
      return children;
    } else {
      return [
        TagButton(
            text: widget.tags,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => CharacterSearchResult(
                        characterName: widget.tags,
                        animeName: widget.engName,
                      )));
            })
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start, children: children);
  }

  List<Widget> listoOfChildrens() {
    return [
      Text(
        'Anime: ${widget.engName}',
        style: TextStyle(
          color: Colors.black87,
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      SizedBox(height: 20.h),
      Text(
        'Synonym: ${widget.japName}',
        style: TextStyle(
          color: Colors.black87,
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      SizedBox(height: 20.h),
      Text(
        'Tags:',
        style: TextStyle(
          color: Colors.black87,
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    ];
  }
}
