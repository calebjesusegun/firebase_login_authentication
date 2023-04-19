import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import '../view_model/login_viewmodel.dart';

List<SingleChildWidget> appProviders = [
  ChangeNotifierProvider(create: (_) => LoginViewModel()),
];
