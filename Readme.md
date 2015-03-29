#Graystone

[![pub package](https://img.shields.io/pub/v/graystone.svg)](https://pub.dartlang.org/packages/graystone)
[![Build Status](https://drone.io/github.com/nfrancois/graystone/status.png)](https://drone.io/github.com/nfrancois/graystone/latest)

Inspired by cylon.js

The rise of Dart Bot !

```Dart

import 'package:graystone/graystone.dart';
import 'package:graystone/graystone_firmata.dart';
import 'package:graystone/graystone_gpio.dart';

void main() {

	final firmataConn = new FirmataConnection();
	final led = new Led(firmataConn, 13);

	new Robot([firmataConn], [led])
			..behaviour = (() => led.strobe())
			..start();

}


```
