// LSB at pin 11, MSB at pin 13

int var;
String randomStr;
int r1;
int r2;
int r3;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  pinMode( 11, OUTPUT);
  pinMode( 12, OUTPUT);
  pinMode( 13, OUTPUT);
}

void loop() {
  // put your main code here, to run repeatedly:
  var = random(1, 8);
  r1 = var & B00000001;
  r2 = var & B00000010;
  r3 = var & B00000100;
  
  digitalWrite(11, var & B00000001);
  digitalWrite(12, var & B00000010);
  digitalWrite(13, var & B00000100);
  
  
  Serial.print(r3);
  Serial.print(r2);
  Serial.print(r1);
  Serial.print(" = ");
  Serial.println( var);
  
  
  delay(10);
}
