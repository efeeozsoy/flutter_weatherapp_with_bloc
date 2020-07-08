import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weatherapp_with_bloc/blocs/weather/tema/tema_bloc.dart';
import 'package:flutter_weatherapp_with_bloc/blocs/weather/weather_bloc.dart';
import 'package:flutter_weatherapp_with_bloc/widget/gecis_arka_plan_rengi.dart';

import 'hava_durumu_resim.dart';
import 'location.dart';
import 'max_min_sicaklik.dart';
import 'sehir_sec.dart';
import 'son_guncelleme.dart';


class WeatherApp extends StatelessWidget {
  String kullanicininSectigiSehir = "";
  Completer<void> _refreshCompleter = Completer<void>();

  @override
  Widget build(BuildContext context) {
    final _weatherBloc = BlocProvider.of<WeatherBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Weather App"),
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () async {
                kullanicininSectigiSehir = await Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SehirSecWidget()));
                if(kullanicininSectigiSehir != null){
                  _weatherBloc.add(FetchWeatherEvent(sehirAdi: kullanicininSectigiSehir));
                  
                }
              })
        ],
      ),
      body: Center(
        child: BlocBuilder(
          bloc: _weatherBloc,
          // ignore: missing_return
          builder: (context, WeatherState state){
            if(state is WeatherInitial){
              return Center(child: Text("Şehir Seçiniz"),);
            }
            if(state is WeatherLoadingState){
              return Center(child: CircularProgressIndicator(),);
            }
            if(state is WeatherLoadedState){
              final getirilenWeather = state.weather;
              final _havaDurumuKisaltma = getirilenWeather.consolidatedWeather[0].weatherStateAbbr;

              kullanicininSectigiSehir = getirilenWeather.title;
               BlocProvider.of<TemaBloc>(context).add(TemaDegistirEvent(havaDurumuKisaltmasi: _havaDurumuKisaltma));

              _refreshCompleter.complete();
              _refreshCompleter= Completer();
              return BlocBuilder(
                bloc: BlocProvider.of<TemaBloc>(context),
                builder: (context, TemaState temaState) => GecisliRenkContainer(
                  renk: (temaState as UygulamaTemasi).renk,
                  child: RefreshIndicator(
                    onRefresh: (){
                      _weatherBloc.add(RefreshWeatherEvent(sehirAdi: kullanicininSectigiSehir));
                      return _refreshCompleter.future;
                    },
                    child: ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                              child: LocationWidget(
                                secilenSehir: getirilenWeather.title,
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(child: SonGuncellemeWidget()),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(child: HavaDurumuResim()),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Center(child: MaxAndMinSicaklikWidget()),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }
            if(state is WeatherErrorState){
              return Center(child: Text("Hata Oluştu"),);
            }
          },
        ),
      ),
    );
  }
}
