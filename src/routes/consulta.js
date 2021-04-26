const express = require('express');
const passport = require('passport');
const router = express.Router();
const conn = require('../database'); // Buscando el archivo de conf de la base de datos
const multer = require('multer');
const flash    = require('connect-flash');
var estadoCategoria = 0;
var estadoAdministrador = 0;
var estadoRegistrar = 0;

//Getters y setters de estados
function setEstadoCategoria(estadoCategoria){
    this.estadoCategoria = estadoCategoria;
}

function getEstadoCategoria(){
    return estadoCategoria;
}

function setEstadoAdministrador(estadoAdministrador){
    this.estadoAdministrador = estadoAdministrador;
}

function getEstadoAdministrador(){
    return estadoAdministrador;
}

function setEstadoRegistar (){
    this.estadoRegistrar = estadoRegistrar;
}

function getEstadoRegistrar(){
    return estadoRegistrar;
}

router.get('/consulta', (req,res,next) =>{

    if(req.isAuthenticated()) return next();
    
    res.redirect('/login');
    
    },(req,res,err) =>{

    conn.query('Select * from categoria', (err,resp,campos) => {
        res.render('consulta.ejs',   { datos: resp});
    });

});

router.get('/profile/:nombre_usuario', (req,res) =>{


    conn.query('Select * from producto where nombre_usuario = ?', [req.params.nombre_usuario], (err,resp,campos) => {
        conn.query('Select * from contacto where nombre_usuario = ?', [req.params.nombre_usuario], (err,resp2,campos) => {
            conn.query('Select * from emprendedor where nombre_usuario = ?', [req.params.nombre_usuario], (err,resp3,campos) => {
                conn.query('Select * from categoria', [req.params.nombre_usuario], (err,resp4,campos) => {
                    res.render('profile.ejs',   { datos: resp, datos2: resp2, datos3:resp3, cat:resp4});
                });
            });
        });
    });
});

router.get('/Registrar', (req,res) =>{
    estadoRegistrar = getEstadoRegistrar();
    res.render('RegistrarUsuario.ejs', {estadoRegistrar})
});

router.get('/contacto', (req,res, next) =>{

    if(req.isAuthenticated()) return next();
    
    res.redirect('/login');
    
    },(req,res,err) =>{

    res.render('contacto.ejs')
    
});

router.post('/FormularioContacto',(req, res) => {
    const {contacto,nombre_usuario, tipo_contacto} = req.body;
    conn.query('INSERT into contacto SET? ',{
        contacto: contacto,
        nombre_usuario: nombre_usuario,
        tipo_contacto: tipo_contacto
    }, (err, result) => {
        if(!err) {
            res.redirect('/contacto');
        } else {
            console.log(err);
        }
    });
});

router.get('/solicitud', (req,res, next) =>{

    if(req.isAuthenticated()) return next();
    
    res.redirect('/login');
    
    },(req,res,err) =>{

    
    res.render('solicitud.ejs')
});


router.post('/FormularioSolicitud',(req, res) => {
    const {nombre_usuario, motivo, tipo_solicitud, tipo_entidad} = req.body;
    conn.query('INSERT into solicitudes SET? ',{
        nombre_usuario: nombre_usuario,
        motivo: motivo,
        tipo_solicitud: tipo_solicitud,
        tipo_entidad: tipo_entidad
    }, (err, result) => {
        if(!err) {
            res.redirect('/solicitud');
        } else {
            console.log(err);
        }
    });
});






