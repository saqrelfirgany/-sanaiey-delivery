import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sanaiey/Helper/decoration_helper.dart';
import 'package:sanaiey/Helper/fonts_helper.dart';
import 'package:sanaiey/Helper/route.dart';
import 'package:sanaiey/Models/SubModel/phone_model.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/controllers/MainControllers/department_controller.dart';
import 'package:sanaiey/controllers/MainControllers/order_controller.dart';
import 'package:sanaiey/controllers/SubControllers/user_controller.dart';
import 'package:sanaiey/screens/SharedComponents/AppBar/back_app_bar.dart';
import 'package:sanaiey/screens/SharedComponents/Dialog/aap_dialog.dart';
import 'package:sanaiey/screens/SharedComponents/Dialog/app_dialog.dart';
import 'package:sanaiey/screens/SharedComponents/getsnack_bars.dart';
import 'package:sanaiey/screens/SharedComponents/loaders/reload.dart';
import 'package:sanaiey/screens/SharedComponents/loaders/screen_loader.dart';
import 'package:sanaiey/screens/SubScreens/ChooseDateScreen/time_screen.dart';
import 'package:sanaiey/screens/SubScreens/EditAddress/edit_address.dart';
import 'package:sanaiey/screens/SubScreens/ProfileScreen/body/profile_dialog.dart';
import 'package:sanaiey/screens/SubScreens/ProfileScreen/profile_screen.dart';

class SelectAddress extends StatefulWidget {
  const SelectAddress({Key? key}) : super(key: key);

  @override
  State<SelectAddress> createState() => _SelectAddressState();
}

class _SelectAddressState extends State<SelectAddress> {
  late UserController userController;
  late OrderController orderController;
  Completer<GoogleMapController> _mapController = Completer();
  late GoogleMapController mapController;

  Geolocator geoLocator = Geolocator()
    ..checkGeolocationPermissionStatus(
      locationPermission: GeolocationPermission.location,
    ).then((value) {});

  MapType _currentMapType = MapType.normal;
  final Set<Marker> _markers = {};
  late LatLng _center;
  late LatLng _lastMapPosition;
  String initialAddress = "";
  var lat, lng;
  var country;
  var street;
  var areaName;
  var city;
  bool isLoadingLocation = true;

  @override
  void initState() {
    super.initState();
    // openLocation();
    _mapCreated = false;
    getUserAddress();
    orderController = Get.find<OrderController>();
    // _checkGps();
    print('here222222');
    Geolocator().checkGeolocationPermissionStatus(
      locationPermission: GeolocationPermission.location,
    );
    getDefaultData();
    locateUser();
  }

  Future<void> getUserAddress() async {
    await Get.find<UserController>().getUserAddress();
  }

  Future _checkGps() async {
    if (!(await Geolocator().isLocationServiceEnabled())) {
      if (Theme.of(context).platform == TargetPlatform.android) {
        AppDialog(context: context);
      }
    }
  }

