int relay_pin_1 = 8;
int relay_pin_2 = 9;
String command;
char receivedChar;

// read from serial and concat it to command
void readFromSerial() {
  while (Serial.available() > 0) {
    receivedChar = Serial.read();
    command.concat(receivedChar);
    delay(10);
  }
}


void setup() {
  // put your setup code here, to run once:
  pinMode(relay_pin_1, OUTPUT);
  pinMode(relay_pin_2, OUTPUT);

  digitalWrite(relay_pin_1, HIGH);
  digitalWrite(relay_pin_2, HIGH);

  // initialize Serial to a data rate
  Serial.begin(9600);     // Port serial 9600 baud.
}

void doCommand() {
  // turn light bulb 1 on
  if (command.equals("L1_ON") == true) {
    digitalWrite(relay_pin_1, LOW);
    return;
  }
  // turn light bulb 1 off
  if (command.equals("L1_OFF") == true) {
    digitalWrite(relay_pin_1, HIGH);
    return;
  }

  // turn light bulb 2 on
  if (command.equals("L2_ON") == true) {
    digitalWrite(relay_pin_2, LOW);
    return;
  }
  // turn light bulb 2 off
  if (command.equals("L2_OFF") == true) {
    digitalWrite(relay_pin_2, HIGH);
    return;
  }

}

void loop() {
  // put your main code here, to run repeatedly:
  readFromSerial();
  doCommand();
  delay(200); // wait for a second

  // Clean the command to receive the next
  command = "";

}
