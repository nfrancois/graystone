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

class ServoMotor extends Gpio {

  num _angle;

  ServoMotor(GpioConnection connection, int pin) : super(connection, pin);

  int get angle => _angle;

  void set angle(int value)  {
    _angle = value;
    _gpioConnection.servoWrite(pin, _angle);
  }

}
