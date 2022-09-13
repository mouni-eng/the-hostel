import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_hostel/constants.dart';
import 'package:the_hostel/infrastructure/utils.dart';
import 'package:the_hostel/size_config.dart';
import 'package:the_hostel/view_models/home_cubit/cubit.dart';
import 'package:the_hostel/view_models/wishList_cubit/cubit.dart';
import 'package:the_hostel/view_models/wishList_cubit/states.dart';
import 'package:the_hostel/views/components/base_widget.dart';
import 'package:the_hostel/views/components/components/custom_text.dart';
import 'package:the_hostel/views/components/components/rentalPropertyWidget.dart';

class WishListView extends StatelessWidget {
  const WishListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: RentXWidget(builder: (rentxcontext) {
        return BlocConsumer<WishListCubit, WishListStates>(
          builder: (context, state) {
            WishListCubit cubit = WishListCubit.get(context);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  color: rentxcontext.theme.customTheme.headline,
                  fontSize: width(24),
                  text: "WishList (${cubit.wishList.length})",
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(
                  height: height(24),
                ),
                ConditionalBuilder(
                    condition: state is! GetWishListLoadingState,
                    fallback: (context) => loading,
                    builder: (context) {
                      return cubit.wishList.isEmpty
                          ? Column(
                              children: [
                                SizedBox(
                                  height: height(300),
                                ),
                                Center(
                                  child: CustomText(
                                    fontSize: width(20),
                                    text: "No Cureent wishlist",
                                  ),
                                ),
                              ],
                            )
                          : ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) =>
                                  HorizontalPropertyWidget(
                                appartmentModel: cubit.wishList[index],
                                rating: HomeCubit.get(context)
                                        .reviewsApartments
                                        .isNotEmpty
                                    ? StringUtil.ratingUtil(
                                            HomeCubit.get(context)
                                                    .reviewsApartments[
                                                cubit.wishList[index].apUid]!)
                                        .toString()
                                    : "NA",
                                isFavourite: true,
                                onTap: () {
                                  cubit.deleteFromWishList(
                                    model: cubit.wishList[index],
                                  );
                                },
                              ),
                              itemCount: cubit.wishList.length,
                              separatorBuilder: (context, index) => SizedBox(
                                height: height(15),
                              ),
                            );
                    }),
              ],
            );
          },
          listener: (context, state) {},
        );
      }),
    );
  }
}
