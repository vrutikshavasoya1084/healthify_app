import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';

final List<String> videoUrls = [
  'https://www.youtube.com/watch?v=C4bofW53sO8',
  'https://www.youtube.com/watch?v=blbv5UTBCGg',
  'https://www.youtube.com/watch?v=MSdqEhO1egc',
];

String getYouTubeThumbnail(String url) {
  Uri uri = Uri.parse(url);
  String? videoId = uri.queryParameters["v"];
  return videoId != null
      ? "https://img.youtube.com/vi/$videoId/0.jpg"
      : "https://via.placeholder.com/400";
}

class VideoSuggestions extends StatefulWidget {
  const VideoSuggestions({Key? key}) : super(key: key);

  @override
  _VideoSuggestionsState createState() => _VideoSuggestionsState();
}

class _VideoSuggestionsState extends State<VideoSuggestions> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            autoPlay: true,
            height: 170,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          items: videoUrls.map((videoUrl) {
            String thumbnailUrl = getYouTubeThumbnail(videoUrl);
            return GestureDetector(
              onTap: () async {
                // if (await canLaunchUrl(Uri.parse(videoUrl))) {
                  await launchUrl(Uri.parse(videoUrl));
                // }
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Container(
                  width: 400,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black45.withOpacity(0.1),
                        offset: const Offset(0, 0),
                        blurRadius: 10,
                      ),
                    ],
                    image: DecorationImage(
                      image: NetworkImage(thumbnailUrl), // Use thumbnail
                      fit: BoxFit.cover,
                    ),
                    color: Colors.deepPurple[200],
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(55),
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      const SizedBox(height: 115),
                      Container(
                        height: 55,
                        width: 400,
                        decoration: const BoxDecoration(
                          color: Colors.black38,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                        ),
                        child: Row(
                          children: <Widget>[
                            const SizedBox(width: 10),
                            const Icon(
                              Icons.alarm,
                              size: 20,
                              color: Colors.white,
                            ),
                            const Text(
                              " 15 min",
                              style: TextStyle(color: Colors.white),
                            ),
                            const SizedBox(width: 100),
                            Container(
                              height: 45,
                              width: 45,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                BorderRadius.all(Radius.circular(50)),
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.play_arrow,
                                  size: 30,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: videoUrls.map((urlOfItem) {
            int index = videoUrls.indexOf(urlOfItem);
            return Container(
              width: 10.0,
              height: 10.0,
              margin: const EdgeInsets.symmetric(
                  vertical: 10.0, horizontal: 2.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentIndex == index
                    ? const Color.fromRGBO(0, 0, 0, 0.8)
                    : const Color.fromRGBO(0, 0, 0, 0.3),
              ),
            );
          }).toList(),
        )
      ],
    );
  }
}
