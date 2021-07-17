import 'dart:ui';

import 'package:Anwar/helper/product_type.dart';
import 'package:Anwar/localization/language_constrants.dart';
import 'package:Anwar/provider/banner_provider.dart';
import 'package:Anwar/provider/brand_provider.dart';
import 'package:Anwar/provider/cart_provider.dart';
import 'package:Anwar/provider/category_provider.dart';
import 'package:Anwar/provider/flash_deal_provider.dart';
import 'package:Anwar/provider/product_provider.dart';
import 'package:Anwar/utill/color_resources.dart';
import 'package:Anwar/utill/custom_themes.dart';
import 'package:Anwar/utill/dimensions.dart';
import 'package:Anwar/utill/images.dart';
import 'package:Anwar/view/basewidget/title_row.dart';
import 'package:Anwar/view/screen/cart/cart_screen.dart';
import 'package:Anwar/view/screen/category/all_category_screen.dart';
import 'package:Anwar/view/screen/flashdeal/flash_deal_screen.dart';
import 'package:Anwar/view/screen/home/widget/banners_view.dart';
import 'package:Anwar/view/screen/home/widget/category_view.dart';
import 'package:Anwar/view/screen/home/widget/flash_deals_view.dart';
import 'package:Anwar/view/screen/home/widget/products_view.dart';
import 'package:Anwar/view/screen/search/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();

  Future<void> _loadData(BuildContext context, bool reload) async {
    await Provider.of<BannerProvider>(context, listen: false)
        .getBannerList(reload, context);
    await Provider.of<CategoryProvider>(context, listen: false)
        .getCategoryList(reload, context);
    await Provider.of<FlashDealProvider>(context, listen: false)
        .getMegaDealList(reload, context);
    await Provider.of<BrandProvider>(context, listen: false)
        .getBrandList(reload, context);
    await Provider.of<ProductProvider>(context, listen: false)
        .getLatestProductList('1', context, reload: reload);
  }

  @override
  Widget build(BuildContext context) {
    _loadData(context, false);

    return Scaffold(
      backgroundColor: ColorResources.getHomeBg(context),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: RefreshIndicator(
          backgroundColor: Theme.of(context).primaryColor,
          onRefresh: () async {
            await _loadData(context, true);
            return true;
          },
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              // App Bar
              SliverAppBar(
                floating: true,
                elevation: 0,
                centerTitle: true,
                automaticallyImplyLeading: false,
                backgroundColor: Theme.of(context).accentColor,
                title: Text('مطعم انوار القدس', style: robotoBold),
                leading: Image.asset(
                  Images.logo_with_name_image,
                  height: 50,
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => CartScreen()));
                    },
                    icon: Stack(clipBehavior: Clip.none, children: [
                      Image.asset(
                        Images.cart_arrow_down_image,
                        height: Dimensions.ICON_SIZE_DEFAULT,
                        width: Dimensions.ICON_SIZE_DEFAULT,
                        color: ColorResources.getPrimary(context),
                      ),
                      Positioned(
                        top: -4,
                        right: -4,
                        child: CircleAvatar(
                          radius: 7,
                          backgroundColor: ColorResources.RED,
                          child: Text(
                              Provider.of<CartProvider>(context)
                                  .cartList
                                  .length
                                  .toString(),
                              style: titilliumSemiBold.copyWith(
                                color: ColorResources.WHITE,
                                fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                              )),
                        ),
                      ),
                    ]),
                  )
                ],
              ),

              // Search Button
              SliverPersistentHeader(
                  pinned: true,
                  delegate: SliverDelegate(
                      child: InkWell(
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (_) => SearchScreen())),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_SMALL,
                          vertical: 2),
                      color: Theme.of(context).accentColor,
                      alignment: Alignment.center,
                      child: Container(
                        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                        height: 50,
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          color: ColorResources.getGrey(context),
                          borderRadius: BorderRadius.circular(
                              Dimensions.PADDING_SIZE_SMALL),
                        ),
                        child: Row(children: [
                          Icon(Icons.search,
                              color: ColorResources.getPrimary(context),
                              size: Dimensions.ICON_SIZE_LARGE),
                          SizedBox(width: 5),
                          Text(
                              getTranslated('SEARCH_HINT', context) ==
                                      "اي فون 11X مجانا"
                                  ? "بحث"
                                  : "Search",
                              style: robotoRegular.copyWith(
                                  color: Theme.of(context).hintColor)),
                        ]),
                      ),
                    ),
                  ))),

              SliverToBoxAdapter(
                child: Column(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.only(top: Dimensions.PADDING_SIZE_LARGE),
                      child: BannersView(),
                    ),

                    // Category
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          Dimensions.PADDING_SIZE_SMALL,
                          20,
                          Dimensions.PADDING_SIZE_SMALL,
                          Dimensions.PADDING_SIZE_SMALL),
                      child: TitleRow(
                          title: getTranslated('CATEGORY', context),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => AllCategoryScreen()));
                          }),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_SMALL),
                      child: CategoryView(isHomePage: true),
                    ),

                    // Mega Deal
                    Consumer<FlashDealProvider>(
                      builder: (context, flashDeal, child) {
                        return flashDeal.flashDeal == null
                            ? Padding(
                                padding: EdgeInsets.fromLTRB(
                                    Dimensions.PADDING_SIZE_SMALL,
                                    20,
                                    Dimensions.PADDING_SIZE_SMALL,
                                    Dimensions.PADDING_SIZE_SMALL),
                                child: TitleRow(
                                    title: getTranslated('flash_deal', context),
                                    eventDuration: flashDeal.flashDeal != null
                                        ? flashDeal.duration
                                        : null,
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  FlashDealScreen()));
                                    }),
                              )
                            : (flashDeal.flashDeal.id != null &&
                                    flashDeal.flashDealList != null &&
                                    flashDeal.flashDealList.length > 0)
                                ? Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        Dimensions.PADDING_SIZE_SMALL,
                                        20,
                                        Dimensions.PADDING_SIZE_SMALL,
                                        Dimensions.PADDING_SIZE_SMALL),
                                    child: TitleRow(
                                        title: getTranslated(
                                            'flash_deal', context),
                                        eventDuration:
                                            flashDeal.flashDeal != null
                                                ? flashDeal.duration
                                                : null,
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      FlashDealScreen()));
                                        }),
                                  )
                                : SizedBox.shrink();
                      },
                    ),
                    Consumer<FlashDealProvider>(
                      builder: (context, megaDeal, child) {
                        return megaDeal.flashDeal == null
                            ? Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: Dimensions.PADDING_SIZE_SMALL),
                                child: Container(
                                    height: 150, child: FlashDealsView()),
                              )
                            : (megaDeal.flashDeal.id != null &&
                                    megaDeal.flashDealList != null &&
                                    megaDeal.flashDealList.length > 0)
                                ? Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            Dimensions.PADDING_SIZE_SMALL),
                                    child: Container(
                                        height: 150, child: FlashDealsView()),
                                  )
                                : SizedBox.shrink();
                      },
                    ),

                    // Brand

                    // Latest Products
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          Dimensions.PADDING_SIZE_SMALL,
                          20,
                          Dimensions.PADDING_SIZE_SMALL,
                          Dimensions.PADDING_SIZE_SMALL),
                      child: TitleRow(
                          title: getTranslated('latest_products', context)),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_SMALL),
                      child: ProductView(
                          productType: ProductType.LATEST_PRODUCT,
                          scrollController: _scrollController),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SliverDelegate extends SliverPersistentHeaderDelegate {
  Widget child;
  SliverDelegate({@required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 50;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(SliverDelegate oldDelegate) {
    return oldDelegate.maxExtent != 50 ||
        oldDelegate.minExtent != 50 ||
        child != oldDelegate.child;
  }
}
