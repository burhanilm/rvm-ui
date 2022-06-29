<template>
    <div class="base-size">
        <img src="~/assets/vector/thanks.svg" alt="">
        <div class="it-overlay">
            <div class="done-btn" @click="$router.replace('/')">
            </div>
            <h5 class="total-bottle">{{ $route.params.t }} botol</h5>
        </div>
    </div>
</template>

<script>
    export default {

    }
</script>

<style lang="css" scoped>
    .done-btn {
        position: absolute;
        width: 642px;
        height: 126px;
        left: 319px;
        top: 540px;
    }

    .total-bottle {
        color: black;
        position: absolute;
        text-align: center;
        font-size: 24px;
        font-weight: 400;
        top: 359px;
        left: 50%;
        transform: translateX(-50%);   
    }
</style>