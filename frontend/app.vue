<template>
  <div class="bg-black h-screen">
    <div class="bg-black">
      <div class="text-white">
        <h1 class="text-center text-3xl text-white">Fuksipassi</h1>
        <div class="flex justify-center m-6">
          <div>
            <div v-for="item in content">
              <div class="my-10" v-for="n in item">
                <h2>{{ n.name }}</h2>
                <ol>
                  <li><input class="mr-2" type="checkbox" name="" id="">{{n.desc}}<span class="ml-3">{{n.points}} bits</span></li>
                </ol>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
<script setup lang="ts">

const content = {
  "AINE OPINNOT":
      [
        {
          name: "Osallistuminen kastajaisiin",
          desc: "Osallistuminen kastajaisiin on hieno saavutus",
          points: 10,
          status: false
        },
        {
          name: "Osallistuminen kastajaisiin",
          desc: "Osallistuminen kastajaisiin on hieno saavutus",
          points: 15,
          status: false
        },
        {
          name: "Osallistuminen kastajaisiin",
          desc: "Osallistuminen kastajaisiin on hieno saavutus",
          points: 10,
          status: false
        },

      ]

}

</script>