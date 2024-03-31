<html lang="en"> 
    <head> 
        <meta charset="UTF-8"> 
        <title>Title</title> 
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous"> 
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script> 
    </head> 
    <body>
        <cfparam name="tool" default="addEdit">
    
       
        <cfif NOT session.user.isAdmin>
            <cflocation url="#cgi.SCRIPT_NAME#" addtoken="false">
        </cfif>
    
        <div id="wrapper" class="container">
            <div id="navArea">
                Mav Area
            </div>
            <div id="mainArea">
           
                <cfinclude template="#tool#.cfm"/>
            </div>
        </div>
    </body> 
    </html>
    <script src="https://cdn.ckeditor.com/ckeditor5/41.1.0/classic/c"></script>
    