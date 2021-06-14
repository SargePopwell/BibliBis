<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="models.Livre" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/style.css">
<title>Bibliotheque Bis</title>
</head>
<body>
	<h1>Bienvenue dans ma bibliothèque!</h1>
	
	<!-- Afficher une valeur -->
	<h2><%= "Hello World!" %></h2>
	<!-- Ces deux lignes de codes ont la même fonction, en haut en JAVA, en dessous en JSTL -->
	<h2><c:out value="Hello World"/></h2>
	
	<!-- Créer une variable (équivalent) -->
	<% String maVariable = "Ma valeur"; %>
	<c:set var="maVariable2" value="Ma valeur 2"/>
	<p><%= maVariable %><p>
	<p><c:out value="${ maVariable2 }"/><p>
	
	<% if(15<50) { %>
		<h2>Test Validé</h2>
	<% } %>
	
	<c:if test="${ 15<50 }">
		<h2>Test validé</h2>
	</c:if>
	
<%--<c:choose>
 	<c:when test="${ condition }">Un texte</c:when>
	<c:when test="${ autreCondition }">Un autre texte</c:when>
	<c:when test="${ encoreUneAutreCondition }">Encore un autre texte</c:when>
	<c:otherwise>(Texte par défaut)</c:otherwise>
	</c:choose> --%> 

	<h2>Livres disponibles</h2>
	<table>
		<tr id="tableHead">
			<th>Référence</th>
			<th>Titre</th>
			<th>Auteur</th>
			<td></td>
			<td></td>
		</tr>
	<c:forEach var="livre" items="${ bibliotheque }">
		<tr>
			<td><c:out value="${ livre.getReference() }"/></td>
			<td><c:out value="${ livre.getTitre() }"/></td>
			<td><c:out value="${ livre.getAuteur() }"/></td>
			<td><a href="bibliotheque?action=modify&reference=<c:out value="${ livre.getReference() }"/>">Modifier</a></td>
			<td><a href="bibliotheque?action=delete&reference=<c:out value="${ livre.getReference() }"/>">X</a></td>
		</tr>
		</c:forEach>
	</table>
	
		<h2>${ modifLivre != null ? "Modifier le livre" : "Ajouter un livre"}</h2>
	
	<form action='bibliotheque?to=${modifLivre != null? "mod":"add"}' method="POST" id="formulaire">
	
		<label for="reference" id="reference">Référence</label>
		<input type="text" name="reference" id="reference" value='${ modifLivre != null? modifLivre.reference:"" }'${ modifLivre != null? "disabled":"" }>
		<c:if test='${ modifLivre != null }'> 
		<input type="hidden" name="reference" value='${ modifLivre.reference }'>
		</c:if>
		<label for="titre" id="titre">Titre</label>
		<input type="text" name="titre" id="titre" value='${modifLivre != null? modifLivre.titre:"" }' >
		
		<label for="auteur" id="auteur">Auteur</label>
		<input type="text" name="auteur" id="auteur" value='${modifLivre != null? modifLivre.getAuteur():"" }'>
		
		<button type="submit">${ modifLivre != null ? "Modifier le livre" : "Ajouter à la bibliothèque"}</button>
	</form>
</body>
</html>