import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SelectedIndexController extends GetxController {
  final RxInt selectedIndex = 0.obs;

  final box = GetStorage(); // Initialize GetStorage

  void setSelectedIndex(int index) {
    selectedIndex.value = index;
    box.write('selectedIndex', index); // Save the selected index to storage
  }

  int getSelectedIndex() {
    return selectedIndex.value;
  }

  @override
  void onInit() {
    // Load the selected index from storage when the controller is initialized.
    final savedIndex = box.read('selectedIndex');
    selectedIndex.value = savedIndex ?? 0;
    super.onInit();
  }
}
