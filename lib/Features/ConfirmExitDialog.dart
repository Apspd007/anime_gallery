import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ConfirmExit {
  static Future<bool> showComfirmExitDialog(BuildContext context) async {
    return (await showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  title: Text(
                    'Exit?',
                    style: GoogleFonts.comfortaa(),
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop<bool>(context, false);
                        },
                        child: Text(
                          'No',
                          style: GoogleFonts.comfortaa(
                            color: Colors.black,
                          ),
                        )),
                    TextButton(
                        onPressed: () {
                          Navigator.pop<bool>(context, true);
                        },
                        child: Text(
                          'Yes',
                          style: GoogleFonts.comfortaa(
                            color: Colors.black,
                          ),
                        )),
                  ],
                ))) ??
        false;
  }
}












                // TextButton(
                //     onPressed: () {
                //       Navigator.pop<bool>(context, false);
                //     },
                //     child: Text('No')),
                // TextButton(
                //     onPressed: () {
                //       Navigator.pop<bool>(context, true);
                //     },
                //     child: Text('Yes')),