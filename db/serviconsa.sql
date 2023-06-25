-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jun 25, 2023 at 06:56 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.0.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `serviconsa`
--

-- --------------------------------------------------------

--
-- Table structure for table `categorias`
--

CREATE TABLE `categorias` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nombreCategoria` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categorias`
--

INSERT INTO `categorias` (`id`, `nombreCategoria`) VALUES
(1, 'LIBRETAS'),
(2, 'LAPICES'),
(4, 'PLUMONES'),
(5, 'CRAYOLAS'),
(8, 'ARTICULOS DE OFICINA');

-- --------------------------------------------------------

--
-- Table structure for table `clientes`
--

CREATE TABLE `clientes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `telefono` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `clientes`
--

INSERT INTO `clientes` (`id`, `nombre`, `telefono`) VALUES
(1, 'paco rivera bernabe', '2311459874'),
(2, 'canela perez', '2311469874'),
(3, 'ejemplo de cliente', ''),
(4, 'ejemplo de otro cliente', '231213456987'),
(5, 'otrooooo clienteee', ''),
(7, 'Lars Montriel', '231212315121');

-- --------------------------------------------------------

--
-- Table structure for table `configuracion`
--

CREATE TABLE `configuracion` (
  `nombre` varchar(255) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `logo` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `configuracion`
--

INSERT INTO `configuracion` (`nombre`, `telefono`, `logo`) VALUES
('Serviconsa', '8498517880', './logos/logo.png');

-- --------------------------------------------------------

--
-- Table structure for table `cotizaciones`
--

CREATE TABLE `cotizaciones` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `fecha` datetime NOT NULL,
  `total` decimal(9,2) NOT NULL,
  `idCliente` bigint(20) DEFAULT NULL,
  `idUsuario` bigint(20) NOT NULL,
  `descuento` int(11) DEFAULT NULL,
  `terminos` text DEFAULT NULL,
  `observacion` text DEFAULT NULL,
  `impuesto` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cotizaciones`
--

INSERT INTO `cotizaciones` (`id`, `fecha`, `total`, `idCliente`, `idUsuario`, `descuento`, `terminos`, `observacion`, `impuesto`) VALUES
(27, '2023-06-25 09:30:21', 1180.00, 1, 1, 0, '', '', 1),
(28, '2023-06-25 10:32:30', 1000.00, 1, 1, 0, 'todo good', 'observacion bien', 0),
(29, '2023-06-25 10:33:01', 1180.00, 1, 1, 0, 'con impuestos', 'a ver', 1),
(30, '2023-06-25 10:42:23', 1416.00, 5, 1, 0, 'a ver', 'a ver en observacion', 1);

-- --------------------------------------------------------

--
-- Table structure for table `cuentas_apartados`
--

