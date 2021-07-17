import 'package:Anwar/data/datasource/remote/dio/dio_client.dart';
import 'package:Anwar/data/datasource/remote/exception/api_error_handler.dart';
import 'package:Anwar/data/model/response/base/api_response.dart';
import 'package:Anwar/utill/app_constants.dart';
import 'package:flutter/material.dart';

class ProductRepo {
  final DioClient dioClient;
  ProductRepo({@required this.dioClient});

  Future<ApiResponse> getLatestProductList(String offset) async {
    try {
      final response =
          await dioClient.get(AppConstants.LATEST_PRODUCTS_URI + offset);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getSellerProductList(
      String sellerId, String offset) async {
    try {
      final response = await dioClient.get(AppConstants.SELLER_PRODUCT_URI +
          sellerId +
          '/products?limit=10&&offset=' +
          offset);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getBrandOrCategoryProductList(
      bool isBrand, String id) async {
    try {
      String uri;
      if (isBrand) {
        uri = '${AppConstants.BRAND_PRODUCT_URI}$id';
      } else {
        uri = '${AppConstants.CATEGORY_PRODUCT_URI}$id';
      }
      final response = await dioClient.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getRelatedProductList(String id) async {
    try {
      final response =
          await dioClient.get(AppConstants.RELATED_PRODUCT_URI + id);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
