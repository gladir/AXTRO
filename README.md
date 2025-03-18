# AXTRO
Liste de commandes sur l'astronomie écrit en Pascal.

<h2>Liste des fichiers</h2>

Voici la liste des différents fichiers proposés dans AXTRO :

<table>
	<tr>
		<th>Nom</th>
		<th>Description</th>	
	</tr>
	<tr>
    		<td><b>COSMIC.PAS</b></td>
    		<td>Cette commande permet de générer du texte aléatoire d'astronomie (Cosmic Ipsum).</td>
  	</tr>
	<tr>
		<td><b>DISTANCE.PAS</b></td>
		<td>Cette commande permet d'indiquer la distance entre la planète Terre et un astre.</td>
	</tr>
	<tr>
		<td><b>GALEQU.PAS</b></td>
		<td>Cette commande permet de passer des coordonnées équatoriales aux coordonnées galactiques.</td>
	</tr>
	<tr>
		<td><b>MOON.PAS</b></td>
		<td>Cette commande permet d'afficher une phase lunaire dans un mois.</td>
	</tr>	
	<tr>
		<td><b>OBSERV.PAS</b></td>
		<td>Cette commande permet d'afficher la liste des observatoires d'astronomies.</td>
	</tr>
	<tr>
		<td><b>ORIGIN.PAS</b></td>
		<td>Cette commande permet d'indiquer l'origine astronomique d'un mot.</td>
	</tr>	
	<tr>
		<td><b>PLANET.PAS</b></td>
		<td>Cette commande permet d'afficher la liste des planètes du système solaire.</td>
	</tr>	
</table>

<h2>Compilation</h2>
	
Les fichiers Pascal n'ont aucune dépendances, il suffit de télécharger le fichier désiré et de le compiler avec Free Pascal avec la syntaxe de commande  :

<pre><b>fpc</b> <i>LEFICHIER.PAS</i></pre>
	
Sinon, vous pouvez également le compiler avec le Turbo Pascal à l'aide de la syntaxe de commande suivante :	

<pre><b>tpc</b> <i>LEFICHIER.PAS</i></pre>
	
Par exemple, si vous voulez compiler MOON.PAS, vous devrez tapez la commande suivante :

<pre><b>fpc</b> MOON.PAS</pre>

<h3>Remarque</h3>
<ul>
		<li>La version 1.1 de la commande DISTANCE, ajoute le paramètre --version et corrige les distances terre-astre des astre du système solaire.</li>
</ul>

<h2>Licence</h2>
<ul>
 <li>Le code source est publié sous la licence <a href="https://github.com/gladir/AXTRO/blob/main/LICENSE">MIT</a>.</li>
 <li>Le paquet original est publié sous la licence <a href="https://github.com/gladir/AXTRO/blob/main/LICENSE">MIT</a>.</li>
</ul>
