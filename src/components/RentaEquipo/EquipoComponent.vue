<template>
	<section>
		<nav-component :titulo="'Renta de equipo'" :link="{ path: '/agregar-renta-equipo' }" :texto="'Agregar renta de equipo'" />
		<b-table
		:data="rentaequipo">
			<b-table-column field="nombre" label="Nombre" sortable searchable v-slot="props">
				{{ props.row.nombre }}
			</b-table-column>

			<b-table-column field="suplidor" label="Suplidor" sortable searchable v-slot="props">
				{{ props.row.suplidor }}
			</b-table-column>

			<b-table-column field="costo" label="Costo" sortable searchable v-slot="props">
				{{ new Intl.NumberFormat('en-IN', { maximumSignificantDigits: 2 }).format(props.row.costo,2) }}
			</b-table-column>

			<b-table-column field="estado" label="Estado" sortable searchable v-slot="props">
				{{ (props.row.estado===1)?'Activo':'Inactivo' }}
			</b-table-column>

			<b-table-column field="fecha" label="Fecha" sortable searchable v-slot="props">
				{{ props.row.fecha }}
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
		name: "EquipoComponent",
		components: { NavComponent },

		data:()=>({
			cargando: false,
			rentaequipo: []
		}),

		mounted(){
			this.obtenerRentaEquipo()
		},

		methods:{
			async eliminar(idRentaEquipo){
                this.$buefy.dialog.confirm({
                    title: 'Eliminar Renta',
                    message: 'Seguro que quieres <b>eliminar</b> este Renta? Esta acción no se puede revertir.',
                    confirmText: 'Sí, eliminar',
                    cancelText: 'Cancelar',
                    type: 'is-danger',
                    hasIcon: true,
                    onConfirm: () => {
                        this.cargando = true
                        HttpService.eliminar('RentaEquipo.php',{
                            accion: 'eliminar',
                            id: idRentaEquipo
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
                                    message: 'Renta de equipo eliminada.'
                                })
                                this.obtenerRentaEquipo()
                            }
                        })
                    }
                })
            },

			editar(idRentaEquipo){
				this.$router.push({
					name: "EditarRentaEquipo",
					params: { id: idRentaEquipo}
				})
			},

			obtenerRentaEquipo(){
				this.cargando = true
				let payload = {
					accion: "obtener",
				}

				HttpService.obtenerConConsultas("RentaEquipo.php", payload)
				.then(rentaequipo =>{
					this.rentaequipo = rentaequipo
					this.cargando = false
				})
			}
		}
	}
</script>