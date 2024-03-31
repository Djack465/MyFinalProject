<cfparam name="genre" default="" />
<cfset bookstoreFunctions = createObject("component", "bookstore") />
<cfset bookInfo = bookstoreFunctions.obtainSearchResults(form.searchme) />

<cfif bookInfo.recordCount == 0>
    <cfoutput>#noResults()#</cfoutput>
<cfelseif bookInfo.recordCount == 1>
    <cfoutput>#oneResult(bookInfo)#</cfoutput>
<cfelse>
    <cfoutput>#manyResults(bookInfo)#</cfoutput>
</cfif>

<cffunction name="noResults" returntype="string">
    <cfreturn "There were no results to be found.">
</cffunction>

<cffunction name="oneResult" returntype="string">
    <cfargument name="bookInfo" type="query">
    <cfset result = "" />
    <cfset result &= "<img src='images/#bookInfo.IMAGE[1]#' style='float:left; width:250px; height:250px'/>" />
    <cfset result &= "<span>Title: #bookInfo.title[1]#</span>" />
    <cfset result &= "<span>Publisher: #bookInfo.name[1]#</span>" />
    <cfreturn result />
</cffunction>

<cffunction name="manyResults" returntype="string">
    <cfargument name="bookInfo" type="query">
    <cfset result = "" />
    <cfset result &= "<ol class='nav flex-column'>" />
    <cfoutput query="bookInfo">
        <cfset result &= "<li class='nav-item'>" />
        <cfset result &= "<a class='nav-link' href='#cgi.script_name#?p=details&searchme=#trim(isbn13)#'>#trim(title)#</a>" />
        <cfset result &= "</li>" />
    </cfoutput>
    <cfset result &= "</ol>" />
    <cfreturn result />
</cffunction>
