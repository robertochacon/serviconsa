<template>
    <section>
        <h1 class="title is-1">Editar renta de equipos</h1>
        <b-breadcrumb
            align="is-left"
        >
            <b-breadcrumb-item tag='router-link' to="/">Inicio</b-breadcrumb-item>
            <b-breadcrumb-item tag='router-link' to="/cientes">Renta de equipos</b-breadcrumb-item>
            <b-breadcrumb-item active>Editar rentaequipo</b-breadcrumb-item>
        </b-breadcrumb>
        <form-renta-equipo :rentaequipo="datosRentaEquipo" @registrar="onEditar" v-if="datosRentaEquipo" />
        <b-loading :is-full-page="true" v-model="cargando" :can-cancel="false"></b-loading>
    </section>
</template>
<script>
    import HttpService from '../../Servicios/HttpService'
    import FormRentaEquipo from './FormRentaEquipo'

    export default{
        name: "EditaGasto",
        components: { FormRentaEquipo },

        data:()=>({
            cargando: false,
            datosRentaEquipo: null
        }),

        async mounted(){
            this.cargando = true    
            const rentaequipo = await HttpService.obtenerConConsultas('RentaEquipo.php', {
                accion: 'obtener_por_id',
                id: this.$route.params.id
            })

            this.datosRentaEquipo = rentaequipo
            this.cargando = false
        },

        methods: {
            async onEditar(datosRentaEquipo){
                this.cargando = true
                const resultado = await HttpService.editar('RentaEquipo.php',{
                    accion: 'editar',
                    rentaequipo: datosRentaEquipo
                })

                if(resultado) {
                    this.cargando = false
                    this.$buefy.toast.open({
                         type: 'is-info',
                         message: 'Información de rentaequipo actualizada con éxito.'
                    })
                    this.$router.push({ name: 'EquipoComponent'})
                }
            }
        }
    }
</script>