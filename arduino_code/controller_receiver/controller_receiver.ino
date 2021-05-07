#include <SPI.h>
#include <esp_now.h>
#include <WiFi.h>

SPISettings settings(1000000, LSBFIRST, SPI_MODE0);
SPIClass vspi(VSPI);
#define dataReadyPin 21

typedef struct struct_message {
    char encrypted_message[15];
} struct_message;


struct_message myMessage;
void charArrayToBytes(char* message, int len) {
  byte new_message[15];
  for (int i = 0; i < len; i++) {
    new_message[i] = (byte) message[i];
  }
  return new_message;
}
void OnDataRecv(const uint8_t * mac, const uint8_t *incomingData, int len) {
  memcpy(&myMessage, incomingData, sizeof(myMessage));
  Serial.print("Bytes received: ");
  Serial.println(len);
  Serial.print("Encrypted Message: ");
  Serial.println(myMessage.encrypted_message);
  Serial.println();

  Serial.println("Write cycle");
  digitalWrite(22, LOW);
  
  for (byte i = 0; i < 16; i++) {
    byte curr_byte = (byte) myMessage.encrypted_message[i];
    
    vspi.beginTransaction(settings);
    digitalWrite(5, LOW);
    Serial.print("Sending Byte: "); Serial.print(curr_byte); Serial.print(" Response Byte: "); Serial.println(vspi.transfer(curr_byte));
    delay(330);
    digitalWrite(5, HIGH);  
    vspi.endTransaction();
  }
  
  //Serial.println("waiting for data ready signal");
  while(digitalRead(dataReadyPin) == LOW) {
    delay(10);
  }
  Serial.println("recieved data ready signal");


  Serial.println("Read cycle");
  char decrypted_message[15];
  for (byte i = 0; i < 16; i++) {
    vspi.beginTransaction(settings);
    digitalWrite(5, LOW);
    Serial.print("Sending Byte: ");Serial.print(0); Serial.print(" Response Byte: ");
    byte response_byte = vspi.transfer(0);
    Serial.println(response_byte);
    decrypted_message[i] = response_byte;
    delay(300);
    digitalWrite(5, HIGH);  
    vspi.endTransaction();
  }
  digitalWrite(22, HIGH);

  // convert message to byte form here
  Serial.println(decrypted_message);
  delay(1000);
}

void setup() {
  // Set device as a Wi-Fi Station
  WiFi.mode(WIFI_STA);

  // Init ESP-NOW
  if (esp_now_init() != ESP_OK) {
    Serial.println("Error initializing ESP-NOW");
    return;
  }

  esp_now_register_recv_cb(OnDataRecv);
  
  pinMode(5, OUTPUT); // set the CS pin as an output
  pinMode(22, OUTPUT);
  pinMode(dataReadyPin, INPUT);
  digitalWrite(22, HIGH);
  digitalWrite(5, LOW);
  SPI.end();
  vspi.begin();         // initialize the SPI library

  Serial.begin(115200);}

void loop() {

}
