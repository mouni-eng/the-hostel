import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_hostel/size_config.dart';
import 'package:the_hostel/view_models/add_property_cubit/cubit.dart';
import 'package:the_hostel/view_models/add_property_cubit/states.dart';
import 'package:the_hostel/views/components/base_widget.dart';
import 'package:the_hostel/views/components/components/custom_button.dart';
import 'package:the_hostel/views/components/components/custom_text.dart';
import 'package:the_hostel/views/components/components/rentalPropertyWidget.dart';
import 'package:the_hostel/views/auth_views/user_registration/userRegistration.dart';
import 'package:the_hostel/views/owner_views/property_listing/property_listing_view.dart';

class RealEstatesView extends StatelessWidget {
  const RealEstatesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RentXWidget(builder: (rentxcontext) {
      var color = rentxcontext.theme.customTheme;
      return BlocConsumer<AddPropertyCubit, AddPropertyStates>(
          listener: (context, state) {},
          builder: (context, state) {
            AddPropertyCubit cubit = AddPropertyCubit.get(context);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  fontSize: width(20),
                  text: "Apartments List (${cubit.apartments.length})",
                  fontWeight: FontWeight.w600,
                  color: color.headline,
                ),
                SizedBox(
                  height: height(25),
                ),
                ConditionalBuilder(
                  condition: state is! GetApartmentLoadingState,
                  builder: (context) {
                    return ListView.separated(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) =>
                           HorizontalPropertyWidget(
                            appartmentModel: cubit.apartments[index],
                           ),
                      separatorBuilder: (context, index) => SizedBox(
                        height: height(25),
                      ),
                      itemCount: cubit.apartments.length,
                    );
                  },
                  fallback: (context) => const Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
                ),
                SizedBox(
                  height: height(25),
                ),
                CustomButton(
                  fontSize: width(18),
                  function: () {
                    rentxcontext.route(
                      (context) => PropertyListingView(),
                    );
                  },
                  text: "Add Real estate",
                ),
              ],
            );
          });
    });
  }
}
