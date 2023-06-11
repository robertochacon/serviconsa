<template>
    <section>
        <p class="title is-1">Agregar renta de equipo</p>
         <b-breadcrumb
            align="is-left"
        >
            <b-breadcrumb-item tag='router-link' to="/">Inicio</b-breadcrumb-item>
            <b-breadcrumb-item tag='router-link' to="/renta-equipos">renta de equipo</b-breadcrumb-item>
            <b-breadcrumb-item active>Agregar renta de equipo</b-breadcrumb-item>
        </b-breadcrumb>
        <form-renta-equipo :rentaequipo="datosRentaEquipo" @registrar="onRegistrar"/>
        <b-loading :is-full-page="true" v-model="cargando" :can-cancel="false"></b-loading>
    </section>
</template>
<script>
    import FormRentaEquipo from './FormRentaEquipo'
    import HttpService from '../../Servicios/HttpService'

    export default{
        name: "AgregarEquipo",
        components: { FormRentaEquipo },

        data: ()=>({
            cargando: false,
            datosRentaEquipo: {
                nombre: "",
                suplidor: "",
                costo: 0,
                estado: 1
            }
        }),

        methods: {
            onRegistrar(rentaequipo){
                console.log(rentaequipo)
                this.cargando = true
                let payload = {
                    accion: "registrar",
                    rentaequipo: rentaequipo
                }
                HttpService.registrar("RentaEquipo.php", payload)
                .then(registrado =>{
                    if(registrado){
                        this.$buefy.toast.open({
                          type: 'is-info',
                          message: 'Renta de equipo registrada con éxito.'
                        })
                        this.cargando = false
                        this.$router.push({ name: 'EquipoComponent'})
                    }
                })
            }
        }
    }
</script>