<?php

include_once "encabezado.php";
$payload = json_decode(file_get_contents("php://input"));
if (!$payload) {
    http_response_code(500);
    exit;
}

include_once "funciones.php";

$accion = $payload->accion;

switch ($accion) {
	case 'registrar':
		echo json_encode(registrarGasto($payload->gasto));
		break;

	case 'obtenerFijos':
		echo json_encode(obtenerGastosFijos());
		break;

	case 'obtenerRegulares':
		echo json_encode(obtenerGastosRegulares());
		break;
	
	case 'obtener_por_nombre':
		echo json_encode(obtenerGastosPorNombre($payload->descripcion));
		break;

	case 'obtener_por_id':
		echo json_encode(obtenerGastoPorId($payload->id));
		break;

	case 'editar':
		echo json_encode(editarGasto($payload->gasto));
		break;
	
	case 'eliminar':
		echo json_encode(eliminarGasto($payload->id));
		break;
	
	default:
		echo json_encode("No se reconoce");
		break;
}