<template>
	<form>
		<b-field label="Nombre del suplidor" >
            <b-input step="any" icon="account" type="text" placeholder="Ej. Don Paco" v-model="datosSuplidor.nombre"></b-input>
        </b-field>
        <b-field label="Teléfono del suplidor" >
            <b-input step="any" icon="phone" type="number" placeholder="Ej. 2311459874" v-model="datosSuplidor.telefono"></b-input>
        </b-field>
         <div class="buttons has-text-centered">
            <b-button type="is-primary" size="is-large" icon-left="check" @click="registrar">Registrar</b-button>
            <b-button type="is-dark" size="is-large" icon-left="cancel" tag="router-link" to="/suplidores">Cancelar</b-button>
        </div>
        <errores-component :errores="mensajesError" v-if="mensajesError.length > 0" />
	</form>
</template>
<script>
	import Utiles from '../../Servicios/Utiles'
	import ErroresComponent from '../Extras/ErroresComponent'
	export default {
		name: "FormSuplidor",
		props: ["suplidor"],
		components: { ErroresComponent },

		data:()=>({
			datosSuplidor: {
				nombre: "",
				telefono: ""
			},
			mensajesError: []
		}),

		mounted(){
			this.datosSuplidor = this.suplidor
		},

		methods: {
			registrar(){
				this.mensajesError = Utiles.validarDatos(this.datosSuplidor)
				if(this.mensajesError.length > 0) return
				this.$emit("registrar", this.datosSuplidor)
				this.datosSuplidor  = {
					nombre: "",
					telefono: ""
				}
			}
		}
	}
</script>