<template>
	<form action="">
		<div class="modal-card" style="width: 600px">
			<header class="modal-card-head has-background-success">
				<p class="modal-card-title has-text-white">Terminar venta</p>
				<button
					type="button"
					class="delete"
					@click="$emit('close', 'venta')"/>
			</header>
			<section class="modal-card-body">
				<p class="is-size-1 has-text-weight-bold">Total ${{ totalVenta - descuento }}</p>
				<busqueda-cliente @seleccionado="onSeleccionado" />
				<b-field label="El cliente paga con" >
					<b-input step="any" ref="pagado" icon="currency-usd" type="number" placeholder="Monto pagado" v-model="pagado" @input="calcularCambio" @keyup.enter.native="terminarVenta" size="is-medium"></b-input>
				</b-field>
				<p class="is-size-1 has-text-weight-bold">Cambio ${{ cambio + descuento }}</p>
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
					@click="$emit('close', 'venta')" />
				<b-button
					label="Terminar venta"
					type="is-success"
					icon-left="check"
					size="is-medium"
					@click="terminarVenta" />
			</footer>
		</div>
	</form>
</template>
<script>
	import BusquedaCliente from '../Clientes/BusquedaCliente'

	export default{
		name:"DialogoTerminarVenta",
		props: ['totalVenta'],
		components: { BusquedaCliente },

		data:()=>({
			pagado: "",
			cambio: 0,
			cliente: {},
			descuento: 0,
			impuesto: 0,
			terminos: '',
			observacion: ''
		}),

		mounted(){
			this.$refs.pagado.focus()
		},

		methods:{
			onSeleccionado(cliente){
				this.cliente = cliente
			},

			calcularCambio(){
				if(this.pagado>this.totalVenta){
					this.cambio = parseFloat(this.pagado-this.totalVenta)
				}else{
					this.cambio = parseFloat(this.totalVenta-this.pagado)
				}
			},

			terminarVenta(){
				if(this.pagado === "" || this.pagado < this.totalVenta) {
					this.$buefy.toast.open({
                         type: 'is-danger',
                         message: 'Debes colocar el total pagado.'
                    })
                    return
				}

				let payload = {
					tipo: 'venta',
					pagado: this.pagado,
					cambio: this.cambio+this.descuento,
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