import { createClient } from '@supabase/supabase-js'

const supabaseClient = createClient(
  // Supabase API URL - env var exported by default.
  process.env.SUPABASE_URL ?? '',
  // Supabase API ANON KEY - env var exported by default.
  process.env.SUPABASE_SERVICE_KEY ??
    '' /*,
  // Create client with Auth context of the user that called the function.
  // This way your row-level-security (RLS) policies are applied.
  { global: { headers: { Authorization: req.headers.get('Authorization')! } } }*/
)

export default supabaseClient
