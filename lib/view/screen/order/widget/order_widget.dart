import 'package:Anwar/data/model/response/order_model.dart';
import 'package:Anwar/helper/date_converter.dart';
import 'package:Anwar/helper/price_converter.dart';
import 'package:Anwar/localization/language_constrants.dart';
import 'package:Anwar/utill/color_resources.dart';
import 'package:Anwar/utill/custom_themes.dart';
import 'package:Anwar/utill/dimensions.dart';
import 'package:Anwar/view/screen/order/order_details_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderWidget extends StatelessWidget {
  final OrderModel orderModel;
  OrderWidget({this.orderModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => OrderDetailsScreen(
                orderModel: orderModel, orderId: orderModel.id)));
      },
      child: Container(
        margin: EdgeInsets.only(
            bottom: Dimensions.PADDING_SIZE_SMALL,
            left: Dimensions.PADDING_SIZE_SMALL,
            right: Dimensions.PADDING_SIZE_SMALL),
        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
        decoration: BoxDecoration(
            color: Theme.of(context).accentColor,
            borderRadius: BorderRadius.circular(5)),
        child: Row(children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Text(getTranslated('ORDER_ID', context),
                  style: titilliumRegular.copyWith(
                      fontSize: Dimensions.FONT_SIZE_SMALL)),
              SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
              Text(orderModel.id.toString(), style: TextStyle(fontSize: 10)),
            ]),
            Row(children: [
              Text(getTranslated('order_date', context),
                  style: titilliumRegular.copyWith(
                      fontSize: Dimensions.FONT_SIZE_SMALL)),
              SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
              Text(DateConverter.isoStringToLocalDateOnly(orderModel.createdAt),
                  style: titilliumRegular.copyWith(
                    fontSize: Dimensions.FONT_SIZE_SMALL,
                    color: Theme.of(context).hintColor,
                  )),
            ]),
          ]),
          SizedBox(width: Dimensions.PADDING_SIZE_LARGE),
          Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(getTranslated('total_price', context),
                  style: titilliumRegular.copyWith(fontSize: 10)),
              Text(PriceConverter.convertPrice(context, orderModel.orderAmount),
                  style: TextStyle(fontSize: 10)),
            ]),
          ),
          Container(
            alignment: Alignment.center,
            padding:
                EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
            decoration: BoxDecoration(
              color: ColorResources.getLowGreen(context),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(orderModel.orderStatus.toUpperCase(),
                style: TextStyle(fontSize: 12)),
          ),
        ]),
      ),
    );
  }
}
