v1.0 
- 基础拍照功能

v1.1
- 基础拍照功能
- 按照时间建文件夹

v1.2
- 拍照逻辑进行了更改，在拍照的时刻调用摄像头，这样可以实现两个摄像头的分别调用

v2.0
- 增加了GUI，但是存在问题

V2.1
- 对GUI进行修改（还没改完）

V3.0
- 无GUI
- 实现了分别调用两个摄像头的功能
- 出现了长时间运行内存会爆掉的问题！

V3.1
- 定时重启，解决长时间运行，内存爆掉的问题（但为什么会出现爆内存的问题没解决）

V4.0
- 把程序进行了重写，改写了程序运行逻辑，尽可能减少一次循环占用的内存资源
- 比较复杂的功能都封装成了函数
- 使用百度PaddlePaddle深度学习框架，调用一个现成的深度学习的模型实现了抠图功能
