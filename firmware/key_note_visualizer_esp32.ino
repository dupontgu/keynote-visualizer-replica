
#include <NeoPixelBus.h>

#include "BleMidi.h"

BLEMIDI_CREATE_INSTANCE(bm);

#define KEYS 44
#define MIN_NOTE 41 //F1
#define MAX_NOTE MIN_NOTE + KEYS
#define LED_PIN_KEYS 33
#define LED_PIN_STAFF 27
#define LED_COUNT_KEYS KEYS
#define LED_COUNT_STAFF 26
#define FADE_SPEED 2
#define LED_COUNT LED_COUNT_KEYS + LED_COUNT_STAFF

#define MODE_SHARP 0
#define MODE_FLAT 1

#define COLOR_MODE_NORMAL 0
#define COLOR_MODE_RAINBOW 1
#define COLOR_MODE_CUSTOM 2
#define COLOR_MODE_RED 3
#define COLOR_MODE_GREEN 4
#define COLOR_MODE_BLUE 5

#define MAX_VELOCITY_SCALE 1.5

byte activeKeys[KEYS];
byte brightnessArray[KEYS];
byte channels[KEYS];

float RED[] = {0.8, 0.2, 0.3};
float GREEN[] = {0.2, 0.8, 0.3};
float BLUE[] = {0.2, 0.2, 0.8};

byte flatStaffMap[] = {
  0, 0, 1, 1, 2, 2, 3, 4, 4, 5, 5, 6,
  7, 7, 8, 8, 9, 9, 10, 11, 11, 12, 12, 13,
  14, 14, 15, 15, 16, 16, 17, 18, 18, 19, 19, 20,
  21, 21, 22, 22, 23, 23, 24, 25
};

byte sharpStaffMap[] = {
  0, 1, 1, 2, 2, 3, 3, 4, 5, 5, 6, 6,
  7, 8, 8, 9, 9, 10, 10, 11, 12, 12, 13, 13,
  14, 15, 15, 16, 16, 17, 17, 18, 19, 19, 20, 20,
  21, 22, 22, 23, 23, 24, 24, 25
};

byte currentMode = MODE_FLAT;
byte colorMode = COLOR_MODE_RAINBOW;
float velocityScale = MAX_VELOCITY_SCALE;
float customR = 1.0;
float customG = 0.0;
float customB = 0.0;

NeoPixelBus<NeoRgbFeature, Neo800KbpsMethod> keyPixels(LED_COUNT, LED_PIN_KEYS);


void setup() {
  Serial.begin(115200);
  while (!Serial) {
    ;
  }

  keyPixels.Begin();
  keyPixels.ClearTo(RgbColor(0));
  delay(100);
  keyPixels.Show();

  bm.begin("Key / Note Visualizer");

  bm.onConnected(onBleMidiConnected);
  bm.onDisconnected(onBleMidiDisconnected);

  bm.setHandleNoteOn(onBleMidiNoteOn);
  bm.setHandleNoteOff(onBleMidiNoteOff);
  bm.setHandleControlChange(onMidiControlChange);

  for (int i = 0; i++; i < KEYS) {
    activeKeys[i] = 0;
    brightnessArray[i] = 0;
  }
}

void loop() {
  byte leds[LED_COUNT] = {};
  byte* staffMap;
  if (currentMode == MODE_FLAT) {
    staffMap = flatStaffMap;
  } else if (currentMode == MODE_SHARP) {
    staffMap = sharpStaffMap;
  }
  for (int i = 0; i < KEYS; i++) {
    byte expected = activeKeys[i];
    byte current = brightnessArray[i];
    byte updated = 0;
    // increment/decrement brightness towards fully on/off
    if (current < expected) {
      updated = current + FADE_SPEED + 1;
      if (updated > expected || updated < current) updated = expected;
    } else if (current > expected) {
      updated = current - FADE_SPEED;
      if (updated < 0 || updated > current) updated = 0;
    } else {
      updated = expected;
    }
    brightnessArray[i] = updated;

    RgbColor color;
    // if it's this low, just shut it off
    if (updated < 5) {
      color = RgbColor(0);
    } else {
      color = colorForChannel(channels[i], i, updated); 
    }

    if (updated > leds[i]) {
      leds[i] = updated;
      keyPixels.SetPixelColor(i, color);
    }

    // My clef's data line is wired reverse, oops
    int staff = -(staffMap[i] - (LED_COUNT_STAFF - 1)) + KEYS;
    // int staff = staffMap[i] + KEYS;
    if (staff < LED_COUNT && updated > leds[staff]) {
      leds[staff] = updated;
      keyPixels.SetPixelColor(staff, color);
    }
  }

  keyPixels.Show();
  delay(2);
}

