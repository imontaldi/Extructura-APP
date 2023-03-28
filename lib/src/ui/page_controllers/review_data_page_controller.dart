import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:extructura_app/src/interfaces/i_view_controller.dart';
import 'package:extructura_app/utils/page_args.dart';

class ReviewDataPageController extends ControllerMVC
    implements IViewController {
  static late ReviewDataPageController _this;

  factory ReviewDataPageController() {
    _this = ReviewDataPageController._();
    return _this;
  }

  static ReviewDataPageController get con => _this;

  PageArgs? args;

  late String? loadingText;

  ReviewDataPageController._();

  @override
  void initPage({PageArgs? arguments}) {}

  @override
  disposePage() {}
}
