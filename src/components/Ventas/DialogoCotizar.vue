<template>
	<form action="">
		<div class="modal-card" style="width: 100%">
			<header class="modal-card-head has-background-warning">
				<p class="modal-card-title ">Agregar cotizacion</p>
				<button
					type="button"
					class="delete"
					@click="$emit('close', 'cotiza')"/>
			</header>
			<section class="modal-card-body">
				<p class="is-size-1 has-text-weight-bold">Total ${{ totalVenta - descuento }}</p>
				<p class="is-size-4 has-text-weight-bold" style="color:red;">Descuento de ${{ descuento }}</p>
				<div class="columns">
					<div class="column is-6">
						<b-field label="Descuento" >
							<b-input step="any" ref="descuento" icon="currency-usd" type="number" placeholder="Descuento" v-model="descuento" size="is-medium"></b-input>
						</b-field>
					</div>
					<div class="column is-6">
						<b-field label="Aplicar impuesto">
							<b-switch v-model="impuesto"></b-switch>
						</b-field>
					</div>
				</div>
				<busqueda-cliente @seleccionado="onSeleccionado"/>
				<b-field label="Terminos" >
					<textarea name="terminos" cols="30" placeholder="Terminos" v-model="terminos" rows="20" class="input is-medium" ></textarea>
				</b-field>
				<b-field label="Observacion" >
					<textarea name="observacion" cols="30" placeholder="Observacion" v-model="observacion" rows="20" class="input is-medium" ></textarea>
				</b-field>
				</section>
			<footer class="modal-card-foot">
				<b-button
					label="Cancelar"
					icon-left="cancel"
					size="is-medium"
					@click="$emit('close', 'cotiza')" />
				<b-button
					label="Guardar cotización"
					type="is-dark"
					icon-left="ticket-outline"
					size="is-medium"
					@click="guardarCotizacion" />
			</footer>
		</div>
	</form>
</template>
<script>
	import BusquedaCliente from '../Clientes/BusquedaCliente'

	export default{
		name:"DialogoCotizar",
		props: ['totalVenta'],
		components: { BusquedaCliente },

		data:()=>({
			cliente: {},
			descuento: 0,
			impuesto: 0,
			terminos: '',
			observacion: ''
		}),


		methods:{
			onSeleccionado(cliente){
				this.cliente = cliente
			},


			guardarCotizacion(){
				if(Object.keys(this.cliente).length === 0) {
					this.$buefy.toast.open({
                         type: 'is-danger',
                         message: 'Debes seleccionar un cliente.'
                    })
                    return
				}

				let payload = {
					tipo: 'cotiza',
					cliente: this.cliente,
					descuento: this.descuento,
					impuesto: this.impuesto,
					terminos: this.terminos,
					observacion: this.observacion
				}

				this.$emit("terminar", payload)
			}
		}
	}
</script>