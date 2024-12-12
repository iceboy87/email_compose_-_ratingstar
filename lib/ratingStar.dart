import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:sizer/sizer.dart';

class RatingScreen extends StatefulWidget {
  @override
  _RatingScreenState createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  double _rating = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rating Star Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onHorizontalDragUpdate: (details) {
                setState(() {
                  double dragValue = (details.localPosition.dx / 40).clamp(0, 5);
                  _rating = dragValue;
                });
              },
              child: RatingStars(
                starOffColor: Colors.grey,
                axis: Axis.horizontal,
                value: _rating,
                onValueChanged: (rating) {
                  setState(() {
                    _rating = rating;
                  });
                },
                starCount: 5,
                starSize: 30.sp,
                starColor: Colors.yellow,
                starSpacing: 1.5.w,
                starBuilder: (index, color) => Icon(
                  Icons.star,
                  color: color,
                  size: 30.sp,
                ),
                valueLabelVisibility: false,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              'Your Rating: ${_rating.toStringAsFixed(1)}',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
