<template>
  <div class="todo-list">
    <h1>Liste des tâches</h1>
    <div class="controls">
      <button @click="load" :disabled="loading">Rafraîchir</button>
    </div>

    <div v-if="loading" class="status">Chargement...</div>
    <div v-else-if="error" class="status error">Erreur : {{ error }}</div>

    <ul v-else class="list">
      <li v-for="todo in todos" :key="todo.id" class="item">
        <span class="status-icon" v-if="todo.completed">✔</span>
        <span class="status-icon" v-else>○</span>
        <span class="title">{{ todo.title }}</span>
      </li>
    </ul>

    <div v-if="!loading && todos.length === 0" class="empty">Aucune tâche.</div>
  </div>
</template>

<script>
import { ref } from 'vue'
import { fetchTodos } from '../api/todos'

export default {
  name: 'TodoList',
  setup() {
    const todos = ref([])
    const loading = ref(false)
    const error = ref(null)

    async function load() {
      loading.value = true
      error.value = null
      try {
        const data = await fetchTodos()
        todos.value = Array.isArray(data) ? data : []
      } catch (err) {
        error.value = err.message || String(err)
      } finally {
        loading.value = false
      }
    }

    // charger au montage
    load()

    return { todos, loading, error, load }
  }
}
</script>

<style scoped>
.todo-list { max-width: 720px; margin: 2rem auto; font-family: Arial, sans-serif }
.controls { margin-bottom: 0.5rem }
.status { margin: 1rem 0; font-style: italic }
.status.error { color: #b00020 }
.list { list-style: none; padding: 0 }
.item { padding: 0.4rem 0; display:flex; align-items:center; gap:0.5rem }
.status-icon { width: 1.2rem; display:inline-block; text-align:center }
.title { flex: 1 }
.empty { color: #666; margin-top: 1rem }
button[disabled] { opacity: 0.6 }
</style>
