import 'package:flutter/material.dart';
import 'package:mental_health/screens/patient_dashboard/fitness_app_home_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mental_health/screens/patient_dashboard/training/data/data.dart';
import 'package:mental_health/screens/patient_dashboard/training/models/style.dart';
import 'package:mental_health/utils/constants.dart';

import '../../fitness_app_theme.dart';

class DiffStyles extends StatelessWidget {
  const DiffStyles({Key? key}) : super(key: key);

  Future<void> _launchURL(String url) async {
    final Uri _uri = Uri.parse(url);
    try {
      {
        // if (await canLaunchUrl(_uri)) {
        await launchUrl(_uri, mode: LaunchMode.externalApplication);
      }
      // else {
      //   throw 'Could not launch $url';
      // }
    } catch (e) {
      throw 'Could not launch $url';
    }
  }

  _buildStyles(BuildContext context, int index) {
    Size size = MediaQuery.of(context).size;
    Style style = styles[index];

    return GestureDetector(
      onTap: () => _launchURL(style.link),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Constants.appPadding / 2),
            child: Container(
              margin: const EdgeInsets.only(
                  top: Constants.appPadding * 3,
                  bottom: Constants.appPadding * 2),
              width: size.width * 0.4,
              height: size.height * 0.2,
              decoration: BoxDecoration(
                  color: Constants.white,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      bottomLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0),
                      topRight: Radius.circular(100.0)),
                  boxShadow: [
                    BoxShadow(
                        color: Constants.black.withOpacity(0.3),
                        blurRadius: 20.0,
                        offset: const Offset(5, 15))
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: Constants.appPadding / 2,
                        right: Constants.appPadding * 3,
                        top: Constants.appPadding),
                    child: Text(
                      style.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54
                      ),
                      maxLines: 2,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: Constants.appPadding / 2,
                        right: Constants.appPadding / 2,
                        bottom: Constants.appPadding),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.access_time_outlined,
                              color: Constants.black.withOpacity(0.3),
                            ),
                            SizedBox(width: size.width * 0.01),
                            Text(
                              '${style.time} min',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Constants.black.withOpacity(0.3)),
                              maxLines: 2,
                            ),
                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.deepPurple[300],
                              borderRadius: BorderRadius.circular(5)),
                          child: const Icon(
                            Icons.play_arrow,
                            color: Constants.white,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: Image(
              width: size.width * 0.3,
              height: size.height * 0.2,
              image: AssetImage(style.imageUrl),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Constants.appPadding, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Yoga For Beginners',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: Colors.deepPurple[300],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: Constants.appPadding / 2),
          child: SizedBox(
            height: size.height * 0.33,
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: styles.length,
                itemBuilder: (BuildContext context, int index) {
                  return _buildStyles(context, index);
                }),
          ),
        )
      ],
    );
  }
}
