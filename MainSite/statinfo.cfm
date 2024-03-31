<cfdump var="#session#">
<cfset stateFunctions = createObject("component", "stateInfo") />
<cfif not session.keyExists("user")>
    <cfset session.user = stateFunctions.obtainUser() />
</cfif>