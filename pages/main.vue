<template>
    <div class="base-size">
        <img src="~/assets/vector/donasi.svg" alt="">
        <div class="it-overlay">
            <div v-if="ready" class="done-btn" @click="(bottles.length == 0) ? $router.replace('/') : $router.replace('/thanks/' + bottles.length)">
                <h1 v-if="bottles.length > 0">Selesai</h1>
                <h1 v-else>Cancel</h1>
            </div>
            <div v-else class="done-btn">
                <h1>Tunggu...</h1>
            </div>
            <h2 class="total-donate">{{ donate }} botol</h2>
            <h3 class="total-current">{{ bottles.length }} botol</h3>
            <h3 class="total-point">{{ totalPoint }} poin</h3>
            <h5 class="user-note">Silahkan masukan kemasan botol atau kaleng pada lubang.</h5>
            <div class="table-list">
                <table>
                    <tbody>
                        <tr v-for="g in grouped" :key="g.sku">
                            <td style="width: 40px">{{ g.qty }}</td>
                            <td style="text-align: center">{{ g.name }}</td>
                            <td style="width: 40px; text-align: right">{{ g.point * g.qty }}</td>
                        </tr>
                    </tbody>
                </table>
            </div>  
        </div>
    </div>
</template>

<script>
    import io from 'socket.io-client';

    export default {
        async asyncData({ params, $axios }) {
            const dat = await $axios.$get(`http://localhost:4551/products.json`)
            return { dataProducts: dat }
        },
        data () {
            return {
                ready: false,
                bottles: [],
                grouped: [],
                donate: 2845,
                totalPoint: 0,
                socketInst: null
            }
        },
        methods: {
            findProducts (sku) {
                let index = this.dataProducts.findIndex(x => x.sku === sku);
                return (index > -1) ? this.dataProducts[index] : 0
            },
            group () {
                for (let i = 0; i < this.bottles.length; i++) {
                    const element = this.bottles[i];
                    let index = this.grouped.findIndex(x => x.sku === element.sku);

                    this.totalPoint += element.point

                    if (index > -1) {
                        this.grouped[index].qty++
                    } else {
                        this.grouped.push({
                            ...element,
                            qty: 1
                        })
                    }
                }
            }
        },
        mounted () {
            this.socketInst = io('http://localhost:4550/frontend')

            this.socketInst.on('stats', data => {
                if (data == 'START' || data == 'REPEAT_START') {
                    this.ready = true
                }
                else if (data == 'DONE') {
                    this.$router.replace('/')
                }
                else {
                    this.ready = false
                }
            })

            this.socketInst.on('barcode', data => {
                let d = this.findProducts(parseInt(data))
                if (d != 0) {
                    this.bottles.push(d) 
                    this.group()
                }
            })

            this.socketInst.on('connect', () => {
                this.socketInst.emit('process_start', response => {
                    console.log(response);
                    if (response.status != 1) {
                        // alert(response.message)
                    }
                })
            })
        },
        beforeDestroy () {
            this.socketInst.emit('process_done', response => {
                console.log(response)
                if (response.status == 2) {
                    // barcodein.innerText = ""
                } else {
                    // alert(response.message)
                }
                this.socketInst.close()
            })
        }
    }
</script>

<style lang="css" scoped>
    .done-btn {
        position: absolute;
        width: 266px;
        height: 94px;
        left: 278px;
        top: 658px;
    }

    .done-btn h1 {
        color: white;
        text-align: center;
        width: 100%;
        line-height: 90px;
        font-size: 36px;
    }

    .total-donate {
        color: #061438;
        text-align: right;
        font-size: 20px;
        width: 150px;
        position: absolute;
        top: 118px;
        right: 64px;
    }

    .total-current {
        color: white;
        text-align: left;
        font-size: 20px;
        width: 150px;
        position: absolute;
        bottom: 65px;
        left: 886px;   
    }

    .total-point {
        color: white;
        text-align: right;
        font-size: 20px;
        width: 150px;
        position: absolute;
        bottom: 65px;
        right: 64px;   
    }

    .user-note {
        position: absolute;
        color: #023F6A;
        max-width: 385px;
        top: 385px;
        left: 411px;
        transform: translate(-50%, -50%);
        text-align: center;
        font-size: 24px;
    }

    .table-list {
        position: absolute;
        width: 367px;
        right: 43px;
        top: 292px;
        height: 403px;
        overflow-x: hidden;
        overflow-y: scroll;
    }

    table {
        width: 100%;
        border-spacing: 0;
        border-collapse: collapse;
    }

    table td {
        padding: 16px;
        font-size: 16px;
    }
</style>