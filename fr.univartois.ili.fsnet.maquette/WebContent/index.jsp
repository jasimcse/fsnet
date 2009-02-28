<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://iliforum.ili.fsnet.com/" prefix="fsnet"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <link rel="icon" type="image/png" href="images/favicon.ico" />
	<meta http-equiv="content-type" content="application/xhtml+xml; charset=UTF-8" />
	<meta name="author" content="Luka Cvrk - www.solucija.com" />
	<meta name="description" content="Site Description" />
	<meta name="keywords" content="site, keywords" />
	<meta name="robots" content="index, follow" />
	<link rel="stylesheet" type="text/css" media="screen" href="css/style.css" />
	<title>FSNet</title>
</head>
<body>
	<div class="wrap background">
		<div id="search">
			<form action="">
				<fieldset>
					<input type="text" class="field" value="Mot clé" />
					<input type="submit" class="button" value="" />
				</fieldset>
			</form>
		</div>
		<ul id="menu">
	<li><a class="current" href="index.jsp">Accueil</a></li>
	<li><a href="profil.jsp">Profil</a></li>
	<li><a href="hub.jsp">Hubs</a></li>
	<li><a href="#">Interaction</a></li>
	<li><a href="#">Messagerie</a></li>
	<li><a href="AddAnnonce?idChoisi=0">Annonces</a></li>
			
		</ul>
		<fsnet:login var="membre" idLogin="${idLogin}">
	Bienvenue M. ${membre.nom} ${membre.prenom} 
	</fsnet:login>	
		<div id="logo">
		  <h1><a href="http://www.google.com">FSNet<br />
			</a></h1>
			<h2 id="slogan">Réseau social </h2>
		</div>
		
		<ul id="feature_menu">
			<li><a class="current" href="">Actualité</a></li>
			<li><a href="#">AAAAAAA</a></li>
			<li><a href="#">BBBBBBBBB</a></li>
		</ul>
			
		<div id="feature">
			<img src="images/feature_img.gif" alt="Featured" />
			<p>Une nouvelle communauté vient d'être créée.</p>
			<p><a class="more" href="#">&not;Detail</a></p>
	  </div>
		
		<div class="clear"></div>
		
		<div id="left">
			<h2><a href="#">Accueil</a></h2>
			<p class="date">Date<br />
		  JJ-MM-AA</p>
			<table width="479">
			  <tr> <td style="width:6 ; height:33"></td>
    <td style="width:450; valign:top; bgcolor:#EDF3F8"><h2 class="Style8"><img src="icon_from_jimmac_musichall_cz_270.png" style="width:32 ; height:27" alt=""/> Ma messagerie </h2></td>
  </tr>
  <tr>
    <td style="height:2"></td>
    <td></td>
  </tr>
  
  <tr>
    <td style="height:38"></td>
    <td valign="top"><ul>
      <li><a href="#">slt c coucou</a></li>
      <li><a href="#">slt c kiki </a></li>
    </ul></td>
  </tr>
  <tr>
    <td style="height:15"></td>
    <td></td>
  </tr>
  <tr>
    <td style="height:38"></td>
    <td valign="top" style="bgcolor:#EDF3F8"><h2><img src="icons/page_01_fichiers/icon_from_jimmac_musichall_cz_223.png" style="width:36 ;height:32" alt=""/> <span class="Style8">Mon r&eacute;seau </span></h2></td>
  </tr>
  <tr>
    <td style="height:20"></td>
    <td>&nbsp;</td>
  </tr>
  
  <tr>
    <td style="height:56"></td>
    <td valign="top"><ul>
      <li><a href="#">Communauté 1</a></li>
      <li><a href="#">Communauté 2</a></li>
      <li><a href="#">Communauté 3</a></li>
    </ul></td>
  </tr>
  <tr>
    <td style="height:17"></td>
    <td></td>
  </tr>
  <tr>
    <td style="height:40"></td>
    <td valign="top" style="bgcolor:#EDF3F8"><h2><span class="Style8"><img src="icons/page_01_fichiers/icon_from_jimmac_musichall_cz_073.png" style="width:34; height:29" alt="" /> Int&eacute;ractions </span></h2></td>
  </tr>
  <tr>
    <td style="height:20"></td>
    <td>&nbsp;</td>
  </tr>
  
  <tr>
    <td style="height:110"></td>
    <td valign="top"><ul>
      <li><a href="CreerCommun.html">Créer communauté</a></li>
      <li><a href="#">S'inscrire à une communauté</a></li>
      <li><a href="#">Gérer communauté</a></li>
      <li><a href="creerevenement.jsp">Créer événement</a></li>
    </ul>
    <p>&nbsp;</p></td>
  </tr>
  <tr>
    <td style="height:88"></td>
    <td>&nbsp;</td>
  </tr>
</table>
	  </div>
		
		<div id="side">
				<div class="boxtop"></div>
				<div class="box">
					<h3>Mes communaut&eacute;s </h3>
				    <a href="#">
				  <span class="item">
						<span class="sidedate">JEE<br />
					&nbsp;&nbsp;&nbsp;&nbsp;</span>
            <strong>Nouveauté J2EE </strong><br />
						Detail</span>
				  </a>
					<a href="#">
					<span class="item">
						<span class="sidedate">JAVA&nbsp;&nbsp;&nbsp;&nbsp;</span>
						<strong>Eclipse ... </strong><br />
						Detail					</span>
					</a>
					<a href="#">
					<span class="item last">
					<span class="sidedate">JSP<br />
					</span>
						<strong>Nouveauté JSP </strong><br />
						Detail</span>
					</a>
				</div>
				<div class="boxbottom"></div>
		</div>
		<p id="ad">&nbsp;</p>
	</div>
	
	<div id="promo" style="text-align:center">
	  <div class="wrap">FSnet licence </div>
	</div>
</body>
</html>
    