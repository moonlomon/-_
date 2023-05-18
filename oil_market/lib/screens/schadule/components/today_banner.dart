import 'package:flutter/material.dart';
import '../../../const/colors.dart';

class TodayBanner extends StatelessWidget {
  final DateTime selectedDate;
  final int count;

  const TodayBanner({Key? key, required this.selectedDate, required this.count}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w600,
    );

    return Container(
      decoration: const BoxDecoration(
        color: kPrimaryColor
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${selectedDate.year}년 ${selectedDate.month}월 ${selectedDate.day}일',
              style: textStyle,
            ),
            Text(
              '$count개',
              style: textStyle,
            )
          ]
        )
      ),
    );
  }
}
