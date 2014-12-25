// Copyright (c) 2014, Nicolas François
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

part of graystone_gpio;

typedef num ConversionValueFormumat(int);

class Sensor extends AnalogicGpio {

  StreamController _valuesController = new StreamController<num>();

  Sensor(GpioConnection connection, int pin) : super(connection, pin);

  Future init(){
    _gpioConnection.onAnalogRead.where((pinState) => pinState.pin == pin).listen((pinState){
      _value = pinState.value;
      _valuesController.add(_value);
    });
    return new Future.value();
  }

  Stream<num> get values => _valuesController.stream;

}

// TODO add farehnin
class TemperatureSensor extends Sensor {

  ConversionValueFormumat _toCelcius;

  TemperatureSensor(GpioConnection connection, int pin, {ConversionValueFormumat toCelcius}) : super(connection, pin) {
    // TODO check if formula
    _toCelcius = toCelcius;
  }

  // TODO check if formula exist
  Stream get celciusDegrees => values.map(_toCelcius);

  num get celciusDegree => _toCelcius(_value);

}
