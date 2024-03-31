<cfset genreList = bookstoreFunctions.getDistinctGenres() />

<cfloop query="genreList">
    <li class="nav-item">
        <a class="nav-link" href="#cgi.SCRIPT_NAME#?p=details&genre=#genreId#">#genreName#</a>
    </li>
</cfloop>
