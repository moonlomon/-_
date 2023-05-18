## 오류
-  Running Gradle task 'bundleRelease'...
FAILURE: Build completed with 2 failures.
1: Task failed with an exception. 
> 앱 아이콘(android/app/src/main/res/mipmap...)의 이름이 ic_launcher.png가 아님

- Unable to find git in your PATH.
1. 환경변수에 git 추가하기(bin, cmd, 그 외 다 추가해보기)
2. cmd터미널을 직접 열어 코드 입력하기
   build app bundle을 해야하는경우 => flutter build appbundle 입력
   pub get을 해야하는 경우 => dart pub get
   > 안될경우
   flutter clean
   flutter pub get
   flutter run
   flutter clean
   flutter pub cache repair
   flutter run

- g.dart 파일 생성 안됨
> dependencies구간이 아닌 dev_dependencies에 패키지 설치

- fluuter device daemon crach
> sdk를 다시 다운받는다