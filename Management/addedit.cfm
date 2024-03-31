<cfset addEditFunctions = createObject("component", "addEdit")>
<cfparam name="qterm" default="">
<cfoutput>#addEditFunctions.findBookForm()#</cfoutput>

<cfset allBooks = addEditFunctions.sideNavBooks(qterm)>
<cfoutput>
    <div>Book List</div>
    <ul class="nav flex-column">
        <cfif qterm.len() == 0>
            <li class="nav-item">No Search Term Entered</li>
        <cfelseif allBooks.recordCount == 0>
            <li class="nav-item">No Results Found</li>
        <cfelse>
            <cfloop query="allBooks">
                <li class="nav-item">
                    <a href="#cgi.script_name#?tool=addedit&book=#isbn13#&qterm=#qterm#" class="nav-link">#trim(title)#</a>
                </li>
            </cfloop>
        </cfif>
    </ul>
</cfoutput>

<cftry>
    <div class="row">
        <div id="main" class="col-9">
            <cfoutput>#mainForm()#</cfoutput>
        </div>
        <div id="leftgutter" class="col-lg-3 order-first">
            <cfoutput>#sideNav()#</cfoutput>
        </div>
    </div>
    <cfcatch type="any">
        <cfoutput>#cfcatch.Message#</cfoutput>
    </cfcatch>
</cftry>

<cffunction name="mainForm">
    <cfset allPublishers = addEditFunctions.allPublishers()>
    <cfif book neq ''>
        <cfset allGenres = bookstoreFunctions.allGenres() />
        <cfset bookGenres = bookstoreFunctions.bookGenres(book) />
    </cfif>
    
    <cfoutput>
        <form action="#cgi.script_name#?tool=addedit" method="post">
            <label for="isbn13">ISBN13:</label>
            <input type="text" id="isbn13" name="isbn13" value="" placeholder="ISBN13" />
            <label for="title">Book Title:</label>
            <input type="text" id="title" name="title" placeholder="Book Title" />
            <div class="form-floating mb-3">
                <select id="publisher" name="publisher" class="form-control">
                    <option value=""></option>
                    <cfloop query="allPublishers">
                        <option value="#id#">#name#</option>
                    </cfloop>
                </select>
                <label for="publisher">Publisher</label>
            </div>
            <button type="submit" class="btn btn-primary">Add Book</button>
        </form>
    </cfoutput>
</cffunction>

<cffunction name="findBookForm">
    <cfoutput>
        <form action="#cgi.script_name#?tool=#url.tool#" method="post">
            <div class="form-floating mb-3">
                <input type="text" id="qterm" name="qterm" class="form-control" value="#qterm#" placeholder="Enter a search term to find a book to edit" />
                <label for="qterm">Search Inventory</label>
            </div>
        </form>
    </cfoutput>
</cffunction>

<cffunction name="sideNav">
    <cfset allBooks = addEditFunctions.sideNavBooks(qterm) />
    <div>Book List</div>
    <cfoutput>#findBookForm()#</cfoutput>
    <cfoutput>
        <ul class="nav flex-column">
            <li class="nav-item">
                <a href="#cgi.script_name#?tool=addedit&book=new" class="nav-link">New Book</a>
            </li>
            <cfif qterm.len() == 0>
                No Search Term Entered
            <cfelseif allBooks.recordCount == 0>
                No Results Found
            <cfelse>
                <cfloop query="allBooks">
                    <li class="nav-item">
                        <a href="#cgi.script_name#?tool=addedit&book=#isbn13#&qterm=#qterm#" class="nav-link">#trim(title)#</a>
                    </li>
                </cfloop>
            </cfif>
        </ul>
    </cfoutput>
</cffunction>
