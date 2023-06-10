<template>
	<section>
		<nav-component :titulo="'suplidores'" :link="{ path: '/agregar-suplidor' }" :texto="'Agregar suplidor'" />
		<b-table
		:data="suplidores">
			<b-table-column field="nombre" label="Nombre del suplidor" sortable searchable v-slot="props">
				{{ props.row.nombre }}
			</b-table-column>

			<b-table-column field="telefono" label="Teléfono" sortable searchable v-slot="props">
				{{ props.row.telefono }}
			</b-table-column>

			<b-table-column field="eliminar" label="Eliminar" v-slot="props">
				<b-button type="is-danger" icon-left="delete" @click="eliminar(props.row.id)">Eliminar</b-button>
			</b-table-column>

			<b-table-column field="editar" label="Editar" v-slot="props">
				<b-button type="is-info" icon-left="pen" @click="editar(props.row.id)">Editar</b-button>
			</b-table-column>
		</b-table>
		<b-loading :is-full-page="true" v-model="cargando" :can-cancel="false"></b-loading>
	</section>
</template>
<script>
	import NavComponent from '../Extras/NavComponent'
	import HttpService from '../../Servicios/HttpService'

	export default{
		name: "SuplidoresComponent",
		components: { NavComponent },

		data:()=>({
			cargando: false,
			suplidores: []
		}),

		mounted(){
			this.obtenerSuplidores()
		},

		methods:{
			async eliminar(idSuplidor){
                this.$buefy.dialog.confirm({
                    title: 'Eliminar suplidor',
                    message: 'Seguro que quieres <b>eliminar</b> este suplidor? Esta acción no se puede revertir.',
                    confirmText: 'Sí, eliminar',
                    cancelText: 'Cancelar',
                    type: 'is-danger',
                    hasIcon: true,
                    onConfirm: () => {
                        this.cargando = true
                        HttpService.eliminar('suplidores.php',{
                            accion: 'eliminar',
                            id: idSuplidor
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
                                    message: 'suplidor eliminado.'
                                })
                                this.obtenerSuplidores()
                            }
                        })
                    }
                })
            },

			editar(idSuplidor){
				this.$router.push({
					name: "EditarSuplidor",
					params: { id: idSuplidor}
				})
			},

			obtenerSuplidores(){
				this.cargando = true
				let payload = {
					accion: "obtener",
				}

				HttpService.obtenerConConsultas("suplidores.php", payload)
				.then(suplidores =>{
					this.suplidores = suplidores
					this.cargando = false
				})
			}
		}
	}
</script>