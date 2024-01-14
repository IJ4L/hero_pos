import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mb_hero_post/core/extension/string_formatter.dart';
import 'package:mb_hero_post/core/routes/app_route_path.dart';
import 'package:mb_hero_post/core/themes/app_color.dart';
import 'package:mb_hero_post/core/themes/app_font.dart';
import 'package:mb_hero_post/data/models/product_model.dart';
import 'package:mb_hero_post/presentation/cubit/troli_cubit/troli_cubit.dart';
import 'package:mb_hero_post/presentation/widgets/floating_price.dart';

class TroliPage extends StatelessWidget {
  const TroliPage({
    super.key,
    required this.itemChoose,
  });

  final TroliState itemChoose;

  @override
  Widget build(BuildContext context) {
    final TroliCubit troliCubit = context.read<TroliCubit>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Keranjang",
          style: AppFont.semiBold.s16,
        ),
        centerTitle: true,
        backgroundColor: AppColor.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 87.h * itemChoose.products.length,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: ListView.separated(
                shrinkWrap: false,
                itemBuilder: (contex, index) {
                  var product = itemChoose.products[index];
                  return BlocBuilder<TroliCubit, TroliState>(
                    builder: (context, state) {
                      return Container(
                        height: 65.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColor.white,
                          borderRadius: BorderRadius.circular(6.w),
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(6.r),
                                bottomLeft: Radius.circular(6.r),
                              ),
                              child: Image.asset(
                                "assets/images/img_wagyu.jpeg",
                                height: 65.h,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 12.h),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.nameOfProduct,
                                  style: AppFont.semiBold.s14,
                                ),
                                Text(
                                  product.priceOfProduct.formatCurrency(),
                                  style: AppFont.regular.s12,
                                ),
                                Text(
                                  "Qty: ${state.products[index].quantity}",
                                  style: AppFont.regular.s12,
                                )
                              ],
                            ),
                            const Spacer(),
                            buttonCounter(
                              ontap: () {
                                troliCubit.addToTroli(
                                  ProductModel(
                                    nameOfProduct: product.nameOfProduct,
                                    priceOfProduct: product.priceOfProduct,
                                    quantity: 1,
                                  ),
                                  double.parse(product.priceOfProduct),
                                );
                              },
                              product: product,
                              color: AppColor.green,
                              icon: Icons.add,
                            ),
                            SizedBox(width: 3.w),
                            buttonCounter(
                              ontap: () {
                                product.quantity != 1
                                    ? troliCubit.removeFromTroli(product,
                                        double.parse(product.priceOfProduct))
                                    : null;
                              },
                              product: product,
                              color: AppColor.red,
                              icon: Icons.remove,
                            ),
                            SizedBox(width: 10.w),
                          ],
                        ),
                      );
                    },
                  );
                },
                separatorBuilder: (context, index) => SizedBox(height: 12.h),
                scrollDirection: Axis.vertical,
                itemCount: itemChoose.products.length,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: BlocBuilder<TroliCubit, TroliState>(
        builder: (context, state) => state.products.isEmpty
            ? const SizedBox()
            : CardTotal(state: state, path: AppRoute.payment.path),
      ),
    );
  }

  IconButton buttonCounter({
    required Function() ontap,
    required ProductModel product,
    required Color color,
    required IconData icon,
  }) {
    return IconButton(
      onPressed: ontap,
      style: IconButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.r),
        ),
      ),
      icon: Icon(
        icon,
        size: 14.r,
        color: AppColor.white,
      ),
    );
  }
}
