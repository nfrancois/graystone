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

import 'package:graystone/graystone.dart';
import 'package:graystone/graystone_firmata.dart';
import 'package:graystone/graystone_gpio.dart';

void main() {

  final firmataConn = new FirmataConnection();
  final led = new Led(firmataConn, 5);
  final button = new Button(firmataConn, 2);

  new Robot([firmataConn], [led, button])
    ..behaviour = (() {
      button.onPress.listen((_) => led.on());
      button.onRelease.listen((_) => led.off());
    })
    ..start();

}

