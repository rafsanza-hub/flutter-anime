import 'package:flutter_anime/utils/colors.dart';
import 'package:movie_ui_design/utils/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  List<MovieModel> popularItems = List.of(popularImages);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                // Background Image
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.50,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        popularItems[0].imageAsset.toString(),
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  foregroundDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    gradient: LinearGradient(
                      colors: [
                        kBackgroundColor.withOpacity(0.8),
                        Colors.transparent,
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                ),

                // Detail Container
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Movie Title
                              Text(
                                "Dune",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 10),

                              // Movie Year & Director
                              Text(
                                "2021, Denis Villeneuve",
                                style: TextStyle(
                                  color: Colors.white38,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              // const SizedBox(height: 10),
                            ],
                          ),
                          // Ratings
                          Row(
                            children: [
                              Text(
                                "8.2",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Icon(
                                Icons.star_rate_rounded,
                                color: Colors.yellow,
                                size: 15,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildTag("Epic"),
                            SizedBox(
                              width: 10,
                            ),
                            _buildTag("Epic"),
                            SizedBox(
                              width: 10,
                            ),
                            _buildTag("Epic"),
                            SizedBox(
                              width: 10,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              child: ReadMoreText(
                                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed sit amet nulla auctor, vestib",
                                trimLines: 3,
                                trimMode: TrimMode.Line,
                                moreStyle: TextStyle(color: kButtonColor),
                                lessStyle: TextStyle(color: kButtonColor),
                                style: TextStyle(
                                  color: Colors.white70,
                                  height: 1.5,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            // ini listtile ubntuk episode
                          ])
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 60,
            right: 20,
            child: Container(
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: Colors.white70),
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.close_rounded,
                    size: 20,
                  )),
            ),
          ),
          // nonton anime
          Positioned(
            left: 30,
            right: 30,
            bottom: 30,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                color: kButtonColor,
                alignment: Alignment.center,
                height: 68,
                child: Text(
                  "Nonton Anime",
                  style: TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String title) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      decoration: BoxDecoration(
        color: kSearchbarColor,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white30,
          fontSize: 16,
        ),
      ),
    );
  }
}
