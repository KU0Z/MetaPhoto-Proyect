<template>
  <v-container>
    <v-row class="text-center">
      <v-col class="mb-4">
        <h1 class="display-2 font-weight-bold mb-3">
          404
        </h1>

        <p class="subheading font-weight-regular">
          Sorry this page no found
          <br>
          <a @click="$router.push({ path: '/' })"
          >Discord Community</a>
        </p>
      </v-col>

    </v-row>
  </v-container>
</template>
