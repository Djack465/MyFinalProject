<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <a class="navbar-brand" href="#">
        <img src="images/rdb.png" alt="Read Dees Books Logo"/>
    </a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
            aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item active">
                <a class="nav-link" href="#">Home <span class="sr-only">(current)</span></a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#">Store Information</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#">Highlighted Favorites</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#">Events</a>
            </li>
        </ul>
        <form class="d-flex">
            <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
            <button class="btn btn-outline-success" type="submit">Search</button>
        </form>
    </div>
</nav>


<a href="login.cfm?p=login">Login</a>

<cfparam name="newAccountMessage" default="">
<cfparam name="loginMessage" default="">


<cfoutput>
    <cfif session.user.isloggedin>
   
        <li>
            <a>Welcome #session.user.firstname#</a>
        </li>
        <li>
            <a href="#cgi.SCRIPT_NAME#?p=logoff">Logout</a>
        </li>
    <cfelse>
 
        <li>
            <a href="#cgi.SCRIPT_NAME#?p=login">Login</a>
        </li>
    </cfif>
</cfoutput>


<div class="row">
    <div class="col-lg-6">
        <h2>Create New Account</h2>
        <form action="login.cfm?p=login" method="post">
            <label for="firstName">First Name:</label>
            <input type="text" id="firstName" name="firstName" required><br>
            <label for="lastName">Last Name:</label>
            <input type="text" id="lastName" name="lastName" required><br>
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required><br>
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required><br>
            <label for="confirmPassword">Confirm Password:</label>
            <input type="password" id="confirmPassword" name="confirmPassword" required><br>
            <input type="submit" value="Register">
        </form>
       
        <cfif newAccountMessage neq "">
            <p>#newAccountMessage#</p>
        </cfif>
    </div>
    
   
    <div class="col-lg-6">
        <h2>Login</h2>
      
        <cfif loginMessage neq "">
            <p>#loginMessage#</p>
        </cfif>
    </div>
</div>


<cfoutput>
    <cfif session.user.isAdmin>
        <li>
            <a href="#cgi.SCRIPT_NAME#?p=management">Management</a>
        </li>
    </cfif>
</cfoutput>
