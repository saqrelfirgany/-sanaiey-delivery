import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/src/media_type.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sanaiey/Helper/dio_helper.dart';
import 'package:sanaiey/Helper/helper.dart';
import 'package:sanaiey/Models/MianModels/cart_model.dart';

import '../../Helper/route.dart';
import '../../screens/SharedComponents/Dialog/falier_alert.dart';
import '../../screens/SubScreens/SelectAddress/select_address.dart';
import '../../screens/SubScreens/cart_terms/cart_terms_screen.dart';

enum CartStage { Normal, ERROR, LOADING, DONE }

class CartController extends GetxController {
  CartStage cartStage = CartStage.Normal;

  Future<void> getCartData() async {
    cartStage = CartStage.LOADING;
    // update();
    await getCartImages();
    await getCart();
    cartStage = CartStage.DONE;
    update();
  }

  ///
  /// Home Slider
  ///
  CartModel _cartModel = CartModel();

  CartModel get cartModel => _cartModel;

  TextEditingController noteController = TextEditingController();
  TextEditingController couponController = TextEditingController();
  bool points = false;

  Future<void> getCart() async {
    cartStage = CartStage.LOADING;
    dynamic response = await DioHelper.get(url: '/cart/GetCustomAppCart');
    if (response == null || response == false) {
      return;
    } else {
      dynamic dynamicCart = response['data'];
      _cartModel = CartModel.fromJson(dynamicCart);
      noteController.text = await _cartModel.note ?? '';
      couponController.text = await _cartModel.promoCode ?? '';
      points = await _cartModel.usePoints ?? false;
      if (_cartModel.cartServiceDetails != null) {
        cartServiceQuantity = _cartModel.cartServiceDetails!.length;
      }
    }
    cartStage = CartStage.DONE;
    update();
  }

  CartStage validateCartStage = CartStage.Normal;

  Future<void> validateCart() async {
    validateCartStage = CartStage.LOADING;
    update();
    dynamic response = await DioHelper.get(url: '/Cart/ValidateCart');
    if (response == null || response == false) {
      return;
    } else {
      if (response['isSuccess'] == true) {
        fadNavigate(Get.context!, CartTermsScreen());
      } else {
        final errosString = response['data'].reduce((value, element) => value + ',' + element);
        FailureAlertDialog(body: errosString, context: Get.context);
      }
    }
    validateCartStage = CartStage.DONE;
    update();
  }

  List<AttachmentModel> _attachmentList = [];

  get attachmentList => _attachmentList;

  Future<void> getCartImages() async {
    // cartStage = CartStage.LOADING;
    dynamic response = await DioHelper.get(url: 'Attachment/GetCartAttachmentList');
    if (response == null || response == false) {
      return;
    } else {
      List<dynamic> dynamicList = response['data'];
      _attachmentList.clear();
      for (var element in dynamicList) {
        _attachmentList.add(AttachmentModel.fromJson(element));
      }
    }
    // cartStage = CartStage.DONE;
    update();
  }

  Future<bool> updateCartByDetailsId({required String detailsId, required String quantity}) async {
    dynamic response = await DioHelper.post(
      url: '/Cart/UpdateQuantity?detailsId=$detailsId&newQuantity=$quantity',
    );
    if (response == null || response == false) {
      return false;
    } else {
      if (response['statusCode'] == 0) {
        return false;
      }
      dynamic dynamicCart = response['data'];
      _cartModel = CartModel.fromJson(dynamicCart);
      update();
      return true;
    }
  }

  Future<bool> removeFromCartByDetailsId({required String detailsId}) async {
    dynamic response = await DioHelper.post(url: '/Cart/DeleteDetails/$detailsId');
    if (response == null || response == false) {
      return false;
    } else {
      if (response['statusCode'] == 0) {
        return false;
      }
      dynamic dynamicCart = response['data'];
      _cartModel = CartModel.fromJson(dynamicCart);
      if (_cartModel.cartServiceDetails != null) {
        cartServiceQuantity = _cartModel.cartServiceDetails!.length;
      }
      update();
      return true;
    }
  }

  Future<bool> updateNote({required String note}) async {
    dynamic response = await DioHelper.post(url: '/cart/UpdateNote?note=$note');
    if (response == null || response == false) {
      return false;
    } else {
      return true;
    }
  }

  bool pointsLoading = false;

  Future<bool> updatePoints() async {
    pointsLoading = true;
    update();
    dynamic response = await DioHelper.post(url: '/cart/ChangeUsePointStatus');
    if (response == null || response == false) {
      pointsLoading = false;
      update();
      return false;
    } else {
      dynamic dynamicCart = response['data'];
      _cartModel = CartModel.fromJson(dynamicCart);
      pointsLoading = false;
      update();
      return true;
    }
  }