router.post('/registrarUsuario', (req,res) =>{
    const {nombre_usuario, correo, password} = req.body;
    conn.query('Select * from cuenta where nombre_usuario = ? and correo = ?',[nombre_usuario, correo] , (err,resp,campos) => {
       
        if(nombre_usuario==''){
            estadoRegistrar=1;
            setEstadoRegistar(estadoRegistrar);
            res.redirect('/Registrar')
        
        }else if(correo == ''){
            estadoRegistrar=2;
            setEstadoRegistar(estadoRegistrar);
            res.redirect('/Registrar')
        }
        else if(password == ''){
            estadoRegistrar=3;
            setEstadoRegistar(estadoRegistrar);
            res.redirect('/Registrar')
        }
     
        else{
            
    conn.query('INSERT into cuenta SET?',{
        nombre_usuario: nombre_usuario,
        correo: correo,
        password: password
    }, (err, result) => {
        
        if(!err) {
            console.log("Cuenta registrada!!!")
           
            estadoRegistrar=5;
            setEstadoRegistar(estadoRegistrar);
            res.redirect('/Registrar');

        } else {
            
            estadoRegistrar=4;
            setEstadoRegistar(estadoRegistrar);
            res.redirect('/Registrar');
            
            }
        });
     }
    });

   
});

router.get('/emprendedor', (req,res,next) =>{

    if(req.isAuthenticated()) return next();
    
    res.redirect('/login');
    
    },(req,res,err) =>{

    res.render('emprendedor.ejs')
});

router.get('/', (req,res) => { //metodo para seleccionar los datos
    conn.query('select * from producto',(err,resp,campos) => {
        if(!err){
            conn.query('select * from categoria',(err,resp1,campos) => {
                
                if(!err){
                
                    res.render('index.ejs', {datos: resp, cat: resp1});
                }else{
                    console.log(err);
                }
                
            });
        }else{
            console.log(err);
        }
    });
});






router.post('/FormularioProducto',(req, res) => {
    const {nombre_usuario,precio, nombre_producto, imagen, descripcion_produc, nombre_cate} = req.body;
    conn.query('INSERT into producto SET? ',{
        nombre_usuario: nombre_usuario,
        precio: precio,
        nombre_producto: nombre_producto,
        imagen: req.files[0].filename,
        descripcion_produc: descripcion_produc,
        nombre_cate: nombre_cate
    }, (err, result) => {
        
        if(!err) {
            console.log("producto ingresado!!!")
            res.redirect('/');
        } else {
            console.log("estoy aqui")
            console.log(err);
        }
    });
});


router.post('/AgregarCategoria',(req, res) => {
    
    const {nombre_cate} = req.body;
 
    conn.query('Select nombre_cate from categoria where nombre_cate = ?',[nombre_cate] , (err,resp,campos) => {
         
        if(nombre_cate==''){
            estadoCategoria=1;
            setEstadoCategoria(estadoCategoria);
            res.redirect('/Agregar')
         }else{
            conn.query('INSERT into categoria SET?',{
                nombre_cate: nombre_cate
            }, (err, result) => {
               
                if(!err) {
                    console.log("Categoria ingresada!!!")
                    res.redirect('/admin');
                } else {
                    estadoCategoria = 2;
                    setEstadoCategoria(estadoCategoria);
                    res.redirect('/Agregar');
                    }
                });  
         }
    });    
        
    
});


router.post('/FormularioEmprendedor',(req, res) => {
    const {nombre_usuario,correo, nombre_emprendedor, nombre_emprendimiento, dirección, horario_atencion, logo, descripcion} = req.body;
    conn.query('INSERT into emprendedor SET? ',{
        nombre_usuario: nombre_usuario,
        correo: correo,
        nombre_emprendedor: nombre_emprendedor,
        nombre_emprendimiento:nombre_emprendimiento,
        dirección: dirección,
        horario_atencion:horario_atencion,
        logo: req.files[0].filename,
        descripcion: descripcion
    }, (err, result) => {
        if(!err) {
            res.redirect('/emprendedor');
        } else {
            console.log(err);
        }
    });
});

