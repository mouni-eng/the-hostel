import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:the_hostel/constants.dart';
import 'package:the_hostel/models/appartment_model.dart';
import 'package:the_hostel/models/booking_model.dart';
import 'package:the_hostel/models/review_model.dart';
import 'package:the_hostel/services/booking_service.dart';
import 'package:the_hostel/services/home_service.dart';
import 'package:the_hostel/view_models/hostel_details_cubit/state.dart';
import 'package:the_hostel/views/components/widgets/map/rentx_map_card.dart';
import 'package:url_launcher/url_launcher.dart';

class HostelDetailsCubit extends Cubit<HostelDetailsStates> {
  HostelDetailsCubit() : super(HostelDetailsStates());

  static HostelDetailsCubit get(context) => BlocProvider.of(context);

  final BookingService _bookingService = BookingService();

  int carousalIndex = 0;
  final RentXMapController mapController = RentXMapController();
  final CarouselController carouselController = CarouselController();
  ApartmentBooking booking = ApartmentBooking.instance();

  /*getApartmentReviews({required AppartmentModel apartmentModel}) {
    emit(GetApartmentReviewsLoadingState());
    _homeService.getReviews(apartmentModel: apartmentModel).then((value) {
      apartmentReview.clear();
      if (value.docs.isEmpty) {
        emit(GetApartmentReviewsSuccessState());
      } else {
        for (var apartment in value.docs) {
          apartmentReview.add(ReviewModel.fromJson(apartment.data()));
          print(apartmentReview.length);
          emit(GetApartmentReviewsErrorState());
        }
      }
    });
  }*/

  onChangeIndex({required int index}) {
    carousalIndex = index;
    emit(OnChangeDetailsState());
  }

  void launchMaps({required AppartmentModel appartmentModel}) {
    final String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=${appartmentModel.address!.latitude},${appartmentModel.address!.longitude}';
    launch(googleUrl).then((value) => emit(OnChangeDetailsState()));
  }

  DateTime currentDate = DateTime(2022, 6, 10);
  CalendarFormat calendarFormat = CalendarFormat.month;
  RangeSelectionMode rangeSelectionMode = RangeSelectionMode
      .toggledOn; // Can be toggled on/off by longpressing a date
  DateTime? selectedDay;
  DateTime focusedDay = DateTime.now();
  DateTime? rangeStart;
  DateTime? rangeEnd;

  chooseDateEnd(DateTime? start, DateTime? end, DateTime? focusDay) {
    selectedDay = null;
    focusedDay = focusDay!;
    rangeEnd = end;
    rangeStart = start;
    rangeSelectionMode = RangeSelectionMode.toggledOn;
    emit(
      OnChangeDetailsState(),
    );
  }

  chooseDate(DateTime value, value2) {
    if (!isSameDay(value, selectedDay)) {
      selectedDay = value;
      focusedDay = value2;
      rangeStart = null; // Important to clean those
      rangeEnd = null;
      rangeSelectionMode = RangeSelectionMode.toggledOff;
      emit(
        OnChangeDetailsState(),
      );
    }
  }

  toggleFormat(value) {
    calendarFormat = value;
    emit(
      OnChangeDetailsState(),
    );
  }

  toggleFocusedDay(value) {
    focusedDay = focusedDay;
    emit(
      OnChangeDetailsState(),
    );
  }

  onChooseRent(Rent value) {
    booking.rentType = value;
    emit(OnChangeDetailsState());
  }

  onChoosePayment({
    required Fees fees,
    required double pricePerDay,
    required double totalPrice,
  }) {
    booking.paymentModel = PaymentModel(
        fees: [fees], pricePerDay: pricePerDay, totalPrice: totalPrice);
    emit(OnChangeDetailsState());
  }

  addBooking({required AppartmentModel appartmentModel}) {
    booking.agentUid = appartmentModel.agentUid!;
    booking.apUid = appartmentModel.apUid!;
    booking.appartmentModel = appartmentModel;
    booking.fromDate = rangeStart!;
    booking.toDate = rangeEnd!;
    booking.user = userModel!;
    booking.status = BookingStatus.pending;
    emit(AddBookingLoadingStateState());
    _bookingService.addBooking(booking).then((value) {
      emit(AddBookingSuccessStateState());
    }).catchError((error) {
      print(error.toString());
      emit(AddBookingErrorStateState());
    });
  }
}
