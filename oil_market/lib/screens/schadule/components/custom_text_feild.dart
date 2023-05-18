import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../const/colors.dart';

class CustumTextFeild extends StatelessWidget {

  final String label;
  final bool isTime;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;

  const CustumTextFeild({Key? key, required this.label, required this.isTime, required this.onSaved, required this.validator}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
              color: kPrimaryColor,
              fontWeight: FontWeight.w500
          ),
        ),
        Expanded(
          // 내용 텍스트상자의 경우 공간을 최대로 채움
          flex: isTime ? 0 : 1,
          child: TextFormField(
            onSaved: onSaved,
            validator: validator,
            // 숫자상자 => 최대 한줄
            maxLines: isTime ? 1 : null,
            // 숫자상자 => 확장적용 x
            expands: !isTime,
            // 숫자상자 => 숫자키보드, 문자상자 => 일반키보드
            keyboardType: isTime ? TextInputType.number : TextInputType.multiline,
            // 숫자상자 => 숫자상자의 입력가능 텍스트 : 숫자텍스트 1개, 문자상자 : 입력제한 없음.
            inputFormatters: isTime ? [FilteringTextInputFormatter.digitsOnly] : [],
            decoration: InputDecoration(
              border: InputBorder.none,
              filled: true,
              fillColor: Colors.grey[300],
              // 숫자상자 => 접미사 '시'추가
              suffix: isTime ? const Text("시") : null
            ),
          ),
        )
      ],
    );
  }
}