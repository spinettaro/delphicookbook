int relay_pin_1 = 8;
int relay_pin_2 = 9;


void setup() {
  // put your setup code here, to run once:
  pinMode(relay_pin_1, OUTPUT);
  pinMode(relay_pin_2, OUTPUT);

  digitalWrite(relay_pin_1, HIGH);
  digitalWrite(relay_pin_2, HIGH);

  // initialize Serial to a data rate
  Serial.begin(115200);     // Port serial 9600 baud.
}

void loop() {
  // put your main code here, to run repeatedly:
  delay(2000);
  // turn light bulb 1 on
  digitalWrite(relay_pin_1, LOW);
  Serial.print("L1_ON");
  delay(5000);

 // turn light bulb 1 off
  digitalWrite(relay_pin_1, HIGH);
  Serial.print("L1_OFF");
  delay(5000);

 // turn light bulb 2 on
  digitalWrite(relay_pin_2, LOW);
  Serial.print("L2_ON");
  delay(5000);

 // turn light bulb 2 off
  digitalWrite(relay_pin_2, HIGH);
  Serial.print("L2_OFF");
  delay(5000);

}
