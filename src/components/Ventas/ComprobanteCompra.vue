<template>
    <section>
        <div class="comprobante" id="comprobante" v-if="datosNegocio" style="width:100%;">
            <div style="width:100%;display: flex;">
                <div style="width:50%;display: blok;justify-content: start;">
                    <img src="@/assets/logo.png" alt="logo" width="100">
                    <p>{{ datosNegocio.nombre }} 
                    <br>Tel: {{ datosNegocio.telefono }}</p>
                    <p style="text-align: left;"><b>Cliente:</b>{{ venta.nombreCliente }}</p>
                    <p style="text-align: left;"><b>Atiende:</b>{{ venta.nombreUsuario }}</p>
                </div>
                <div style="width:50%;display: flex;flex-wrap: wrap;justify-content: end;">
                    <h1 style="display: block;">Cotizacion</h1><br>
                    <p style="display: block;"><b>No. 0000001 </b></p>
                    <p style="display: block;"><b>Fecha: </b>{{ venta.fecha }}</p>
                </div>
            </div>
            <!-- <p><b>{{ titulo }}</b></p> -->

            <table width="100%" style="margin:auto;border:1px solid black;">
                <thead style="text-align: left;border: 1px solid black;" border="1">
                    <th>Articulo</th>
                    <th>Descripcion</th>
                    <th>Cantidad</th>
                    <th>Precio</th>
                    <th>Descuento</th>
                    <th>Subtotal</th>
                </thead>
                <tbody>
                    <tr v-for="(producto, index) in venta.productos" :key="index">
                        <td>{{ producto.id }}</td>
                        <td>{{ producto.nombre }}</td>
                        <td>{{ producto.cantidad }}</td>
                        <td>${{ producto.precio}}</td>
                        <td>${{ (producto.descuento!=null)?producto.descuento:'0.00' }}</td>
                        <!-- <td>${{ producto.precio}} X {{ producto.cantidad }}</td> -->
                        <td>${{ producto.precio * producto.cantidad }}</td>
                    </tr>
                </tbody>
            </table>
            <p style="text-align: left;"><b>Total:</b>${{ venta.total }}</p>
            <p style="text-align: left;" v-if="tipo !== 'cotiza'"><b>Su pago:</b>${{ venta.pagado }}</p>
            <p style="text-align: left;" v-if="tipo === 'venta'"><b>Cambio:</b>${{ venta.pagado - venta.total }}</p>
            <p style="text-align: left;" v-if="tipo === 'cuenta' || tipo === 'apartado'"><b>Por pagar:</b>${{ venta.porPagar }}</p>
            <br>
            <p><b>Gracias por su preferencia</b></p>
            <!-- <p>----------------------------</p>
            <p>Sistema de ventas por RacvyCode</p> -->
            <!-- <img src="@/assets/logo.png" width="120"> -->
        </div>
    </section>
</template>
<script>
    import AyudanteSesion from '../../Servicios/AyudanteSesion'
    import Utiles from '../../Servicios/Utiles'
    import Printd from "printd";

    

    export default{
        name: "ComprobanteCompra",
        props: ["venta", "tipo"],

        data:()=>({
            titulo: "",
            datosNegocio: null,
            cssText: `
                .comprobante{
                    width: 250px;
                    font-family: monospace;
                    font-size: 14px;
                }

                .comprobante > p{
                    margin: 0!important;
                    padding: 0!important;
                    text-align: center;
                }

                .comprobante > img{
                    display: block;
                    margin: 0 auto;
                }

                .comprobante > th, td {
                  border-bottom: 1px solid #ddd;
                  font-size: 12px !important;
                  margin: 0!important;
                  padding: 0!important;
                }
            `,

        }),

        beforeMount(){
            this.generarTitulo()
            this.obtenerDatosNegocio()
        },

        mounted(){
            

            this.d = new Printd();
            const { contentWindow } = this.d.getIFrame();
            contentWindow.addEventListener("beforeprint", () =>
              console.log("before print event!")
            );
            contentWindow.addEventListener("afterprint", () =>
              console.log("after print event!")
            );

            this.imprimir();
        },

        methods:{
            generarTitulo(){
                switch(this.tipo){
                    case "venta":
                        this.titulo = "COMPROBANTE DE COMPRA"
                        break
                    case "cuenta":
                        this.titulo = "COMPROBANTE DE CUENTA"
                        break

                    case "apartado":
                        this.titulo = "COMPROBANTE DE APARTADO"
                        break

                    case "cotiza":
                        this.titulo = "COTIZACIÓN"
                        break

                    default:
                        this.titulo = "COMPROBANTE"
                }
            },

            obtenerDatosNegocio(){
                this.datosNegocio = AyudanteSesion.obtenerDatosNegocio()
                this.datosNegocio.logo = Utiles.regresarRuta() + this.datosNegocio.logo
            },

            imprimir() {
              let zona = document.getElementById("comprobante");
              setTimeout(() => this.d.print(zona, [this.cssText]), 10);
              this.$emit("impreso", false);
            },
        }
    }
</script>
<style scoped>
    .comprobante{
        width: 100%;
        font-family: monospace;
        font-size: 14px;
    }

    .comprobante > p{
        margin: 0!important;
        padding: 0!important;
        text-align: center;
    }

    .comprobante > img{
        display: block;
        margin: 0 auto;
    }

    .comprobante > th, td {
      border-bottom: 1px solid #ddd;
      font-size: 12px !important;
      margin: 0!important;
      padding: 0!important;
    }

    .row{
        width: 100%;
        display: flex;
        justify-content: space-between;
    }

    table, th, td {
    border: 1px solid black;
    border-collapse: collapse;
    }
    
</style>