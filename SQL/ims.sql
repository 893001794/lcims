SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

#化学流转单表
CREATE TABLE IF NOT EXISTS `t_chem_flow` (
  `vfid` varchar(20) DEFAULT NULL,
  `vsid` varchar(30) DEFAULT NULL,
  `vrid` varchar(20) DEFAULT NULL,
  `vpid` varchar(20) DEFAULT NULL,
  `eretest` enum('y','n') NOT NULL DEFAULT 'n',
  `eflowtype` enum('无机流转单','有机流转单','食品流转单','外包流转单','机构合作流转单') DEFAULT NULL,
  `vlab` varchar(100) DEFAULT NULL,
  `dpdtime` datetime DEFAULT NULL,
  `vlevel` varchar(6) DEFAULT NULL,
  `vpduser` varchar(50) DEFAULT NULL,
  `vworkpoint` varchar(20) DEFAULT NULL,
  `vworkpoint2` varchar(20) DEFAULT NULL,
  `vtestparent` varchar(255) DEFAULT NULL,
  `vtestchild` varchar(255) DEFAULT NULL,
  `itestcount` int(11) DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT '0',
  `notes` varchar(255) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=gbk AUTO_INCREMENT=5720 ;

#申请表备注（固定）
CREATE TABLE IF NOT EXISTS `t_chem_notes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `inform` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=gbk AUTO_INCREMENT=13 ;

#化学项目表
CREATE TABLE IF NOT EXISTS `t_chem_project` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `vsid` varchar(30) DEFAULT NULL,
  `vrid` varchar(20) DEFAULT NULL,
  `vpid` varchar(20) DEFAULT NULL,
  `vservname` varchar(20) DEFAULT NULL,
  `drptime` datetime DEFAULT NULL,
  `rpclient` varchar(255) DEFAULT NULL,
  `dsendtime` datetime DEFAULT NULL,
  `vsenduser` varchar(50) DEFAULT NULL,
  `erptype` enum('双语报告','中文报告','英文报告','不出报告','其他') DEFAULT NULL,
  `eiswarn` enum('y','n') NOT NULL DEFAULT 'n',
  `tappform` text,
  `iflowcount` int(11) DEFAULT NULL,
  `vsamplename` varchar(255) DEFAULT NULL,
  `tsampledesc` text,
  `vsamplecount` varchar(100) DEFAULT NULL,
  `tchangedetail` text,
  `taddnotes` text,
  `vnotes` varchar(50) DEFAULT NULL,
  `estatus` enum('立项','排单','流转单','测试','测试完成','重测','报告编制','报告审核','结案','发证','暂停','取消','错单') NOT NULL DEFAULT '立项',
  `istatus` int(11) NOT NULL DEFAULT '0',
  `eitem` enum('成品','食品','散单') DEFAULT NULL,
  `vengineer` varchar(20) DEFAULT NULL,
  `vworkpoint` varchar(20) DEFAULT NULL,
  `isfinish` enum('y','n') DEFAULT 'n',
  `vcreatename` varchar(50) DEFAULT NULL,
  `dcreatetime` datetime DEFAULT NULL,
  `dendtime` datetime DEFAULT NULL,
  `venduser` varchar(50) DEFAULT NULL,
  `eprojectend` enum('y','n') DEFAULT 'n',
  `vcontact` varchar(100) DEFAULT NULL,
  `ischecked` enum('n','y') NOT NULL DEFAULT 'n',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=gbk AUTO_INCREMENT=4714 ;

#化学项目状态时间表
CREATE TABLE IF NOT EXISTS `t_chem_project_time` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `vfid` varchar(20) DEFAULT NULL,
  `vrid` varchar(20) DEFAULT NULL,
  `vsid` varchar(20) DEFAULT NULL,
  `vuser` varchar(30) DEFAULT NULL,
  `vstatus` varchar(100) DEFAULT NULL,
  `dtime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=gbk AUTO_INCREMENT=14705 ;

#化学项目预警表
CREATE TABLE IF NOT EXISTS `t_chem_project_warn` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `vrid` varchar(20) DEFAULT NULL,
  `vsid` varchar(30) DEFAULT NULL,
  `vwarning` varchar(255) DEFAULT NULL,
  `dwarntime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=gbk AUTO_INCREMENT=445 ;

#化学测试小项（固定）
CREATE TABLE IF NOT EXISTS `t_chem_test_child` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `type` enum('无机流转单','有机流转单','食品流转单') NOT NULL,
  `category` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=gbk AUTO_INCREMENT=34 ;

#化学测试大项（固定）
CREATE TABLE IF NOT EXISTS `t_chem_test_parent` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `type` enum('无机流转单','有机流转单','食品流转单') NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=gbk AUTO_INCREMENT=49 ;

#客户表
CREATE TABLE IF NOT EXISTS `t_client` (
  `clientid` varchar(8) NOT NULL,
  `password` varchar(20) NOT NULL,
  `name` varchar(255) NOT NULL,
  `shortname` varchar(100) NOT NULL,
  `ename` varchar(255) DEFAULT NULL,
  `product` varchar(255) DEFAULT NULL,
  `clevel` enum('vip','normal') DEFAULT 'normal',
  `creditlevel` varchar(15) DEFAULT '10000',
  `pay` enum('现付','月结','买点') DEFAULT '现付',
  `addr` varchar(255) DEFAULT NULL,
  `eaddr` varchar(255) DEFAULT NULL,
  `zipcode` varchar(25) DEFAULT NULL,
  `area` varchar(50) DEFAULT NULL,
  `sales` varchar(50) DEFAULT NULL,
  `status` enum('有效','无效') DEFAULT '有效',
  `createtime` datetime DEFAULT NULL,
  `notes` varchar(255) DEFAULT NULL,
  `tag` enum('y','n') DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `salesid` int(11) DEFAULT NULL,
  `contactid` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=gbk AUTO_INCREMENT=920 ;

#客户地区表
CREATE TABLE IF NOT EXISTS `t_client_area` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `city` varchar(50) DEFAULT NULL,
  `code` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=gbk AUTO_INCREMENT=32 ;

#客户联系人
CREATE TABLE IF NOT EXISTS `t_client_contact` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `clientid` varchar(8) NOT NULL,
  `contact` varchar(100) NOT NULL,
  `sex` enum('男','女') DEFAULT NULL,
  `dept` varchar(50) DEFAULT NULL,
  `job` varchar(50) DEFAULT NULL,
  `tel` varchar(100) DEFAULT NULL,
  `mobile` varchar(30) DEFAULT NULL,
  `fax` varchar(100) DEFAULT NULL,
  `qq` varchar(30) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `status` enum('有效','无效') NOT NULL DEFAULT '有效',
  `time` datetime DEFAULT NULL,
  `notes` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=gbk AUTO_INCREMENT=926 ;

#客户权限表
CREATE TABLE IF NOT EXISTS `t_client_perm` (
  `userid` varchar(10) NOT NULL,
  `clientid` varchar(4) DEFAULT NULL,
  `name` varchar(4) DEFAULT NULL,
  `shortname` varchar(4) NOT NULL,
  `ename` varchar(4) DEFAULT NULL,
  `product` varchar(4) DEFAULT NULL,
  `clevel` varchar(4) DEFAULT NULL,
  `creditlevel` varchar(4) DEFAULT NULL,
  `pay` varchar(4) DEFAULT NULL,
  `addr` varchar(4) DEFAULT NULL,
  `eaddr` varchar(4) DEFAULT NULL,
  `zipcode` varchar(4) DEFAULT NULL,
  `area` varchar(4) DEFAULT NULL,
  `sales` varchar(4) DEFAULT NULL,
  `createtime` varchar(4) DEFAULT NULL,
  `notes` varchar(4) DEFAULT NULL,
  `tag` varchar(4) DEFAULT NULL,
  `status` varchar(4) DEFAULT NULL,
  `contact` varchar(4) DEFAULT NULL,
  `sex` varchar(4) DEFAULT NULL,
  `dept` varchar(4) DEFAULT NULL,
  `job` varchar(4) DEFAULT NULL,
  `tel` varchar(4) DEFAULT NULL,
  `mobile` varchar(4) DEFAULT NULL,
  `fax` varchar(4) DEFAULT NULL,
  `qq` varchar(4) DEFAULT NULL,
  `email` varchar(4) DEFAULT NULL,
  `cstatus` varchar(4) DEFAULT NULL,
  `ctime` varchar(4) DEFAULT NULL,
  `cnotes` varchar(4) DEFAULT NULL,
  PRIMARY KEY (`userid`)
) ENGINE=MyISAM DEFAULT CHARSET=gbk;

#公司信息表（固定）
CREATE TABLE IF NOT EXISTS `t_company` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT NULL,
  `fullname` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `tel` varchar(50) DEFAULT NULL,
  `fax` varchar(50) DEFAULT NULL,
  `url` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=gbk AUTO_INCREMENT=4 ;

#安规项目表
CREATE TABLE IF NOT EXISTS `t_phy_project` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `vpid` varchar(20) DEFAULT NULL,
  `vsid` varchar(30) DEFAULT NULL,
  `vrid` varchar(20) DEFAULT NULL,
  `estatus` enum('立项','排单','开案','测试','测试完成','重测','报告编制','报告审核','结案','发证','暂停','取消','错单') NOT NULL DEFAULT '立项',
  `eprojectend` enum('n','y') DEFAULT 'n',
  `erptype` enum('中文报告','英文报告','双语报告','不出报告','其它') DEFAULT NULL,
  `drptime` datetime DEFAULT NULL,
  `vservname` varchar(20) DEFAULT NULL,
  `vcontact` varchar(100) DEFAULT NULL,
  `vrpclient` varchar(255) DEFAULT NULL,
  `vsamplename` varchar(255) DEFAULT NULL,
  `vsamplecount` varchar(100) DEFAULT NULL,
  `vsamplecategory` varchar(255) DEFAULT NULL,
  `vsamplemodel` varchar(255) DEFAULT NULL,
  `vengineer` varchar(30) DEFAULT NULL,
  `vcreatename` varchar(30) DEFAULT NULL,
  `dcreatetime` datetime DEFAULT NULL,
  `istatus` int(11) NOT NULL DEFAULT '1',
  `isfinish` enum('n','y') DEFAULT 'n',
  `vbeginuser` varchar(30) DEFAULT NULL,
  `dbegintime` datetime DEFAULT NULL,
  `venduser` varchar(30) DEFAULT NULL,
  `dendtime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=gbk AUTO_INCREMENT=371 ;

#项目表（财务内容）
CREATE TABLE IF NOT EXISTS `t_project` (
  `vsid` varchar(30) NOT NULL,
  `vrid` varchar(20) DEFAULT NULL,
  `vpid` varchar(20) DEFAULT NULL,
  `eptype` enum('化学测试','电子电器安全测试','EMC测试','光性能测试','能效测试') DEFAULT NULL,
  `etype` enum('自测','机构合作','外包') DEFAULT NULL,
  `isout` enum('y','n') NOT NULL DEFAULT 'n',
  `elab` enum('中山实验室','东莞实验室') DEFAULT NULL,
  `vlevel` varchar(6) DEFAULT NULL,
  `vtestcontent` varchar(255) DEFAULT NULL,
  `fprice` float NOT NULL DEFAULT '0',
  `fpresubcost` float NOT NULL DEFAULT '0',
  `vsubname` varchar(255) DEFAULT NULL,
  `fpresubcost2` float NOT NULL DEFAULT '0',
  `vsubname2` varchar(255) DEFAULT NULL,
  `fsubcost` float NOT NULL DEFAULT '0',
  `dsubcosttime` datetime DEFAULT NULL,
  `vsubcostnotes` varchar(30) DEFAULT NULL,
  `vsubcosttag` varchar(255) DEFAULT NULL,
  `fsubcost2` float NOT NULL DEFAULT '0',
  `dsubcosttime2` datetime DEFAULT NULL,
  `vsubcostnotes2` varchar(30) DEFAULT NULL,
  `vsubcosttag2` varchar(255) DEFAULT NULL,
  `finsubcost` float NOT NULL DEFAULT '0',
  `vinsubtag` varchar(255) DEFAULT NULL,
  `fpreagcost` float NOT NULL DEFAULT '0',
  `vagname` varchar(255) DEFAULT NULL,
  `eclientpay` enum('n','y') NOT NULL DEFAULT 'n',
  `fagcost` float NOT NULL DEFAULT '0',
  `dagtime` datetime DEFAULT NULL,
  `vagnotes` varchar(255) DEFAULT NULL,
  `vagtag` varchar(255) DEFAULT NULL,
  `fotherscost` float NOT NULL DEFAULT '0',
  `votherstag` varchar(255) DEFAULT NULL,
  `einvtype` enum('不开','全额','不含机构费用','代开','收据') DEFAULT NULL,
  `vinvhead` varchar(255) DEFAULT NULL,
  `vinvcontent` varchar(255) DEFAULT NULL,
  `fpreinvprice` float NOT NULL DEFAULT '0',
  `finvprice` float NOT NULL DEFAULT '0',
  `vcontact` varchar(100) DEFAULT NULL,
  `vservname` varchar(50) DEFAULT NULL,
  `eprojectend` enum('y','n') NOT NULL DEFAULT 'n',
  `dendtime` datetime DEFAULT NULL,
  `venduser` varchar(50) DEFAULT NULL,
  `vbuildname` varchar(50) DEFAULT NULL,
  `dbuildtime` datetime DEFAULT NULL,
  `vcreatename` varchar(50) DEFAULT NULL,
  `dcreatetime` datetime DEFAULT NULL,
  `vprojectsettle` varchar(255) DEFAULT NULL,
  `fppreacount` float NOT NULL DEFAULT '0',
  `fpacount` float NOT NULL DEFAULT '0',
  `estatus` enum('未审核','已审核') NOT NULL DEFAULT '未审核',
  `vengineer` varchar(20) DEFAULT NULL,
  `vworkpoint` varchar(20) DEFAULT NULL,
  `isfinish` enum('y','n') NOT NULL DEFAULT 'n',
  `vnotes` varchar(255) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  UNIQUE KEY `vsid` (`vsid`)
) ENGINE=MyISAM  DEFAULT CHARSET=gbk AUTO_INCREMENT=5077 ;

#项目初检时间信息表
CREATE TABLE IF NOT EXISTS `t_project_time` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `vrid` varchar(20) DEFAULT NULL,
  `vsid` varchar(30) DEFAULT NULL,
  `vuser` varchar(30) DEFAULT NULL,
  `vevent` varchar(100) DEFAULT NULL,
  `dtime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=gbk AUTO_INCREMENT=4 ;

#订单表
CREATE TABLE IF NOT EXISTS `t_quotation` (
  `vpid` varchar(20) NOT NULL,
  `equotype` enum('new','add','mod') NOT NULL DEFAULT 'add',
  `vclient` varchar(255) DEFAULT NULL,
  `vrpclient` varchar(255) DEFAULT NULL,
  `vprojectcontent` varchar(255) DEFAULT NULL,
  `vsales` varchar(25) DEFAULT NULL,
  `vcompany` varchar(10) DEFAULT NULL,
  `dcreatetime` datetime DEFAULT NULL,
  `vcreateuser` varchar(25) DEFAULT NULL,
  `vconfirmuser` varchar(25) DEFAULT NULL,
  `dconfirmtime` datetime DEFAULT NULL,
  `dcompletetime` datetime DEFAULT NULL,
  `eadvancetype` varchar(128) DEFAULT NULL,
  `ftotalprice` float NOT NULL DEFAULT '0',
  `fpreadvance` float NOT NULL DEFAULT '0',
  `vcreditcard` varchar(255) DEFAULT NULL,
  `dpaytime` datetime DEFAULT NULL,
  `vpaynotes` varchar(30) DEFAULT NULL,
  `fsepay` float NOT NULL DEFAULT '0',
  `vsepayacount` varchar(50) DEFAULT NULL,
  `vsepaynotes` varchar(30) DEFAULT NULL,
  `dsepaytime` datetime DEFAULT NULL,
  `fprebalance` float NOT NULL DEFAULT '0',
  `fbalance` float NOT NULL DEFAULT '0',
  `vbalanceacount` varchar(50) DEFAULT NULL,
  `vbalancenotes` varchar(30) DEFAULT NULL,
  `dbalancetime` datetime DEFAULT NULL,
  `frefund` float NOT NULL DEFAULT '0',
  `vrefunddesc` varchar(255) DEFAULT NULL,
  `iprojectcount` int(11) NOT NULL DEFAULT '0',
  `eisfinish` enum('y','n') NOT NULL DEFAULT 'n',
  `epaymentclear` enum('y','n') NOT NULL DEFAULT 'n',
  `fprespefund` float NOT NULL DEFAULT '0',
  `fspefund` float NOT NULL DEFAULT '0',
  `vspefundtype` varchar(30) DEFAULT NULL,
  `dspefundtime` datetime DEFAULT NULL,
  `vspefunddesc` varchar(255) DEFAULT NULL,
  `fpreacount` float NOT NULL DEFAULT '0',
  `facount` float NOT NULL DEFAULT '0',
  `einvmethod` enum('分项目','总项目') DEFAULT NULL,
  `einvtype` enum('不开','全额','不含机构费用','借开','收据') DEFAULT NULL,
  `finvcount` float NOT NULL DEFAULT '0',
  `finvprice` float NOT NULL DEFAULT '0',
  `vinvhead` varchar(255) DEFAULT NULL,
  `dinvtime` datetime DEFAULT NULL,
  `vinvcontent` varchar(255) DEFAULT NULL,
  `vinvcode` varchar(20) DEFAULT NULL,
  `ftax` float NOT NULL DEFAULT '0',
  `vstatus` varchar(10) DEFAULT NULL,
  `econfirm` enum('未收到','已收到') NOT NULL DEFAULT '未收到',
  `eaudit` enum('未审核','已审核') NOT NULL DEFAULT '未审核',
  `vauditman` varchar(50) DEFAULT NULL,
  `daudittime` datetime DEFAULT NULL,
  `fstandprice` float NOT NULL DEFAULT '0',
  `vtag` varchar(255) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `clientid` int(11) DEFAULT NULL,
  `product` varchar(255) DEFAULT NULL,
  `productsample` varchar(255) DEFAULT NULL,
  `fpresubcost` float DEFAULT NULL,
  `fsubcost` float DEFAULT NULL,
  `finsubcost` float DEFAULT NULL,
  `fpreagcost` float DEFAULT NULL,
  `fagcost` float DEFAULT NULL,
  `fothercost` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `vpid` (`vpid`)
) ENGINE=MyISAM  DEFAULT CHARSET=gbk AUTO_INCREMENT=2941 ;

#报告图片信息表
CREATE TABLE IF NOT EXISTS `t_reportimg` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rid` varchar(30) DEFAULT NULL,
  `sid` varchar(30) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `imgurl` varchar(255) DEFAULT NULL,
  `detail` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=gbk AUTO_INCREMENT=2 ;

#报告图片目录表（固定）
CREATE TABLE IF NOT EXISTS `t_report_filedirect` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `parentid` int(11) DEFAULT NULL,
  `tag` enum('y','n') NOT NULL DEFAULT 'y',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=gbk AUTO_INCREMENT=7 ;

#报告模板表（固定）
CREATE TABLE IF NOT EXISTS `t_report_moduel` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `reportid` varchar(30) DEFAULT NULL,
  `testcontent` varchar(255) DEFAULT NULL,
  `testmethod` varchar(255) DEFAULT NULL,
  `category` enum('无机','有机','所有') DEFAULT NULL,
  `lan` enum('英文报告','中文报告') DEFAULT NULL,
  `fileid` int(11) DEFAULT NULL,
  `tag` enum('y','n') NOT NULL DEFAULT 'y',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=gbk AUTO_INCREMENT=153 ;

#报价单表
CREATE TABLE IF NOT EXISTS `t_sales_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `vpid` varchar(30) DEFAULT NULL,
  `quotype` enum('new','add','mod') DEFAULT NULL,
  `companyid` int(11) DEFAULT NULL,
  `salesid` int(11) DEFAULT NULL,
  `servid` int(11) DEFAULT NULL,
  `completetime` datetime DEFAULT NULL,
  `clientid` int(11) DEFAULT NULL,
  `circle` varchar(10) DEFAULT NULL,
  `bankid` int(11) DEFAULT NULL,
  `quotime` datetime DEFAULT NULL,
  `advancetypeid` int(11) DEFAULT NULL,
  `invmethod` enum('总项目','分项目') DEFAULT NULL,
  `invtype` enum('全额','不含机构费用','借开','收据') DEFAULT NULL,
  `invcount` float DEFAULT NULL,
  `invhead` varchar(255) DEFAULT NULL,
  `invcontent` varchar(255) DEFAULT NULL,
  `prespefund` float DEFAULT NULL,
  `tag` varchar(255) DEFAULT NULL,
  `product` varchar(255) DEFAULT NULL,
  `productsample` varchar(255) DEFAULT NULL,
  `totalprice` float DEFAULT NULL,
  `standprice` float DEFAULT NULL,
  `detail` varchar(255) DEFAULT NULL,
  `createuser` varchar(30) DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `status` enum('n','y') DEFAULT 'n',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=gbk AUTO_INCREMENT=1615 ;

#收款方式（固定）
CREATE TABLE IF NOT EXISTS `t_sales_order_advancetype` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT NULL,
  `vdesc` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=gbk AUTO_INCREMENT=9 ;

#收款银行账户（固定）
CREATE TABLE IF NOT EXISTS `t_sales_order_bank` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT NULL,
  `creditcard` varchar(50) DEFAULT NULL,
  `account` varchar(50) DEFAULT NULL,
  `address` varchar(50) DEFAULT NULL,
  `vdesc` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=gbk AUTO_INCREMENT=7 ;

#测试项目表（固定）
CREATE TABLE IF NOT EXISTS `t_sales_order_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `item_number` varchar(20) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `fullname` varchar(255) DEFAULT NULL,
  `parentid` varchar(20) DEFAULT NULL,
  `saleprice` float DEFAULT NULL,
  `standprice` float DEFAULT NULL,
  `controlprice` float DEFAULT NULL,
  `outprice` float DEFAULT NULL,
  `deleted` enum('n','y') DEFAULT 'n',
  `isparent` enum('n','y') DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=gbk AUTO_INCREMENT=652 ;

#报价单成品需求
CREATE TABLE IF NOT EXISTS `t_sales_order_product` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT NULL,
  `vdesc` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=gbk AUTO_INCREMENT=3 ;

#报价单成品样品资料
CREATE TABLE IF NOT EXISTS `t_sales_order_product_sample` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT NULL,
  `vdesc` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=gbk AUTO_INCREMENT=3 ;

#报价单测试项目要求表
CREATE TABLE IF NOT EXISTS `t_sales_order_quoitem` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `orderid` int(11) DEFAULT NULL,
  `itemid` int(11) DEFAULT NULL,
  `count` int(11) DEFAULT NULL,
  `saleprice` float DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `samplename` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=gbk AUTO_INCREMENT=2624 ;

#样品信息表
CREATE TABLE IF NOT EXISTS `t_sample` (
  `vsid` varchar(20) DEFAULT NULL,
  `vpid` varchar(20) DEFAULT NULL,
  `vrid` varchar(20) DEFAULT NULL,
  `vfid` varchar(20) DEFAULT NULL,
  `vsamplename` varchar(255) DEFAULT NULL,
  `vsampledesc` varchar(255) DEFAULT NULL,
  `isamplecount` int(11) DEFAULT NULL,
  `vclientid` varchar(8) DEFAULT NULL,
  `vtestcontent` varchar(255) DEFAULT NULL,
  `vinto` varchar(100) DEFAULT NULL,
  `dintime` datetime DEFAULT NULL,
  `vout` varchar(100) DEFAULT NULL,
  `douttime` datetime DEFAULT NULL,
  `vwarehouse` varchar(50) DEFAULT NULL,
  `vnotes` varchar(255) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=gbk;

#系统公告信息表
CREATE TABLE IF NOT EXISTS `t_system` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `head` varchar(255) DEFAULT NULL,
  `content` text,
  `createname` varchar(100) DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=gbk AUTO_INCREMENT=13 ;

#用户表
CREATE TABLE IF NOT EXISTS `t_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` varchar(10) NOT NULL,
  `name` varchar(20) NOT NULL,
  `password` varchar(128) DEFAULT NULL,
  `estatus` enum('有效','无效') NOT NULL DEFAULT '有效',
  `tel` varchar(30) DEFAULT NULL,
  `phone` varchar(30) NOT NULL,
  `email` varchar(30) DEFAULT NULL,
  `sex` enum('男','女') NOT NULL,
  `company` varchar(10) DEFAULT NULL,
  `dept` varchar(50) DEFAULT NULL,
  `job` varchar(50) DEFAULT NULL,
  `popdom` enum('admin','boss','manager','charge','user') NOT NULL DEFAULT 'user',
  `createtime` datetime DEFAULT NULL,
  `ticketid` varchar(128) DEFAULT NULL,
  `tag` enum('y','n') DEFAULT NULL,
  `sales` enum('y','n') NOT NULL DEFAULT 'n',
  `companyid` int(11) DEFAULT NULL,
  `serv` enum('y','n') NOT NULL DEFAULT 'n',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=gbk AUTO_INCREMENT=152 ;

#网站数据更新信息表
CREATE TABLE IF NOT EXISTS `t_webdata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `vurl` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=gbk AUTO_INCREMENT=3174 ;

#外包机构（固定）
CREATE TABLE IF NOT EXISTS `t_subname` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `category` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=gbk ;

#合作机构（固定）
CREATE TABLE IF NOT EXISTS `t_agname` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=gbk ;
