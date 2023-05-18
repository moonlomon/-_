import 'package:flutter/material.dart';
import '../../../const/colors.dart';
import 'custom_text_feild.dart';
import 'package:drift/drift.dart' hide Column; // material.dart패키지의 Column 클래스와 이름이 겹침
import 'package:get_it/get_it.dart';
import 'package:oil_market/datebase/drift_database.dart';

class ScheduleBottomSheet extends StatefulWidget {
  final DateTime selectedDate;

  const ScheduleBottomSheet({Key? key, required this.selectedDate}) : super(key: key);

  @override
  State<ScheduleBottomSheet> createState() => _ScheduleBottomSheetState();
}

class _ScheduleBottomSheetState extends State<ScheduleBottomSheet> {
  final GlobalKey<FormState> formKey = GlobalKey();
  int? startTime;
  int? endTime;
  String? content;


  @override
  Widget build(BuildContext context) {

    // viewInsets.bottom : 시스템 하단의 크기 = 키보드 올라오는 크기
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Form( // Form 내부에 있는 모든 TextFormField를 일괄조작함
      key: formKey, // Form을 조작할 키값
      child: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height / 2 + bottomInset,
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.only(left: 8, right: 8, top: 8, bottom: bottomInset),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(child: CustumTextFeild(
                        label: '시작시간',
                        isTime: true,
                        onSaved: (String? val) {
                          startTime = int.parse(val!);
                        },
                        validator: timeValidator,
                    )),
                    SizedBox(width: 16.0,),
                    Expanded(child: CustumTextFeild(
                        label: '종료시간',
                        isTime: true,
                        onSaved: (String? val) {
                          endTime = int.parse(val!);
                        },
                        validator: timeValidator,
                    )),
                  ],
                ),
                const SizedBox(height: 8.0,),
                Expanded(child: CustumTextFeild(
                  label: '내용',
                  isTime: false,
                  onSaved: (String? val) {
                    content = val;
                  },
                  validator: contentValidator,
                )),
                const SizedBox(height: 8.0,),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: onSavePressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimaryColor,
                    ),
                    child: Text('저장'),
                  ),
                )
              ],
            ),
          )
        ),
      ),
    );
  }

  void onSavePressed() async {
    if (formKey.currentState!.validate()){ // validator()에 입력된 함수를 실행하여 true/false 검증
      formKey.currentState!.save(); // onSaved()에 입력된 함수를 실행

      await GetIt.I<LocalDataBase>().createSchedule(
        SchedulesCompanion(
          startTime: Value(startTime!),
          endTime: Value(endTime!),
          content: Value(content!),
          date: Value(widget.selectedDate),
        )
      );

      // context.read<ScheduleProvider>().createSchedule(
      //     schedule: SchedulesModel(
      //       id: 'new_model',
      //       content: content!,
      //       date: widget.selectedDate,
      //       startTime: startTime!,
      //       endTime: endTime!,
      //     )
      // );

      Navigator.of(context).pop();
    }
  }

  String? timeValidator(String? val) {
    if (val == null) {
      return '값을 입력하세요!';
    }

    int? number;

    try {
      number = int.parse(val);
    } catch (e) {
      return '숫자를 입력하세요';
    }

    if (number < 0 || number > 24) {
      return '0시부터 24시 사이를 입력해주세요';
    }

    return null;
  }

  String? contentValidator(String? val) {
    if (val == null || val.length == 0) {
      return '값을 입력해주세요';
    }
    return null;
  }
}

