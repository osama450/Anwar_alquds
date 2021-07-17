import 'package:Anwar/localization/language_constrants.dart';
import 'package:Anwar/provider/flash_deal_provider.dart';
import 'package:Anwar/utill/dimensions.dart';
import 'package:Anwar/view/basewidget/custom_app_bar.dart';
import 'package:Anwar/view/basewidget/title_row.dart';
import 'package:Anwar/view/screen/home/widget/flash_deals_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FlashDealScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        CustomAppBar(title: getTranslated('flash_deal', context)),
        Padding(
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          child: TitleRow(
              title: getTranslated('flash_deal', context),
              eventDuration: Provider.of<FlashDealProvider>(context).duration),
        ),
        Expanded(
            child: RefreshIndicator(
          backgroundColor: Theme.of(context).primaryColor,
          onRefresh: () async {
            await Provider.of<FlashDealProvider>(context, listen: false)
                .getMegaDealList(true, context);
          },
          child: Padding(
            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
            child: FlashDealsView(isHomeScreen: false),
          ),
        )),
      ]),
    );
  }
}
