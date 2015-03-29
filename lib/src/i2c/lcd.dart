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

part of graystone_i2c;

// i2c commands
const int CLEARDISPLAY = 0x01;
const int RETURNHOME = 0x02;
const int ENTRYMODESET = 0x04;
const int DISPLAYCONTROL = 0x08;
const int CURSORSHIFT = 0x10;
const int FUNCTIONSET = 0x20;
const int SETCGRAMADDR = 0x40;
const int SETDDRAMADDR = 0x80;

// flags for display entry mode
const int ENTRYRIGHT = 0x00;
const int ENTRYLEFT = 0x02;
const int ENTRYSHIFTINCREMENT = 0x01;
const int ENTRYSHIFTDECREMENT = 0x00;

// flags for display on/off control
const int DISPLAYON = 0x04;
const int DISPLAYOFF = 0x00;
const int CURSORON = 0x02;
const int CURSOROFF = 0x00;
const int BLINKON = 0x01;
const int BLINKOFF = 0x00;

// flags for display/cursor shift
const int DISPLAYMOVE = 0x08;
const int CURSORMOVE = 0x00;
const int MOVERIGHT = 0x04;
const int MOVELEFT = 0x00;

// flags for function set
const int EIGHTBITMODE = 0x10;
const int FOURBITMODE = 0x00;
const int TWOLINE = 0x08;
const int ONELINE = 0x00;
const int FIVExTENDOTS = 0x04;
const int FIVExEIGHTDOTS = 0x00;

// flags for backlight control
const int BACKLIGHT = 0x08;
const int NOBACKLIGHT = 0x00;

const int EN = 0x04; // Enable bit
const int RW = 0x02; // Read/Write bit
const int RS = 0x01; // Register select bit

class Lcd {

  final I2CConnection connection;
  final int _address = 0x27;// FIXME
  final int _backlightVal = NOBACKLIGHT;
  final int _displayfunction = FOURBITMODE | TWOLINE | FIVExEIGHTDOTS;
  final int _displaycontrol = DISPLAYON | CURSOROFF | BLINKOFF;
  final int _displaymode = ENTRYLEFT | ENTRYSHIFTDECREMENT;

  // TODO backlight
  // TODO rows
  // TODO cols
  Lcd(this.connection, {List pins, List size}){
    //_address = this.address || 0x27;
    connection.i2cConfig();
  }


  Future print(String message) async {
    await message.codeUnits.forEach(_writeData);
    return true;
  }

  // TODO setCursor(int x, int y)

  Future _writeData(int value) => _sendData(value, RS);

  Future _sendData(int value, int mode) async {
    final highnib = value & 0xf0;
    final lownib = (value << 4) & 0xf0;
    await _write4bits(highnib | mode);
    await _write4bits(lownib | mode);
    return true;
  }

  Future _sendCommand(int value) => _sendData(value, 0);

  Future _write4bits(int value) async {
    await _expanderWrite(value);
    await _pulseEnable(value);
    return true;
  }

  Future _expanderWrite(int value) => connection.i2cWrite(_address, [(value | _backlightVal) & 0xFF]);

  Future _pulseEnable(int value) async {
    await _expanderWrite(value | EN);
    //Cylon.Utils.sleep(0.0001);
    await _expanderWrite(value & ~EN);
    //Cylon.Utils.sleep(0.05);
    return true;
  }


}
