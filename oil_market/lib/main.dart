import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:oil_market/provider/schedule_provider.dart';
import 'package:oil_market/repository/schedule_repository.dart';
import 'package:oil_market/routes.dart';
import 'package:oil_market/screens/schadule/scadule_screen.dart';
import 'package:oil_market/screens/sign_in/sign_in_screen.dart';
import 'package:oil_market/theme.dart';
import 'package:provider/provider.dart';

import 'const/colors.dart';
import 'const/size_config.dart';
import 'datebase/drift_database.dart';

void main() async {

  // 플러터 프레임워크가 준비될 때까지 대기
  WidgetsFlutterBinding.ensureInitialized();

  // intl 패키지 초기화()
  await initializeDateFormatting();

  final database = LocalDataBase(); // 데이터베이스 생성

  GetIt.I.registerSingleton<LocalDataBase>(database); // GetIt에 데이터베이스 변수 주입하기 => 데이터베이스를 전역에서 언제든지 사용할 수 있음.

  // final repository = ScheduleRepository();
  // final scheduleProvider = ScheduleProvider(repository:repository);

  runApp(MyApp()
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context); // init 메서드 호출

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: theme(),
      // home: SplashScreen(),
      // We use routeName so that we dont need to remember the name
      initialRoute: SignInScreen.routeName,
      routes: routes,
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     debugShowCheckedModeBanner: false,
  //     theme: theme(),
  //       home: SignInScreen()
  //   );
  // }
}
