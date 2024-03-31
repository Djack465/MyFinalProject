<cfcomponent>

    <cffunction name="obtainUser" access="public" returntype="struct">
        <cfargument name="isLoggedIn" type="boolean" required="false" default="false">
        <cfargument name="firstName" type="string" required="false" default="">
        <cfargument name="lastName" type="string" required="false" default="">
        <cfargument name="email" type="string" required="false" default="">
        <cfargument name="acctNumber" type="string" required="false" default="">
        
        <cfreturn {
            "isLoggedIn" = arguments.isLoggedIn,
            "firstname" = arguments.firstname,
            "lastname" = arguments.lastname,
            "email" = arguments.email,
            "acctNumber" = arguments.acctNumber
        }>
    </cffunction>

    <cfscript>
        function addPassword(id, password){
            try {
                var qs = new query(datasource = application.dsource);
                qs.setSql("insert into passwords (personid, password) values (:personid, :password) ");
                qs.addParam(name = "personid", value = arguments.id);
                qs.addParam(name = "password", value = hash(arguments.password, "SHA-256"));
                qs.execute();
                return true;
            } catch(any err) {
                return false;
            }
        }

        function addAccount(
            required string id,
            required string firstName,
            required string lastName,
            required string email,
            numeric isAdmin = 0
        ) {
            try {
                var qs = new query(datasource = application.dsource);
                qs.setSql("insert into people (id, firstname, lastname, email, isAdmin) values (:personid, :firstname, :lastname, :email, :isAdmin) ");
                qs.addParam(name = "personid", value = arguments.id);
                qs.addParam(name = "firstname", value = arguments.firstName);
                qs.addParam(name = "lastname", value = arguments.lastName);
                qs.addParam(name = "email", value = arguments.email);
                qs.addParam(name = "isAdmin", value = arguments.isAdmin);
                qs.execute();
                return true;
            } catch(any err) {
                return false;
            }
        }

        function processNewAccount(formData){
            if(emailIsUnique(formData.email)){
                var newid = createuuid();
                if(addPassword(newid, formData.password)){
                    addAccount(newid, formData.firstname, formData.lastname, formData.email);
                    return {success:true, message:"Account Made. Go login!"};
                }
            } else {
                return {success:false, message:"That email is already in our system. Please login"};
            }
        }

        function logMeIn(username, password){
            var hashedPassword = hash(arguments.password, "SHA-256");
            var qs = new query(datasource=application.dsource);
            qs.setSql("
                SELECT * FROM people
                INNER JOIN passwords ON people.id = passwords.personid
                WHERE email=:email AND password=:password
            ");
            qs.addParam(name="email", value=arguments.username);
            qs.addParam(name="password", value=hashedPassword);
            return qs.execute().getResult();
        }

        function obtainUser(isLoggedIn, firstName, lastName, email, isAdmin){
            var user = {};
            user.isLoggedIn = arguments.isLoggedIn;
            user.firstName = arguments.firstName;
            user.lastName = arguments.lastName;
            user.email = arguments.email;
            user.isAdmin = arguments.isAdmin ?: 0; 
            return user;
        }

        function addAccount(id, firstName, lastName, email, isAdmin){
            var qs = new query(datasource=application.dsource);
            qs.setSql("
                INSERT INTO people (id, firstname, lastname, email, isAdmin)
                VALUES (:personid, :firstname, :lastname, :email, :isAdmin)
            ");
            qs.addParam(name="personid", value=arguments.id);
            qs.addParam(name="firstname", value=arguments.firstName);
            qs.addParam(name="lastname", value=arguments.lastName);
            qs.addParam(name="email", value=arguments.email);
            qs.addParam(name="isAdmin", value=arguments.isAdmin ?: 0);
            qs.execute();
        }       
    </cfscript>

</cfcomponent>
