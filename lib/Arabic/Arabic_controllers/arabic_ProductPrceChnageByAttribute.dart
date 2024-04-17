import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mohally/core/utils/Utils_2.dart';
import 'package:mohally/data/response/status.dart';
import 'package:mohally/models/ProductPriceCangeByAttributeModel/ProductpricechangebyAttributeModel.dart';
import 'package:mohally/repository/Auth_Repository/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

String? arabicpid;
// var quantity;
String? arabicproductColor;
String? arabicproductSize;

Map<String, dynamic> productDetails = {};

class ArabicProductPriceChngeByAttribute extends GetxController {
  final _api = AuthRepository();
  RxBool loading = false.obs;
  RxString statusOfApi = ''.obs;
  RxString error = ''.obs;
  RxString productPrice = ''.obs;
  RxString totalQuantity = ''.obs;
  final userlist = ProductPriceChangeByAttributeModel().obs;
  final rxRequestStatus = Status.LOADING.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void setaccountdetails(ProductPriceChangeByAttributeModel value) =>
      userlist.value = value;

  void setError(String value) => error.value = value;

  Future<void> ProductPriceChangeByAttribute(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // String lang = prefs.getString('selectedLanguage').toString();
    print("${prefs.getString('selectedLanguage').toString()}==========lang");

    addIfNotNull(productDetails, 'Color', arabicproductColor?.toString());
    addIfNotNull(productDetails, 'Size', arabicproductSize?.toString());
    // addIfNotNull(productDetails, 'Quantity', quantity.toString());

    loading.value = true;

    Map data = {
      'product_id': arabicpid.toString(),
      'product_attribute':
          // productDetails.toString(),
          json.encode(productDetails), // Encode the map to JSON
      'language_type': 'Arabic'
    };

    final sp = await SharedPreferences.getInstance();
    String token = sp.getString('token').toString();
    var header = {'Authorization': "Bearer $token"};

    try {
      final response = await _api.ProductPriceChangeByAttribute(
          data, header); // Wrapping data inside a list
      loading.value = false;
      print(data);
      print("Message: ${response.message}");
      if (response.status == true) {
        productPrice.value = response.data?.price ?? ''; // Store price
        totalQuantity.value =
            response.data?.totalQuantity ?? ''; // Store quantity
        // Utils.snackBar(context, 'Success', response.message.toString());
      } else {
        Utils.snackBar(context, 'Failed', response.message.toString());
      }
    } catch (error) {
      loading.value = false;
      Utils.snackBar(context, 'Failed', error.toString());
    }
  }

  void addIfNotNull(Map<String, dynamic> map, String key, String? value) {
    if (value != null && value != 'null') {
      map[key] = value;
    }
  }
}
