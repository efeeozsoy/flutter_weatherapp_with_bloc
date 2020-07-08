part of 'tema_bloc.dart';

abstract class TemaState extends Equatable {
  const TemaState();
}

class TemaInitial extends TemaState {
  @override
  List<Object> get props => [];
}

class UygulamaTemasi extends TemaState{
  final ThemeData tema;
  final MaterialColor renk;

  UygulamaTemasi({@required this.tema, @required this.renk});

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}