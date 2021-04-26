-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 26-04-2021 a las 03:14:22
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
  `nombre_usuario` varchar(15) NOT NULL,
  `correo` varchar(100) NOT NULL,
  `nombre_admin` varchar(40) NOT NULL,
  `apellido_admin` varchar(40) NOT NULL,
  `rut` varchar(12) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `administrador`
--

INSERT INTO `administrador` (`nombre_usuario`, `correo`, `nombre_admin`, `apellido_admin`, `rut`) VALUES
('mauriciokiubi', 'mauricio@dominio.cl', 'Mauricio Eduardo', 'De Juan Palavecino', '11.111.111-2');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categoria`
--

CREATE TABLE `categoria` (
  `nombre_cate` varchar(30) NOT NULL DEFAULT 'No categoria'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `categoria`
--

INSERT INTO `categoria` (`nombre_cate`) VALUES
('Artesania'),
('Comida'),
('Entretencion'),
('No categoria');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `contacto`
--

CREATE TABLE `contacto` (
  `contacto` tinytext NOT NULL,
  `nombre_usuario` varchar(15) NOT NULL,
  `tipo_contacto` enum('Whatsapp','Instagram','Pagina web','Facebook','Telegram') NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT 0,
  `id_contacto` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `contacto`
--

INSERT INTO `contacto` (`contacto`, `nombre_usuario`, `tipo_contacto`, `activo`, `id_contacto`) VALUES
('cadu2.net', 'cadu', 'Pagina web', 1, 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cuenta`
--

CREATE TABLE `cuenta` (
  `nombre_usuario` varchar(15) NOT NULL DEFAULT 'admin',
  `correo` varchar(100) NOT NULL,
  `password` varchar(12) NOT NULL DEFAULT 'admin1234',
  `rol` enum('emprendedor','administrador') NOT NULL DEFAULT 'emprendedor'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `cuenta`
--

INSERT INTO `cuenta` (`nombre_usuario`, `correo`, `password`, `rol`) VALUES
('cadu', 'cadu@dominio.cl', '111', 'emprendedor'),
('mauriciokiubi', 'mauricio@dominio.cl', 'hola123', 'administrador'),
('pruebita', 'prueba@dominio.cl', '123', 'emprendedor');

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
  `horario_atencion` tinytext NOT NULL,
  `logo` varchar(1024) NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT 0,
  `descripcion` text NOT NULL,
  `latitud` float NOT NULL DEFAULT 0,
  `longitud` float NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `emprendedor`
--

INSERT INTO `emprendedor` (`nombre_usuario`, `correo`, `nombre_emprendedor`, `nombre_emprendimiento`, `dirección`, `horario_atencion`, `logo`, `activo`, `descripcion`, `latitud`, `longitud`) VALUES
('cadu', 'cadu@dominio.cl', 'Claudia Tobar Moyar', 'Qinti', 'calle falsa 123', 'Lunes a viernes 8:00 a 16:00 hrs', 'facebook.png', 1, 'Vendo nueces!!!', -33.6189, -71.6041);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--

CREATE TABLE `producto` (
  `nombre_usuario` varchar(15) NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT 0,
  `precio` int(11) NOT NULL,
  `nombre_producto` varchar(100) NOT NULL,
  `imagen` varchar(1024) NOT NULL,
  `fecha_publicacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `id_producto` int(11) NOT NULL,
  `descripcion_produc` text NOT NULL,
  `nombre_cate` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `producto`
--

INSERT INTO `producto` (`nombre_usuario`, `activo`, `precio`, `nombre_producto`, `imagen`, `fecha_publicacion`, `id_producto`, `descripcion_produc`, `nombre_cate`) VALUES
('cadu', 1, 20000, 'tapiz', 'wsp.jfif', '2021-04-21 23:03:22', 4, 'asdasdasd', 'Entretencion');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `solicitudes`
--

CREATE TABLE `solicitudes` (
  `nombre_usuario` varchar(15) NOT NULL,
  `motivo` text NOT NULL,
  `tipo_solicitud` enum('modificacion','eliminacion') NOT NULL,
  `tipo_entidad` enum('producto','emprendedor','categoria','contacto') NOT NULL,
  `id_solicitud` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `administrador`
--
ALTER TABLE `administrador`
  ADD KEY `nombre_usuario` (`nombre_usuario`,`correo`);

--
-- Indices de la tabla `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`nombre_cate`);

--
-- Indices de la tabla `contacto`
--
ALTER TABLE `contacto`
  ADD PRIMARY KEY (`id_contacto`),
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
  ADD KEY `nombre_cate` (`nombre_cate`);

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
-- AUTO_INCREMENT de la tabla `contacto`
--
ALTER TABLE `contacto`
  MODIFY `id_contacto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `producto`
--
ALTER TABLE `producto`
  MODIFY `id_producto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `solicitudes`
--
ALTER TABLE `solicitudes`
  MODIFY `id_solicitud` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

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
  ADD CONSTRAINT `producto_ibfk_2` FOREIGN KEY (`nombre_cate`) REFERENCES `categoria` (`nombre_cate`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `solicitudes`
--
ALTER TABLE `solicitudes`
  ADD CONSTRAINT `solicitudes_ibfk_1` FOREIGN KEY (`nombre_usuario`) REFERENCES `emprendedor` (`nombre_usuario`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