  bool couponLoading = false;

  Future<bool> updateCode({required String code}) async {
    couponLoading = true;
    update();
    dynamic response = await DioHelper.post(url: '/cart/ApplyPromocode?promocode=$code');
    if (response == null || response == false) {
      couponLoading = false;
      update();
      return false;
    } else {
      if (response['statusCode'] == 0) {
        couponLoading = false;
        update();
        return false;
      }
      dynamic dynamicCart = response['data'];
      _cartModel = CartModel.fromJson(dynamicCart);
      couponLoading = false;
      update();
      return true;
    }
  }

  Future<bool> removeCode() async {
    dynamic response = await DioHelper.post(url: '/cart/CancelPromocode');
    if (response == null || response == false) {
      return false;
    } else {
      if (response['statusCode'] == 0) {
        return false;
      }
      dynamic dynamicCart = response['data'];
      _cartModel = CartModel.fromJson(dynamicCart);

      update();
      return true;
    }
  }

  int cartServiceQuantity = 0;
  int cartServicePrice = 0;

  Future<bool> updateCart({required String serviceId, required String quantity}) async {
    dynamic response = await DioHelper.post(
      url: '/Cart/AddUpdateService?serviceId=$serviceId&newQuantity=$quantity',
    );
    if (response == null || response == false) {
      // loading = false;
      // update();
      return false;
    } else {
      if (response['statusCode'] == 0) {
        // showToast(body: response['message']);
        return false;
      }

      dynamic dynamicCart = response['data'];
      _cartModel = CartModel.fromJson(dynamicCart);
      if (_cartModel.cartServiceDetails != null) {
        cartServiceQuantity = _cartModel.cartServiceDetails!.length;
      }
      update();
      // showToast(body: response['message']);
      return true;
    }
    return false;
  }

  Future<bool> removeServiceFromCart({required String serviceId}) async {
    dynamic response = await DioHelper.post(
      url: '/Cart/DeleteDetails/$serviceId',
    );
    if (response == null || response == false) {
      // loading = false;
      // update();
      return false;
    } else {
      if (response['statusCode'] == 0) {
        return false;
      }

      return true;
    }
    return false;
  }

  bool isDeletingImage = false;

  Future<bool> removeImage({required String id}) async {
    isDeletingImage = true;
    update();
    dynamic response = await DioHelper.post(
      url: 'attachment/delete/$id',
    );
    if (response == null || response == false) {
      Navigator.pop(Get.context!);
      isDeletingImage = false;
      update();
      // getCart();
      return false;
    } else {
      Navigator.pop(Get.context!);
      isDeletingImage = false;
      update();
      getCartImages();
      return true;
    }
  }

  bool isLoadingImage = false;

  final ImagePicker _picker = ImagePicker();

  Future<void> getImage(ImageSource source, BuildContext context, bool isOnePop) async {
    await ImagePicker.pickImage(source: source, maxWidth: 400.0, maxHeight: 800, imageQuality: 70)
        .then((image) async {
      if (image != null) {
        isLoadingImage = true;
        update();
        File x = File(image.path);
        String fileName = x.path.split('/').last;
        var request = http.MultipartRequest(
          "POST",
          Uri.parse("https://api.sane3ydelivery.com/test/api/Attachment/AttachImageToCart"),
        );
        var headers = {'Authorization': "Bearer ${Helper.token}"};
        //add headers
        request.headers.addAll(headers);
        var pic = await http.MultipartFile.fromPath(
          "file",
          x.path,
          filename: fileName,
          contentType: MediaType('image', 'jpeg'),
        );
        request.files.add(pic);
        var response = await request.send();
        if (response.statusCode == 200) {
          if (isOnePop) {
            Navigator.pop(context);
            getCartImages();
            isLoadingImage = false;
            update();
            return;
          }
          Navigator.pop(context);
          Navigator.pop(context);
          isLoadingImage = false;
          update();
          getCartImages();
        }
        // var formData = dio.FormData.fromMap(
        //   {
        //     'file': [
        //       await dio.MultipartFile.fromFile(
        //         x.path,
        //         filename: basename(x.path),
        //       )
        //     ],
        //   },
        // );
        // dynamic response = await DioHelper.post(
        //   url: 'Attachment/AttachImageToCart',
        //   data: formData,
        // );
        // if (response == null || response == false) {
        //   Navigator.pop(context);
        //   return false;
        // } else {
        //   Navigator.pop(context);
        // }
      }
    });
  }
}
