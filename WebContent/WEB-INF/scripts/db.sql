-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

DROP TABLE IF EXISTS `usuario`;
CREATE TABLE IF NOT EXISTS `usuario` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `idSocial` varchar(50) DEFAULT NULL,
  `nombre` varchar(50) NOT NULL,
  `apellido` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  `token` varchar(50) DEFAULT NULL,
  `activo` tinyint(1) NOT NULL,
  `tipo` varchar(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=21 ;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id`, `idSocial`, `nombre`, `apellido`, `email`, `password`, `token`, `activo`, `tipo`) VALUES
(1, NULL, 'admin', 'admin', 'admin@localhost.com', 'admin', '', 1, 'admin'),
(2, NULL, 'invitado', 'invitado', 'invitado@localhost.com', 'invitado', '', 1, 'invitado'),
(3, NULL, 'joanna', 'iquize', 'ur1@localhost.com', 'ur1', '', 1, 'usuario'),
(4, NULL, 'Juan', 'Topo', 'ur2@localhost.com', 'ur2', '', 1, 'usuario');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario_tabla`
--

DROP TABLE IF EXISTS `usuario_tabla`;
CREATE TABLE IF NOT EXISTS `usuario_tabla` (
  `id_usuario` int(10) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `tabla` varchar(50) NOT NULL,
  `relation` varchar(500) NOT NULL,
  `classindex` int(100) NOT NULL,
  `descripcion` varchar(200) NOT NULL,
  `origen` varchar(1000) NOT NULL,
  PRIMARY KEY (`id_usuario`,`nombre`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
