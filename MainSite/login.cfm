<cfparam name="AccountMessage" default="">
<cfparam name="LoginMessage" default="">
<cfparam name="newAccountMessage" default="">
<cfparam name="loginMessage" default="">

<div class="row">
    <div class="col-lg-6">
        <h2>Create New Account</h2>
        <script type="text/javascript">
            function validateNewAccount() {
                let originalPassword = document.getElementById('password').value;
                let confirmPassword = document.getElementById('confirmPassword').value;

                if (originalPassword !== '' && originalPassword === confirmPassword) {
                    document.getElementById('submitNewAccountForm').click();
                    document.getElementById('newAccountMessage').innerHTML = "";
                } else {
                    document.getElementById('newAccountMessage').innerHTML = "Passwords do not match.";
                }
            }
        </script>

        <div id="newAccountMessage"></div>
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
            <button id="newAccountButton" class="btn btn-warning" type="button" onclick="validateNewAccount()">Make Account</button>
            <input type="submit" id="submitNewAccountForm" style="display:none" />
        </form>

        <cfif form.keyExists("firstname")>
            <cfset newAccountResult = stateFunctions.processNewAccount(form) />
            <cfset newAccountMessage = newAccountResult.message />
        </cfif>

        <cfif newAccountMessage neq "">
            <p>#newAccountMessage#</p>
        </cfif>
    </div>

    <div class="col-lg-6">
        <h2>Login</h2>
        <p>#loginMessage#</p>

        <cfoutput>
            <div id="loginmessage">#loginMessage#</div>
            <form action="#cgi.SCRIPT_NAME#?p=login" method="post">
                <label for="loginemail">Email:</label>
                <input type="text" id="loginemail" name="loginemail" required><br>
                <label for="loginpass">Password:</label>
                <input type="password" id="loginpass" name="loginpass" required><br>
                <input type="submit" value="Login">
            </form>
        </cfoutput>
    </div>
</div>
</div>