void onBleMidiConnected() {
  Serial.println(F("Connected"));
}

void onBleMidiDisconnected() {
  Serial.println(F("Disconnected"));
}

void onBleMidiNoteOn(byte channel, byte note, byte velocity) {
  if (note < MIN_NOTE || note > MAX_NOTE) {
    return;
  }
  byte adjustedNote = note - MIN_NOTE;
  if (channel >= channels[adjustedNote] || activeKeys[adjustedNote] == 0) {
    channels[adjustedNote] = channel;
    activeKeys[adjustedNote] = velocity * velocityScale;
  }
}

void onBleMidiNoteOff(byte channel, byte note, byte velocity) {
  if (note < MIN_NOTE || note > MAX_NOTE) {
    return;
  }
  byte adjustedNote = note - MIN_NOTE;
  if (channel == channels[adjustedNote]) {
    activeKeys[note - MIN_NOTE] = 0;
  }
}

void onMidiControlChange(byte channel, byte number, byte value) {
  if (number == 0) {
    if (value == 0) {
      currentMode = MODE_FLAT;
    } else if (value == 1) {
      currentMode = MODE_SHARP;
    }
  } else if (number == 1) {
      // MIDI CC 1 -> brightness
    velocityScale = ((float) value / 127.0) * MAX_VELOCITY_SCALE;
  } else if (number == 2) {
      // MIDI CC 2 -> red
    customR = ((float) value / 127.0);
  } else if (number == 3) {
      // MIDI CC 1 -> green
    customG = ((float) value / 127.0);
  } else if (number == 4) {
      // MIDI CC 1 -> blue
    customB = ((float) value / 127.0);
  }
}

RgbColor colorForChannel(byte channel, byte note, byte updated) {
  if (channel == COLOR_MODE_RAINBOW) {
      byte wheelPos = (256 / KEYS) * note;
      return wheel(wheelPos, (float) updated / (127.0 * MAX_VELOCITY_SCALE));
    } else if (channel == COLOR_MODE_CUSTOM) {
      byte r = updated * customR;
      byte g = updated * customG;
      byte b = updated * customB;
      return RgbColor(r, g, b);
    } else if (channel == COLOR_MODE_RED) {
      return RgbColor(RED[0] * updated, RED[1] * updated, RED[2] * updated);
    } else if (channel == COLOR_MODE_GREEN) {
      return RgbColor(GREEN[0] * updated, GREEN[1] * updated, GREEN[2] * updated);
    } else if (channel == COLOR_MODE_BLUE) {
      return RgbColor(BLUE[0] * updated, BLUE[1] * updated, BLUE[2] * updated);
    } else {
      byte r = updated * 0.85;
      byte g = updated;
      byte b = updated * 0.4;
      return RgbColor(r, g, b);
    }
}

// for rainbow mode!
RgbColor wheel(byte wheelPos, float brightness) {
  if (wheelPos < 85) {
    return RgbColor((wheelPos * 3) * brightness, (255 - wheelPos * 3) * brightness, 0);
  }
  else if (wheelPos < 170) {
    wheelPos -= 85;
    return RgbColor((255 - wheelPos * 3) * brightness, 0, (wheelPos * 3) * brightness);
  }
  else {
    wheelPos -= 170;
    return RgbColor(0, (wheelPos * 3) * brightness, (255 - wheelPos * 3) * brightness);
  }
}