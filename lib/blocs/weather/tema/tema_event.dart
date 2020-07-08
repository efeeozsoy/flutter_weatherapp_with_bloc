part of 'tema_bloc.dart';

abstract class TemaEvent extends Equatable {
  const TemaEvent();
}

class TemaDegistirEvent extends TemaEvent{
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();


  final String havaDurumuKisaltmasi;
  TemaDegistirEvent({@required this.havaDurumuKisaltmasi});

}