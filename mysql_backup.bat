net stop mysql
xcopy "C:\Program Files\MySQL\MySQL Server 5.0\data\ims\*.*" "C:\mysql_bak\ims\%date:~0,11%\" /y
xcopy "C:\Program Files\MySQL\MySQL Server 5.0\data\invoicemanager\*.*" "C:\mysql_bak\invoicemanager\%date:~0,11%\" /y
net start mysql