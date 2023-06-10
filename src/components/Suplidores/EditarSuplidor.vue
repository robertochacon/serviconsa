<template>
    <section>
        <h1 class="title is-1">Editar suplidor</h1>
        <b-breadcrumb
            align="is-left"
        >
            <b-breadcrumb-item tag='router-link' to="/">Inicio</b-breadcrumb-item>
            <b-breadcrumb-item tag='router-link' to="/cientes">Suplidores</b-breadcrumb-item>
            <b-breadcrumb-item active>Editar suplidor</b-breadcrumb-item>
        </b-breadcrumb>
        <form-suplidor :suplidor="datosSuplidor" @registrar="onEditar" v-if="datosSuplidor" />
        <b-loading :is-full-page="true" v-model="cargando" :can-cancel="false"></b-loading>
    </section>
</template>
<script>
    import HttpService from '../../Servicios/HttpService'
    import FormSuplidor from './FormSuplidor'

    export default{
        name: "EditaSuplidor",
        components: { FormSuplidor },

        data:()=>({
            cargando: false,
            datosSuplidor: null
        }),

        async mounted(){
            this.cargando = true    
            const suplidor = await HttpService.obtenerConConsultas('suplidores.php', {
                accion: 'obtener_por_id',
                id: this.$route.params.id
            })

            this.datosSuplidor = suplidor
            this.cargando = false
        },

        methods: {
            async onEditar(datosSuplidor){
                this.cargando = true
                const resultado = await HttpService.editar('suplidores.php',{
                    accion: 'editar',
                    suplidor: datosSuplidor
                })

                if(resultado) {
                    this.cargando = false
                    this.$buefy.toast.open({
                         type: 'is-info',
                         message: 'Información de suplidor actualizada con éxito.'
                    })
                    this.$router.push({ name: 'SuplidoresComponent'})
                }
            }
        }
    }
</script>