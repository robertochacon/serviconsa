<template>
	<form action="">
		<div class="modal-card" style="width: 600px">
			<header class="modal-card-head has-background-info">
				<p class="modal-card-title has-text-white">Agregar a cuenta</p>
				<button
					type="button"
					class="delete"
					@click="$emit('close', 'cuenta')"/>
			</header>
			<section class="modal-card-body">
				<p class="is-size-1 has-text-weight-bold">Total ${{ totalVenta - descuento }}</p>
				<busqueda-cliente @seleccionado="onSeleccionado"/>
				<b-field label="Pago inicial" >
					<b-input step="any" icon="currency-usd" type="number" placeholder="Cuánto deja el cliente" v-model="pagado" @input="calcularRestante" size="is-medium"></b-input>
				</b-field>
				<p class="is-size-1 has-text-weight-bold">Por Pagar ${{ porPagar - descuento }}</p>
				<b-field label="Descuento" >
					<b-input step="any" ref="descuento" icon="currency-usd" type="number" placeholder="Descuento" v-model="descuento" size="is-medium"></b-input>
				</b-field>
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
					@click="$emit('close', 'cuenta')" />
				<b-button
					label="Agregar a cuenta"
					type="is-info"
					icon-left="wallet-plus"
					size="is-medium"
					@click="agregarCuenta" />
			</footer>
		</div>
	</form>
</template>
<script>
	import BusquedaCliente from '../Clientes/BusquedaCliente'

	export default{
		name:"DialogoAgregarCuenta",
		props: ['totalVenta'],
		components: { BusquedaCliente },

		data:()=>({
			pagado: "",
			porPagar: 0,
			cliente: {},
			descuento: 0,
			terminos: '',
			observacion: ''
		}),


		mounted(){
				this.calcularRestante()
			},

		methods:{
			onSeleccionado(cliente){
				this.cliente = cliente
			},


			calcularRestante(){
				if(this.porPagar>this.totalVenta){
					this.porPagar = parseFloat(this.totalVenta-this.pagado-this.descuento)
				}else{
					this.porPagar = parseFloat(this.totalVenta+this.pagado-this.descuento)
				}
			},

			agregarCuenta(){
				if(Object.keys(this.cliente).length === 0) {
					this.$buefy.toast.open({
                         type: 'is-danger',
                         message: 'Debes seleccionar un cliente.'
                    })
                    return
				}

				let payload = {
					tipo: 'cuenta',
					pagado: this.pagado,
					porPagar: this.porPagar-this.descuento,
					cliente: this.cliente,
					descuento: this.descuento,
					terminos: this.terminos,
					observacion: this.observacion
				}

				this.$emit("terminar", payload)
			}	
		
		}
	}
</script>