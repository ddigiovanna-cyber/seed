#include <Arduino.h>
#include "esp_camera.h"
#include <Wire.h>
#include "Adafruit_SHT4x.h"
#include <RadioLib.h>

#define TIME_TO_SLEEP  21600ULL * 1000000ULL 

Adafruit_SHT4x sht4 = Adafruit_SHT4x();
SX1262 radio = new Module(41, 39, 42, 40);

void setup() {
  Serial.begin(115200);
  Wire.begin(5, 6);
  sht4.begin();
  sensors_event_t humidity, temp;
  sht4.getEvent(&humidity, &temp);
  int leafWetness = analogRead(1);
  float batteryVoltage = (analogRead(3) / 4095.0) * 3.3 * 2;

  pinMode(2, OUTPUT);
  digitalWrite(2, HIGH);
  delay(200);
  camera_fb_t * fb = esp_camera_fb_get();
  digitalWrite(2, LOW);

  int alienSpeciesCount = 0;
  if (fb) {
    // Inserire qui la chiamata alla libreria Edge Impulse FOMO quantizzata INT8
    esp_camera_fb_return(fb);
  }

  uint8_t payload[7];
  int16_t tempInt = temp.temperature * 100;
  uint16_t humInt = humidity.relative_humidity * 100;
  
  payload[0] = highByte(tempInt);
  payload[1] = lowByte(tempInt);
  payload[2] = highByte(humInt);
  payload[3] = lowByte(humInt);
  payload[4] = map(leafWetness, 0, 4095, 0, 100);
  payload[5] = (uint8_t)alienSpeciesCount;
  payload[6] = (uint8_t)(batteryVoltage * 50);

  delay(random(0, 30000));

  radio.begin(868.0);
  radio.transmit(payload, sizeof(payload));
  radio.sleep();

  esp_sleep_enable_timer_wakeup(TIME_TO_SLEEP);
  esp_deep_sleep_start();
}

void loop() {}
