import 'package:flutter/material.dart';
import '../../../const/colors.dart';

class SchaduleCard extends StatelessWidget {
  final int startTime;
  final int endTime;
  final String content;

  const SchaduleCard({Key? key, required this.startTime, required this.endTime, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: kPrimaryColor, width: 1.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      // intrinsicHeight를 사용하면 child의 height를 자동으로 조절해줌
      child: IntrinsicHeight(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _Time(startTime: startTime, endTime: endTime),
              const SizedBox(width: 16.0),
              _Content(content: content),
              const SizedBox(width: 16.0),
            ],
          ),
        ),
      )
    );
  }
}


class _Time extends StatelessWidget {
  final int startTime;
  final int endTime;

  const _Time({Key? key, required this.startTime, required this.endTime}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    const textStyle = TextStyle(
      color: kPrimaryColor,
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${startTime.toString().padLeft(2,'0')}:00',
          style: textStyle,
        ),
        const SizedBox(height: 4.0),
        Text(
          '${endTime.toString().padLeft(2,'0')}:00',
          style: textStyle.copyWith(
            fontSize: 10.0,
          )
        ),
      ],
    );
  }
}

class _Content extends StatelessWidget {
  final String content;

  const _Content({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text(content),
    );
  }
}