CREATE TABLE `cuentas_apartados` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `fecha` datetime NOT NULL,
  `total` decimal(9,2) NOT NULL,
  `pagado` decimal(9,2) NOT NULL,
  `porPagar` decimal(9,2) NOT NULL,
  `tipo` enum('apartado','cuenta') NOT NULL,
  `idCliente` bigint(20) DEFAULT NULL,
  `idUsuario` bigint(20) NOT NULL,
  `descuento` int(11) DEFAULT NULL,
  `terminos` text DEFAULT NULL,
  `observacion` text DEFAULT NULL,
  `impuesto` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cuentas_apartados`
--

INSERT INTO `cuentas_apartados` (`id`, `fecha`, `total`, `pagado`, `porPagar`, `tipo`, `idCliente`, `idUsuario`, `descuento`, `terminos`, `observacion`, `impuesto`) VALUES
(1, '2022-06-25 17:30:03', 1000.00, 1000.00, 0.00, 'cuenta', 2, 1, NULL, NULL, NULL, NULL),
(2, '2022-06-25 17:36:09', 1000.00, 1000.00, 0.00, 'apartado', 1, 1, NULL, NULL, NULL, NULL),
(3, '2022-06-25 17:53:10', 1000.00, 900.00, 100.00, 'cuenta', 1, 1, NULL, NULL, NULL, NULL),
(4, '2022-06-25 17:53:25', 1000.00, 1000.00, 0.00, 'apartado', 2, 1, NULL, NULL, NULL, NULL),
(5, '2022-07-03 17:53:15', 22.00, 22.00, 0.00, 'cuenta', 1, 1, NULL, NULL, NULL, NULL),
(6, '2022-07-03 18:13:16', 1000.00, 300.00, 700.00, 'apartado', 4, 1, NULL, NULL, NULL, NULL),
(7, '2022-07-06 18:09:30', 300.00, 100.00, 200.00, 'cuenta', 2, 1, NULL, NULL, NULL, NULL),
(8, '2022-07-06 18:10:14', 1022.00, 0.00, 1022.00, 'apartado', 4, 1, NULL, NULL, NULL, NULL),
(9, '2023-06-10 08:44:25', 800.00, 100.00, 700.00, 'apartado', 3, 1, 200, 'ijii', 'ygyugyfg', NULL),
(10, '2023-06-10 08:51:50', 900.00, 700.00, 200.00, 'cuenta', 3, 1, 100, 'tf', 'ed', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `gastos`
--

CREATE TABLE `gastos` (
  `id` int(11) NOT NULL,
  `descripcion` varchar(200) DEFAULT NULL,
  `monto` int(11) DEFAULT NULL,
  `fijo` tinyint(1) NOT NULL,
  `fecha` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `gastos`
--

INSERT INTO `gastos` (`id`, `descripcion`, `monto`, `fijo`, `fecha`) VALUES
(1, 'ejemplo', 200, 1, '2023-06-11 01:51:27'),
(2, 'ok', 23, 0, '2023-06-11 10:41:12'),
(4, 'nuevo', 400, 0, '2023-06-11 10:45:12'),
(6, 'otro', 34, 0, '2023-06-11 10:54:30'),
(9, 'ejemplo', 2000, 1, '2023-06-25 09:41:36'),
(10, 'Compra de comida', 1000, 1, '2023-06-25 17:52:57'),
(11, 'pago de agua', 2000, 0, '2023-06-25 17:53:32'),
(12, 'compra de jugo', 2000, 0, '2023-06-25 17:55:00');

-- --------------------------------------------------------

--
-- Table structure for table `marcas`
--

CREATE TABLE `marcas` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nombreMarca` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `marcas`
--

INSERT INTO `marcas` (`id`, `nombreMarca`) VALUES
(1, 'NORMA'),
(2, 'SCRIBE'),
(3, 'MAPED'),
(4, 'PELIKAN'),
(5, 'BIC'),
(6, 'PAPER MATE'),
(7, 'KIUT'),
(10, 'SHARPIE'),
(11, 'ESTRELLA');

-- --------------------------------------------------------

--
-- Table structure for table `productos`
--

CREATE TABLE `productos` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `codigo` varchar(50) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `precioCompra` decimal(8,2) NOT NULL,
  `precioVenta` decimal(8,2) NOT NULL,
  `existencia` int(11) NOT NULL,
  `vendidoMayoreo` tinyint(1) DEFAULT NULL,
  `precioMayoreo` decimal(8,2) DEFAULT NULL,
  `cantidadMayoreo` decimal(8,2) DEFAULT NULL,
  `marca` bigint(20) UNSIGNED DEFAULT NULL,
  `categoria` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `productos`
--

INSERT INTO `productos` (`id`, `codigo`, `nombre`, `precioCompra`, `precioVenta`, `existencia`, `vendidoMayoreo`, `precioMayoreo`, `cantidadMayoreo`, `marca`, `categoria`) VALUES
(1, '1321355155', 'Bocina', 500.00, 1000.00, 20, 0, 0.00, 0.00, 0, 0),
(2, '12123146556415', 'Libreta de Call of duty', 15.00, 22.00, 99, 0, 0.00, 0.00, 1, 1),
(3, '113241564546', 'Cuaderno cosido ', 15.00, 22.00, 66, 1, 13.00, 10.00, 2, 1),
(4, '1321354564', 'Lapiz bonito', 5.00, 10.00, 453, 1, 8.00, 20.00, 3, 2),
(6, '12131212545454', 'Mouse inalámbrico ', 50.00, 100.00, 96, 0, 0.00, 0.00, 0, 0),
(7, '11321345495', 'Teclado inálambrico', 105.00, 200.00, 496, 0, 0.00, 0.00, 0, 0),
(8, '1213221', 'Calculadora', 25.00, 28.00, 11, 0, 0.00, 0.00, 0, 0),
(9, '123135135487487', 'Goma pelikan strike', 1.54, 4.00, 3, 1, 3.00, 20.00, 4, 0);

