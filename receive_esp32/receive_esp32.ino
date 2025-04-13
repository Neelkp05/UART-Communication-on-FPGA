#define BAUD_RATE 9600

void setup() {
    Serial2.begin(BAUD_RATE, SERIAL_8N1, 16, -1);  // RX2 = GPIO16
    delay(100);
    Serial.begin(BAUD_RATE);
    Serial.println("ESP32 Ready to Receive from FPGA on RX2 (GPIO16)");
}

void loop() {
    if (Serial2.available()) {
        char receivedChar = Serial2.read();
        Serial.print("Received: ");
        Serial.print(receivedChar);
        Serial.print(" (ASCII: ");
        Serial.print((int)receivedChar);
        Serial.println(")");
    }
}
