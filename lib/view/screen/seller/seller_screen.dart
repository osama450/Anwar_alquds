import 'package:Anwar/data/model/response/seller_model.dart';
import 'package:Anwar/helper/product_type.dart';
import 'package:Anwar/provider/auth_provider.dart';
import 'package:Anwar/provider/product_provider.dart';
import 'package:Anwar/provider/splash_provider.dart';
import 'package:Anwar/utill/color_resources.dart';
import 'package:Anwar/utill/custom_themes.dart';
import 'package:Anwar/utill/dimensions.dart';
import 'package:Anwar/utill/images.dart';
import 'package:Anwar/view/basewidget/animated_custom_dialog.dart';
import 'package:Anwar/view/basewidget/guest_dialog.dart';
import 'package:Anwar/view/basewidget/search_widget.dart';
import 'package:Anwar/view/screen/chat/chat_screen.dart';
import 'package:Anwar/view/screen/home/widget/products_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SellerScreen extends StatelessWidget {
  final SellerModel seller;
  SellerScreen({@required this.seller});

  @override
  Widget build(BuildContext context) {
    Provider.of<ProductProvider>(context, listen: false).removeFirstLoading();
    Provider.of<ProductProvider>(context, listen: false).clearSellerData();
    Provider.of<ProductProvider>(context, listen: false)
        .initSellerProductList(seller.id.toString(), '1', context);
    ScrollController _scrollController = ScrollController();

    return Scaffold(
      backgroundColor: ColorResources.getIconBg(context),
      body: Column(
        children: [
          SearchWidget(
            hintText: 'Search product...',
            onTextChanged: (String newText) =>
                Provider.of<ProductProvider>(context, listen: false)
                    .filterData(newText),
            onClearPressed: () {},
          ),
          Expanded(
            child: ListView(
              controller: _scrollController,
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.all(0),
              children: [
                // Banner
                Padding(
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: FadeInImage.assetNetwork(
                      placeholder: Images.placeholder,
                      image:
                          '${Provider.of<SplashProvider>(context, listen: false).baseUrls.shopImageUrl}/${seller.shop != null ? seller.shop.image : ''}',
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                Container(
                  color: Theme.of(context).accentColor,
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                  child: Column(children: [
                    // Seller Info
                    Row(children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: FadeInImage.assetNetwork(
                          placeholder: Images.placeholder,
                          image:
                              '${Provider.of<SplashProvider>(context, listen: false).baseUrls.sellerImageUrl}/${seller.image}',
                          height: 80,
                          width: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                      Expanded(
                        child: Text(
                          seller.fName + ' ' + seller.lName,
                          style: titilliumSemiBold.copyWith(
                              fontSize: Dimensions.FONT_SIZE_LARGE),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          if (!Provider.of<AuthProvider>(context, listen: false)
                              .isLoggedIn()) {
                            showAnimatedDialog(context, GuestDialog(),
                                isFlip: true);
                          } else if (seller != null) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) =>
                                        ChatScreen(seller: seller)));
                          }
                        },
                        icon: Image.asset(Images.chat_image,
                            color: ColorResources.SELLER_TXT,
                            height: Dimensions.ICON_SIZE_DEFAULT),
                      ),
                    ]),
                  ]),
                ),
                SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                Padding(
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  child: ProductView(
                      productType: ProductType.SELLER_PRODUCT,
                      scrollController: _scrollController,
                      sellerId: seller.id.toString()),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