-- --------------------------------------------------------

--
-- Table structure for table `productos_vendidos`
--

CREATE TABLE `productos_vendidos` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `cantidad` decimal(5,2) NOT NULL,
  `precio` decimal(8,2) NOT NULL,
  `idProducto` bigint(20) NOT NULL,
  `idReferencia` bigint(20) NOT NULL,
  `tipo` enum('apartado','cuenta','venta','cotiza') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `productos_vendidos`
--

INSERT INTO `productos_vendidos` (`id`, `cantidad`, `precio`, `idProducto`, `idReferencia`, `tipo`) VALUES
(1, 1.00, 1000.00, 1, 1, 'cuenta'),
(2, 1.00, 20.00, 3, 1, 'venta'),
(3, 1.00, 22.00, 2, 1, 'venta'),
(4, 1.00, 1000.00, 1, 2, 'apartado'),
(5, 1.00, 22.00, 2, 2, 'venta'),
(6, 1.00, 10.00, 4, 2, 'venta'),
(7, 1.00, 1000.00, 1, 3, 'cuenta'),
(8, 1.00, 1000.00, 1, 4, 'apartado'),
(9, 1.00, 22.00, 2, 3, 'venta'),
(10, 1.00, 10.00, 4, 3, 'venta'),
(11, 1.00, 1000.00, 1, 4, 'venta'),
(12, 1.00, 22.00, 3, 5, 'venta'),
(13, 5.00, 22.00, 2, 6, 'venta'),
(14, 15.00, 13.00, 3, 7, 'venta'),
(15, 1.00, 22.00, 2, 8, 'venta'),
(16, 1.00, 22.00, 3, 9, 'venta'),
(17, 3.00, 22.00, 2, 1, 'cotiza'),
(18, 3.00, 10.00, 4, 1, 'cotiza'),
(19, 1.00, 1000.00, 1, 1, 'cotiza'),
(20, 3.00, 22.00, 3, 1, 'cotiza'),
(21, 100.00, 8.00, 4, 2, 'cotiza'),
(22, 1.00, 22.00, 3, 5, 'cuenta'),
(23, 1.00, 1000.00, 1, 6, 'apartado'),
(29, 4.00, 22.00, 3, 4, 'cotiza'),
(30, 3.00, 10.00, 4, 4, 'cotiza'),
(31, 3.00, 1000.00, 1, 4, 'cotiza'),
(32, 5.00, 200.00, 7, 4, 'cotiza'),
(33, 4.00, 100.00, 6, 4, 'cotiza'),
(34, 10.00, 22.00, 3, 10, 'venta'),
(35, 2.00, 10.00, 4, 10, 'venta'),
(36, 2.00, 100.00, 6, 10, 'venta'),
(37, 1.00, 200.00, 7, 10, 'venta'),
(38, 2.00, 22.00, 3, 11, 'venta'),
(39, 2.00, 10.00, 4, 11, 'venta'),
(40, 1.00, 100.00, 6, 12, 'venta'),
(41, 1.00, 200.00, 7, 12, 'venta'),
(42, 1.00, 22.00, 2, 12, 'venta'),
(43, 1.00, 10.00, 4, 12, 'venta'),
(44, 1.00, 200.00, 7, 13, 'venta'),
(45, 10.00, 10.00, 4, 14, 'venta'),
(46, 1.00, 100.00, 6, 7, 'cuenta'),
(47, 1.00, 200.00, 7, 7, 'cuenta'),
(48, 1.00, 1000.00, 1, 8, 'apartado'),
(49, 1.00, 22.00, 2, 8, 'apartado'),
(50, 2.00, 10.00, 4, 5, 'cotiza'),
(51, 1.00, 200.00, 7, 5, 'cotiza'),
(52, 1.00, 100.00, 6, 5, 'cotiza'),
(53, 1.00, 1000.00, 1, 5, 'cotiza'),
(54, 1.00, 22.00, 3, 5, 'cotiza'),
(55, 3.00, 22.00, 3, 15, 'venta'),
(56, 2.00, 10.00, 4, 16, 'venta'),
(57, 1.00, 22.00, 3, 16, 'venta'),
(58, 8.00, 4.00, 9, 17, 'venta'),
(59, 10.00, 10.00, 4, 17, 'venta'),
(60, 7.00, 22.00, 3, 6, 'cotiza'),
(61, 6.00, 1000.00, 1, 6, 'cotiza'),
(62, 20.00, 22.00, 2, 6, 'cotiza'),
(63, 1.00, 1000.00, 1, 7, 'cotiza'),
(64, 2.00, 1000.00, 1, 8, 'cotiza'),
(65, 1.00, 1000.00, 1, 9, 'cotiza'),
(66, 2.00, 1000.00, 1, 10, 'cotiza'),
(67, 1.00, 22.00, 2, 11, 'cotiza'),
(68, 1.00, 1000.00, 1, 9, 'apartado'),
(69, 1.00, 1000.00, 1, 10, 'cuenta'),
(70, 1.00, 1000.00, 1, 18, 'venta'),
(71, 1.00, 1000.00, 1, 12, 'cotiza'),
(72, 1.00, 1000.00, 1, 13, 'cotiza'),
(73, 2.00, 1000.00, 1, 14, 'cotiza'),
(74, 1.00, 1000.00, 1, 15, 'cotiza'),
(75, 1.00, 1000.00, 1, 16, 'cotiza'),
(76, 1.00, 1000.00, 1, 17, 'cotiza'),
(77, 1.00, 1000.00, 1, 18, 'cotiza'),
(78, 1.00, 1000.00, 1, 19, 'cotiza'),
(79, 1.00, 1000.00, 1, 20, 'cotiza'),
(80, 1.00, 1000.00, 1, 21, 'cotiza'),
(81, 1.00, 1000.00, 1, 22, 'cotiza'),
(82, 1.00, 100.00, 6, 23, 'cotiza'),
(83, 1.00, 1000.00, 1, 24, 'cotiza'),
(84, 1.00, 1000.00, 1, 25, 'cotiza'),
(85, 1.00, 1000.00, 1, 26, 'cotiza'),
(86, 1.00, 1000.00, 1, 27, 'cotiza'),
(87, 1.00, 1000.00, 1, 19, 'venta'),
(88, 1.00, 1000.00, 1, 20, 'venta'),
(89, 1.00, 1000.00, 1, 28, 'cotiza'),
(90, 1.00, 1000.00, 1, 29, 'cotiza'),
(91, 1.00, 1000.00, 1, 30, 'cotiza'),
(92, 1.00, 200.00, 7, 30, 'cotiza'),
(93, 1.00, 1000.00, 1, 21, 'venta');

