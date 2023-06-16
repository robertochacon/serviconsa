<template>
  <section>
    <p class="title is-1">Gastos</p>
    <b-breadcrumb
    align="is-left"
    >
    <b-breadcrumb-item tag='router-link' to="/">Inicio</b-breadcrumb-item>
    <b-breadcrumb-item active>Gastos</b-breadcrumb-item>
  </b-breadcrumb>
  <b-tabs v-model="tabActiva" size="is-large">
    <b-tab-item label="Gastos regulares" icon="sacka">
      <GastosRegularesComponent/>
    </b-tab-item>

    <b-tab-item label="Gastos fijos" icon="archive">
      <GastosFijosComponent />
    </b-tab-item>
  </b-tabs>
</section>
</template>
<script>
  import GastosRegularesComponent from './GastosRegularesComponent'
  import GastosFijosComponent from './GastosFijosComponent'
  export default{
    name: "GastosComponent",
    components: { GastosRegularesComponent, GastosFijosComponent },

    data:()=>({
      tabActiva: 0,      
    }),
  }
</script>