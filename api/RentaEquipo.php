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
		echo json_encode(registrarRentaEquipo($payload->rentaequipo));
		break;

	case 'obtener':
		echo json_encode(obtenerRentaEquipos());
		break;
	
	case 'obtener_por_nombre':
		echo json_encode(obtenerRentaEquipoPorNombre($payload->nombre));
		break;

	case 'obtener_por_id':
		echo json_encode(obtenerRentaEquipoPorId($payload->id));
		break;

	case 'editar':
		echo json_encode(editarRentaEquipo($payload->rentaequipo));
		break;
	
	case 'eliminar':
		echo json_encode(eliminarRentaEquipo($payload->id));
		break;
	
	default:
		echo json_encode("No se reconoce");
		break;
}