<template>
	<form>
		<b-field label="Nombre" >
            <b-input step="any" icon="account" type="text" placeholder="Nombre de equipo" v-model="datosRentaEquipo.nombre"></b-input>
        </b-field>
        <b-field grouped group-multiline>
			<b-field label="Selecciona un suplidor" >
					<b-select placeholder="Marca" icon="tag-multiple" v-model="datosRentaEquipo.suplidor">
						<option v-for="suplidorItem in suplidores" :key="suplidorItem.id" :value="suplidorItem.nombre">
							{{ suplidorItem.nombre }}
						</option>
					</b-select>
				</b-field>
			<b-field label="Costo" >
				<b-input step="any" icon="phone" type="number" placeholder="Costo" v-model="datosRentaEquipo.costo"></b-input>
			</b-field>
			<b-field label="Estado">
				<b-switch v-model="datosRentaEquipo.estado"
					true-value="1"
					false-value="0">
				</b-switch>
			</b-field>
        </b-field><br>
         <div class="buttons has-text-centered">
            <b-button type="is-primary" size="is-large" icon-left="check" @click="registrar">Registrar</b-button>
            <b-button type="is-dark" size="is-large" icon-left="cancel" tag="router-link" to="/gastos">Cancelar</b-button>
        </div>
        <errores-component :errores="mensajesError" v-if="mensajesError.length > 0" />
	</form>
</template>
<script>
    import HttpService from '../../Servicios/HttpService'
	import Utiles from '../../Servicios/Utiles'
	import ErroresComponent from '../Extras/ErroresComponent'
	export default {
		name: "FormRentaEquipo",
		props: ["rentaequipo"],
		components: { ErroresComponent },

		data:()=>({
			datosRentaEquipo: {
                nombre: "",
                suplidor: "",
                costo: 0,
                estado: 1
			},
            suplidores: [],
			mensajesError: []
		}),

		mounted(){
			this.datosRentaEquipo = this.rentaequipo
			this.obtenerSuplidores();
		},

		methods: {
			registrar(){
				this.mensajesError = Utiles.validarDatos(this.datosRentaEquipo)
				if(this.mensajesError.length > 0) return
				this.$emit("registrar", this.datosRentaEquipo)
				this.datosRentaEquipo  = {
					nombre: "",
					suplidor: "",
					costo: 0,
					estado: 1
				}
			},
			obtenerSuplidores(){
            let payload = {
              accion: 'obtener'
            }
            HttpService.obtenerConConsultas('suplidores.php', payload)
            .then(suplidores => {
              this.suplidores = suplidores
            })
          },
		}
	}
</script>