router.post('/agregarAdministrador',(req, res) => {
    const {nombre_usuario,correo, nombre_admin, apellido_admin, rut} = req.body;
    conn.query('Select nombre_usuario, correo from cuenta where nombre_usuario = ? and correo = ?',[nombre_usuario, correo] , (err,resp,campos) => {
        
        if(nombre_usuario==''){
            estadoAdministrador=1;
            setEstadoAdministrador(estadoAdministrador);
            res.redirect('/Agregar')
        }
        else if(correo==''){
            estadoAdministrador=2;
            setEstadoAdministrador(estadoAdministrador);
            res.redirect('/Agregar')
        }
        else if(nombre_admin==''){
            estadoAdministrador=3;
            setEstadoAdministrador(estadoAdministrador);
            res.redirect('/Agregar')
        }
        else if(apellido_admin==''){
            estadoAdministrador=4;
            setEstadoAdministrador(estadoAdministrador);
            res.redirect('/Agregar')
        }
        else if(rut==''){
            estadoAdministrador=5;
            setEstadoAdministrador(estadoAdministrador);
            res.redirect('/Agregar')
        }
        else if(nombre_usuario==undefined || correo==undefined){
            estadoAdministrador=6;
            setEstadoAdministrador(estadoAdministrador);
            res.redirect('/Agregar')
        }else{
            conn.query('INSERT into administrador SET? ',{
                nombre_usuario: nombre_usuario,
                correo: correo,
                nombre_admin: nombre_admin,
                apellido_admin: apellido_admin,
                rut: rut
            }, (err, result) => {
                if(!err) {
                    estadoAdministrador=7;
                    setEstadoAdministrador(estadoAdministrador);
                    res.redirect('/Agregar');
                } else {
                    estadoAdministrador=6;
                    setEstadoAdministrador(estadoAdministrador);
                    res.redirect('/Agregar')
                }
            });

        }

    });
  
});

router.get('/admin', (req,res,next) =>{
    
    if(req.isAuthenticated()) return next();
    
    res.redirect('/login');

    //res.render('index.ejs');
    },(req,res,err) =>{
    
        let op = require("../index.js")
        let tipo_usuario = op.rol1;
        if(tipo_usuario==='emprendedor'){
            res.redirect('/')
        }
    conn.query('Select * from emprendedor', (err,resp,campos) => {
        conn.query('Select * from producto', (err,resp1,campos) => {
            conn.query('Select * from contacto', (err,resp2,campos) => {
                conn.query('Select * from cuenta', (err,resp3,campos) => {
                    conn.query('Select * from categoria', (err,resp4,campos) => {
                        conn.query('Select * from solicitudes', (err,resp5,campos) => {
                            conn.query('Select * from administrador', (err,resp6,campos) => {
                                res.render('administrador.ejs',   { datos: resp ,datos1: resp1, datos2: resp2, datos3: resp3, datos4: resp4, datos5:resp5, datos6: resp6});
                            });
                        });
                    });
                });
            });
        });
    });
});



router.get('/Agregar', (req,res,next) =>{
    
    if(req.isAuthenticated()) return next();
    
    res.redirect('/login');

    //res.render('index.ejs');
    },(req,res,err) =>{
        let op = require("../index.js")
        let tipo_usuario = op.rol1;
        if(tipo_usuario==='emprendedor'){
            res.redirect('/')
        }

        estadoCategoria = getEstadoCategoria();
        estadoAdministrador = getEstadoAdministrador();
        conn.query('Select * from cuenta', (err,resp3,campos) => {
            conn.query('Select * from administrador', (err,resp6,campos) => {
                res.render('Agregar.ejs',{datos3:resp3,datos6: resp6, estadoCategoria, estadoAdministrador});
            });
        });
});
router.post('/modificar/:nombre_usuario', (req,res,err) =>{
   
    
    conn.query('UPDATE emprendedor SET activo=1 WHERE nombre_usuario = ?', [req.params.nombre_usuario], (err, resp, campos) => {
        if(!err){
            console.log("emprendedor aceptado")
            res.redirect('/admin')
        }else{
            console.log(err);
        }
    });
});

