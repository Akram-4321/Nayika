import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/src/widgets/container.dart';
//import 'package:flutter/src/widgets/framework.dart';
import 'package:nayika/utils/quotes.dart';
import 'package:nayika/widgets/home_widgets/safewebview.dart';

class CustomCarouel extends StatelessWidget {
  const CustomCarouel({super.key});

  void navigateToRoute(BuildContext context, Widget route) {
    Navigator.push(context, CupertinoPageRoute(builder: (builder) => route));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CarouselSlider(
        options: CarouselOptions(
          aspectRatio: 2.0,
          autoPlay: true,
          enlargeCenterPage: true,
        ),
        items: List.generate(
            imageSliders.length,
            (index) => Card(
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: InkWell(
                    onTap: () {
                      if (index == 0) {
                  navigateToRoute(
                      context,
                      SafeWebView(
                          url:
                              "https://www.educationworld.in/international-womens-day-2022-influential-indian-women-leaders/"));
                } else if (index == 1) {
                  navigateToRoute(
                      context,
                      SafeWebView(
                          url:
                              "https://plan-international.org/ending-violence/16-ways-end-violence-girls"));
                } else if (index == 2) {
                  navigateToRoute(
                      context,
                      SafeWebView(
                          url:
                              "https://www.indiatimes.com/trending/social-relevance/government-schemes-for-women-empowerment-534032.html"));
                } else if (index == 3) {
                  navigateToRoute(
                      context,
                      SafeWebView(
                          url:
                              "https://www.healthline.com/health/womens-health/self-defense-tips-escape"));
                } else if (index == 4){
                  navigateToRoute(
                      context,
                      SafeWebView(
                          url:
                              "https://www.indiatoday.in/education-today/gk-current-affairs/story/11-women-rights-india-312263-2016-03-08"));
                } else {
                  navigateToRoute(
                      context,
                      SafeWebView(
                          url:
                              "https://www.thebetterindia.com/143044/lesser-known-unique-handicrafts-handlooms-india-villages/"));
                }

                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                imageSliders[index],
                              ))),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(colors: [
                            Colors.black.withOpacity(0.5),
                            Colors.transparent,
                          ]),
                        ),
                        child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 8, left: 8),
                              child: Text(
                                articleTitle[index],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.05,
                                ),
                              ),
                            )),
                      ),
                    ),
                  ),
                )),
      ),
    );
  }
}
