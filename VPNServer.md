#添加服务：

vi /etc/init.d/vpnserver
#新建一个vpnserver服务
#将vpnserver中的代码粘贴进去

systemctl enable vpnserver
#打开服务

systemctl start vpnserver
#启动服务
