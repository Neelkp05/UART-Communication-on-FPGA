#define BAUD_RATE 115200

void setup() {
    Serial.begin(BAUD_RATE);
    Serial1.begin(BAUD_RATE, SERIAL_8N1, -1, 10); // RX = -1, TX = GPIO10
    delay(100);
    Serial.println("ESP32 Ready");
    Serial.println("Enter a number to send to FPGA:");
}

void loop() {
    if (Serial.available()) {
        String input = Serial.readStringUntil('\n');
        input.trim();
        if (input.length() > 0) {
            Serial1.print(input);
            Serial1.print('\n');
            Serial.print("Sent to FPGA: ");
            Serial.println(input);
        }
    }
}
