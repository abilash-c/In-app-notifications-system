const express = require('express');
const path = require('path');
const cookieSession = require('cookie-session');
const bcrypt = require('bcrypt');
const dbConnection = require('./database');
const { body, validationResult } = require('express-validator');

const app = express();
app.use(express.urlencoded({extended:false}));

// SET OUR VIEWS AND VIEW ENGINE
app.set('views', path.join(__dirname,'views'));
app.set('view engine','ejs');
app.use('/images/',express.static('./images'));
app.use('/css/',express.static('./css'));

// APPLY COOKIE SESSION MIDDLEWARE
app.use(cookieSession({
    name: 'session',
    keys: ['key1', 'key2'],
    maxAge:  3600 * 1000 // 1hr
}));

// DECLARING CUSTOM MIDDLEWARE
const ifNotLoggedin = (req, res, next) => {
    if(!req.session.isLoggedIn){
        return res.render('login-register');
    }
    next();
}

const ifLoggedin = (req,res,next) => {
    if(req.session.isLoggedIn){
        return res.redirect('/home');
    }
    next();
}

const notif = (req,res) => {
    var html=null;
    html="<html><head><link rel=\"stylesheet\" href=\"https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css\" integrity=\"sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk\" crossorigin=\"anonymous\"><link rel=\"stylesheet\" href=\"https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css\"></head><body><style>.navbar {height: 90px;background-color: black; color: whitesmoke;margin-bottom: 15px;text-align: center;font-size: 30px;display: flex;justify-content: center;align-items: center;}</style><h4 class=\"navbar\">Notification</h4><div style=\"padding : 10px;\"><center><div style =\"margin-left : 30%;margin-right : 30%;\">";
    dbConnection.execute("SELECT * FROM `course`")
        .then(([rows]) => {
            rows.forEach(i => {
                let name = i.name;
                let start = i.start_time;
                let end = i.end_time;

                html += "<div class=\"card\"><div class=\"card-body\">\"You are enrolled in a course <b>"+name+ "</b> which starts at "+start+ " and ends at " +end+"</div></div><br>";
            });
            html += "</div></body></html>"
            res.send(html);
        });
}

// END OF CUSTOM MIDDLEWARE

// ROOT PAGE
app.get('/', ifNotLoggedin, (req,res,next) => {
    dbConnection.execute("SELECT * FROM `users` WHERE `id`=?",[req.session.userID])
    .then(([rows]) => {
        res.render('home',{
            name:rows[0].name,
            tenth:rows[0].tenth_mark,
            twelth:rows[0].twelth_mark,
            ug:rows[0].ug_cgpa,
            college:rows[0].college,
            backlogs:rows[0].backlogs
        });
    }); 
});// END OF ROOT PAGE



// REGISTER PAGE
app.post('/register', ifLoggedin, 
[
    body('course_name','Coursename is Empty!').trim().not().isEmpty(),
],
(req,res,next) => {
    const validation_result = validationResult(req);
    const {course_name, start, end} = req.body;
    // IF validation_result HAS NO ERROR
    if(validation_result.isEmpty()){
            // INSERTING USER INTO DATABASE
            dbConnection.execute("INSERT INTO `course` (`name`, `start_time`, `end_time`) VALUES(?,?,?)",[course_name,start, end])
            .then(result => {
                res.send(`course has been created successfully`);
            }).catch(err => {
                // THROW INSERTING USER ERROR'S
                if (err) throw err;
            });
    }
    else{
        // COLLECT ALL THE VALIDATION ERRORS
        let allErrors = validation_result.errors.map((error) => {
            return error.msg;
        });
        // REDERING login-register PAGE WITH VALIDATION ERRORS
        res.render('login-register',{
            register_error:allErrors,
            old_data:req.body
        });
    }
});// END OF REGISTER PAGE

// LOGIN PAGE
app.post('/', ifLoggedin, [
    body('user_email').custom((value) => {
        return dbConnection.execute('SELECT `email` FROM `users` WHERE `email`=?', [value])
        .then(([rows]) => {
            if(rows.length == 1){
                return true;
            }
            return Promise.reject('Invalid Email Address!');
            
        });
    }),
    body('user_pass','Password is empty!').trim().not().isEmpty(),
], (req, res) => {
    const validation_result = validationResult(req);
    const {user_pass, user_email} = req.body;
    if(validation_result.isEmpty()){
        
        dbConnection.execute("SELECT * FROM `users` WHERE `email`=?",[user_email])
        .then(([rows]) => {
            // console.log(rows[0].password);
            bcrypt.compare(user_pass, rows[0].password).then(compare_result => {
                if(compare_result === true){
                    req.session.isLoggedIn = true;
                    req.session.userID = rows[0].id;

                    res.redirect('/');
                }
                else{
                    res.render('login-register',{
                        login_errors:['Invalid Password!']
                    });
                }
            })
            .catch(err => {
                if (err) throw err;
            });


        }).catch(err => {
            if (err) throw err;
        });
    }
    else{
        let allErrors = validation_result.errors.map((error) => {
            return error.msg;
        });
        // REDERING login-register PAGE WITH LOGIN VALIDATION ERRORS
        res.render('login-register',{
            login_errors:allErrors
        });
    }
});
// END OF LOGIN PAGE

// LOGOUT
app.get('/logout',(req,res)=>{
    //session destroy
    req.session = null;
    res.redirect('/');
});
// END OF LOGOUT

// NOTIFICATION
app.get('/notification',notif

);
//END OF NOTIFICATION
app.use('/', (req,res) => {

    res.status(404).send('<h1>404 Page Not Found!</h1>');
});

app.listen(3000, () => console.log("Server is Running..."));
