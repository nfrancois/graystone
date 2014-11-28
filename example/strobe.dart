import 'package:graystone/graystone.dart';
import 'package:graystone/graystone-gpio.dart';
import 'package:graystone/graystone-firmata.dart';

void main() {

	final firmataConn = new FirmataConnection();
	final led = new Led(firmataConn, 13);

	new Robot([firmataConn], [led])
			..behaviour = (() => led.strobe())
			..start();

}
