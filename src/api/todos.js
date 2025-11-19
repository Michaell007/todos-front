const API_BASE = import.meta.env.VITE_API_BASE || ''

/**
 * fetchTodos() -> récupère la liste via GET /api/todos
 * Retour attendu : un tableau JSON d'objets tâches.
 */
export async function fetchTodos() {
  const res = await fetch(`${API_BASE}/api/todos`)
  if (!res.ok) {
    const text = await res.text().catch(() => '')
    throw new Error(`Erreur HTTP ${res.status} ${res.statusText} ${text}`)
  }
  return res.json()
}