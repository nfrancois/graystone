part of graystone_i2c;

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
//
//
// https://github.com/MrYsLab/PyMata/blob/master/examples/i2c/pymata_i2c_write/bicolor_display_controller.py
// https://github.com/adafruit/Adafruit-LED-Backpack-Library/blob/master/Adafruit_LEDBackpack.cpp
//

class LedBackpack extends I2CDevice {
    
    // blink rate defines
    final HT16K33_BLINK_CMD = 0x80;
    final HT16K33_BLINK_DISPLAYON = 0x01;
    final HT16K33_BLINK_OFF = 0;
    final HT16K33_BLINK_2HZ = 1;
    final HT16K33_BLINK_1HZ = 2;
    final HT16K33_BLINK_HALFHZ = 3;

    // oscillator control values
    final OSCILLATOR_ON = 0x21;
    final OSCILLATOR_OFF = 0x20;

    // led color selectors
    final LED_OFF = 0;
    final LED_RED = 1;
    final LED_YELLOW = 2;
    final LED_GREEN = 3;
    
    // brightness
    final MAX_BRIGHTNESS = 15
    
    
    int boardAddress;   // i2c address
    int blinkRate; // blink rate
    int brightness; // brightness
    
    ColorDisplay(I2Connection connection, this.boardAddress, this.blinkRate, this.brightness): super(connection);
    
    Future init() async {
        await clear();
        await connection.i2Config();
        return true;
    }
    
    /// Set the user's desired blink rate (0 - 3)    
    Future set blinkRate(int value) async {
        if(value > 3){
            value = 0 
        }
        connection.i2cWrite(boardAddress, (HT16K33_BLINK_CMD | HT16K33_BLINK_DISPLAYON | (value << 1)))
    }    

    /// Turn oscillator on or off 
    Future set oscillator(int value){
        return connection.i2cWrite(boardAddress, value);
    }    
    
    /// Set the brightness level (0 -15) for the entire display
    Future set blinkRate(int value) async {
        if(value > 15){
            value = 15 
        }
        connection.i2cWrite(0x70, brightness)
    }
        
    
    /// Set all led's to off.
    Future clear(){
        for(int row=0; row<8; row++){
            await connection.i2cWrite(0x70, row*2, 0, 0);
            await connection.i2cWrite(0x70, (row*2+1), 0, 0);
            
            for (int col = 0, col <8; col++) {
              // self.display_buffer[row][column] = 0
            }
        }
    }


    
    /*def set_pixel(self, row, column, color, suppress_write):
        # rows 0,2,4,6,8,10,12,14 are green
        # rows 1,3,5,7,9,11,13,15 are red
        #
        # A row entry consists of 2 bytes, the first always being 0 and the second
        # being the state of the pixel (high or low)
        """
        @param row: pixel row number
        @param column: pix column number
        @param color: pixel color (yellow is both red and green both on)
        @param suppress_write: if true, just sets the internal data structure, else writes out the pixel to the display
        """
        if (row < 0) or (row >= 8):
            print("set_pixel(): ROW out of range")
            return
        if (column < 0) or (column >= 8):
            print("set_pixel(): COLUMN out of range")
            return

        self.display_buffer[row][column] = color

        # output changes to row on display

        green = 0
        red = 0

        # calculate row for green rows and then adjust it for red

        for col in range(0, 8):
            # assemble green data for the row and output
            if self.display_buffer[row][col] == self.LED_GREEN:
                green |= 1 << col
            elif self.display_buffer[row][col] == self.LED_RED:
                red |= 1 << col
            elif self.display_buffer[row][col] == self.LED_YELLOW:
                green |= 1 << col
                red |= 1 << col
            elif self.display_buffer[row][col] == self.LED_OFF:
                green &= ~(1 << col)
                red &= ~(1 << col)

        if not suppress_write:
            self.firmata.i2c_write(0x70, row * 2, 0, green)
            self.firmata.i2c_write(0x70, row * 2 + 1, 0, red)
            */
            
    Future setPixel(int col, int row, int color, boolean suppressWrite ) {
        // TODO check pixels range
        //for(int row=0; row<8; row++){
            
            for (int col = 0, col <8; col++) { 
            
                
            }
        //}
    }      
    
    Future close() => connection.close();
    
}

