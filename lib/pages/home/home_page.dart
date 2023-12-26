import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:reka/news/components/news_card.dart';
import 'package:getwidget/getwidget.dart';

import '../../news/model/news_model.dart';
import 'package:reka/widget/grundg.dart';

class HomeScren extends StatefulWidget {
  HomeScren({super.key});

  @override
  State<HomeScren> createState() => _HomeScrenState();
}

class _HomeScrenState extends State<HomeScren> {
  late bool isDataLoading;

  void initState() {
    super.initState();
    if (NewsData.breakingNewsData.isEmpty) {
      setState(() {
        isDataLoading = true;
      });
    } else {
      setState(() {
        isDataLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return grundg(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const GFTypography(
                text: "News",
                type: GFTypographyType.typo1,
              ),
              const SizedBox(
                height: 20,
              ),

//               //let's build our caroussel

              CarouselSlider.builder(
                  itemCount: NewsData.breakingNewsData.length,
                  itemBuilder: (context, index, id) =>
                      BreakingNewsCard(NewsData.breakingNewsData[index]),
                  options: CarouselOptions(
                    aspectRatio: 16 / 9,
                    enableInfiniteScroll: true,
                    enlargeCenterPage: true,
                  )),

              const SizedBox(
                height: 40.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
