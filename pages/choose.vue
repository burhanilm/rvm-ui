<template>
    <div class="base-size">
        <img src="~/assets/vector/choose.svg" alt="">
        <div class="it-overlay">
            <div class="donation-btn" @click="$router.replace('/main')"></div>
        </div>
    </div>
</template>

<script>
    export default {

    }
</script>

<style lang="css" scoped>
    .donation-btn {
        position: absolute;
        width: 211px;
        height: 257px;
        left: 704px;
        top: 304px;
    }
</style>