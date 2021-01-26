import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class GalleryFullScreen extends StatefulWidget {
  final List imageSlider;
  final int position;

  GalleryFullScreen(this.imageSlider, this.position);

  @override
  _GalleryFullScreenState createState() => _GalleryFullScreenState();
}

class _GalleryFullScreenState extends State<GalleryFullScreen> {
  CarouselController buttonCarouselController = CarouselController();

  int currentPosition;

  @override
  void initState() {
    currentPosition = widget.position;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _exit(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            title: Text(
                "تصویر ${currentPosition + 1} از ${widget.imageSlider.length}",
                style: TextStyle(
                    fontSize: 14, color: Colors.white, fontFamily: 'yekan')),
            centerTitle: true,
            elevation: 8.0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => {Navigator.of(context).pop()},
            )),
        body: Center(
          child: CarouselSlider.builder(
            carouselController: buttonCarouselController,
            options: CarouselOptions(
              autoPlay: false,
              enlargeCenterPage: true,
              viewportFraction: 1,
              aspectRatio: 2.0,
              initialPage: currentPosition,
              onPageChanged: (index, reason) {
                setState(() {
                  currentPosition = index;
                });
              },
            ),
            itemCount: widget.imageSlider.length,
            itemBuilder: (context, index) {
              return Hero(
                  tag: widget.imageSlider,
                  child: Image.network(
                      "BASE_URL" + widget.imageSlider[index],
                      fit: BoxFit.cover,
                      height: double.infinity,
                      width: double.infinity,
                      alignment: Alignment.center));
            },
          ),
        ),
      ),
    );
  }

  Future<bool> _exit() async {
    Navigator.of(context).pop();
    return false;
  }
}