-- --------------------------------------------------------

--
-- Table structure for table `renta_equipo`
--

CREATE TABLE `renta_equipo` (
  `id` int(11) NOT NULL,
  `nombre` varchar(200) DEFAULT NULL,
  `suplidor` varchar(200) DEFAULT NULL,
  `costo` int(11) DEFAULT NULL,
  `fecha` datetime DEFAULT NULL,
  `estado` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `renta_equipo`
--

INSERT INTO `renta_equipo` (`id`, `nombre`, `suplidor`, `costo`, `fecha`, `estado`) VALUES
(3, 'Ejemplo de camion 1', 'ejemplo 1', 5009, '2023-06-11 10:40:42', 1),
(5, 'test 1', 'ejemplo 2', 500, '2023-06-11 07:39:34', 1);

-- --------------------------------------------------------

--
-- Table structure for table `suplidores`
--

CREATE TABLE `suplidores` (
  `id` int(11) NOT NULL,
  `nombre` varchar(200) DEFAULT NULL,
  `telefono` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `suplidores`
--

INSERT INTO `suplidores` (`id`, `nombre`, `telefono`) VALUES
(1, 'ejemplo 1', '222222445'),
(3, 'ejemplo 2', '23423423');

-- --------------------------------------------------------

--
-- Table structure for table `usuarios`
--

CREATE TABLE `usuarios` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `usuario` varchar(50) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `telefono` varchar(20) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `usuarios`
--

INSERT INTO `usuarios` (`id`, `usuario`, `nombre`, `telefono`, `password`) VALUES
(1, 'admin', 'Administrador', '0000000000', '$2a$12$SQT/CuSstC7v7QeBRHhzKe.mKBXw.8fwilUIJ6BDRX2ZyWUAU3QY2'),
(2, 'ventas', 'Ventas', '0000000000', '$2a$12$q0tUitm3fjvcPdkmlW4UseNMgaSpqsKpDHK/QBqfvxVOIomE3l65i');

-- --------------------------------------------------------

--
-- Table structure for table `ventas`
--

CREATE TABLE `ventas` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `fecha` datetime NOT NULL,
  `total` decimal(9,2) NOT NULL,
  `pagado` decimal(9,2) NOT NULL,
  `idCliente` bigint(20) DEFAULT NULL,
  `idUsuario` bigint(20) NOT NULL,
  `descuento` int(11) DEFAULT NULL,
  `terminos` text DEFAULT NULL,
  `observacion` text DEFAULT NULL,
  `impuesto` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ventas`
--

INSERT INTO `ventas` (`id`, `fecha`, `total`, `pagado`, `idCliente`, `idUsuario`, `descuento`, `terminos`, `observacion`, `impuesto`) VALUES
(1, '2022-06-25 17:30:52', 42.00, 50.00, 0, 1, NULL, NULL, NULL, NULL),
(2, '2022-06-25 17:52:56', 32.00, 50.00, 0, 1, NULL, NULL, NULL, NULL),
(3, '2022-06-28 13:38:54', 32.00, 50.00, 0, 1, NULL, NULL, NULL, NULL),
(4, '2022-06-28 14:48:09', 1000.00, 1000.00, 1, 1, NULL, NULL, NULL, NULL),
(5, '2022-07-01 16:43:50', 22.00, 30.00, 0, 1, NULL, NULL, NULL, NULL),
(6, '2022-07-01 17:25:46', 110.00, 200.00, 0, 1, NULL, NULL, NULL, NULL),
(7, '2022-07-02 18:05:34', 195.00, 200.00, 0, 1, NULL, NULL, NULL, NULL),
(8, '2022-07-02 18:15:48', 22.00, 50.00, 0, 1, NULL, NULL, NULL, NULL),
(9, '2022-07-02 18:18:22', 22.00, 50.00, 0, 1, NULL, NULL, NULL, NULL),
(10, '2022-07-06 14:57:27', 640.00, 1000.00, 0, 1, NULL, NULL, NULL, NULL),
(11, '2022-07-06 17:56:18', 64.00, 100.00, 0, 1, NULL, NULL, NULL, NULL),
(12, '2022-07-06 17:59:02', 332.00, 332.00, 0, 1, NULL, NULL, NULL, NULL),
(13, '2022-07-06 17:59:27', 200.00, 200.00, 2, 2, NULL, NULL, NULL, NULL),
(14, '2022-07-06 18:09:03', 100.00, 100.00, 0, 2, NULL, NULL, NULL, NULL),
(15, '2022-07-15 13:20:43', 66.00, 100.00, 0, 1, NULL, NULL, NULL, NULL),
(16, '2022-07-15 16:41:45', 42.00, 50.00, 4, 1, NULL, NULL, NULL, NULL),
(17, '2022-07-15 16:43:23', 132.00, 500.00, 0, 5, NULL, NULL, NULL, NULL),
(18, '2023-06-10 08:59:39', 900.00, 2000.00, 3, 1, 100, 'ygy', 'hyh', NULL),
(21, '2023-06-25 17:11:06', 1180.00, 1000.00, 0, 1, 0, '', '', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cotizaciones`
--
ALTER TABLE `cotizaciones`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cuentas_apartados`
--
ALTER TABLE `cuentas_apartados`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `gastos`
--
ALTER TABLE `gastos`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `marcas`
--
ALTER TABLE `marcas`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `productos_vendidos`
--
ALTER TABLE `productos_vendidos`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `renta_equipo`
--
ALTER TABLE `renta_equipo`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `suplidores`
--
ALTER TABLE `suplidores`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ventas`
--
ALTER TABLE `ventas`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categorias`
--
ALTER TABLE `categorias`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `clientes`
--
ALTER TABLE `clientes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `cotizaciones`
--
ALTER TABLE `cotizaciones`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `cuentas_apartados`
--
ALTER TABLE `cuentas_apartados`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `gastos`
--
ALTER TABLE `gastos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `marcas`
--
ALTER TABLE `marcas`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `productos`
--
ALTER TABLE `productos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `productos_vendidos`
--
ALTER TABLE `productos_vendidos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=94;

--
-- AUTO_INCREMENT for table `renta_equipo`
--
ALTER TABLE `renta_equipo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `suplidores`
--
ALTER TABLE `suplidores`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `ventas`
--
ALTER TABLE `ventas`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
