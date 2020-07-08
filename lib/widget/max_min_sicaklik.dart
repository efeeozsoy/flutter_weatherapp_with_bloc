import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weatherapp_with_bloc/blocs/weather/weather_bloc.dart';

class MaxAndMinSicaklikWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _weatherBloc = BlocProvider.of<WeatherBloc>(context);

    return BlocBuilder(
      bloc: _weatherBloc,
      builder: (context, WeatherState state) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Maksimum  : " +
                (state as WeatherLoadedState)
                    .weather
                    .consolidatedWeather[0]
                    .maxTemp
                    .floor()
                    .toString() +
                " °C",
            style: TextStyle(fontSize: 20),
          ),
          Text(
            "Minimum  : " +
                (state as WeatherLoadedState)
                    .weather
                    .consolidatedWeather[0]
                    .minTemp
                    .floor()
                    .toString() +
                " °C",
            style: TextStyle(fontSize: 20),
          )
        ],
      ),
    );
  }
}
