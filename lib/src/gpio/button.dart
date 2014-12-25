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


class Button extends DigitalGpio {

  StreamController _pressController = new StreamController();
  StreamController _releaseController = new StreamController();

  Button(GpioConnection connection, int pin) : super(connection, pin, GpioPinMode.INPUT);

  Future init() =>
    super.init().then((_){
      (connection as GpioConnection).onDigitalRead.where((pinState) => pinState.pin == pin).listen((pinState){
        switch(pinState.value){
          case 0:// TODO replace 0 by constant
            if(isReleased){
              _value = GpioVoltage.LOW;
              _pressController.add(true);
            }
            break;
          case 1:// TODO replace 0 by constant
            if(isPressed) {
              _value = GpioVoltage.HIGH;
              _releaseController.add(true);
            }
            break;
        }
      });
    });

  Stream get onPress => _pressController.stream;

  Stream get onRelease => _releaseController.stream;

  bool get isPressed => _value == GpioVoltage.LOW;

  bool get isReleased => _value == GpioVoltage.HIGH;

}
