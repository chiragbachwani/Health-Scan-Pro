import '../const/const.dart';

Widget applogoWidget() {
  return Image.asset(
    'assets/images/logo.png',
    width: 250,
  ).box.padding(const EdgeInsets.all(8)).size(250, 250).make();
}
