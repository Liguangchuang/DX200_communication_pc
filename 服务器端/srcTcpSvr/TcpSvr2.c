﻿/* TcpSvr2.c */
/* Copyright 2009 YASKAWA ELECTRIC All Rights reserved. */

#include "motoPlus.h"
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

// for API & FUNCTIONS
void moto_plus0_task(void);//子函数的声明
void ap_TCP_Sserver(ULONG portNo);//子函数的声明
#define PORT        11000 //端口号，
#define BUFF_MAX    1023

char* result[100];

void moto_plus0_task(void)
{
    puts("Activate moto_plus0_task!");

    ap_TCP_Sserver(PORT);

    mpSuspendSelf;//通讯程序停止，表示子任务的停止。
}

//char *strupr(char *string);
char* location(char*string );

void ap_TCP_Sserver(ULONG portNo)
{
    int     sockHandle;
    struct  sockaddr_in  serverSockAddr;
    int     rc;

    printf("Simple TCP server\n");

    sockHandle = mpSocket(AF_INET, SOCK_STREAM, 0);//创建socket,这里需要注意三个参数：第一个参数只有一种值，AF_INET表示使用ipv4通信簇， 确定通信类型：tcp或者tdp，该函数会输出一个新建的socket的描述符。
    if (sockHandle < 0)//如果socket创建失败，进行返回
        return;

    memset(&serverSockAddr, 0, sizeof(serverSockAddr));//初始化，
    serverSockAddr.sin_family = AF_INET; //该参数表示使用ipv4的协议。
    serverSockAddr.sin_addr.s_addr = INADDR_ANY;//INADDR_ANY就是指定地址为0.0.0.0的地址，这个地址事实上表示不确定地址，或“所有地址”、“任意地址”。 一般来说，在各个系统中均定义成为0值。
    serverSockAddr.sin_port = mpHtons(portNo);//将十进制的端口号转化成为网络形式的端口号。

    rc = mpBind(sockHandle, (struct sockaddr *)&serverSockAddr, sizeof(serverSockAddr)); //绑定socket和端口号，对sockt绑定需要知道该socket的描述符，还有需要知道服务器端的端口地址。
    if (rc < 0)
        goto closeSockHandle;//关闭端口号，

    rc = mpListen(sockHandle, SOMAXCONN);//监听端口号
    if (rc < 0)
        goto closeSockHandle;

    while (1)
    {
        int     acceptHandle;//接收到信息的的字节数
        struct  sockaddr_in     clientSockAddr;
        int     sizeofSockAddr;

        memset(&clientSockAddr, 0, sizeof(clientSockAddr));
        sizeofSockAddr = sizeof(clientSockAddr);
        

        acceptHandle = mpAccept(sockHandle, (struct sockaddr *)&clientSockAddr, &sizeofSockAddr);//接收来自客户端的链接请求

        if (acceptHandle < 0)
            break;

        while( 1 )
        {
            int     bytesRecv;
            int     bytesSend;
            char    buff[BUFF_MAX + 1];

            memset(buff, 0, sizeof(buff));
            buff[]="请确定开启机械臂：yes or no？"；
            mpSend(acceptHandle,buff, bytesRecv, 0)；
            
            while(1)
            {
            	memset(buff, 0, sizeof(buff));
            	bytesRecv = mpRecv(acceptHandle, buff, BUFF_MAX, 0);//从socket中提取字符
            	if(bytesRecv > 0)
            	{
            		if (strncmp(buff, "yes", 3) == 0 || strncmp(buff, "YES", 3) == 0)
              			{
              	 			memset(buff, 0, sizeof(buff));
              				buff[100]="请输入坐标"；
              				bytesSend = mpSend(acceptHandle,buff, bytesRecv, 0);
              				while(1)
              				{
              					memset(buff, 0, sizeof(buff));
              					bytesRecv = mpRecv(acceptHandle, buff, BUFF_MAX, 0);//从socket中提取字符
              					if(bytesRecv>0)
              					{
              						//进入一个子函数将坐标传给机器人,执行完任务之后返回最后一个，
              					}
              					
              					if(bytesRecv=0);
              					if(bytesRecv<0) break;
	
              				}
             			 }
             			 
             	    if (strncmp(buff, "no", 2) == 0 || strncmp(buff, "NO", 2) == 0)
              			{
              	 			break;
             			}

            		
            	}
            	if(bytesRecv =0)
            	{
            		
            	}
            	else break;

            }

            bytesRecv = mpRecv(acceptHandle, buff, BUFF_MAX, 0);//从socket中提取字符
            
            puts(buff);

            if (bytesRecv < 0)
                break;

            /* 受信データを大文字に変換して送り返す */
           // strupr(buff);
            location(buff);
            bytesSend = mpSend(acceptHandle,buff, bytesRecv, 0);//向socket写入信息

            if (strncmp(buff, "yes", 3) == 0 || strncmp(buff, "YES", 3) == 0)
              {
              	 memset(buff, 0, sizeof(buff));
              	 buff[100]="请输入坐标"；
              	 bytesSend = mpSend(acceptHandle,buff, bytesRecv, 0);
              }
              
            if (bytesSend != bytesRecv)
                break;
             

            if (strncmp(buff, "EXIT", 4) == 0 || strncmp(buff, "exit", 4) == 0)
                break;
        }
        mpClose(acceptHandle);//关闭socket
    }
closeSockHandle:
    mpClose(sockHandle);//关闭socket

    return;
}

/*char *strupr(char *string)//对字符实现转化，将小写字母转化成大写字母。
{
    int		i;
    int     len;

    len = strlen(string);
	for (i=0; i < len; i++)
	{
	    if (isalpha((unsigned char)string[i]))
	    {
		    string[i] = toupper(string[i]);
        }
	}
    return (string);
}*/

char *location(char*string ){

/****************将buff转成整形数组**************/
int i=0;
int b[3];
char g[100];
char * p;
const char * split = ",";

p = strtok (string,split);

while(p!=NULL)
{

   b[i]= atoi(p);
   printf ("%d\n",b[i]);
   i++;
   p = strtok(NULL,split);

}
  


/****************将整形数组转成字符串**************/

int L;
sprintf(g,"");
for (i=0;i<3;i++) 
{
	L = strlen(g);
	if (i<2) 
	   sprintf(g+L,"\%d\,,",b[i]);
	else 
	   sprintf(g+L,"\%d",b[i]);
};
/****************************************************/
 int len;
  len = strlen(g);
  for (i=0; i < len; i++)
  {
  	string[i] = g[i];
  }
   
return(string);
}


