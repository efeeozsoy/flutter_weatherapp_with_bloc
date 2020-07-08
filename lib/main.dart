import 'package:flutter/material.dart';
import 'package:flutter_weatherapp_with_bloc/blocs/weather/tema/tema_bloc.dart';
import 'blocs/weather/weather_bloc.dart';
import 'locator.dart';
import 'widget/weather_app.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  setupLocator();
  runApp(
      BlocProvider<TemaBloc>(create: (context) => TemaBloc(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: BlocProvider.of<TemaBloc>(context),
      builder: (context, TemaState state ) => MaterialApp(
        title: 'Weather App',
        debugShowCheckedModeBanner: false,
        theme:(state as UygulamaTemasi).tema,
        home: BlocProvider<WeatherBloc>(
            create: (context) => WeatherBloc(), child: WeatherApp()),
      ),
    );
  }
}
