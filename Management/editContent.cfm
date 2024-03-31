<cfparam name="url.contentId" default="">

<cfif url.contentId neq "">
    <cfset content = contentFunctions.getContentById(url.contentId)>
    
    <form action="updateContent.cfm" method="post">
        <input type="hidden" name="contentId" value="#content.contentId#">
        Title: <input type="text" name="title" value="#content.title#"><br>
        Description: <textarea name="description">#content.description#</textarea><br>
        <input type="submit" value="Save">
    </form>
</cfif>
