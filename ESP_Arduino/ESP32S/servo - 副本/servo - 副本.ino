#include <ESP32Servo.h>

Servo myservo;  // 定义Servo对象来控制
int pos = 90;    // 角度存储变量

void setup() {
  myservo.attach(16);  // 控制线连接数字9
}

void kaideng(){
  myservo.write(pos);
  delay(2000);
  myservo.write(pos+45);
  delay(1000);
}

void guanding(){
  myservo.write(pos);
  delay(2000);
  myservo.write(pos-45);
  delay(1000);

}
void loop() {
  
//  for (pos = 0; pos <= 180; pos ++) { // 0°到180°
//    // in steps of 1 degree
//    myservo.write(pos);              // 舵机角度写入
//    delay(5);                       // 等待转动到指定角度
//  }
//  for (pos = 180; pos >= 0; pos --) { // 从180°到0°
//    myservo.write(pos);              // 舵机角度写入
//    delay(5);                       // 等待转动到指定角度
//  }
}
