<template>
	<section>
		<b-field label="Nombre del rentaequipo">
			<b-autocomplete
				v-model="rentaequipo"
				id="rentaequipo"
				placeholder="Escribe el nombre del rentaequipo"
				:keep-first="true"
				:data="rentaequipoFiltrados"
				field="nombre"
				@input="buscarSuplidores"
				@select="seleccionarSuplidor"
				size="is-medium"
			>
			</b-autocomplete>
		</b-field>
		<div class="notification is-info mt-2" v-if="rentaequipoSeleccionado">
			<button class="delete" @click="deseleccionarGasto"></button>
			<p>Nombre: <b>{{ rentaequipoSeleccionado.nombre }}</b></p>
			<p>Suplidor: <b>{{ rentaequipoSeleccionado.suplidor }}</b></p>
			<p>Costo: <b>{{ rentaequipoSeleccionado.costo }}</b></p>
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

			buscarSuplidores(){
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
			rentaequipoFiltrados() {
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