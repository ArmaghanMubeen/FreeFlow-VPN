import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


//card to represent status in home screen
class HomeCard extends StatelessWidget {
  final String title, subtitle;

  const HomeCard({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //subtitle
        Text(
          subtitle,
          style: GoogleFonts.roboto(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.grey.shade200
                  : Colors.grey.shade700,
              fontSize: 9),
        ),
        //for adding some space
        const SizedBox(height: 6),
        //title
        Text(title,
            style: GoogleFonts.roboto(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
            )),
      ],
    );
  }
}
