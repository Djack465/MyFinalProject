<cfset contentList = contentFunctions.getAllContent()>

<ul>
    <cfloop query="contentList">
        <li><a href="editContent.cfm?contentId=#contentList.contentId#">#contentList.title#</a></li>
    </cfloop>
</ul>
