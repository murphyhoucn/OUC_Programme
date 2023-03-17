/*
发票统计
描述

有一个小型的报账系统，它有如下功能： 

1. 统计每个人所报发票的总钱数；

2. 统计每类发票的总钱数。

将此系统简化为如下：假设发票类别共有 A、B、C 三种；一共有三个人，ID 分别为 1、2、3。


输入
输入包含三行，
每行第一个数为人员 ID（整型，1 或 2 或 3），
第二个数为发票总张数（张数不超过 100），
之后是多个发票类别（字符型，A 或 B 或 C）和相应发票金额（单精度浮点型，不超过 1000.0）。

输出
输出包含六行，前三行为每人（按 ID 由小到大输出）所报发票总钱数（保留两位小数），
后三行为每类发票的总钱数（保留两位小数）。

1 5 A 1.0 A 2.0 C 1.0 B 1.0 C 1
3 3 B 1.0 C 2.0 C 1.0
2 4 B 1.0 A 1.0 C 1.0 A 1.0


1 6.00
2 4.00
3 4.00
A 5.00
B 3.00
C 6.00

*/



