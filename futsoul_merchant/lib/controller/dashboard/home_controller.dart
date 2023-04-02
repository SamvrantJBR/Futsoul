import 'package:futsoul_merchant/repo/booking/booking_repo.dart';
import 'package:futsoul_merchant/models/banner.dart';
import 'package:futsoul_merchant/models/booking.dart';
import 'package:futsoul_merchant/repo/general/banner_repo.dart';
import 'package:futsoul_merchant/repo/general/income_repo.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxList<Banner> bannerImages = RxList<Banner>(<Banner>[]);
  RxBool isLoadingBanner = RxBool(false);
  RxDouble online = RxDouble(0);
  RxDouble offline = RxDouble(0);
  RxBool isLoadingIncomes = RxBool(false);

  RxList<Booking> bookings = RxList<Booking>();
  RxBool isLoadingBokking = RxBool(false);

  @override
  void onInit() {
    loadBanner();
    loadIncome();
    loadActiveBooking();
    super.onInit();
  }

  void loadBanner() async {
    isLoadingBanner.value = true;
    bannerImages.clear();
    await BannerRepo.getBanner(
      onSuccess: (banners) {
        isLoadingBanner.value = false;
        bannerImages.addAll(banners);
      },
      onError: (message) {
        isLoadingBanner.value = false;
      },
    );
  }

  void loadIncome() async {
    isLoadingIncomes.value = true;
    await IncomeRepo.getIncomes(
      onSuccess: (online, offline) {
        this.online.value = online;
        this.offline.value = offline;
        isLoadingIncomes.value = false;
      },
      onError: (message) {
        isLoadingIncomes.value = false;
      },
    );
  }

  void loadActiveBooking() async {
    isLoadingBokking.value = true;
    bookings.clear();
    await BookingRepo.getActiveBookings(
      onSuccess: (bookings, nextPage) {
        this.bookings.addAll(bookings);
        isLoadingBokking.value = false;
      },
      onError: (message) {
        isLoadingBokking.value = false;
      },
    );
  }
}
