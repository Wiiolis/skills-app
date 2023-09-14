import 'package:demo_app/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

class DocumentBox extends StatelessWidget {
  final String link;
  final String title;

  const DocumentBox({super.key, required this.link, required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        var url = Uri.parse(link);
        if (await canLaunchUrl(url)) {
          launchUrl(url);
        }
      },
      child: Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: SizedBox(
          width: 150,
          height: 190,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      'assets/images/Documents.svg',
                      color: AppColors.primaryColor,
                      height: 36,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      title,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const TextButton(
                  style: ButtonStyle(),
                  onPressed: null,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Open',
                        style: TextStyle(color: AppColors.primaryColor),
                      ),
                      Icon(
                        Icons.arrow_outward_rounded,
                        color: AppColors.primaryColor,
                        size: 15,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
