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

part of graystone_firmata;

class FirmataConnection extends GpioConnection {

  String _portName;
  Board _board;

  FirmataConnection([String portname]) {
    this._portName = portname;
  }

  Future open() {
    Future<Board> isConnected = (_portName == null) ? Board.detect() : Board.fromPortName(portName);
    return isConnected.then((b) {
      _board = b;
      return new Future.value();
    });
  }

  String get portName => portName;

  initPin(int pin, GpioPinMode mode) =>
    _board.pinMode(pin, mode == GpioPinMode.INPUT ? PinModes.INPUT : PinModes.OUTPUT);

  inputPin(int pin) {
    _board.pinMode(pin, PinModes.INPUT);
  }

  outputPin(int pin) {
    _board.pinMode(pin, PinModes.OUTPUT);
  }

  Future _analogWrite(int pin, int value) =>
    _board.analogWrite(pin, value);


  Future digitalWrite(int pin, GpioVoltage value) =>
    _board.digitalWrite(pin, value==GpioVoltage.HIGH ? PinValue.HIGH : PinValue.LOW);

}