router.post('/cambiarImagenEmprendedor/:nombre_usuario', (req,res,err) =>{
   
    
    conn.query('UPDATE emprendedor SET logo="" WHERE nombre_usuario = ?', [req.params.nombre_usuario], (err, resp, campos) => {
        if(!err){
            console.log("imagen borrada")
            res.redirect('/admin')
        }else{
            console.log(err);
        }
    });
});

router.post('/modificarEmprendedor/:nombre_usuario', (req,res,err) =>{
   
    
    conn.query('UPDATE cuenta SET rol="administrador" WHERE nombre_usuario = ?', [req.params.nombre_usuario], (err, resp, campos) => {
        if(!err){
            console.log("imagen borrada")
            res.redirect('/Agregar')
        }else{
            console.log(err);
        }
    });
});

router.post('/modificarAdministrador/:nombre_usuario', (req,res,err) =>{
   
    
    conn.query('UPDATE cuenta SET rol="emprendedor" WHERE nombre_usuario = ?', [req.params.nombre_usuario], (err, resp, campos) => {
        if(!err){
            console.log("imagen borrada")
            res.redirect('/Agregar')
        }else{
            console.log(err);
        }
    });
});

router.post('/cambiarImagenProducto/:nombre_usuario', (req,res,err) =>{
   
    
    conn.query('UPDATE producto SET imagen="" WHERE nombre_usuario = ?', [req.params.nombre_usuario], (err, resp, campos) => {
        if(!err){
            console.log("imagen borrada")
            res.redirect('/admin')
        }else{
            console.log(err);
        }
    });
});

router.post('/modificar1/:id_producto', (req,res,err) =>{
   
    conn.query('UPDATE producto SET activo=1 WHERE id_producto = ?', [req.params.id_producto], (err, resp, campos) => {
        if(!err){
            console.log("producto aceptado")
            res.redirect('/admin')
        }else{
            console.log(err);
        }
    });
});

router.post('/modificar2/:id_contacto', (req,res,err) =>{
   
    conn.query('UPDATE contacto SET activo=1 WHERE id_contacto = ?', [req.params.id_contacto], (err, resp, campos) => {
        if(!err){
            console.log("contacto aceptado")
            res.redirect('/admin')
        }else{
            console.log(err);
        }
    });
});

router.post('/modificarCuentas/:nombre_usuario', (req,res,err) =>{
   
    const {correo, password}= datitos =  req.body;
    const {nombre_usuario} = req.params
    conn.query('UPDATE cuenta SET? WHERE nombre_usuario = ?', [datitos, req.params.nombre_usuario], (err, resp, campos) => {
        if(!err){
            console.log("cuenta actualizada")
            res.redirect('/admin')
        }else{
            console.log(err);
        }
    });
});

router.post('/modificarAdministrador/:nombre_usuario', (req,res,err) =>{
    
    const {correo, password, nombre_admin, apellido_admin, rut}= datitos =  req.body;
    const {nombre_usuario} = req.params
    conn.query('UPDATE administrador SET? WHERE nombre_usuario = ?', [datitos, req.params.nombre_usuario], (err, resp, campos) => {
        if(!err){
            console.log("cuenta actualizada")
            res.redirect('/admin')
        }else{
            console.log(err);
        }
    });
});

router.post('/modificarEmprendimiento/:nombre_usuario', (req,res,err) =>{
    
    const {correo, nombre_emprendedor, nombre_emprendimiento, dirección, logo, descripcion, latitud, longitud}= datitos =  req.body;
    const {nombre_usuario} = req.params
    conn.query('UPDATE emprendedor SET? WHERE nombre_usuario = ?', [datitos, req.params.nombre_usuario], (err, resp, campos) => {
        if(!err){
            console.log("Emprendedor actualizado")
            res.redirect('/admin')
        }else{
            console.log(err);
        }
    });
});

router.post('/modificarContacto/:id_contacto', (req,res,err) =>{
    
    const {contacto, tipo_contacto}= datitos =  req.body;
    const {id_contacto} = req.params
    conn.query('UPDATE contacto SET? WHERE id_contacto = ?', [datitos, req.params.id_contacto], (err, resp, campos) => {
        if(!err){
            console.log("contacto actualizado")
            res.redirect('/admin')
        }else{
            console.log(err);
        }
    });
});