  void _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal ? MapType.satellite : MapType.normal;
    });
  }

  TextEditingController _addressController = TextEditingController();

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
    _changeLatLang(_lastMapPosition);
  }

  bool _mapCreated = false;

  void _onMapCreated(GoogleMapController controller) {
    _mapCreated = true;
    mapController = controller;
    mapController.animateCamera(
      CameraUpdate.newLatLngZoom(
        _center,
        15.0,
      ),
    );
    if (!_mapController.isCompleted) {
      //first calling is false
      //call "completer()"
      _mapController.complete(controller);
    } else {
      //other calling, later is true,
      //don't call again completer()
    }
  }

  Future<dynamic> locations(lat, long) async {
    // final coordinates = new Coordinates(lat, long);
    // var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var addresses;
    try {
      addresses = await Geolocator().placemarkFromCoordinates(lat, long);
      Placemark first = addresses.first;
      setState(() {
        country = first.country;
        areaName = first.name;
        city = first.administrativeArea;
        // areaName=first.city;
        street = first.thoroughfare;
        initialAddress = "$country - $areaName - $city - $street ";
        _addressController.text = "$country - $areaName - $city - $street ";
        print("initialAddress $initialAddress");
      });
    } catch (e) {
      setState(() {
        country = null;
        areaName = null;
        street = null;
        city = null;
        _markers.clear();
        LatLng center = LatLng(lat, long);
        if (country != null && areaName != null && street != null && city != null) {
          _markers.add(Marker(
            // This marker id can be anything that uniquely identifies each marker.
            markerId: MarkerId(_lastMapPosition.toString()),
            position: center,
            icon: BitmapDescriptor.defaultMarker,
            // infoWindow: InfoWindow(title: '$country , $areaName , $street',snippet: "${AppLocalizations.of(context).trans('deliverToThisPlace')}"),
          ));
        }

        if (country == null && areaName == null && street == null && city == null) {
          locations(lat, long);
        }
      });
    }
  }

  Future<Position> locateUser() {
    setState(() {
      isLoadingLocation = true;
    });

    return Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((location) {
      if (location != null) {
        setState(() {
          // _center = LatLng(location.latitude, location.longitude);
          _lastMapPosition = _center;
          lat = _lastMapPosition.latitude;
          lng = _lastMapPosition.longitude;
          _markers.add(Marker(
            // This marker id can be anything that uniquely identifies each marker.
            markerId: MarkerId(_lastMapPosition.toString()),
            position: _lastMapPosition,
            icon: BitmapDescriptor.defaultMarker,
            // infoWindow: InfoWindow(title: '$country , $areaName , $street',snippet: "${AppLocalizations.of(context).trans('deliverToThisPlace')}"),
          ));
          if (country == null && areaName == null && street == null && city == null) {
            locations(lat, lng);
            print(initialAddress);
          }
          isLoadingLocation = false;
        });
      }
      return location;
    });
  }

  void _onCameraClick(LatLng argument) {
    _lastMapPosition = argument;

    _changeLatLang(_lastMapPosition);
  }

  void _changeLatLang(_lastMapPosition) {
    setState(() {
      _markers.clear();
      // if (country!=null && areaName!=null && street!=null){
      _markers.add(Marker(
        // This marker id can be anything that uniquely identifies each marker.
        onTap: () {},
        markerId: MarkerId(_lastMapPosition.toString()),
        position: _lastMapPosition,
        icon: BitmapDescriptor.defaultMarker,
        // infoWindow: InfoWindow(title: '$country , $areaName , $street',snippet: "${AppLocalizations.of(context).trans('deliverToThisPlace')}"),
      ));
      // }
      lat = _lastMapPosition.latitude;
      lng = _lastMapPosition.longitude;
      print("lat $lat");
      print("lng $lng");
    });
  }

  _onCameraMovementEnd() {
    locations(lat, lng);
  }

  List<bool> isSelected = [false, false, false];
  int _mobileIndex = -1;
  int _addressIndex = -1;
  bool _addressFlag = false;
  late UserController _userController;

  void getDefaultData() {
    _mobileIndex = -1;
    _addressIndex = -1;
    _userController = Get.find<UserController>();
    if (_userController.addressList[0].isDefault ?? false) {
      _addressIndex = 0;
      print('_addressIndex$_addressIndex');
      lat = _userController.addressList[0].latitude ?? '0';
      lng = _userController.addressList[0].longitude ?? '0';
      _center = LatLng(
        double.parse(
          lat,
        ),
        double.parse(
          lng,
        ),
      );
    } else {
      for (var element in _userController.addressList) {
        if (element.isDefault) {
          _addressIndex++;
          orderController.setAddressId(id: '${element.addressId}');
          lat = element.latitude ?? '0';
          lng = element.longitude ?? '0';
          _center = LatLng(
            double.parse(
              lat,
            ),
            double.parse(
              lng,
            ),
          );
          break;
        }
        _addressIndex++;
        print('_addressIndex$_addressIndex');
      }
    }

    if (_userController.phoneList[0].isDefault ?? false) {
      _mobileIndex = 0;
      print('mobile index$_mobileIndex');
    } else {
      for (var element in _userController.phoneList) {
        if (element.isDefault ?? false) {
          _mobileIndex++;
          orderController.setPhoneId(id: '${element.clientPhoneId}');
          break;
        }
        _mobileIndex++;
        print('mobile index$_mobileIndex');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      extendBody: true,
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            BackAppBar(title: 'اختيار البيانات'),
            // SizedBox(height: 40),
            Container(
              width: 414.w,
              height: 600.h,
              child: GetBuilder<DepartmentController>(
                builder: (controller) => controller.departmentStage == DepartmentStage.LOADING
                    ? const ScreenLoader()
                    : Reload(
                        load: () async {
                          // await getData();
                        },
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              height: 590.h,
                              child: Stack(
                                children: [
                                  isLoadingLocation == true
                                      ? Center(
                                          child: SpinKitWave(
                                            size: 35,
                                            color: mainColor,
                                          ),
                                        )
                                      : Container(
                                          width: 414.w,
                                          height: 200.h,
                                          child: GoogleMap(
                                            gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                                              Factory<OneSequenceGestureRecognizer>(
                                                () => EagerGestureRecognizer(),
                                              ),
                                            },
                                            onMapCreated: _onMapCreated,
                                            initialCameraPosition: CameraPosition(
                                              target: _center,
                                              zoom: 15.0,
                                            ),
                                            onTap: (argument) {
                                              _onCameraClick(argument);
                                            },
                                            myLocationButtonEnabled: true,
                                            myLocationEnabled: true,

                                            mapType: _currentMapType,
                                            markers: _markers,
                                            // onCameraMove: _onCameraMove,
                                            onCameraIdle: _onCameraMovementEnd,
                                            padding: EdgeInsets.only(bottom: 18.h),
                                          ),
                                        ),
                                  PositionedDirectional(
                                    top: 190.h,
                                    child: Container(
                                      width: 414.w,
                                      height: 46.h,
                                      padding: EdgeInsets.only(top: 8.h),
                                      decoration: BoxDecoration(
                                        color: Color(0xFF00385B),
                                        borderRadius: BorderRadiusDirectional.only(
                                          topStart: Radius.circular(30.r),
                                          topEnd: Radius.circular(30.r),
                                        ),
                                      ),
                                      child: Align(
                                        alignment: Alignment.topCenter,
                                        child: Text(
                                          'تحديد الموقع يدوي',
                                          style: titleNormal(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                  PositionedDirectional(
                                    top: 250.h,
                                    child: Container(
                                      width: 414.w,
                                      height: 560.h,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadiusDirectional.only(
                                          topStart: Radius.circular(30.r),
                                          topEnd: Radius.circular(30.r),
                                        ),
                                      ),
                                      child: SingleChildScrollView(
                                        physics: BouncingScrollPhysics(),
                                        child: GetBuilder<UserController>(
                                          builder: (userController) => userController.userStage ==
                                                  UserStage.LOADING
                                              ? const ScreenLoader()
                                              : Container(
                                                  padding: EdgeInsets.all(16.w),
                                                  margin: EdgeInsets.only(bottom: 120.h),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      SizedBox(height: 8.h),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Text(
                                                            'العناوين',
                                                            style:
                                                                titleNormal(color: Colors.black, size: 18),
                                                          ),
                                                          InkWell(
                                                            onTap: () {
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      ProfileScreen(isReverse: true),
                                                                ),
                                                              ).then((_) {
                                                                if (_mapCreated) {
                                                                  mapController.animateCamera(
                                                                    CameraUpdate.newLatLngZoom(
                                                                      LatLng(
                                                                        double.parse(
                                                                          '${userController.addressList[_addressIndex].latitude}',
                                                                        ),
                                                                        double.parse(
                                                                          '${userController.addressList[_addressIndex].longitude}',
                                                                        ),
                                                                      ),
                                                                      15.0,
                                                                    ),
                                                                  );
                                                                  setState(() {
                                                                    _markers.clear();
                                                                    // if (country!=null && areaName!=null && street!=null){
                                                                    _markers.add(Marker(
                                                                      // This marker id can be anything that uniquely identifies each marker.
                                                                      onTap: () {},
                                                                      markerId: MarkerId(
                                                                          _lastMapPosition.toString()),
                                                                      position: LatLng(
                                                                        double.parse(
                                                                          '${userController.addressList[_addressIndex].latitude}',
                                                                        ),
                                                                        double.parse(
                                                                          '${userController.addressList[_addressIndex].longitude}',
                                                                        ),
                                                                      ),
                                                                      icon: BitmapDescriptor.defaultMarker,
                                                                      // infoWindow: InfoWindow(title: '$country , $areaName , $street',snippet: "${AppLocalizations.of(context).trans('deliverToThisPlace')}"),
                                                                    ));
                                                                  });
                                                                }
                                                              });
                                                            },
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              crossAxisAlignment: CrossAxisAlignment.end,
                                                              children: [
                                                                Text(
                                                                  'اضافة عنوان',
                                                                  style: titleNormal(
                                                                      color: Colors.black, size: 16),
                                                                ),
                                                                SizedBox(width: 6.w),
                                                                const Icon(CupertinoIcons.arrow_left_circle)
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(height: 8.h),

                                                      ///
                                                      /// Address List
                                                      ///
                                                      AddressList(userController),
                                                      SizedBox(height: 8.h),
                                                      Divider(thickness: 2, color: mainColor),
                                                      SizedBox(height: 8.h),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Text(
                                                            'ارقام الهاتف',
                                                            style: titleNormal(color: Colors.black),
                                                          ),
                                                          InkWell(
                                                            onTap: () {
                                                              Get.find<UserController>()
                                                                  .setPhone(phone: PhoneModel());
                                                              ProfileDialog(
                                                                context: context,
                                                                controller: userController.phoneController,
                                                                press: () => userController.addPhone(),
                                                                title: 'اضافة رقم',
                                                              );
                                                            },
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              crossAxisAlignment: CrossAxisAlignment.end,
                                                              children: [
                                                                Text(
                                                                  'اضافة رقم جديد',
                                                                  style: titleNormal(
                                                                      color: Colors.black, size: 16),
                                                                ),
                                                                SizedBox(width: 6.w),
                                                                const Icon(CupertinoIcons.add_circled)
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(height: 8.h),

                                                      ///
                                                      /// Phone List
                                                      ///
                                                      phoneList(userController),
                                                      SizedBox(height: 140.h),
                                                    ],
                                                  ),
                                                ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          if (_addressIndex == -1) {
            showError(body: 'برجاء تحديد الماكان');
            return;
          }
          if (_mobileIndex == -1) {
            showError(body: 'برجاء اختيار رقم الهاتف');
            return;
          }
          fadNavigate(context, TimeScreen());
          // Get.to(() => TimeScreen());
        },
        child: Container(
          width: double.infinity,
          height: 50.h,
          margin: EdgeInsets.all(16.w),
          decoration: decorationRadius().copyWith(
            color: const Color(0xFFAE0910),
          ),
          child: Center(
            child: Text(
              'متابعة الطلب',
              style: titleNormal(color: Colors.white, size: 18),
            ),
          ),
        ),
      ),
    );
  }

  SizedBox phoneList(UserController userController) {
    return SizedBox(
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemCount: userController.phoneList.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              setState(() {
                _mobileIndex = index;
              });
              orderController.setPhoneId(id: '${userController.phoneList[index].clientPhoneId}');
            },
            child: Container(
              width: double.infinity,
              height: 48.h,
              decoration: decorationDoubleRadiusBorder(
                color: _mobileIndex == index ? mainColor : Color(0xFFDFDFDF),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              margin: EdgeInsetsDirectional.only(bottom: 8.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(CupertinoIcons.phone),
                          SizedBox(width: 8.w),
                          Text(
                            '${userController.phoneList[index].clientPhone}',
                            style: titleNormal(color: Colors.black),
                            maxLines: 1,
                          ),
                        ],
                      ),
                      _mobileIndex == index
                          ? Container(
                              width: 22.w,
                              height: 22.w,
                              // padding: EdgeInsets.all(8.w),
                              decoration: BoxDecoration(
                                color: mainColor,
                                border: Border.all(width: 1, color: mainColor),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.done,
                                  color: Colors.white,
                                  size: 12.w,
                                ),
                              ),
                            )
                          : Container(
                              width: 22.w,
                              height: 22.w,
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                // color: Colors.grey,
                                border: Border.all(width: 1, color: mainColor),
                                shape: BoxShape.circle,
                              ),
                            ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  SizedBox AddressList(UserController userController) {
    return SizedBox(
      // height: 300.h,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemCount: userController.addressList.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return Row(
            children: [
              Expanded(
                flex: 12,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    // setState(() {
                    //   _addressIndex = index;
                    //   _addressFlag = true;
                    // });
                    // if (_mapCreated) {
                    //   mapController.animateCamera(
                    //     CameraUpdate.newLatLngZoom(
                    //       LatLng(
                    //         double.parse(
                    //           '${userController.addressList[index].latitude}',
                    //         ),
                    //         double.parse(
                    //           '${userController.addressList[index].longitude}',
                    //         ),
                    //       ),
                    //       15.0,
                    //     ),
                    //   );
                    //   setState(() {
                    //     _markers.clear();
                    //     // if (country!=null && areaName!=null && street!=null){
                    //     _markers.add(Marker(
                    //       // This marker id can be anything that uniquely identifies each marker.
                    //       onTap: () {},
                    //       markerId: MarkerId(_lastMapPosition.toString()),
                    //       position: LatLng(
                    //         double.parse(
                    //           '${userController.addressList[index].latitude}',
                    //         ),
                    //         double.parse(
                    //           '${userController.addressList[index].longitude}',
                    //         ),
                    //       ),
                    //       icon: BitmapDescriptor.defaultMarker,
                    //       // infoWindow: InfoWindow(title: '$country , $areaName , $street',snippet: "${AppLocalizations.of(context).trans('deliverToThisPlace')}"),
                    //     ));
                    //   });
                    // }
                    userController.changeAddress(changeAddress: userController.addressList[index]);
                    userController.updateDefaultAddress(popFlag: false).then((value) {});
                    AppDialog2(context: Get.context!, text: '${userController.changeCartAddressMessage}');
                    orderController.setAddressId(id: '${userController.addressList[index].addressId}');
                    // setState(() {
                    //   _addressFlag = false;
                    // });
                  },
                  child: Container(
                    width: double.infinity,
                    height: 68.h,
                    decoration: decorationDoubleRadiusBorder(
                      color: _addressIndex == index ? mainColor : Color(0xFFDFDFDF),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    margin: EdgeInsetsDirectional.only(bottom: 8.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(CupertinoIcons.location),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  // color: Colors.blue,
                                  width: 220.w,
                                  margin: EdgeInsetsDirectional.only(start: 8.w),
                                  child: Text(
                                    '${userController.addressList[index].addressGov} - '
                                    '${userController.addressList[index].addressCity} - '
                                    '${userController.addressList[index].addressRegion}',
                                    style: titleNormal(color: Colors.black),
                                    maxLines: 1,
                                  ),
                                ),
                                Container(
                                  // color: Colors.blue,
                                  width: 230.w,
                                  margin: EdgeInsetsDirectional.only(start: 8.w),
                                  child: Text(
                                    '${userController.addressList[index].addressDes ?? ''}',
                                    style: titleNormal(color: Colors.grey.shade800, size: 14),
                                    maxLines: 1,
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                            userController.loading && _addressIndex == index
                                ? SizedBox(
                                    width: 22.w,
                                    height: 22.w,
                                    child: Center(
                                      child: SpinKitCircle(
                                        size: 20.w,
                                        color: const Color(0xFFAE0910),
                                      ),
                                    ),
                                  )
                                : _addressIndex == index
                                    ? Container(
                                        width: 22.w,
                                        height: 22.w,
                                        // padding: EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          color: mainColor,
                                          border: Border.all(width: 1, color: mainColor),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Center(
                                          child: Image.asset(
                                            'assets/icons/location.png',
                                            width: 10.w,
                                            height: 10.w,
                                          ),
                                        ),
                                      )
                                    : Container(
                                        width: 22.w,
                                        height: 22.w,
                                        padding: EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          // color: Colors.grey,
                                          border: Border.all(width: 1, color: mainColor),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 6.w),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: GestureDetector(
                    onTap: () {
                      Get.find<UserController>().setAddress(address: userController.addressList[index]);
                      // fadNavigate(context, EditAddressScreen(address: userController.addressList[index]));
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              EditAddressScreen(address: userController.addressList[index]),
                        ),
                      ).then((_) {
                        if (_mapCreated) {
                          mapController.animateCamera(
                            CameraUpdate.newLatLngZoom(
                              LatLng(
                                double.parse(
                                  '${userController.addressList[index].latitude}',
                                ),
                                double.parse(
                                  '${userController.addressList[index].longitude}',
                                ),
                              ),
                              15.0,
                            ),
                          );
                          setState(() {
                            _markers.clear();
                            // if (country!=null && areaName!=null && street!=null){
                            _markers.add(Marker(
                              // This marker id can be anything that uniquely identifies each marker.
                              onTap: () {},
                              markerId: MarkerId(_lastMapPosition.toString()),
                              position: LatLng(
                                double.parse(
                                  '${userController.addressList[index].latitude}',
                                ),
                                double.parse(
                                  '${userController.addressList[index].longitude}',
                                ),
                              ),
                              icon: BitmapDescriptor.defaultMarker,
                              // infoWindow: InfoWindow(title: '$country , $areaName , $street',snippet: "${AppLocalizations.of(context).trans('deliverToThisPlace')}"),
                            ));
                          });
                        }
                      });
                    },
                    child: Container(
                      // padding: EdgeInsets.all(8.w),
                      height: 68.h,
                      decoration: decorationDoubleRadiusBorder(
                        radius: 16,
                        color: _addressIndex == index ? mainColor : Color(0xFFDFDFDF),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.edit, size: 18),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
