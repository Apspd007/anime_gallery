import 'package:flutter/material.dart';

class ImageOptions extends StatefulWidget {
  final List<String> items;

  const ImageOptions({
    required this.items,
  });

  @override
  _ImageOptionsState createState() => _ImageOptionsState();
}

class _ImageOptionsState extends State<ImageOptions> {
  var value;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 50,
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.red[100],
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: DropdownButton<String>(
          dropdownColor: Colors.cyan[100],
          // hint: Text(widget.title),
          value: value,
          iconEnabledColor: Colors.black87,
          style: TextStyle(fontSize: 20, color: Colors.black87),
          items: widget.items.map<DropdownMenuItem<String>>((value) {
            return DropdownMenuItem(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (val) {
            setState(() {
              value = val!;
            });
          },
        ),
      ),
    );
  }
}
