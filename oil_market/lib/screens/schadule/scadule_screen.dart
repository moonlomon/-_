// 외부라이브러리
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

// 내부파일
import '../../const/colors.dart';
import '../../datebase/drift_database.dart';
import '../../provider/schedule_provider.dart';
import 'components/main_calendar.dart';
import 'components/schadule_bottom_sheet.dart';
import 'components/schadule_card.dart';
import 'components/today_banner.dart';

class SchaduleScreen extends StatefulWidget {
  static String routeName = "/schadule";
  // ➊ StatelessWidget에서 StatefulWidget으로 전환
  const SchaduleScreen({Key? key}) : super(key: key);

  @override
  State<SchaduleScreen> createState() => _SchaduleScreenState();
}

class _SchaduleScreenState extends State<SchaduleScreen> {
  DateTime selectedDate = DateTime.utc(
    // ➋ 선택된 날짜를 관리할 변수
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        // ➊ 새 일정 버튼
        backgroundColor: kPrimaryColor,
        onPressed: () {
          showModalBottomSheet(
            // ➋ BottomSheet 열기
            context: context,
            isDismissible: true, // ➌ 배경 탭했을 때 BottomSheet 닫기
            isScrollControlled: true,
            builder: (_) => ScheduleBottomSheet(
              selectedDate: selectedDate, // 선택된 날짜 (selectedDate) 넘겨주기
            ),
          );
        },
        child: Icon(
          Icons.add,
        ),
      ),
      body: SafeArea(
        // 시스템 UI 피해서 UI 구현하기
        child: Column(
          // 달력과 리스트를 세로로 배치
          children: [
            MainCalendar(
              selectedDate: selectedDate, // 선택된 날짜 전달하기

              // 날짜가 선택됐을 때 실행할 함수
              onDaySelected: onDaySelected,
            ),
            SizedBox(height: 8.0),
            StreamBuilder<List<Schedule>>(
                stream: GetIt.I<LocalDataBase>().watchSchedules(selectedDate),
                builder: (context, snapshot) {
                  return TodayBanner(
                    selectedDate: selectedDate,
                    count: snapshot.data?.length ?? 0,
                  );
                }
            ),
            SizedBox(height: 8.0),
            Expanded(
              // ➊ 남는 공간을 모두 차지하기
              child: StreamBuilder<List<Schedule>>(
                // ➋ 일정 정보가 Stream으로 제공되기 때문에 StreamBuilder 사용
                stream: GetIt.I<LocalDataBase>().watchSchedules(selectedDate),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    // ➌ 데이터가 없을 때
                    return Container();
                  }

                  return ListView.builder(
                    // ➍ 화면에 보이는 값들만 렌더링하는 리스트
                    itemCount: snapshot.data!.length, // ➎ 리스트에 입력할 값들의 총 개수
                    itemBuilder: (context, index) {
                      final schedule =
                      snapshot.data![index]; // ➏ 현재 index에 해당되는 일정
                      return Dismissible(
                        key: ObjectKey(schedule.id),
                        // ➊ 유니크한 키값
                        direction: DismissDirection.startToEnd,
                        // ➋ 밀기 방향 (오른쪽에서 왼쪽으로)
                        onDismissed: (DismissDirection direction) {
                          // ➌ 밀기 했을 때 실행할 함수
                          GetIt.I<LocalDataBase>().removeSchedule(schedule.id);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              bottom: 8.0, left: 8.0, right: 8.0),
                          child: SchaduleCard(
                            startTime: schedule.startTime,
                            endTime: schedule.endTime,
                            content: schedule.content,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onDaySelected(DateTime selectedDate, DateTime focusedDate) {
    // ➌ 날짜 선택될 때마다 실행할 함수
    setState(() {
      this.selectedDate = selectedDate;
    });
  }
}




// class ScaduleScreen extends StatelessWidget {
//   const ScaduleScreen({Key? key}) : super(key: key);
//
//   void onDaySelected (
//       DateTime selectedDate,
//       DateTime focusedDate,
//       buildContext, context
//       ) {
//     final provider = context.read<ScheduleProvider>();
//     provider.changeSelectedDate(
//         date: selectedDate
//     );
//     provider.getSchedules(date:selectedDate);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     final provider = context.watch<ScheduleProvider>();
//     final selectedDate = provider.selectedDate;
//     final schedules = provider.cache[selectedDate] ?? [];
//
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: kPrimaryColor,
//         child: const Icon(Icons.add),
//         onPressed: () {
//           showModalBottomSheet(
//               context: context,
//               // 배경 클릭시 시트가 내려감
//               isDismissible: true,
//               builder: (_) => ScheduleBottomSheet(
//                 selectedDate: selectedDate,
//               ),
//               // bottomSheet의 높이를 고정(화면의 절반)에서 화면최대를 모두 사용할 수 있게 정의 -> 스크롤 가능
//               isScrollControlled: true);
//         },
//       ),
//       // SafeArea : 시스템이 맞게 UI를 맞춰줌
//       body: SafeArea(
//         child: Column(
//           children: [
//             MainCalendar(
//                 selectedDate: selectedDate,
//                 onDaySelected: (selectedDate, focusedDate) =>
//                     onDaySelected(selectedDate, focusedDate, context)
//             ),
//             const SizedBox(
//               height: 8.0,
//             ),
//             TodayBanner(
//               selectedDate: selectedDate,
//               count: schedules.length,
//             ),
//             const SizedBox(
//               height: 8.0,
//             ),
//             Expanded(
//               child: ListView.builder(
//                   itemCount: schedules.length,
//                   itemBuilder: (context, index) {
//                     final schedule = schedules[index];
//                     return Dismissible(
//                       // 밀어내기 삭제
//                       key: ObjectKey(schedule.id),
//                       direction: DismissDirection.startToEnd,
//                       onDismissed: (DismissDirection direction) {
//                         provider.deleteSchedule(date: selectedDate, id: schedule.id);
//                       },
//                       child: Padding(
//                         padding: const EdgeInsets.only(
//                             bottom: 8.0, left: 8.0, right: 8.0),
//                         child: SchaduleCard(
//                           startTime: schedule.startTime,
//                           endTime: schedule.endTime,
//                           content: schedule.content,
//                         ),
//                       ),
//                     );
//                   }),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }