#Graystone

[![Build Status](https://drone.io/github.com/nfrancois/graystone/SerialPort/status.png)](https://drone.io/github.com/nfrancois/graystone/latest)

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
