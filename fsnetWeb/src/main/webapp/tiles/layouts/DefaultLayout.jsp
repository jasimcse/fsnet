<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="/struts-tags" %>

<c:set var="pageTitle">
	<tiles:getAsString name="title" />
</c:set>
<!DOCTYPE html>
<html>
<head>

<meta http-equiv="content-type"
	content="application/xhtml+xml; charset=UTF-8" />
<meta http-equiv="pragma" content="no-cache" />
<meta http-equiv="cache-control" content="no-cache" />
<meta http-equiv="expires" content="0" />

<title><s:text name="%{pageTitle}" /></title>

<link rel="shortcut icon" href="images/Favicon.ico"
	type="image/vnd.microsoft.icon" />

<link rel="stylesheet" type="text/css" media="screen"
	href="css/style.css" />
<link rel="stylesheet" type="text/css" media="screen"
	href="css/fsnet-custom.css" />
<link type="text/css" href="css/jquery-tablesorter-custom.css"
	rel="stylesheet" />

<link type="text/css" rel="stylesheet" media="all" href="css/screen.css" />

<link type="text/css" href="css/cupertino/jquery-ui-1.8.18.custom.css"
	rel="stylesheet" />
<script type="text/javascript" src="js/jquery-1.9.0.js"></script>
<script type="text/javascript" src="js/jquery-migrate-1.0.0.js"></script>
<script type="text/javascript" src="js/jquery-ui-1.10.0.custom.min.js"></script>
<script type="text/javascript" src="js/jquery-ui-i18n.min.js"></script>
<link type="text/css" rel="stylesheet" media="all"
	href="css/jquery-ui-timepicker-addon.css" />
<!-- DO NOT GET THIS LIBRARY HERE !!! -->
<!--<script type="text/javascript" src="js/jquery-ui-timepicker-addon.js"></script>-->
<script type="text/javascript" src="js/functions.js"></script>
<script type="text/javascript"
	src="http://maps.google.com/maps/api/js?sensor=false"></script>
<script type="text/javascript" src="js/geolocalisation.js"></script>
<script type="text/javascript" src="js/jquery.simplemodal.1.4.4.min.js"></script>

<script type="text/javascript" src="js/talkUtils.js"></script>
<script type="text/javascript" src="js/chat.js"></script>
<script class="jsbin" type="text/javascript"
	src="js/jquery.dataTables.js"></script>

<link rel="stylesheet" type="text/css" media="screen"
	href="css/skeleton.css" />

<link rel="stylesheet" media="screen" type="text/css"
	href="css/colorpicker.css" />
<script type="text/javascript" src="js/colorpicker.js"></script>
<script type="text/javascript" src="js/eye.js"></script>

<script type="text/javascript" src="js/utils.js"></script>
<script type="text/javascript" src="js/layout.js?ver=1.0.2"></script>

<script>
	$('#colorpickerField1').ColorPicker({
		onSubmit : function(hsb, hex, rgb, el) {
			$(el).val(hex);
			$(el).ColorPickerHide();
		},
		onBeforeShow : function() {
			$(this).ColorPickerSetColor(this.value);
		}
	}).bind('keyup', function() {
		$(this).ColorPickerSetColor(this.value);
	});
</script>

<link rel="stylesheet" media="screen" type="text/css"
	href="./bootstrap/css/bootstrap.min.css" />
<link type="text/css" rel="stylesheet" media="all" href="css/chat.css" />
<link href="./bootstrap/css/bootstrap-responsive.min.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" media="screen"
	href="css/bootstrapStyle.css" />
	

<!-- Custom color style by group-->
<style type="text/css">
body {
	background:-webkit-linear-gradient(top, #${color} 0%, white 100%);
	background:-o-linear-gradient(top, #${color} 0%, white 100%);
	background:-moz-linear-gradient(top, #${color} 0%, white 100%);
}
</style>
</head>
<body>
	<tiles:useAttribute name="currentMenu" scope="request" ignore="true" />
	<tiles:insertAttribute name="menu" />
	<div class="clear"></div>
	<div id="wrapBody">
		<div class="row-fluid">
			<div class="span2 fixed">		
					<tiles:insertAttribute name="logo" />
					<div id="left" class="cadreDivMenuTop">
						<h2>
							<s:property value="%{getText(#attr.pageTitle)}"/>
						</h2>
						<tiles:insertAttribute name="left" />
						<tiles:insertAttribute name="loggedUsers" />
					</div>
				
			</div>
			<div class="span8 offset2">
					<tiles:insertAttribute name="body-content" />
			</div>
		</div>
		<div style="clear: both"></div>
	</div>
	<tiles:insertAttribute name="footer" />
</body>
</html>