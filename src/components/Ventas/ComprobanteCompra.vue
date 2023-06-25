<template>
    <section>
        <div class="comprobante" id="comprobante" v-if="datosNegocio" style="width:100%;">
            <div style="width:100%;display: flex;">
                <div style="width:50%;display: blok;justify-content: start;">
                    <img src="@/assets/logo.png" alt="logo" width="100">
                    <p><b>SERVICONSA</b></p>
                    <p><b>RNC:</b> 06800345909</p>
                    <p style="text-align: left;margin-top:-10px;"><b>TEL:</b> 849-851-7880</p>
                    <p style="text-align: left;margin-top:-10px;"><b>Dirección:</b> C/Central #6, Sector Libertad, <br>Villa Altagracia, R.D.</p>
                </div>
                <div style="width:50%;display: flex;flex-wrap: wrap;justify-content: end;">
                    <div>
                        <h1 v-if="tipo === 'cotiza'" style="display: block;">Cotizacion</h1>
                        <h1 v-if="tipo === 'venta'" style="display: block;">Venta</h1>
                        <h1 v-if="tipo === 'cuenta'" style="display: block;">Cuenta</h1>
                        <h1 v-if="tipo === 'apartado'" style="display: block;">Apartado</h1>
                        <p style="display: block;margin-top:-10px;"><b>No. 000000 </b></p>
                        <p style="display: block;margin-top:-10px;"><b>Fecha: </b>{{ venta.fecha }}</p>
                    </div>
                </div>
            </div>

            <div style="width:100%; margin-top:10px;margin-bottom: 20px;border:1px solid black;padding-left: 10px;padding-top:-20px;padding-bottom: -20px; box-sizing: border-box;">
                <p style="text-align: left;"><b>Cliente:</b>{{ venta.nombreCliente }}</p>
                <p style="text-align: left;margin-top:-10px;"><b>Atiende:</b>{{ venta.nombreUsuario }}</p>
            </div>
            <!-- <p><b>{{ titulo }}</b></p> -->

            <table width="100%" style="margin:auto;border:1px solid black;">
                <thead style="text-align: left;border: 1px solid black;" border="1">
                    <th>Articulo</th>
                    <th>Descripcion</th>
                    <th>Cantidad</th>
                    <th>Precio</th>
                    <!-- <th>Descuento</th> -->
                    <th>Subtotal</th>
                </thead>
                <tbody>
                    <tr v-for="(producto, index) in venta.productos" :key="index">
                        <td>{{ producto.id }}</td>
                        <td>{{ producto.nombre }}</td>
                        <td>{{ producto.cantidad }}</td>
                        <td>${{ producto.precio}}</td>
                        <!-- <td>${{ (producto.descuento!=null)?producto.descuento:'0.00' }}</td> -->
                        <!-- <td>${{ producto.precio}} X {{ producto.cantidad }}</td> -->
                        <td>${{ producto.precio * producto.cantidad }}</td>
                    </tr>
                </tbody>
            </table>

            <div style="width:100%;display:flex;justify-content: space-between; margin-top:20px;margin-bottom: 10px;">
                <div style="width: 45%;padding: 10px;box-sizing: border-box;border:1px solid black;">
                    <b>Términos</b><hr>
                    {{ venta.terminos }}
                </div>
                <div style="width: 50%;padding: 10px;box-sizing: border-box;border:1px solid black;">
                    <b>Observaciones</b><hr>
                    {{ venta.observacion }}
                </div>
            </div>

            <div style="width:100%;display: flex;justify-content: end;">
                <div style="width:auto;">
                    <p style="text-align: left;"><b>Subtotal:</b>${{ venta.subtotal+'.00' }}</p>
                    <p style="text-align: left;margin-top:-10px;"><b>Impuesto:</b>{{ venta.impuesto_numero+'.00' }}</p>
                    <p style="text-align: left;margin-top:-10px;"><b>Total:</b>${{ venta.total+'.00' }}</p>
                    <!-- <p style="text-align: left;" v-if="tipo !== 'cotiza'"><b>Su pago:</b>${{ venta.pagado }}</p>
                    <p style="text-align: left;" v-if="tipo === 'venta'"><b>Cambio:</b>${{ venta.pagado - venta.total }}</p>
                    <p style="text-align: left;" v-if="tipo === 'cuenta' || tipo === 'apartado'"><b>Por pagar:</b>${{ venta.porPagar }}</p> -->
                </div>
            </div>

            <div style="width:100%;display: flex;flex-wrap: wrap;justify-content: end;margin-top: 50px;">
                <div style="width:30%;text-align: center;">
                    <hr>
                    Firma del Cliente
                </div>
            </div>

            <p style="margin-top: 200px;"><b>Gracias por su preferencia</b></p>
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