import 'package:get/get.dart';

import '../../../../common/ui.dart';
import '../../../models/award_model.dart';
import '../../../models/e_provider_model.dart';
import '../../../models/e_service_model.dart';
import '../../../models/experience_model.dart';
import '../../../models/media_model.dart';
import '../../../models/message_model.dart';
import '../../../models/review_model.dart';
import '../../../models/user_model.dart';
import '../../../repositories/e_provider_repository.dart';
import '../../../routes/app_routes.dart';

class EProviderController extends GetxController {
  final eProvider = EProvider().obs;
  final reviews = <Review>[].obs;
  final awards = <Award>[].obs;
  final galleries = <Media>[].obs;
  final experiences = <Experience>[].obs;
  final featuredEServices = <EService>[].obs;
  final currentSlide = 0.obs;
  String heroTag = "";
  late EProviderRepository _eProviderRepository;

  EProviderController() {
    _eProviderRepository = new EProviderRepository();
  }

  @override
  void onInit() {
    var arguments = Get.arguments as Map<String, dynamic>;
    eProvider.value = arguments['eProvider'] as EProvider;
    heroTag = arguments['heroTag'] as String;
    super.onInit();
  }

  @override
  void onReady() async {
    await refreshEProvider();
    super.onReady();
  }

  Future refreshEProvider({bool showMessage = false}) async {
    await getEProvider();
    await getFeaturedEServices();
    await getAwards();
    await getExperiences();
    await getGalleries();
    await getReviews();
    if (showMessage) {
      Get.showSnackbar(Ui.SuccessSnackBar(message: (eProvider.value.name ?? '') + " " + "page refreshed successfully".tr));
    }
  }

  Future getEProvider() async {
    try {
      String? id = eProvider.value.id;
      if (id != null) {
        eProvider.value = await _eProviderRepository.get(id);
      }
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    }
  }

  Future getFeaturedEServices() async {
    try {
      String? id = eProvider.value.id;
      if (id != null) {
        featuredEServices.assignAll(await _eProviderRepository.getFeaturedEServices(eProviderId: id, page: 1));
      }
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    }
  }

  Future getReviews() async {
    try {
      String? id = eProvider.value.id;
      if (id != null) {
        reviews.assignAll(await _eProviderRepository.getReviews(id));
      }
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    }
  }

  Future getAwards() async {
    try {
      String? id = eProvider.value.id;
      if (id != null) {
        awards.assignAll(await _eProviderRepository.getAwards(id));
      }
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    }
  }

  Future getExperiences() async {
    try {
      String? id = eProvider.value.id;
      if (id != null) {
        experiences.assignAll(await _eProviderRepository.getExperiences(id));
      }
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    }
  }

  Future getGalleries() async {
    try {
      String? id = eProvider.value.id;
      if (id != null) {
        final _galleries = await _eProviderRepository.getGalleries(id);
        galleries.assignAll(_galleries.where((e) => e.image != null).map((e) {
          e.image!.name = e.description ?? '';
          return e.image!;
        }));
      }
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    }
  }

  void startChat() {
    List<User>? employeesList = eProvider.value.employees;
    if (employeesList != null && eProvider.value.images.isNotEmpty) {
      List<User> _employees = employeesList.map((e) {
        e.avatar = eProvider.value.images[0];
        return e;
      }).toList();
      Message _message = new Message(_employees, name: eProvider.value.name ?? '');
      Get.toNamed(Routes.CHAT, arguments: _message);
    }
  }
}
