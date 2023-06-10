<template>
    <section>
        <p class="title is-1">Agregar suplidor</p>
         <b-breadcrumb
            align="is-left"
        >
            <b-breadcrumb-item tag='router-link' to="/">Inicio</b-breadcrumb-item>
            <b-breadcrumb-item tag='router-link' to="/cientes">Suplidor</b-breadcrumb-item>
            <b-breadcrumb-item active>Agregar suplidor</b-breadcrumb-item>
        </b-breadcrumb>
        <form-suplidor :suplidor="datosSuplidor" @registrar="onRegistrar"/>
        <b-loading :is-full-page="true" v-model="cargando" :can-cancel="false"></b-loading>
    </section>
</template>
<script>
    import FormSuplidor from './FormSuplidor'
    import HttpService from '../../Servicios/HttpService'

    export default{
        name: "AgregarSuplidor",
        components: { FormSuplidor },

        data: ()=>({
            cargando: false,
            datosSuplidor: {
                nombre: "",
                telefono: ""
            }
        }),

        methods: {
            onRegistrar(suplidor){
                console.log(suplidor)
                this.cargando = true
                let payload = {
                    accion: "registrar",
                    suplidor: suplidor
                }
                HttpService.registrar("suplidores.php", payload)
                .then(registrado =>{
                    if(registrado){
                        this.$buefy.toast.open({
                          type: 'is-info',
                          message: 'Suplidor registrado con éxito.'
                        })
                        this.cargando = false
                        this.$router.push({ name: 'SuplidoresComponent'})
                    }
                })
            }
        }
    }
</script>