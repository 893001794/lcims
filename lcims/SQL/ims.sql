SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

#��ѧ��ת����
CREATE TABLE IF NOT EXISTS `t_chem_flow` (
  `vfid` varchar(20) DEFAULT NULL,
  `vsid` varchar(30) DEFAULT NULL,
  `vrid` varchar(20) DEFAULT NULL,
  `vpid` varchar(20) DEFAULT NULL,
  `eretest` enum('y','n') NOT NULL DEFAULT 'n',
  `eflowtype` enum('�޻���ת��','�л���ת��','ʳƷ��ת��','�����ת��','����������ת��') DEFAULT NULL,
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

#�����ע���̶���
CREATE TABLE IF NOT EXISTS `t_chem_notes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `inform` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=gbk AUTO_INCREMENT=13 ;

#��ѧ��Ŀ��
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
  `erptype` enum('˫�ﱨ��','���ı���','Ӣ�ı���','��������','����') DEFAULT NULL,
  `eiswarn` enum('y','n') NOT NULL DEFAULT 'n',
  `tappform` text,
  `iflowcount` int(11) DEFAULT NULL,
  `vsamplename` varchar(255) DEFAULT NULL,
  `tsampledesc` text,
  `vsamplecount` varchar(100) DEFAULT NULL,
  `tchangedetail` text,
  `taddnotes` text,
  `vnotes` varchar(50) DEFAULT NULL,
  `estatus` enum('����','�ŵ�','��ת��','����','�������','�ز�','�������','�������','�᰸','��֤','��ͣ','ȡ��','��') NOT NULL DEFAULT '����',
  `istatus` int(11) NOT NULL DEFAULT '0',
  `eitem` enum('��Ʒ','ʳƷ','ɢ��') DEFAULT NULL,
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

#��ѧ��Ŀ״̬ʱ���
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

#��ѧ��ĿԤ����
CREATE TABLE IF NOT EXISTS `t_chem_project_warn` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `vrid` varchar(20) DEFAULT NULL,
  `vsid` varchar(30) DEFAULT NULL,
  `vwarning` varchar(255) DEFAULT NULL,
  `dwarntime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=gbk AUTO_INCREMENT=445 ;

#��ѧ����С��̶���
CREATE TABLE IF NOT EXISTS `t_chem_test_child` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `type` enum('�޻���ת��','�л���ת��','ʳƷ��ת��') NOT NULL,
  `category` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=gbk AUTO_INCREMENT=34 ;

#��ѧ���Դ���̶���
CREATE TABLE IF NOT EXISTS `t_chem_test_parent` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `type` enum('�޻���ת��','�л���ת��','ʳƷ��ת��') NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=gbk AUTO_INCREMENT=49 ;

#�ͻ���
CREATE TABLE IF NOT EXISTS `t_client` (
  `clientid` varchar(8) NOT NULL,
  `password` varchar(20) NOT NULL,
  `name` varchar(255) NOT NULL,
  `shortname` varchar(100) NOT NULL,
  `ename` varchar(255) DEFAULT NULL,
  `product` varchar(255) DEFAULT NULL,
  `clevel` enum('vip','normal') DEFAULT 'normal',
  `creditlevel` varchar(15) DEFAULT '10000',
  `pay` enum('�ָ�','�½�','���') DEFAULT '�ָ�',
  `addr` varchar(255) DEFAULT NULL,
  `eaddr` varchar(255) DEFAULT NULL,
  `zipcode` varchar(25) DEFAULT NULL,
  `area` varchar(50) DEFAULT NULL,
  `sales` varchar(50) DEFAULT NULL,
  `status` enum('��Ч','��Ч') DEFAULT '��Ч',
  `createtime` datetime DEFAULT NULL,
  `notes` varchar(255) DEFAULT NULL,
  `tag` enum('y','n') DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `salesid` int(11) DEFAULT NULL,
  `contactid` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=gbk AUTO_INCREMENT=920 ;

#�ͻ�������
CREATE TABLE IF NOT EXISTS `t_client_area` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `city` varchar(50) DEFAULT NULL,
  `code` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=gbk AUTO_INCREMENT=32 ;

#�ͻ���ϵ��
CREATE TABLE IF NOT EXISTS `t_client_contact` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `clientid` varchar(8) NOT NULL,
  `contact` varchar(100) NOT NULL,
  `sex` enum('��','Ů') DEFAULT NULL,
  `dept` varchar(50) DEFAULT NULL,
  `job` varchar(50) DEFAULT NULL,
  `tel` varchar(100) DEFAULT NULL,
  `mobile` varchar(30) DEFAULT NULL,
  `fax` varchar(100) DEFAULT NULL,
  `qq` varchar(30) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `status` enum('��Ч','��Ч') NOT NULL DEFAULT '��Ч',
  `time` datetime DEFAULT NULL,
  `notes` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=gbk AUTO_INCREMENT=926 ;

#�ͻ�Ȩ�ޱ�
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

#��˾��Ϣ���̶���
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

#������Ŀ��
CREATE TABLE IF NOT EXISTS `t_phy_project` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `vpid` varchar(20) DEFAULT NULL,
  `vsid` varchar(30) DEFAULT NULL,
  `vrid` varchar(20) DEFAULT NULL,
  `estatus` enum('����','�ŵ�','����','����','�������','�ز�','�������','�������','�᰸','��֤','��ͣ','ȡ��','��') NOT NULL DEFAULT '����',
  `eprojectend` enum('n','y') DEFAULT 'n',
  `erptype` enum('���ı���','Ӣ�ı���','˫�ﱨ��','��������','����') DEFAULT NULL,
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

#��Ŀ���������ݣ�
CREATE TABLE IF NOT EXISTS `t_project` (
  `vsid` varchar(30) NOT NULL,
  `vrid` varchar(20) DEFAULT NULL,
  `vpid` varchar(20) DEFAULT NULL,
  `eptype` enum('��ѧ����','���ӵ�����ȫ����','EMC����','�����ܲ���','��Ч����') DEFAULT NULL,
  `etype` enum('�Բ�','��������','���') DEFAULT NULL,
  `isout` enum('y','n') NOT NULL DEFAULT 'n',
  `elab` enum('��ɽʵ����','��ݸʵ����') DEFAULT NULL,
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
  `einvtype` enum('����','ȫ��','������������','����','�վ�') DEFAULT NULL,
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
  `estatus` enum('δ���','�����') NOT NULL DEFAULT 'δ���',
  `vengineer` varchar(20) DEFAULT NULL,
  `vworkpoint` varchar(20) DEFAULT NULL,
  `isfinish` enum('y','n') NOT NULL DEFAULT 'n',
  `vnotes` varchar(255) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  UNIQUE KEY `vsid` (`vsid`)
) ENGINE=MyISAM  DEFAULT CHARSET=gbk AUTO_INCREMENT=5077 ;

#��Ŀ����ʱ����Ϣ��
CREATE TABLE IF NOT EXISTS `t_project_time` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `vrid` varchar(20) DEFAULT NULL,
  `vsid` varchar(30) DEFAULT NULL,
  `vuser` varchar(30) DEFAULT NULL,
  `vevent` varchar(100) DEFAULT NULL,
  `dtime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=gbk AUTO_INCREMENT=4 ;

#������
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
  `einvmethod` enum('����Ŀ','����Ŀ') DEFAULT NULL,
  `einvtype` enum('����','ȫ��','������������','�迪','�վ�') DEFAULT NULL,
  `finvcount` float NOT NULL DEFAULT '0',
  `finvprice` float NOT NULL DEFAULT '0',
  `vinvhead` varchar(255) DEFAULT NULL,
  `dinvtime` datetime DEFAULT NULL,
  `vinvcontent` varchar(255) DEFAULT NULL,
  `vinvcode` varchar(20) DEFAULT NULL,
  `ftax` float NOT NULL DEFAULT '0',
  `vstatus` varchar(10) DEFAULT NULL,
  `econfirm` enum('δ�յ�','���յ�') NOT NULL DEFAULT 'δ�յ�',
  `eaudit` enum('δ���','�����') NOT NULL DEFAULT 'δ���',
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

#����ͼƬ��Ϣ��
CREATE TABLE IF NOT EXISTS `t_reportimg` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rid` varchar(30) DEFAULT NULL,
  `sid` varchar(30) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `imgurl` varchar(255) DEFAULT NULL,
  `detail` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=gbk AUTO_INCREMENT=2 ;

#����ͼƬĿ¼���̶���
CREATE TABLE IF NOT EXISTS `t_report_filedirect` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `parentid` int(11) DEFAULT NULL,
  `tag` enum('y','n') NOT NULL DEFAULT 'y',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=gbk AUTO_INCREMENT=7 ;

#����ģ����̶���
CREATE TABLE IF NOT EXISTS `t_report_moduel` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `reportid` varchar(30) DEFAULT NULL,
  `testcontent` varchar(255) DEFAULT NULL,
  `testmethod` varchar(255) DEFAULT NULL,
  `category` enum('�޻�','�л�','����') DEFAULT NULL,
  `lan` enum('Ӣ�ı���','���ı���') DEFAULT NULL,
  `fileid` int(11) DEFAULT NULL,
  `tag` enum('y','n') NOT NULL DEFAULT 'y',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=gbk AUTO_INCREMENT=153 ;

#���۵���
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
  `invmethod` enum('����Ŀ','����Ŀ') DEFAULT NULL,
  `invtype` enum('ȫ��','������������','�迪','�վ�') DEFAULT NULL,
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

#�տʽ���̶���
CREATE TABLE IF NOT EXISTS `t_sales_order_advancetype` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT NULL,
  `vdesc` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=gbk AUTO_INCREMENT=9 ;

#�տ������˻����̶���
CREATE TABLE IF NOT EXISTS `t_sales_order_bank` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT NULL,
  `creditcard` varchar(50) DEFAULT NULL,
  `account` varchar(50) DEFAULT NULL,
  `address` varchar(50) DEFAULT NULL,
  `vdesc` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=gbk AUTO_INCREMENT=7 ;

#������Ŀ���̶���
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

#���۵���Ʒ����
CREATE TABLE IF NOT EXISTS `t_sales_order_product` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT NULL,
  `vdesc` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=gbk AUTO_INCREMENT=3 ;

#���۵���Ʒ��Ʒ����
CREATE TABLE IF NOT EXISTS `t_sales_order_product_sample` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT NULL,
  `vdesc` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=gbk AUTO_INCREMENT=3 ;

#���۵�������ĿҪ���
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

#��Ʒ��Ϣ��
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

#ϵͳ������Ϣ��
CREATE TABLE IF NOT EXISTS `t_system` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `head` varchar(255) DEFAULT NULL,
  `content` text,
  `createname` varchar(100) DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=gbk AUTO_INCREMENT=13 ;

#�û���
CREATE TABLE IF NOT EXISTS `t_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` varchar(10) NOT NULL,
  `name` varchar(20) NOT NULL,
  `password` varchar(128) DEFAULT NULL,
  `estatus` enum('��Ч','��Ч') NOT NULL DEFAULT '��Ч',
  `tel` varchar(30) DEFAULT NULL,
  `phone` varchar(30) NOT NULL,
  `email` varchar(30) DEFAULT NULL,
  `sex` enum('��','Ů') NOT NULL,
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

#��վ���ݸ�����Ϣ��
CREATE TABLE IF NOT EXISTS `t_webdata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `vurl` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=gbk AUTO_INCREMENT=3174 ;

#����������̶���
CREATE TABLE IF NOT EXISTS `t_subname` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `category` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=gbk ;

#�����������̶���
CREATE TABLE IF NOT EXISTS `t_agname` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=gbk ;
