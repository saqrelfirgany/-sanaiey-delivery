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
import 'package:sanaiey/Models/IntroModels/city_model.dart';
import 'package:sanaiey/Models/IntroModels/governorate_model.dart';
import 'package:sanaiey/Models/IntroModels/region_model.dart';
import 'package:sanaiey/Models/SubModel/address_model.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/controllers/IntroControllers/select_address_controller.dart';
import 'package:sanaiey/controllers/SubControllers/user_controller.dart';
import 'package:sanaiey/screens/SharedComponents/AppBar/profile_app_bar.dart';
import 'package:sanaiey/screens/SharedComponents/Buttons/back_button.dart';
import 'package:sanaiey/screens/SharedComponents/Dialog/aap_dialog.dart';
import 'package:sanaiey/screens/SharedComponents/TextFormFields/text_field_address.dart';
import 'package:sanaiey/screens/SharedComponents/loader.dart';
import 'package:sanaiey/screens/SharedComponents/loaders/screen_loader.dart';

class EditAddressScreen extends StatefulWidget {
  const EditAddressScreen({Key? key, this.edit = true, required this.address}) : super(key: key);
  final bool edit;
  final AddressModel address;

  @override
  _EditAddressScreenState createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends State<EditAddressScreen> {
  late UserController userController;
  String _regionId = '';
  String _addressGov = '';
  String _addressCity = '';
  String _addressRegion = '';
  String _addressStreet = '';
  String _addressBlockNum = '';
  String _addressFlatNum = '';
  String _addressDes = '';
  String _location = '';

  void getData() {
    lat = double.parse('${widget.address.latitude ?? '0.0'}');
    lng = double.parse('${widget.address.longitude ?? '0.0'}');
    userController.addressStreetController.text = '${widget.address.addressStreet}';
    userController.addressBlockNumController.text = '${widget.address.addressBlockNum}';
    userController.addressFlatNumController.text = '${widget.address.addressFlatNum}';
    userController.addressDesController.text = '${widget.address.addressDes}';
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

  ///
  ///
  ///

  late SelectAddressController _selectAddressController;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  bool _loadAll = false;

  Future<void> loadData() async {
    setState(() {
      _loadAll = true;
    });
    locateUser();
    await getCurrentGovernorate();
    await getCurrentCity();
    await getCurrentRegion();
    _checkGps();
    userController = Get.find<UserController>();
    Geolocator()..checkGeolocationPermissionStatus(locationPermission: GeolocationPermission.location);
    getData();
    setState(() {
      _loadAll = false;
    });
  }

  String _currentGovId = '1';
  Governorate _currentGov = Governorate();
  int _currentGovIndex = 0;

  Future getCurrentGovernorate() async {
    _currentGovIndex = 0;
    _currentGovId = '${widget.address.governorateId}';
    if (_currentGovId == 'null') {
      return;
    }
    _selectAddressController = Get.find<SelectAddressController>();
    for (var element in _selectAddressController.governorateList) {
      if ('${element.governorateId}' == _currentGovId) {
        _currentGov = element;
        await _selectAddressController.changeGovernorate(item: element);
        return;
      }
      _currentGovIndex++;
    }
    _currentGov = Governorate(governorateId: '1');
  }

  int _currentCityIndex = 0;
  String _currentCityId = '1';
  City _currentCity = City();

  Future getCurrentCity({changeCityId = null}) async {
    _currentCityIndex = 0;
    _currentCityId = changeCityId ?? '${widget.address.cityId}';
    if (_currentCityId == 'null') {
      return;
    }
    _selectAddressController = Get.find<SelectAddressController>();
    for (var element in _selectAddressController.cityList) {
      if ('${element.cityId}' == _currentCityId) {
        _currentCity = element;
        await _selectAddressController.changeCityModel(item: element);
        return;
      }
      _currentCityIndex++;
    }
    await getCurrentRegion();
    _currentCity = City(cityId: '1');
  }

  int _currentRegionIndex = 0;
  String _currentRegionId = '1';
  RegionModel _currentRegion = RegionModel();

  Future getCurrentRegion({changeRegionId = null}) async {
    _currentRegionIndex = 0;
    _currentRegionId = changeRegionId ?? '${widget.address.regionId}';
    if (_currentRegionId == 'null') {
      return;
    }
    _selectAddressController = Get.find<SelectAddressController>();
    for (var element in _selectAddressController.regionList) {
      if ('${element.regionId}' == _currentRegionId) {
        _currentRegion = element;
        await _selectAddressController.changeRegionModel(item: element);
        return;
      }
      _currentRegionIndex++;
    }
    _currentRegion = RegionModel(cityId: '1');
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
      _location = '${pickedLocation.country}-${pickedLocation.administrativeArea}';
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
          _center = LatLng(
            double.parse(
              '${widget.address.latitude ?? location.latitude}',
            ),
            double.parse(
              '${widget.address.longitude ?? location.longitude}',
            ),
          );
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
    _location = '${pickedLocation.country}-${pickedLocation.administrativeArea}';
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
      appBar: ProfileAppBar2(context: context, title: 'تعديل العنوان'),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: GetBuilder<UserController>(
          builder: (userController) => _loadAll
              ? const ScreenLoader()
              : isLoadingLocation
                  ? const ScreenLoader()
                  : Column(
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
                                init: Get.find<SelectAddressController>(),
                                builder: (controller) => GetShadow1(
                                  child: Container(
                                    width: double.infinity,
                                    height: 45.h,
                                    margin: EdgeInsets.symmetric(horizontal: 0.w),
                                    decoration: BoxDecoration(
                                      color: backGroundColor,
                                      borderRadius: BorderRadius.circular(10.r),
                                      border: Border.all(
                                        color: const Color(0xFFBEBEBE),
                                      ),
                                    ),
                                    child: DropdownButtonFormField<Governorate>(
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsetsDirectional.only(
                                          start: 16.w,
                                          end: 8.w,
                                          bottom: 4.h,
                                        ),
                                      ),
                                      isDense: false,
                                      itemHeight: 55.h,
                                      dropdownColor: backGroundColor,
                                      iconEnabledColor: Colors.black,
                                      iconDisabledColor: Colors.black,
                                      value: controller.governorateList[_currentGovIndex],
                                      items: controller.governorateList
                                          .map(
                                            (item) => DropdownMenuItem<Governorate>(
                                              value: item,
                                              child: Text(
                                                item.governorateName,
                                                maxLines: 1,
                                                style: titleNormal(color: const Color(0xFF949494)),
                                              ),
                                            ),
                                          )
                                          .toList(),
                                      onChanged: (item) async {
                                        await controller.changeGovernorate(item: item);
                                        setState(() {
                                          _currentCityIndex = 0;
                                          _currentRegionIndex = 0;
                                        });
                                      },
                                    ),
                                  ),
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
                                    : Container(
                                        width: double.infinity,
                                        height: 45.h,
                                        margin: EdgeInsets.symmetric(horizontal: 0.w),
                                        decoration: BoxDecoration(
                                          color: backGroundColor,
                                          borderRadius: BorderRadius.circular(10.r),
                                          border: Border.all(
                                            color: const Color(0xFFBEBEBE),
                                          ),
                                        ),
                                        child: DropdownButtonFormField<City>(
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            contentPadding: EdgeInsetsDirectional.only(
                                              start: 16.w,
                                              end: 8.w,
                                              bottom: 4.h,
                                            ),
                                          ),
                                          isDense: false,
                                          itemHeight: 55.h,
                                          dropdownColor: backGroundColor,
                                          iconEnabledColor: Colors.black,
                                          iconDisabledColor: Colors.black,
                                          value: controller.cityList[_currentCityIndex],
                                          items: controller.cityList
                                              .map(
                                                (item) => DropdownMenuItem<City>(
                                                  value: item,
                                                  child: Text(
                                                    item.cityName,
                                                    maxLines: 1,
                                                    style: titleNormal(color: const Color(0xFF949494)),
                                                  ),
                                                ),
                                              )
                                              .toList(),
                                          onChanged: (item) async {
                                            await controller.changeCityModel(item: item);
                                            setState(() {
                                              _currentRegionIndex = 0;
                                            });
                                          },
                                        ),
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
                                    : Container(
                                        width: double.infinity,
                                        height: 45.h,
                                        margin: EdgeInsets.symmetric(horizontal: 0.w),
                                        decoration: BoxDecoration(
                                          color: backGroundColor,
                                          borderRadius: BorderRadius.circular(10.r),
                                          border: Border.all(
                                            color: const Color(0xFFBEBEBE),
                                          ),
                                        ),
                                        child: DropdownButtonFormField<RegionModel>(
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            contentPadding: EdgeInsetsDirectional.only(
                                              start: 16.w,
                                              end: 8.w,
                                              bottom: 4.h,
                                            ),
                                          ),
                                          isDense: false,
                                          itemHeight: 55.h,
                                          dropdownColor: backGroundColor,
                                          iconEnabledColor: Colors.black,
                                          iconDisabledColor: Colors.black,
                                          value: controller.regionList[_currentRegionIndex],
                                          items: controller.regionList
                                              .map(
                                                (item) => DropdownMenuItem<RegionModel>(
                                                  value: item,
                                                  child: Text(
                                                    item.regionName,
                                                    maxLines: 1,
                                                    style: titleNormal(color: const Color(0xFF949494)),
                                                  ),
                                                ),
                                              )
                                              .toList(),
                                          onChanged: (item) {
                                            controller.changeRegionModel(item: item);
                                          },
                                        ),
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
                                              userController.updateAddress(
                                                lat: lat,
                                                lng: lng,
                                                mapDescription: _mapAddressController.text,
                                                addressId: '${widget.address.addressId}',
                                                isDefault: widget.address.isDefault ?? false,
                                              );
                                            },
                                            child: Material(
                                              elevation: 8,
                                              borderRadius: BorderRadius.circular(10.r),
                                              child: Container(
                                                width: 170.w,
                                                height: 48.h,
                                                // margin: EdgeInsets.all(16.w),
                                                decoration: decorationRadius().copyWith(
                                                  color: const Color(0xFFAE0910),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    widget.edit ? 'تعديل العنوان' : 'اضافة عنوان جديد',
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
    );
  }
}
