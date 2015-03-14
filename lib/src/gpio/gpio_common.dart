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

  Gpio(connection, this.pin) : super(connection);

  GpioConnection get _gpioConnection => (connection as GpioConnection);

  Future init() => new Future.value();// Not init by default

}

abstract class DigitalGpio extends Gpio {

  final GpioPinMode mode;
  GpioVoltage _value = GpioVoltage.LOW;

  DigitalGpio(GpioConnection connection, int pin, this.mode) : super(connection, pin);

  Future init() => _gpioConnection.pinMode(pin, mode);

}

abstract class AnalogicGpio extends Gpio {

  num _value;

  AnalogicGpio(GpioConnection connection, int pin) : super(connection, pin);

}

abstract class GpioConnection extends Connection {

  Future pinMode(int pin, GpioPinMode mode);

  Future digitalWrite(int pin, GpioVoltage value);

  Future analogWrite(int pin, int value);

  Future servoWrite(int pin, int angle);

  Stream<PinState> get onDigitalRead;

  Stream<PinState> get onAnalogRead;

}
