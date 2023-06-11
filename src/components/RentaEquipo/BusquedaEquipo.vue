<template>
	<section>
		<b-field label="Descripcion">
			<b-autocomplete
				v-model="rentaequipo"
				id="rentaequipo"
				placeholder="Escribe la descripcion"
				:keep-first="true"
				:data="clientesFiltrados"
				field="nombre"
				@input="buscarGastos"
				@select="seleccionarSuplidor"
				size="is-medium"
			>
			</b-autocomplete>
		</b-field>
		<div class="notification is-info mt-2" v-if="rentaequipoSeleccionado">
			<button class="delete" @click="deseleccionarGasto"></button>
			<p>nombre: <b>{{ rentaequipoSeleccionado.nombre }}</b></p>
			<p>suplidor: <b>{{ rentaequipoSeleccionado.suplidor }}</b></p>
			<p>costo: <b>{{ rentaequipoSeleccionado.costo }}</b></p>
		</div>
	</section>
</template>
<script>
	import HttpService from '../../Servicios/HttpService'

	export default{
		name: "BusquedaGasto",

		data:()=>({
			rentaequipo: "",
			rentaequiposEncontrados: [],
			rentaequipoSeleccionado: null
		}),

		methods: {
			deseleccionarGasto(){
				this.rentaequipoSeleccionado = null
			},
			seleccionarSuplidor(opcion) {
				if(!opcion) return
				this.rentaequipoSeleccionado = opcion
				this.$emit("seleccionado", this.rentaequipoSeleccionado)
				setTimeout(() => this.rentaequipo = '', 10)
			},

			buscarGastos(){
				let payload = {
					accion: 'obtener_por_nombre',
					nombre: this.rentaequipo
				}

				HttpService.obtenerConConsultas('RentaEquipo.php', payload)
				.then(rentaequipos =>{ 
					this.rentaequiposEncontrados = rentaequipos
				})
			},
		},

		computed: {
			clientesFiltrados() {
				return this.rentaequiposEncontrados.filter(opcion => {
					return (
						opcion.nombre
							.toString()
							.toLowerCase()
							.indexOf(this.rentaequipo.toLowerCase()) >= 0
					)
				})
			}
		}

	}
</script>