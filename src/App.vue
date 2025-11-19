<template>
  <main>
    <TodoList />
  </main>
</template>

<script>
import TodoList from './components/TodoList.vue'
export default { components: { TodoList } }
</script>

<style>
main { padding: 1rem; min-height: 100vh; background: #f7f7f8 }
</style>
