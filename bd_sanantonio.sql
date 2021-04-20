-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 21-04-2021 a las 00:48:10
-- Versión del servidor: 10.4.16-MariaDB
-- Versión de PHP: 7.4.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `bd_sanantonio`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `administrador`
--

CREATE TABLE `administrador` (
  `nombre_usuario` varchar(15) DEFAULT NULL,
  `correo` varchar(100) DEFAULT NULL,
  `nombre_admin` varchar(40) DEFAULT NULL,
  `apellido_admin` varchar(40) DEFAULT NULL,
  `rut` varchar(12) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `administrador`
--

INSERT INTO `administrador` (`nombre_usuario`, `correo`, `nombre_admin`, `apellido_admin`, `rut`) VALUES
('mauriciokiubi', 'mauricio@dominio.cl', 'Mauricio Eduardo', 'De Juan Palavecino', '11.111.111-2'),
('adminPrueba', 'adminPrueba123@dominio.cl', 'admin', 'prueba', '11.111.111-3');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categoria`
--

CREATE TABLE `categoria` (
  `nombre_cate` varchar(30) NOT NULL DEFAULT 'No categoria',
  `id_cate` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `categoria`
--

INSERT INTO `categoria` (`nombre_cate`, `id_cate`) VALUES
('Artesania', 1),
('Tecnologia', 2),
('Entretencion', 12);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `contacto`
--

CREATE TABLE `contacto` (
  `contacto` tinytext DEFAULT NULL,
  `nombre_usuario` varchar(15) DEFAULT NULL,
  `tipo_contacto` enum('Whatsapp','Instagram','Pagina web','Facebook','Telegram') DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `contacto`
--

INSERT INTO `contacto` (`contacto`, `nombre_usuario`, `tipo_contacto`, `activo`) VALUES
('+56950926264', 'dandi', 'Whatsapp', 1),
('Cristales_y_Encantos', 'clato', 'Instagram', 1),
('dulce_suculenta', 'denipla', 'Instagram', 1),
('saagsdg', 'Donato777HD', 'Instagram', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cuenta`
--

CREATE TABLE `cuenta` (
  `nombre_usuario` varchar(15) NOT NULL DEFAULT 'admin',
  `correo` varchar(100) NOT NULL,
  `password` varchar(12) NOT NULL DEFAULT 'admin1234',
  `rol` enum('emprendedor','administrador') DEFAULT 'emprendedor'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `cuenta`
--

INSERT INTO `cuenta` (`nombre_usuario`, `correo`, `password`, `rol`) VALUES
('adminPrueba', 'adminPrueba123@dominio.cl', 'admin1234', 'administrador'),
('cadu', 'cadu@dominio.cl', '111', 'emprendedor'),
('clato', 'clato@dominio.cl', '333', 'emprendedor'),
('dandi', 'dandi@dominio.cl', '222', 'emprendedor'),
('denipla', 'denipla@dominio.cl', '444', 'emprendedor'),
('Donato777HD', 'donato@dominio.cl', 'donato123', 'emprendedor'),
('LuisMi12', 'luismiguel@dominio.cl', 'luis12', 'emprendedor'),
('mauriciokiubi', 'mauricio@dominio.cl', 'hola1234', 'administrador');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `emprendedor`
--

CREATE TABLE `emprendedor` (
  `nombre_usuario` varchar(15) NOT NULL,
  `correo` varchar(100) NOT NULL,
  `nombre_emprendedor` varchar(50) NOT NULL,
  `nombre_emprendimiento` varchar(50) NOT NULL,
  `dirección` tinytext NOT NULL,
  `horario_atencion` tinytext DEFAULT NULL,
  `logo` varchar(1024) DEFAULT NULL,
  `activo` tinyint(1) NOT NULL,
  `descripcion` text NOT NULL,
  `latitud` float NOT NULL DEFAULT 0,
  `longitud` float NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `emprendedor`
--

INSERT INTO `emprendedor` (`nombre_usuario`, `correo`, `nombre_emprendedor`, `nombre_emprendimiento`, `dirección`, `horario_atencion`, `logo`, `activo`, `descripcion`, `latitud`, `longitud`) VALUES
('cadu', 'cadu@dominio.cl', 'Catherine Duarte Duarte', 'QintiPro123', 'Joaquin Robledo 1120, Tejas Verdes', 'Lunes a Viernes 9:00 a 19:00', '', 1, 'Accesorios, cuadros, tapiceria bordada en punto cruz.', 100, 50),
('dandi', 'dandi@dominio.cl', 'Danae Diaz Rojas', 'Arcoiris Decocrochet', 'Pudeto 2070, Barrancas', 'Lunes a Viernes 9:00 a 19:00', '', 1, 'Tejidos decorativos, manualidades y accesorios', 0, 0),
('clato', 'clato@dominio.cl', 'Claudia Tobar Moya', 'Cristales y encantos', 'Altos de Miramar, Barracas', 'Lunes a Viernes 09:00 a 19:00 hrs', '', 1, 'Elaboracion y venta de joyas y accesorios artesanales: pulseras, aros, collares, llaveros, prismas de decoracion, con piedras naturales.', 0, 0),
('denipla', 'denipla@dominio.cl', 'Denizad Plaza Avello', 'Dulce Suculenta', 'Parcela 21, San Juan el Tranque', '10:00 a 18:00', '', 1, 'Venta de arreglos de cactus y suculentas en macetas', 0, 0),
('Donato777HD', 'donato@dominio.cl', 'Donato Oliveira', 'DonatoNueces.Inc', 'calle falsa 123', 'Lunes a viernes 8:00 a 16:00 hrs', 'donato.jfif', 1, 'Vendo nueces para todos!!! a 7000 el kilo, soy de san antonio!!!', 0, 0),
('LuisMi12', 'luismiguel@dominio.cl', 'Luis Miguelito', 'Cervezas Kunstmann', 'calle falsa 123', 'Lunes a viernes 8:00 a 16:00 hrs', 'luismiguel.jfif', 1, 'Vendo cervezas Kunstmann a $10000 pesos las 4 botellas todo por delivery', 0, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--

CREATE TABLE `producto` (
  `nombre_usuario` varchar(12) NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT 0,
  `precio` int(11) NOT NULL,
  `nombre_producto` tinytext NOT NULL,
  `imagen` varchar(1024) DEFAULT NULL,
  `fecha_publicacion` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `id_producto` int(4) NOT NULL,
  `descripcion_produc` text NOT NULL,
  `id_cate` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `producto`
--

INSERT INTO `producto` (`nombre_usuario`, `activo`, `precio`, `nombre_producto`, `imagen`, `fecha_publicacion`, `id_producto`, `descripcion_produc`, `id_cate`) VALUES
('cadu', 1, 5000, 'Tapiz', '', '2021-04-14 00:56:26', 1, 'Tapiz de silla', 1),
('dandi', 1, 2000, 'Aros', '', '2021-04-03 23:00:02', 2, 'Aros de crochet', 2),
('cadu', 1, 13000, 'Prueba_Categoria', 'seguro defensa juridica.jpg', '2021-04-13 01:20:45', 12, 'Prueba_Categoria', 1),
('LuisMi12', 1, 10000, 'Kunstmann torobayo', 'kunstmann.jfif', '2021-04-14 18:46:44', 13, 'Cerveza Kunstmann', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `solicitudes`
--

CREATE TABLE `solicitudes` (
  `nombre_usuario` varchar(13) DEFAULT NULL,
  `motivo` text DEFAULT NULL,
  `tipo_solicitud` enum('modificacion','eliminacion') DEFAULT NULL,
  `tipo_entidad` enum('producto','emprendedor','categoria','contacto') DEFAULT NULL,
  `id_solicitud` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `administrador`
--
ALTER TABLE `administrador`
  ADD PRIMARY KEY (`rut`),
  ADD KEY `nombre_usuario` (`nombre_usuario`,`correo`);

--
-- Indices de la tabla `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`id_cate`,`nombre_cate`);

--
-- Indices de la tabla `contacto`
--
ALTER TABLE `contacto`
  ADD KEY `nombre_usuario` (`nombre_usuario`);

--
-- Indices de la tabla `cuenta`
--
ALTER TABLE `cuenta`
  ADD PRIMARY KEY (`nombre_usuario`,`correo`);

--
-- Indices de la tabla `emprendedor`
--
ALTER TABLE `emprendedor`
  ADD KEY `nombre_usuario` (`nombre_usuario`,`correo`);

--
-- Indices de la tabla `producto`
--
ALTER TABLE `producto`
  ADD PRIMARY KEY (`id_producto`),
  ADD KEY `nombre_usuario` (`nombre_usuario`),
  ADD KEY `id_cate` (`id_cate`);

--
-- Indices de la tabla `solicitudes`
--
ALTER TABLE `solicitudes`
  ADD PRIMARY KEY (`id_solicitud`),
  ADD KEY `nombre_usuario` (`nombre_usuario`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `categoria`
--
ALTER TABLE `categoria`
  MODIFY `id_cate` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `producto`
--
ALTER TABLE `producto`
  MODIFY `id_producto` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `solicitudes`
--
ALTER TABLE `solicitudes`
  MODIFY `id_solicitud` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `administrador`
--
ALTER TABLE `administrador`
  ADD CONSTRAINT `administrador_ibfk_1` FOREIGN KEY (`nombre_usuario`,`correo`) REFERENCES `cuenta` (`nombre_usuario`, `correo`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `contacto`
--
ALTER TABLE `contacto`
  ADD CONSTRAINT `contacto_ibfk_1` FOREIGN KEY (`nombre_usuario`) REFERENCES `emprendedor` (`nombre_usuario`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `emprendedor`
--
ALTER TABLE `emprendedor`
  ADD CONSTRAINT `emprendedor_ibfk_1` FOREIGN KEY (`nombre_usuario`,`correo`) REFERENCES `cuenta` (`nombre_usuario`, `correo`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `producto`
--
ALTER TABLE `producto`
  ADD CONSTRAINT `producto_ibfk_1` FOREIGN KEY (`nombre_usuario`) REFERENCES `emprendedor` (`nombre_usuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `producto_ibfk_2` FOREIGN KEY (`id_cate`) REFERENCES `categoria` (`id_cate`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `solicitudes`
--
ALTER TABLE `solicitudes`
  ADD CONSTRAINT `solicitudes_ibfk_1` FOREIGN KEY (`nombre_usuario`) REFERENCES `emprendedor` (`nombre_usuario`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
