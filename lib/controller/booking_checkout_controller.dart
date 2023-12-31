import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/api/api_checker.dart';
import '../data/model/body/user_information_body.dart';
import '../data/model/response/vehicle_model.dart';
import '../data/repository/rider_repo.dart';
import '../view/base/custom_snackbar.dart';

enum PageState {orderDetails, payment, complete}

enum PaymentMethodName  {digitalPayment, COS}

class BookingCheckoutController extends GetxController implements GetxService{
  final RiderRepo riderRepo;
  BookingCheckoutController({@required this.riderRepo});

  PageState currentPage = PageState.orderDetails;
  bool _isLoading = false;
  var selectedPaymentMethod = PaymentMethodName.COS;
  bool showCoupon = false;
  bool cancelPayment = false;

  bool _showCouponSection = false;
  double _couponDiscount = 0;
  int _paymentMethodIndex = 0;
  int _tripId;

  bool get showCouponSection => _showCouponSection;
  bool get isLoading => _isLoading;
  double get couponDiscount => _couponDiscount;
  int get paymentMethodIndex => _paymentMethodIndex;
  int get tripId => _tripId;

  void setPaymentMethod(int index, {bool isUpdate = true}) {
    _paymentMethodIndex = index;
    if(isUpdate){
      update();
    }
  }

  void showHideCoupon(){
    _showCouponSection = !_showCouponSection;
    update();
  }

  void setCouponDiscount(double discount){
    _couponDiscount = discount;
    update();
  }

  void cancelPaymentOption(){
    cancelPayment = true;
    update();
  }

  void updateState(PageState _currentPage,{bool shouldUpdate = true}){
    print('--------------$_currentPage');
    currentPage=_currentPage;
    if(shouldUpdate){
      update();
    }
  }

  void updateDigitalPaymentOption(PaymentMethodName paymentMethodName,{bool shouldUpdate = true}){
    selectedPaymentMethod = paymentMethodName;
    if(shouldUpdate){
      update();
    }
  }


  Future<bool> placeTrip({@required UserInformationBody filterBody, @required Vehicles vehicle}) async {
    _tripId = null;
    bool success = false;
    _isLoading = true;
    update();
    Map<String, String> body = {
      'start_latitude': filterBody.from.latitude,
      'start_longitude': filterBody.from.longitude,
      'end_latitude': filterBody.to.latitude,
      'end_longitude': filterBody.to.longitude,
      'fare_category': filterBody.fareCategory,
      'schedule_at': filterBody.rentTime,
      'distance': filterBody.distance.toString(),
      'filter_type': filterBody.filterType,
      'payment_method': _paymentMethodIndex == 0 ? 'cash_on_delivery' : _paymentMethodIndex == 1 ? 'digital_payment' : 'wallet',
      'vehicle_id': vehicle.id.toString(),
      'provider_id': vehicle.providerId.toString(),
    };

    Response response = await riderRepo.placeTrip(body);
    _isLoading = false;
    if (response.statusCode == 200) {
      success = true;
      showCustomSnackBar(response.body['message'], isError: false);
      print('-------------${response.body}');
      _tripId = response.body['trip_id'];
    } else {
      ApiChecker.checkApi(response);
    }
    update();
    return success;
  }


}