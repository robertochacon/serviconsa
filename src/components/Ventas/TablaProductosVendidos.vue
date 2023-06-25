<template>
	<b-table
		:data="productos"
		class="is-size-7">
			<b-table-column field="nombre" label="Nombre" v-slot="props">
				{{ props.row.nombre }}
			</b-table-column>

			<b-table-column field="precio" label="Precio" v-slot="props">
				${{ new Intl.NumberFormat('en-IN', { maximumSignificantDigits: 2 }).format(props.row.precio,2) }}
			</b-table-column>

			<b-table-column field="cantidad" label="Cantidad" v-slot="props">
				{{ props.row.cantidad}}
			</b-table-column>

			<b-table-column field="subtotal" label="Subtotal" v-slot="props">
				<b>${{ new Intl.NumberFormat('en-IN', { maximumSignificantDigits: 2 }).format(props.row.precio * props.row.cantidad,2) }}</b>
			</b-table-column>
		</b-table>
</template>
<script>
	export default {
		name: "TablaProductosVendidos",
		props: ["productos"]
	}
</script>