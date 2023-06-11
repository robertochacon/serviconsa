<template>
	<section>
		<b-button type="is-primary" size="is-medium" class="is-rounded" icon-left="plus" @click="agregarCategoria">
			Agregar gasto
		</b-button>
		<b-table
		:data="gatos">
		<b-table-column field="descripcion" label="Descripcion" sortable searchable v-slot="props">
			{{ props.row.descripcion }}
		</b-table-column>

		<b-table-column field="monto" label="Monto" sortable searchable v-slot="props">
			{{ props.row.monto }}
		</b-table-column>

		<b-table-column field="fecha" label="Fecha" sortable searchable v-slot="props">
			{{ props.row.fecha }}
		</b-table-column>

		<b-table-column field="eliminar" label="Eliminar" v-slot="props">
			<b-button type="is-danger" icon-left="delete" @click="eliminar(props.row)">Eliminar</b-button>
		</b-table-column>

		<b-table-column field="editar" label="Editar" v-slot="props">
			<b-button type="is-info" icon-left="pen" @click="editar(props.row)">Editar</b-button>
		</b-table-column>
	</b-table>
	<b-modal
	v-model="mostrarDialogoGastoFijo"
	has-modal-card
	trap-focus
	:destroy-on-hide="false"
	aria-role="dialog"
	aria-label="Modal"
	close-button-aria-label="Close"
	aria-modal>
	<dialogo-gastos-fijos :titulo="tituloModal" :gasto="datosGasto" @close="onCerrarDialogo" @registrar="onRegistrar" v-if="mostrarDialogoGastoFijo"></dialogo-gastos-fijos>
</b-modal>

<b-loading :is-full-page="true" v-model="cargando" :can-cancel="false"></b-loading>
</section>
</template>
<script>
	import HttpService from '../../Servicios/HttpService'
	import DialogoGastosFijos from './DialogoGastosFijos'

	export default{
		name: "GastosFijosComponent",
		components: { DialogoGastosFijos },
		data:()=>({     
			gatos: [],
			cargando: false,
			mostrarDialogoGastoFijo: false,
			tituloModal: "",
			datosGasto:{
				descripcion: "",
				monto: 0,
				fijo: 0,
			},
			idGasto: "",
		}),

		mounted(){
			this.obtenerGastos()
		},

		methods: {
			eliminar(categoria){
				this.$buefy.dialog.confirm({
					title: 'Eliminar categoría',
					message: 'Seguro que quieres <b>eliminar</b> la categoría ' + categoria.nombreCategoria +'? Esta acción no se puede revertir.',
					confirmText: 'Sí, eliminar',
					cancelText: 'Cancelar',
					type: 'is-danger',
					hasIcon: true,
					onConfirm: () => {
						this.cargando = true
						HttpService.eliminar('categorias.php',{
							accion: 'eliminar',
							id: categoria.id
						})
						.then(resultado => {
							if(!resultado) {
								this.$buefy.toast.open('Error al eliminar')
								this.cargando = false
								return
							}

							if(resultado){
								this.cargando = false
								this.$buefy.toast.open({
									type: 'is-info',
									message: 'Categoría eliminada.'
								})
								this.obtenerGastos()
							}
						})
					}
				})
			},

			editar(gasto){
				this.tituloModal = "Editar"
				this.mostrarDialogoGastoFijo = true
				this.idGasto = gasto.id
				this.datosGasto.descripcion = gasto.descripcion,
				this.datosGasto.monto = gasto.monto
			}, 

			onCerrarDialogo(){
				this.mostrarDialogoGastoFijo = false
				this.nombreCategoria = "" 
			},

			onRegistrar(gasto) {
				this.cargando = true

				let accionARealizar = (this.tituloModal === 'Agregar') ? 'registrar' : (this.tituloModal === 'Editar') ? 'editar' : false

				HttpService.registrar('gastos.php', {
					accion: accionARealizar,
					gasto: gasto
				})
				.then(registrado => {
					if(registrado) {
						this.cargando = false
						this.$buefy.toast.open({
							type: 'is-info',
							message: 'Información de gasto registrada con éxito.'
						})
						this.obtenerGastos()
						this.nombreCategoria = ""
						this.mostrarDialogoGastoFijo = false
					}
				})
			},

			agregarCategoria(){
				this.tituloModal = "Agregar"
				this.mostrarDialogoGastoFijo = true
			},

			obtenerGastos(){
				this.cargando = true
				let payload = {
					accion: 'obtenerFijos'
				}
				HttpService.obtenerConConsultas('gastos.php', payload)
				.then(gatos => {
					this.gatos = gatos
					this.cargando = false
				})
			}
		}
	}
</script>