router.post('/modificarCategoria/:nombre_cate', (req,res,err) =>{
    
   
    const {nombre_cate} = datitos = req.body;
    
    conn.query('UPDATE categoria SET? WHERE nombre_cate = ?', [datitos, req.params.nombre_cate], (err, resp, campos) => {
        if(!err){
            console.log("categoria actualizada")
            res.redirect('/admin')
        }else{
            console.log(err);
        }
    });
});

router.post('/modificarProducto/:id_producto', (req,res,err) =>{
    
    const {nombre_usuario, precio, nombre_producto, imagen, descripcion_produc, id_cate}= datitos =  req.body;
    const {id_producto} = req.params
    conn.query('UPDATE producto SET? WHERE id_producto = ?', [datitos, req.params.id_producto], (err, resp, campos) => {
        if(!err){
            console.log("categoria actualizada")
            res.redirect('/admin')
        }else{
            console.log(err);
        }
    });
});

router.get('/eliminar/:nombre_usuario', (req,res,err) =>{
   

    const { nombre_usuario } = req.params;
    console.log(req.params)
    conn.query('DELETE from emprendedor WHERE nombre_usuario = ?', [nombre_usuario], (err, resp, campos) => {
        if(!err){
            console.log("emprendedor rechazado")
            res.redirect('/admin')
        }else{
            console.log(err);
        }
    });
});

router.get('/eliminar1/:id_producto', (req,res,err) =>{
   

    const { id_producto } = req.params;
    console.log(req.params)
    conn.query('DELETE from producto WHERE id_producto = ?', [id_producto], (err, resp, campos) => {
        if(!err){
            console.log("producto rechazado")
            res.redirect('/admin')
        }else{
            console.log(err);
        }
    });
});

router.get('/eliminar2/:nombre_usuario', (req,res,err) =>{

    const { nombre_usuario } = req.params;
    
    conn.query('DELETE from cuenta WHERE nombre_usuario = ?', [nombre_usuario], (err, resp, campos) => {
        if(!err){
            console.log("cuenta eliminada")
            res.redirect('/admin')
        }else{
            console.log(err);
        }
    });
});

router.get('/eliminar3/:id_contacto', (req,res,err) =>{

    const { id_contacto } = req.params;
    
    conn.query('DELETE from contacto WHERE id_contacto = ?', [id_contacto], (err, resp, campos) => {
        if(!err){
            console.log("contacto eliminado")
            res.redirect('/admin')
        }else{
            console.log(err);
        }
    });
});

router.get('/eliminar4/:nombre_cate', (req,res,err) =>{

    const { nombre_cate } = req.params;
    
    conn.query('DELETE from categoria WHERE nombre_cate = ?', [nombre_cate], (err, resp, campos) => {
        if(!err){
            console.log("categoria eliminada")
            res.redirect('/admin')
        }else{
            console.log(err);
        }
    });
});

router.get('/eliminar5/:id_solicitud', (req,res,err) =>{

    const { id_solicitud } = req.params;
    
    conn.query('DELETE from solicitudes WHERE id_solicitud = ?', [id_solicitud], (err, resp, campos) => {
        if(!err){
            console.log("solicitud finalizada")
            res.redirect('/admin')
        }else{
            console.log(err);
        }
    });
});

router.get('/login', (req,res) =>{
    const errors = req.flash().error || [];
    let op = require("../index.js")
    let estado = op.estado1;
    res.render('login.ejs', {errors, estado});

});

router.post('/login', passport.authenticate('local',{  
    failureFlash: true,
    failureRedirect: "/login",
}), (req,res,next) =>{    
    res.redirect("/admin") 
});

router.get('/logout', (req, res) => {
    req.logout();
    res.redirect('/login');
});

module.exports = router;