#include <SPI.h>
#include <esp_now.h>
#include <WiFi.h>

SPISettings settings(1000000, LSBFIRST, SPI_MODE1);
SPIClass vspi(VSPI);
#define dataReadyPin 21

typedef struct struct_message {
    char encrypted_message[15];
} struct_message;
struct_message myMessage;

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
    delay(10);
    digitalWrite(5, LOW);
    delay(10);
    
    Serial.print("Sending Byte: "); Serial.print(curr_byte); Serial.print(" Response Byte: ");
    Serial.println( vspi.transfer(curr_byte));
    
    delay(10);
    digitalWrite(5, HIGH);
    delay(10);
    vspi.endTransaction();
  }  
//  digitalWrite(22, HIGH);
  delay(33);
  //Serial.println("waiting for data ready signal");
  while(digitalRead(dataReadyPin) == LOW) {
    delay(10);
  }
  Serial.println("recieved data ready signal");

  Serial.println("Read cycle");
  char decrypted_message[16];
//  digitalWrite(22, LOW);
  delay(50);
  for (byte i = 0; i < 16; i++) {
    vspi.beginTransaction(settings);
    delay(10);
    digitalWrite(5, LOW);
    delay(10);
    
    Serial.print("Sending Byte: ");Serial.print(0); Serial.print(" Response Byte: ");
    decrypted_message[i] = vspi.transfer(0);
    Serial.println( (byte) decrypted_message[i]);
//    decrypted_message[i] = response_byte;
    delay(10);
    digitalWrite(5, HIGH);
    delay(10);
    vspi.endTransaction();
  }
  digitalWrite(22, HIGH);

//  byte byte_message[15] = charArrayToBytes(decrypted_message, 16);
  decrypted_message[15] = '\0';
  Serial.println(decrypted_message);
  delay(250);
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

  Serial.begin(115200);
}

void loop() {

}
