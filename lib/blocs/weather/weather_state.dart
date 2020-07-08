part of 'weather_bloc.dart';


abstract class WeatherState extends Equatable {
}

class WeatherInitial extends WeatherState {
  @override
  List<Object> get props => [];
}

class WeatherLoadingState extends WeatherState{
  @override
  List<Object> get props => throw UnimplementedError();
}
class WeatherLoadedState extends WeatherState{

  final Weather weather;
  WeatherLoadedState({@required this.weather});

  @override
  List<Object> get props => throw UnimplementedError();

}

class WeatherErrorState extends WeatherState {
  @override

  List<Object> get props => throw UnimplementedError();

}