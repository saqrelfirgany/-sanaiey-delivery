import 'package:get/get.dart';
import 'package:sanaiey/Helper/dio_helper.dart';
import 'package:sanaiey/Models/MianModels/fav_model.dart';
import 'package:sanaiey/Models/SubModel/EmployeeFavModel.dart';

enum FavStage { Normal, ERROR, LOADING, DONE }

class FavController extends GetxController {
  FavStage favStage = FavStage.Normal;

  Future<void> getData() async {
    favStage = FavStage.LOADING;

    await getFavList();

    favStage = FavStage.DONE;
    update();
  }

  Future<void> addToFav({required String serviceId}) async {
    dynamic response = await DioHelper.post(url: '/Service/FavouriteSwitch?serviceId=$serviceId');
    if (response == null || response == false) {
      return;
    } else {}
  }

  ///
  /// Home Slider
  ///
  List<FavModel> _favList = [];

  List<FavModel> get favList => _favList;

  void removeFromFavList({required int index}) {
    _favList.removeAt(index);
    update();
  }

  Future<void> getFavList() async {
    dynamic response = await DioHelper.get(url: '/Service/GetFavouriteList');
    if (response == null || response == false) {
      return;
    } else {
      if (response['data'] == null) return;
      List<dynamic> dynamicList = response['data'];
      _favList.clear();
      for (var element in dynamicList) {
        _favList.add(FavModel.fromJson(element));
      }
    }
    update();
  }

  List<EmployeeModel> _favEmployeeList = [];

  List<EmployeeModel> get favEmployeeList => _favEmployeeList;

  void removeFromFavEmployeeList({required int index}) {
    _favEmployeeList.removeAt(index);
    update();
  }

  Future<void> getFavEmployeeList() async {
    dynamic response = await DioHelper.get(url: 'employee/GetFavouriteList');
    if (response == null || response == false) {
      return;
    } else {
      if (response['data'] == null) return;
      List<dynamic> dynamicList = response['data'];
      _favEmployeeList.clear();
      for (var element in dynamicList) {
        _favEmployeeList.add(EmployeeModel.fromJson(element));
      }
    }
    update();
  }

  Future<void> addEmployeeToFav({required String employeeId}) async {
    dynamic response = await DioHelper.post(url: 'employee/FavouriteSwitch?employeeId=$employeeId');
    if (response == null || response == false) {
      return;
    } else {}
  }
}
