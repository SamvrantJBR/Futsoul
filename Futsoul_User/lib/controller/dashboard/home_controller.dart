import 'package:futsoul_user/models/futsals.dart';
import 'package:futsoul_user/repo/general/banner_repo.dart';
import 'package:futsoul_user/models/banner.dart';
import 'package:futsoul_user/repo/general/favorite_repo.dart';
import 'package:futsoul_user/repo/general/futsals_repo.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxList<Banner> bannerImages = RxList<Banner>(<Banner>[]);
  RxBool isLoadingBanner = RxBool(false);

  RxList<Futsal> futsals = RxList<Futsal>(<Futsal>[]);
  RxBool isLoadingFutsal = RxBool(false);

  RxList<Futsal> favorites = RxList<Futsal>(<Futsal>[]);
  RxBool isLoadingFavorites = RxBool(false);

  @override
  void onInit() {
    loadFavorites();
    loadBanner();
    loadFutsals();
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

  void loadFutsals() async {
    isLoadingFutsal.value = true;
    futsals.clear();
    await FutsalRepo.getFutsals(
      onSuccess: (futsals, nextPage) {
        isLoadingFutsal.value = false;
        this.futsals.addAll(futsals);
      },
      onError: (message) {
        isLoadingFutsal.value = false;
      },
    );
  }

  void loadFavorites() async {
    isLoadingFavorites.value = true;
    favorites.clear();
    await FavoriteRepo.getFavorites(
      onSuccess: (futsals, nextPage) {
        isLoadingFavorites.value = false;
        favorites.addAll(futsals);
      },
      onError: (message) {
        isLoadingFavorites.value = false;
      },
    );
  }
}
