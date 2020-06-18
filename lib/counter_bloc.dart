import 'dart:async';
import 'dart:developer';

import 'package:bloc_practice_edi/evento_contador.dart';

class CounterBloc {
  // Esta variable almacenará el estado necesario
  int _counter = 0;

  StreamController<int> _stateController = StreamController<int>();
  StreamController<EventoContador> _eventController = StreamController<EventoContador>();

  // Permite añadir los eventos desde fuera del BLoC
  StreamSink get eventSink =>  _eventController.sink;

  // Permite emitir los estados hacia fuera del BLoC
  Stream<int> get stateStream => _stateController.stream;

  // Permitirá añadir nuevos estados al stream
  StreamSink get _stateSink => _stateController.sink;

  CounterBloc() {
    _eventController.stream.listen(_mapEventToState);
  }

  // Aquí va la lógica de negocio de la vista propiamente dicha
  void _mapEventToState(EventoContador event) { 
    // Si el evento es un evento de incremento..
    if (event is EventoIncremento) _counter++;
    else _counter--;

    _stateSink.add(_counter);
  }
  
  void dispose() {
    _eventController.close();
    _stateController.close();
  }
}
