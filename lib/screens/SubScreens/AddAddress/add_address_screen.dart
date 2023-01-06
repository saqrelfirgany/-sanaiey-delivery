import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sanaiey/Helper/decoration_helper.dart';
import 'package:sanaiey/Helper/fonts_helper.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/controllers/IntroControllers/select_address_controller.dart';
import 'package:sanaiey/controllers/SubControllers/user_controller.dart';
import 'package:sanaiey/screens/IntroScreens/SelectAddress/body/city_drop_down.dart';
import 'package:sanaiey/screens/IntroScreens/SelectAddress/body/governorate_drop_down.dart';
import 'package:sanaiey/screens/IntroScreens/SelectAddress/body/region_drop_down.dart';
import 'package:sanaiey/screens/SharedComponents/AppBar/profile_app_bar.dart';
import 'package:sanaiey/screens/SharedComponents/Buttons/back_button.dart';
import 'package:sanaiey/screens/SharedComponents/Dialog/aap_dialog.dart';
import 'package:sanaiey/screens/SharedComponents/TextFormFields/text_field_address.dart';
import 'package:sanaiey/screens/SharedComponents/loader.dart';
import 'package:sanaiey/screens/SharedComponents/loaders/screen_loader.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({Key? key, this.edit = true}) : super(key: key);
  final bool edit;

  @override
  _AddAddressScreenState createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  late UserController userController;

  void getData() {
    userController.addressStreetController.text = '';

    ///
    userController.addressBlockNumController.text = '';

    ///
    userController.addressFlatNumController.text = '';

    ///
    userController.addressDesController.text = '';
  }

  Completer<GoogleMapController> _mapController = Completer();

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
  bool isLoadingLocation = false;

  @override
  void initState() {
    super.initState();
    _checkGps();
    userController = Get.find<UserController>();
    lat = double.parse(userController.address.latitude ?? '0.0');
    lng = double.parse(userController.address.longitude ?? '0.0');
    Geolocator()..checkGeolocationPermissionStatus(locationPermission: GeolocationPermission.location);
    getData();
    locateUser();
  }

  Future _checkGps() async {
    if (!(await Geolocator().isLocationServiceEnabled())) {
      if (Theme.of(context).platform == TargetPlatform.android) {
        AppDialog(context: context);
      }
    }
  }

  TextEditingController _mapAddressController = TextEditingController();

  void _onMapCreated(GoogleMapController controller) {
    // _controller.complete(controller);
    if (!_mapController.isCompleted) {
      //first calling is false
      //call "completer()"
      _mapController.complete(controller);
    } else {
      //other calling, later is true,
      //don't call again completer()
    }
  }

  Future<dynamic> locationss(lat, long) async {
    var addresses;
    try {
      var pickedAddresses = await geocoding.placemarkFromCoordinates(
        lat,
        long,
        localeIdentifier: 'ar',
      );
      var pickedLocation = pickedAddresses.first;
      _mapAddressController.text = '${pickedLocation.country} '
          '- ${pickedLocation.administrativeArea}'
          '- ${pickedLocation.subAdministrativeArea}'
          '- ${pickedLocation.locality}'
          '- ${pickedLocation.subLocality}'
          '- ${pickedLocation.thoroughfare}';
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
          locationss(lat, long);
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
          _center = LatLng(location.latitude, location.longitude);
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
            locationss(lat, lng);
          }
          isLoadingLocation = false;
        });
      }
      return location;
    });
  }

  Future<void> _onCameraClick(LatLng position) async {
    _lastMapPosition = position;
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
      getDescription();
    });
  }

  Future<void> getDescription() async {
    var pickedAddresses = await geocoding.placemarkFromCoordinates(
      lat,
      lng,
      localeIdentifier: 'ar',
    );
    var pickedLocation = pickedAddresses.first;
    // _location = '${pickedLocation.country}-${pickedLocation.administrativeArea}';
    _mapAddressController.text = '${pickedLocation.country} '
        '- ${pickedLocation.administrativeArea}'
        '- ${pickedLocation.subAdministrativeArea}'
        '- ${pickedLocation.locality}'
        '- ${pickedLocation.subLocality}'
        '- ${pickedLocation.thoroughfare}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      extendBody: true,
      appBar: ProfileAppBar2(context: context, title: 'اضافة عنوان جديد'),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: GetBuilder<UserController>(
          builder: (userController) => userController.userStage == UserStage.LOADING
              ? const ScreenLoader()
              : isLoadingLocation
                  ? const ScreenLoader()
                  : SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            width: 414.w,
                            height: 300.h,
                            child: GoogleMap(
                              gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
                                new Factory<OneSequenceGestureRecognizer>(
                                  () => new EagerGestureRecognizer(),
                                ),
                              ].toSet(),
                              myLocationEnabled: true,
                              myLocationButtonEnabled: true,
                              onMapCreated: _onMapCreated,
                              initialCameraPosition: CameraPosition(
                                target: _center,
                                zoom: 15.0,
                              ),
                              onTap: (argument) {
                                _onCameraClick(argument);
                              },
                              mapType: _currentMapType,
                              markers: _markers,
                              padding: EdgeInsets.only(bottom: 18.h),
                            ),
                          ),

                          ///
                          /// First List
                          ///
                          SizedBox(height: 6.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Align(
                                  alignment: AlignmentDirectional.topStart,
                                  child: Text(
                                    'الموقع',
                                    style: titleNormal(color: Colors.black),
                                  ),
                                ),
                                SizedBox(height: 6.h),

                                GetBuilder<SelectAddressController>(
                                  builder: (controller) => GovernorateDropDown(
                                    list: controller.governorateList,
                                    press: controller.changeGovernorateId,
                                    margin: 0,
                                  ),
                                ),
                                Align(
                                  alignment: AlignmentDirectional.topStart,
                                  child: Text(
                                    'الموقع',
                                    style: titleNormal(color: Colors.black),
                                  ),
                                ),
                                SizedBox(height: 6.h),

                                GetBuilder<SelectAddressController>(
                                  builder: (controller) => controller.loadingCity
                                      ? loader
                                      : CityDropDown(
                                          list: controller.cityList,
                                          press: controller.changeCity,
                                          margin: 0,
                                        ),
                                ),
                                SizedBox(height: 6.h),

                                ///
                                /// Area List
                                ///
                                Align(
                                  alignment: AlignmentDirectional.topStart,
                                  child: Text(
                                    'المنطقة',
                                    style: titleNormal(color: Colors.black),
                                  ),
                                ),
                                SizedBox(height: 6.h),
                                GetBuilder<SelectAddressController>(
                                  builder: (controller) => controller.loadingRegion
                                      ? loader
                                      : RegionDropDown(
                                          list: controller.regionList,
                                          press: controller.changeRegion,
                                          margin: 0,
                                        ),
                                ),
                                SizedBox(height: 8.h),
                                Text(
                                  'اسم الشارع',
                                  style: titleNormal(color: Colors.black),
                                ),
                                SizedBox(height: 8.h),
                                TextFieldAddress(
                                  controller: userController.addressStreetController,
                                  textInputType: TextInputType.text,
                                ),
                                SizedBox(height: 8.h),
                                Text(
                                  'رقم المنزل',
                                  style: titleNormal(color: Colors.black),
                                ),
                                SizedBox(height: 8.h),
                                TextFieldAddress(
                                  controller: userController.addressBlockNumController,
                                  textInputType: TextInputType.number,
                                ),
                                SizedBox(height: 8.h),
                                Text(
                                  'رقم الشقة',
                                  style: titleNormal(color: Colors.black),
                                ),
                                SizedBox(height: 8.h),
                                TextFieldAddress(
                                  controller: userController.addressFlatNumController,
                                  textInputType: TextInputType.number,
                                ),
                                SizedBox(height: 8.h),
                                Text(
                                  'الوصف',
                                  style: titleNormal(color: Colors.black),
                                ),
                                SizedBox(height: 8.h),
                                TextFieldAddress(
                                  controller: userController.addressDesController,
                                  textInputType: TextInputType.multiline,
                                  height: 90,
                                ),
                                SizedBox(height: 24.h),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    GetBuilder<UserController>(
                                      builder: (controller) => controller.loading
                                          ? Container(
                                              margin: EdgeInsetsDirectional.only(start: 80.w),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    // width: width.w,
                                                    height: 48.h,
                                                    child: loader,
                                                  ),
                                                ],
                                              ),
                                            )
                                          : InkWell(
                                              onTap: () {
                                                userController.addAddress(
                                                  lat: lat,
                                                  lng: lng,
                                                  mapDescription: _mapAddressController.text,
                                                );
                                              },
                                              child: GetShadow(
                                                child: Container(
                                                  width: 170.w,
                                                  height: 48.h,
                                                  // margin: EdgeInsets.all(16.w),
                                                  decoration: decorationRadius().copyWith(
                                                    color: const Color(0xFFAE0910),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      'اضافة عنوان جديد',
                                                      style: titleNormal(color: Colors.white, size: 18),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                    ),
                                    AuthBack(
                                      text: 'رجوع',
                                      width: 135.w,
                                      height: 48.h,
                                    )
                                  ],
                                ),
                                SizedBox(height: 16.h),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
        ),
      ),
    );
  }
}
