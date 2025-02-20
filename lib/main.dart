import 'package:flutter/material.dart';
import 'package:flutter_api_project/presntation/bloc/chopper/api_bloc_chopper.dart';
import 'package:flutter_api_project/presntation/bloc/dio/api_bloc_dio.dart';
import 'package:flutter_api_project/presntation/bloc/http/api_bloc.dart';
import 'package:flutter_api_project/presntation/pages/main_menu_page.dart';
import 'package:flutter_api_project/presntation/bloc/retrofit/api_bloc_retrofit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/api_client.dart';

void main() {
  final apiClient = ApiClient(); // ✅ Initialize once

  runApp(MyApp(apiClient: apiClient));
}

class MyApp extends StatelessWidget {
  final ApiClient apiClient;

  const MyApp({super.key, required this.apiClient});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => ApiBlocDio(apiService: apiClient.apiServiceDio)),
        BlocProvider(
            create: (_) => ApiBlocHttp(apiService: apiClient.apiServiceHttp)),
        BlocProvider(
            create: (_) =>
                ApiBlocChopper(apiService: apiClient.apiServiceChopper)),
        BlocProvider(
            create: (_) =>
                ApiBlocRetrofit(apiService: apiClient.apiServiceRetrofit)),
      ],
      child: const MaterialApp(
        title: 'Flutter API Project',
        home: MainMenuPage(),
      ),
    );
  }
}
