// Copyright (c) 2014-2015, Nicolas François
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

part of graystone_firmata_internal;

abstract class FirmataConnectionProvider {

  Future<Board> connect(portName);

}

abstract class AbstractFirmataConnection implements GpioConnection {

  final FirmataConnectionProvider _provider;
  String _portName;
  Board _board;


  AbstractFirmataConnection(this._portName, this._provider);

  Future open() async {
    _board = await _provider.connect(_portName);
    return true;
  }

  Future close() => _board.close();

  Future pinMode(int pin, GpioPinMode mode) =>
    _board.pinMode(pin, mode == GpioPinMode.INPUT ? PinModes.INPUT : PinModes.OUTPUT);

  Future analogWrite(int pin, int value) =>
    _board.analogWrite(pin, value);

  Future digitalWrite(int pin, GpioVoltage value) =>
    _board.digitalWrite(pin, value == GpioVoltage.HIGH ? PinValue.HIGH : PinValue.LOW);

  Stream<PinState> get onDigitalRead => _board.onDigitalRead.asBroadcastStream();

  Stream<PinState> get onAnalogRead => _board.onAnalogRead;

  Future servoWrite(int pin, int angle) => _board.servoWrite(pin, angle);

}
