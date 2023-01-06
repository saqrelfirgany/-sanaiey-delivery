import 'package:get/get.dart';

enum PackageStage { Normal, ERROR, LOADING, DONE }

class PackagesController extends GetxController {
  int _index = 0;

  get index => _index;

  void changePackRowIndex({required int i}) {
    _index = i;
    update();
  }

  void changeDepPackRowIndexWithoutUpdate({required int i}) {
    _index = i;
  }

  List<String> packagesRow = [
    'باقة 1',
    'باقة 2',
    'باقة 3',
    'باقة 4',
    'باقة 5',
  ];
}
