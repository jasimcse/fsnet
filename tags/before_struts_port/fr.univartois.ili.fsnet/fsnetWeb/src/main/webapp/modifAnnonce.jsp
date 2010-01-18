<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <%@ taglib uri="http://iliforum.ili.fsnet.com/" prefix="fsnet"%>
    <head>

        <link rel="icon" type="image/png" href="images/favicon.ico" />
        <meta http-equiv="content-type"
              content="application/xhtml+xml; charset=UTF-8" />
        <meta name="author" content="Luka Cvrk - www.solucija.com" />
        <meta name="description" content="Site Description" />
        <meta name="keywords" content="site, keywords" />
        <meta name="robots" content="index, follow" />
        <link rel="stylesheet" type="text/css" media="screen"
              href="css/style.css" />


        <title>FSNet</title>

        <!-- FICHIER DE STYLE DU CALENDRIER //-->
        <link rel='stylesheet' href="css/calendar.css" />
        <!-- FICHIER DE SCRIPT DU CALENDRIER //-->
        <script type="text/javascript" src="maquette.js"></script>
        <script type="text/javascript">

            /******************************/
            /**self.defaultStatus = "GnooCalendar 1.4";
        /******************************/
            /*
             * instanciation de l'objet
             */
            var CL = new GnooCalendar("CL", 0, 20,"Annonce");

            /******************************/
            function init()
            {
                CL.init("calend", document.forms["testform"].elements["dateFinAnnonce"]);
	

	
            }
            /******************************/
            //-->
        </script>
    </head>
    <body onload="showMenu();init();">
        <div class="wrap background"><jsp:include page="haut.jsp"></jsp:include>

            <a name="top"></a>

            <div id="left">
                <h2><a href="#">Annonces</a></h2>
                <table width="445">
                    <tr>
                        <th style="width: 181px" scope="col">Entrer votre texte</th>
                        <th style="width: 252px" scope="col">
                            <div style="text-align: right">2000 caractères maximums</div>
                        </th>
                    </tr>
                </table>
                <p>&nbsp;</p>
                <form name='testform' method="do" action="ModifAnnonce" id="annonce" style='margin: 0px;'>

                    <table style="width: 633px">
                        <tr>
                            <th style="width: 193px" scope="row">Titre</th>
                            <td style="width: 228px">
                                <div style="align: right" class="Style1">
                                    <label style="text-align: left">
                                        <input name="titreAnnonce" type="text" size="50" value="${annonce.nom}" />
                                    </label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th style="width: 193px" scope="row">Contenu</th>
                            <td style="width: 228px">
                                <textarea name="contenuAnnonce" cols="57" rows="10">${annonce.contenu}</textarea>
                            </td>
                        </tr>
                        <tr>
                            <th style="width: 193px" scope="row">Date de fin</th>
                            <td>
                                <input type='text' name="dateFinAnnonce" value="${annonce.dateAnnonce}" size="8" />
                                <button type='button' name='show1' onclick='CL.show();'>
                                    <img src="images/button_calendar.gif" height="15" width="15" />
                                </button>
                            </td>
                        </tr>
                        <tr>
                            <th style="width: 193px" scope="row"></th>
                            <td style="width: 228px" id="calend">&nbsp;</td>
                        </tr>
                        <tr>
                            <th scope="row"></th>
                            <td>
                                <div style="text-align: right">
                                    <input name="submit" type="submit" value="Publier" />
                                </div>
                            </td>
                        </tr>
                    </table>
                </form>
                <br />
                <!-- <div id="calend">&nbsp;</div>--></div>
            <jsp:include page="bas.jsp"></jsp:include></div>
    </body>
</html>