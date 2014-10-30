
--
-- Estructura de tabla para la tabla `usuario`
--

DROP TABLE IF EXISTS `usuario`;
CREATE TABLE IF NOT EXISTS `usuario` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `apellido` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `token` varchar(50) NOT NULL,
  `activo` tinyint(1) NOT NULL,
  `tipo` varchar(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=37 ;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id`, `nombre`, `apellido`, `email`, `password`, `token`, `activo`, `tipo`) VALUES
(1, 'admin', 'admin', 'admin@localhost.com', 'delta1.yo', '', 1, 'admin'),
(2, 'invitado', 'invitado', 'invitado@localhost.com', 'invitado', '', 1, 'invitado'),
(3, 'joanna', 'iquize', 'ur1@localhost.com', 'ur1', '', 1, 'usuario'),
(4, 'Juan', 'Topo', 'ur2@localhost.com', 'ur2', '', 1, 'usuario');


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
  `origen` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;