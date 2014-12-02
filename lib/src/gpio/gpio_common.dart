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

enum GpioPinMode {
  INPUT,
  OUTPUT
}

enum GpioVoltage {
  HIGH,
  LOW
}

abstract class Gpio extends Device {

  final int pin;
  final GpioPinMode mode;

  Gpio(connection, this.pin, this.mode) : super(connection);

}

abstract class GpioConnection extends Connection {

  initPin(int pin, GpioPinMode mode);

  Future digitalWrite(int pin, GpioVoltage value);

}

class InputPin extends Gpio {

  GpioVoltage _value = GpioVoltage.LOW;

  InputPin(final GpioConnection connection, final int pin) : super(connection, pin, GpioPinMode.INPUT);

  Future init() =>
    (connection as GpioConnection).initPin(pin, GpioPinMode.INPUT);

}

abstract class OutputPin extends Gpio  {

  GpioVoltage _value = GpioVoltage.LOW;

  OutputPin(final GpioConnection connection, final int pin, {GpioVoltage value: GpioVoltage.LOW}) : super(connection, pin, GpioPinMode.OUTPUT) {
    _value = value;
  }

  bool get isOn => _value == GpioVoltage.HIGH;
  bool get isOff => _value == GpioVoltage.LOW;

  Future init() =>
    (connection as GpioConnection).initPin(pin, GpioPinMode.OUTPUT);

  Future on() {
    _value = GpioVoltage.HIGH;
    return (connection as GpioConnection).digitalWrite(pin, _value);
  }

  Future  off() {
    _value = GpioVoltage.LOW;
    return (connection as GpioConnection).digitalWrite(pin, _value);
  }

  Future toggle() =>
    isOn ? off() : on();

}
