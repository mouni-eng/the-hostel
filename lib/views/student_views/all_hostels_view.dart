import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:the_hostel/constants.dart';
import 'package:the_hostel/infrastructure/utils.dart';
import 'package:the_hostel/size_config.dart';
import 'package:the_hostel/view_models/home_cubit/cubit.dart';
import 'package:the_hostel/view_models/home_cubit/state.dart';
import 'package:the_hostel/view_models/student_cubit/cubit.dart';
import 'package:the_hostel/views/components/base_widget.dart';
import 'package:the_hostel/views/components/components/back_button.dart';
import 'package:the_hostel/views/components/components/custom_form_field.dart';
import 'package:the_hostel/views/components/components/rentalPropertyWidget.dart';
import 'package:the_hostel/views/student_views/home_view.dart';
import 'package:the_hostel/views/student_views/hostel_details_view.dart';

class AllHostelsView extends StatelessWidget {
  const AllHostelsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RentXWidget(builder: (rentxcontext) {
      return BlocConsumer<HomeCubit, HomeStates>(
          listener: (context, state) {},
          builder: (context, state) {
            HomeCubit cubit = HomeCubit.get(context);
            return Scaffold(
                body: SafeArea(
                    child: Padding(
              padding: padding,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CustomBorderWidget(
                          rentxcontext: rentxcontext,
                          iconData: const Icon(Icons.arrow_back_ios_rounded),
                          onTap: () {
                            rentxcontext.pop();
                          },
                        ),
                        SizedBox(
                          width: width(15),
                        ),
                        Expanded(
                          child: SizedBox(
                            height: height(46),
                            child: CustomFormField(
                              context: context,
                              prefix: Padding(
                                padding: padding,
                                child: SvgPicture.asset(
                                    "assets/images/search.svg"),
                              ),
                              hintText: "Search your house....",
                              onChange: (value) {
                                cubit.searchApartment(value);
                              },
                              onSubmit: (value) {
                                cubit.getAllApartments();
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height(25),
                    ),
                    ConditionalBuilder(
                        condition: state is! GetAllApartmentsLoadingState,
                        fallback: (context) => loading,
                        builder: (context) {
                          return ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) =>
                                HorizontalPropertyWidget(
                                    appartmentModel: cubit.allApartments[index],
                                    rating: cubit.reviewsApartments.isNotEmpty
                                        ? StringUtil.ratingUtil(
                                                cubit.reviewsApartments[cubit
                                                    .allApartments[index]
                                                    .apUid]!)
                                            .toString()
                                        : "NA",
                                    isFavourite: cubit.favouriteApartments[
                                            cubit.allApartments[index].apUid] ??
                                        false,
                                    onTap: () {
                                      cubit.toggleFavourite(
                                        appartmentModel:
                                            cubit.allApartments[index],
                                      );
                                    }),
                            separatorBuilder: (context, index) => SizedBox(
                              height: height(25),
                            ),
                            itemCount: cubit.allApartments.length,
                          );
                        }),
                  ],
                ),
              ),
            )));
          });
    });
  }
}
