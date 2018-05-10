<%@ page contentType="text/html; charset=GBK" pageEncoding="GBK"%>
 <%@ page errorPage="../../error.jsp" %>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
		<title>标签示例</title>
		<style type="text/css">
body {
	font-size: 14px;
	font-family: "宋体";
	background-color: #fffff5;
}


ol li {
	margin: 8px
}

#con {
	font-size: 12px;
	width: 600px;
	margin: 0 auto
}

#tags {
	height: 23px;
	width: 1200px;
	margin: 0;
	padding: 0;
	margin-left: 90px
}

#tags li {
	float: left;
	margin-right: 1px;
	background: url(../../images/tagleft.gif) no-repeat left bottom;
	height: 23px;
	list-style-type: none
}

#tags li a {
	text-decoration: none;
	float: left;
	background: url(../../images/tagright.gif) no-repeat right bottom;
	height: 23px;
	padding: 0px 10px;
	line-height: 23px;
	color: #999
}

#tags li.emptyTag {
	width: 4px;
	background: none
}

#tags li.selectTag {
	background-position: left top;
	position: relative;
	height: 25px;
	margin-bottom: -2px
}

#tags li.selectTag a {
	background-position: right top;
	color: #000;
	height: 25px;
	line-height: 25px;
}

#tagContent {
	margin-left:50px;
	padding: 1px;
	background-color: #fff;
	border: 1px solid #aecbd4;
}

.tagContent {
	padding: 10px;
	color: #474747;
	width: 1024px;
	display: none
}

#tagContent div.selectTag {
	display: block
}
</style>
	</head>
	<body>

		<div id="con">
			<ul id="tags">
				<li class="selectTag">
					<a href="javascript:void(0)"
						onclick="selectTag('tagContent0',this)" id="one">项目状态</a>
				</li>
				<li>
					<a href="javascript:void(0)"
						onclick="selectTag('tagContent1',this)">无机实验室状态</a>
				</li>
				<li>
					<a href="javascript:void(0)"
						onclick="selectTag('tagContent2',this)">有机实验室状态</a>
				</li>
				<li>
					<a href="javascript:void(0)"
						onclick="selectTag('tagContent3',this)">食品级实验室状态</a>
				</li>
				<li class="selectTag">
					<a href="javascript:void(0)"
						onclick="selectTag('tagContent4',this)">完成状态</a>
				</li>
				<li>
					<a href="javascript:void(0)" onclick="selectTag('tagContent5',this)">预警与外包项目</a>
				</li>
				<li class="selectTag">
					<a href="javascript:void(0)" onclick="selectTag('tagContent6',this)">迟单预警</a>
				</li>
				
			</ul>
			<div id="tagContent">
				<div id="tagContent0" class="tagContent"><%@ include file="status.jsp"%></div>
				<div id="tagContent1" class="tagContent"><%@ include file="wuji.jsp"%></div>
				<div id="tagContent2" class="tagContent"><%@ include file="youji.jsp"%></div>
				<div id="tagContent3" class="tagContent"><%@ include file="shipin.jsp"%></div>
				<div id="tagContent4" class="tagContent"><%@ include file="finish.jsp"%></div>
				<div id="tagContent5" class="tagContent"><%@ include file="warnout.jsp"%></div>
				<div id="tagContent6" class="tagContent"><%@ include file="latewarn.jsp"%></div>
			</div>
		</div>
		<script type="text/javascript">
	window.onload = function() {//页面加载时的函数
		selectTag('tagContent0', document.getElementById('one'));
	}

	function selectTag(showContent, selfObj) {
		selfObj.blur();
		// 操作标签
		var tag = document.getElementById("tags").getElementsByTagName("li");
		var taglength = tag.length;
		for (i = 0; i < taglength; i++) {
			tag[i].className = "";
		}
		selfObj.parentNode.className = "selectTag";
		// 操作内容
		for (i = 0; j = document.getElementById("tagContent" + i); i++) {
			j.style.display = "none";
		}
		document.getElementById(showContent).style.display = "block";

	}
</script>
	</body>
</html>
