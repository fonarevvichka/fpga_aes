#include <SPI.h>
#include <esp_now.h>
#include <WiFi.h>
#define dataReadyPin 21

SPISettings settings(100000, LSBFIRST, SPI_MODE1);
SPIClass vspi(VSPI);
uint8_t broadcastAddress[] = {0xF0, 0x08, 0xD1, 0xD1, 0x93, 0x30};

typedef struct struct_message {
  char encrypted_message[15];
} struct_message;
struct_message myMessage;

void OnDataSent(const uint8_t *mac_addr, esp_now_send_status_t status) {
  Serial.print("\r\nLast Packet Send Status:\t");
  Serial.println(status == ESP_NOW_SEND_SUCCESS ? "Delivery Success" : "Delivery Fail");
}

void setup() {
  Serial.begin(115200);
  WiFi.mode(WIFI_STA);

  // Init ESP-NOW
  if (esp_now_init() != ESP_OK) {
    Serial.println("Error initializing ESP-NOW");
    return;
  }

  esp_now_register_send_cb(OnDataSent);

   // Register peer
  esp_now_peer_info_t peerInfo;
  memcpy(peerInfo.peer_addr, broadcastAddress, 6);
  peerInfo.channel = 0;  
  peerInfo.encrypt = false;
  
  // Add peer        
  if (esp_now_add_peer(&peerInfo) != ESP_OK){
    Serial.println("Failed to add peer");
    return;
  }
  
  pinMode(5, OUTPUT); // set the CS pin as an output
  pinMode(22, OUTPUT);
  pinMode(dataReadyPin, INPUT);
  digitalWrite(22, HIGH);
  digitalWrite(5, LOW);
  SPI.end();
  vspi.begin();         // initialize the SPI library
}

void loop() {
  
  Serial.println("Write cycle");
  digitalWrite(22, LOW);
//  byte message[] = {0x00, 0x01, 0x00, 0x01, 0x00, 0x01, 0x00, 0x01, 0x00, 0x01, 0x00, 0x01, 0x00, 0x01, 0x00, 0x01};
  byte message[] = {0x68, 0x65, 0x6c, 0x6c, 0x6f, 0x20, 0x77, 0x6f, 0x72, 0x6c, 0x64, 0x21, 0x21, 0x21, 0x00, 0x00};
  for (byte i = 0; i < 16; i++) {
    vspi.beginTransaction(settings);
    delay(10);
    digitalWrite(5, LOW);
    delay(10);
    Serial.print("Sending Byte: ");Serial.print(i); Serial.print(" Response Byte: ");
//    Serial.println((char) vspi.transfer(message[i]));
    Serial.println(vspi.transfer(message[i]));

    delay(100);
    digitalWrite(5, HIGH);  
    vspi.endTransaction();
  }
  
  //Serial.println("waiting for data ready signal");
  while(digitalRead(dataReadyPin) == LOW) {
    delay(10);
  }
  
  Serial.println("recieved data ready signal");

  Serial.println("Read cycle");
  char encrypted_message[15];
  for (byte i = 0; i < 16; i++) {
    vspi.beginTransaction(settings);
    delay(10);
    digitalWrite(5, LOW);
    delay(10);
    Serial.print("Sending Byte: ");Serial.print(i);
    byte response_byte = vspi.transfer(0);
    Serial.print(" Response Byte: ");
//    Serial.println((char) response_byte);
    Serial.println(response_byte);

    encrypted_message[i] = response_byte;
    delay(100);
    digitalWrite(5, HIGH);  
    vspi.endTransaction();
  }
  digitalWrite(22, HIGH);
  
  //send data over wifi
  strcpy(myMessage.encrypted_message, encrypted_message);
  // Send message via ESP-NOW
  esp_err_t result = esp_now_send(broadcastAddress, (uint8_t *) &myMessage, sizeof(myMessage));
   
  if (result == ESP_OK) {
    Serial.println("Sent with success");
  }
  else {
    Serial.println("Error sending the data");
  }
  delay(7500); // simple wait before doing the process again
}
