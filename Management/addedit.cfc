component {

    property name="qterm" default="";

    function processForms(required struct formData) {
        if (formData.keyExists("genre")) {
            deleteAllBookGenres(formData.isbn13);
            formData.genre.listToArray().each(function(item){
                insertGenre(item, formData.isbn13);
            });
        }
    }

    function sideNavBooks(required string qterm) {
        if (arguments.qterm.len() == 0) {
            return queryNew("title");
        } else {
            var qs = new query(datasource=application.dsource);
            qs.setSql("SELECT * FROM books WHERE title LIKE :qterm ORDER BY title");
            qs.addParam(name="qterm", value="%#arguments.qterm#%");
            return qs.execute().getResult();
        }
    }

    function allPublishers() {
        var qs = new query(datasource=application.dsource);
        qs.setSql("SELECT * FROM publishers ORDER BY name");
        return qs.execute().getResult();
    }

    function bookDetails(required string isbn13) {
        var qs = new query(datasource=application.dsource);
        qs.setSql("SELECT * FROM books WHERE isbn13 = :isbn13");
        qs.addParam(name="isbn13", value=arguments.isbn13, cfsqltype="CF_SQL_NVARCHAR");
        return qs.execute().getResult();
    }

    function findBookForm() {
        var addEditFunctions = createObject("component", "addEdit");
        var allGenres = addEditFunctions.getAllGenres();
        var bookGenres = addEditFunctions.getBookGenres(arguments.qterm);

        var output = "";

        output &= "<div>Genres</div>";
        output &= "<form>";
        for (var i = 1; i <= allGenres.recordCount; i++) {
            output &= "<input id='genre#allGenres.genreId[i]#' type='checkbox' name='genre' value='#allGenres.genreId[i]#' /> #allGenres.genreName[i]#<br/>";
        }
        output &= "</form>";

        for (var j = 1; j <= bookGenres.recordCount; j++) {
            output &= "<script>document.getElementById('genre#bookGenres.genreId[j]#').checked = true;</script>";
        }

        return output;
    }

    function sideNav() {
    }
}

<cfset addEditFunctions = new addEdit()>
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
