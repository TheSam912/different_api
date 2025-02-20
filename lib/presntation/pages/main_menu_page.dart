import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_api_project/presntation/pages/retrofit_test_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/services/api_service_chopper.dart';
import '../../data/services/api_service_dio.dart';
import '../../data/services/api_service_retrofit.dart';
import '../bloc/chopper/api_bloc_chopper.dart';
import '../bloc/dio/api_bloc_dio.dart';
import '../bloc/retrofit/api_bloc_retrofit.dart';
import 'chopper_test_page.dart';
import 'dio_test_page.dart';
import 'http_test_page.dart';

class MainMenuPage extends StatelessWidget {
  const MainMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Select API Method")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HttpTestPage()),
                );
              },
              child: const Text("HTTP"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) =>
                          ApiBlocDio(apiService: ApiServiceDio()),
                      child: const DioTestPage(),
                    ),
                  ),
                );
              },
              child: const Text("Dio"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) => ApiBlocChopper(
                          apiService: ApiServiceChopper.create()),
                      child: const ChopperTestPage(),
                    ),
                  ),
                );
              },
              child: const Text("Chopper"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) => ApiBlocRetrofit(
                          apiService: ApiServiceRetrofit(Dio())),
                      child: const RetrofitTestPage(),
                    ),
                  ),
                );
              },
              child: const Text("Retrofit"),
            ),
          ],
        ),
      ),
    );
  }
}
