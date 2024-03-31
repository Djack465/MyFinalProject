<cfcomponent>

    <cffunction name="obtainSearchResults" access="public" returntype="query">
        <cfargument name="searchTerm" type="string" required="yes">
        
        <cfquery name="searchResults" datasource="yourDataSourceName">
            SELECT books.*, publishers.name 
            FROM books 
            INNER JOIN publishers ON books.publisher = publishers.id 
            WHERE title LIKE '%#trim(arguments.searchTerm)#%' 
            OR isbn13 LIKE '%#trim(arguments.searchTerm)#%'
        </cfquery>
        <cfreturn searchResults>
    </cffunction>
    
    <cffunction name="getAllGenres" access="public" output="false">
        <cfquery name="allGenresQuery" datasource="#application.dsource#">
            SELECT genreId, genreName FROM genres ORDER BY genreName
        </cfquery>
        <cfreturn allGenresQuery />
    </cffunction>

    <cffunction name="getBookGenres" access="public" output="false">
        <cfargument name="isbn13" type="string" required="true">
        <cfquery name="bookGenresQuery" datasource="#application.dsource#">
            SELECT genreId FROM genresToBooks WHERE isbn13 = <cfqueryparam value="#isbn13#" cfsqltype="cf_sql_varchar">
        </cfquery>
        <cfreturn bookGenresQuery />
    </cffunction>

    <cffunction name="deleteAllBookGenres" access="public" output="false">
        <cfargument name="isbn13" type="string" required="true">
        <cfquery datasource="#application.dsource#">
            DELETE FROM genresToBooks WHERE isbn13 = <cfqueryparam value="#arguments.isbn13#" cfsqltype="cf_sql_varchar">
        </cfquery>
    </cffunction>

    <cffunction name="insertGenre" access="public" output="false">
        <cfargument name="genreId" type="string" required="true">
        <cfargument name="isbn13" type="string" required="true">
        <cfquery datasource="#application.dsource#">
            INSERT INTO genresToBooks (genreId, isbn13) VALUES (<cfqueryparam value="#arguments.genreId#" cfsqltype="cf_sql_varchar">, <cfqueryparam value="#arguments.isbn13#" cfsqltype="cf_sql_varchar">)
        </cfquery>
    </cffunction>

    <cffunction name="getDistinctGenres" access="public" output="false">
        <cfquery name="distinctGenresQuery" datasource="#application.dsource#">
            SELECT DISTINCT g.genreId, g.genreName 
            FROM genres g
            INNER JOIN genresToBooks gb ON g.genreId = gb.genreId 
            ORDER BY g.genreName
        </cfquery>
        <cfreturn distinctGenresQuery />
    </cffunction>
</cfcomponent>
