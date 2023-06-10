<template>
	<section>
		<b-field label="Nombre del suplidor">
			<b-autocomplete
				v-model="suplidor"
				id="suplidor"
				placeholder="Escribe el nombre del suplidor"
				:keep-first="true"
				:data="clientesFiltrados"
				field="nombre"
				@input="buscarSuplidores"
				@select="seleccionarSuplidor"
				size="is-medium"
			>
			</b-autocomplete>
		</b-field>
		<div class="notification is-info mt-2" v-if="clienteSeleccionado">
			<button class="delete" @click="deseleccionarSuplidor"></button>
			<p>Suplidor: <b>{{ clienteSeleccionado.nombre }}</b></p>
			<p>Teléfono: <b>{{ clienteSeleccionado.telefono }}</b></p>
		</div>
	</section>
</template>
<script>
	import HttpService from '../../Servicios/HttpService'

	export default{
		name: "BusquedaSuplidor",

		data:()=>({
			suplidor: "",
			clientesEncontrados: [],
			clienteSeleccionado: null
		}),

		methods: {
			deseleccionarSuplidor(){
				this.clienteSeleccionado = null
			},
			seleccionarSuplidor(opcion) {
				if(!opcion) return
				this.clienteSeleccionado = opcion
				this.$emit("seleccionado", this.clienteSeleccionado)
				setTimeout(() => this.suplidor = '', 10)
			},

			buscarSuplidores(){
				let payload = {
					accion: 'obtener_por_nombre',
					nombre: this.suplidor
				}

				HttpService.obtenerConConsultas('suplidores.php', payload)
				.then(suplidores =>{ 
					this.clientesEncontrados = suplidores
				})
			},
		},

		computed: {
			clientesFiltrados() {
				return this.clientesEncontrados.filter(opcion => {
					return (
						opcion.nombre
							.toString()
							.toLowerCase()
							.indexOf(this.suplidor.toLowerCase()) >= 0
					)
				})
			}
		}

	}
</script>