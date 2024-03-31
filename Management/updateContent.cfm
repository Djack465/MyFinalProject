<cfparam name="form.contentId" default="">
<cfparam name="form.title" default="">
<cfparam name="form.description" default="">

<cfif form.contentId neq "" and form.title neq "" and form.description neq "">
    <cfset success = contentFunctions.updateContent(form.contentId, form.title, form.description)>
    
    <cfif success>
        <p>Content updated successfully!</p>
    <cfelse>
        <p>Error updating content. Please try again.</p>
    </cfif>
<cfelse>
    <p>Missing required parameters. Please fill in all fields.</p>
</cfif>
