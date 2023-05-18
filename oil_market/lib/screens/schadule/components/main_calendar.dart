import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../const/colors.dart';

class MainCalendar extends StatelessWidget {
  final OnDaySelected onDaySelected;
  final DateTime selectedDate;

  const MainCalendar({Key? key,
    required this.onDaySelected,
    required this.selectedDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      // 한국어로 언어설정
      // locale: 'ko_kr',
      // 날짜 선택 시 발v생되는 함수(콜백 함수)를 정의
      onDaySelected: onDaySelected,
      // 선택한 날짜를 selectedDate로 정의, 날짜별 선택여부를 구분해 달력에 표시
      selectedDayPredicate: (date) =>
          date.year == selectedDate.year &&
          date.month == selectedDate.month &&
          date.day == selectedDate.day,
      firstDay: DateTime(1900, 1, 1),
      lastDay: DateTime(2999, 12, 31),
      // focusedDay를 선택한 날짜로 설정(DateTime.now -> selectedDate)
      // 이렇게 하면 선택한 날짜에 해당하는 달로 화면이 자동 전환되지 않음
      focusedDay: selectedDate,
      headerStyle: const HeaderStyle(
        titleCentered: true,
        formatButtonVisible: false,
        titleTextStyle: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w700,
        )
      ),
      calendarStyle: CalendarStyle(
        isTodayHighlighted: false,
        defaultDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: kLIGHT_GREY_COLOR
        ),
        weekendDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: kLIGHT_GREY_COLOR
        ),
        selectedDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: kPrimaryColor, width: 2.0),
        ),
        defaultTextStyle: TextStyle(
          fontWeight: FontWeight.w600,
          color: kDARK_GREY_COLOR
        ),
        weekendTextStyle: TextStyle(
          fontWeight: FontWeight.w600,
          color: kDARK_GREY_COLOR
        ),
        selectedTextStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          color: kPrimaryColor
        ),
      ),
    );
  }
}