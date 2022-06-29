<template>
    <div class="base-size" ref="slider">
        <div @click="$router.replace('/choose')">
            <img src="~/assets/vector/slide1.svg" alt="">
            <img src="~/assets/vector/slide2.svg" alt="">
            <img src="~/assets/vector/slide3.svg" alt="">
        </div>
    </div>
</template>


<script>

import gsap from 'gsap'
import { ScrollToPlugin } from 'gsap/dist/ScrollToPlugin'

gsap.registerPlugin(ScrollToPlugin)

export default {
    data () {
        return {
            currentSlide: 0,
            int: null
        }
    },
    mounted () {
        this.int = setInterval(() => {
            this.currentSlide++
            if (this.currentSlide > 2) this.currentSlide = 0
            gsap.to(this.$refs.slider, { scrollTo: 800 * this.currentSlide, duration: 1, ease: 'Power2.easeInOut' })
        }, 4000)
    },
    beforeDestroy () {
        clearInterval(this.int)
    }
}
</script>

<style lang="css" scoped>
    .base-size {
        /* overflow-y: scroll; */
        overflow: hidden;
    }

    .base-size img {
        display: block;
    }
</style>