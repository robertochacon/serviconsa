<template>
	<form action="">
		<div class="modal-card" style="width: 600px">
			<header class="modal-card-head">
				<p class="modal-card-title">{{ titulo }} Gasto Fijo</p>
				<button
					type="button"
					class="delete"
					@click="$emit('close')"/>
			</header>
			<section class="modal-card-body">
				<b-field label="Descripcion" >
					<b-input  type="text" placeholder="Pago de luz" v-model="datosGasto.descripcion"></b-input>
				</b-field>
				<b-field label="monto" >
					<b-input  type="number" placeholder="0.00" v-model="datosGasto.monto"></b-input>
				</b-field>
			</section>
			<footer class="modal-card-foot">
				<b-button
					label="Cancelar"
					icon-left="cancel"
					size="is-medium"
					@click="$emit('close')" />
				<b-button
					label="Registrar"
					type="is-primary"
					icon-left="check"
					@click="registrar" />
			</footer>
		</div>
	</form>
</template>
<script>
	export default{
		name: "DialogoGastosFijos",
		props: ['titulo', 'gasto'],

		data:()=>({
			datosGasto:{
				descripcion: "",
				monto: 0,
				fijo: 0,
			}
		}),

		mounted(){
			this.datosGasto.id = this.gasto.id,
			this.datosGasto.descripcion = this.gasto.descripcion
			this.datosGasto.monto = this.gasto.monto
		},

		methods:{

			registrar(){
				if(!this.datosGasto.descripcion){
					this.$buefy.toast.open({
                        type: 'is-danger',
                        message: 'Debes colocar una descripcion.'
                    })
					return
				}

				this.$emit("registrar", this.datosGasto)
			}	
		}
	}
</script>