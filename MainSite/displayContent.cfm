<cfparam name="url.contentId" default="">
<cfif url.contentId neq "">
    <cfset contentFunctions = createObject("component", "contentFunctions")>
    <cfset content = contentFunctions.getContentById(url.contentId)>
    <h1>#content.title#</h1>
    <p>#content.description#</p>
<cfelse>
    <p>No content found.</p>
</cfif>
