import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../core/view_model/login_viewmodel.dart';
import '../login/login_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<LoginViewModel>();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              viewModel.logout();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return const LoginView();
                  },
                ),
              );
            },
            icon: const Icon(
              Icons.logout,
              weight: 10,
              color: Colors.black54,
            ),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset("assets/success.svg", width: 120),
              const SizedBox(
                height: 12,
              ),
              const Text(
                "Hi there",
                style: TextStyle(
                    color: Color(0xff2a2a2a),
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 8,
              ),
              const Text(
                "You have successfully logged into the mobile app",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xff8B8B8B),
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
