# DuckDrop

A tiny, static cruise duck hunting app. One HTML file, Supabase backend, Vercel-ready.

## Fast Setup

1. Create a free Supabase project.
2. Open the Supabase SQL editor and run `supabase-setup.sql`.
3. In Supabase, go to Project Settings -> API.
4. Copy the Project URL and anon public key.
5. Open `index.html` and replace:
   - `PASTE_SUPABASE_URL_HERE`
   - `PASTE_SUPABASE_ANON_KEY_HERE`
6. Deploy this folder to Vercel as a static project.

## Routes

- `#/ducks` - all ducks
- `#/duck/:id` - found duck page and passport
- `#/leaderboard` - top finders
- `#/admin` - add ducks and print QR codes

Admin password: `quack2026`

## Printing QR Labels

1. Go to `#/admin`.
2. Add ducks.
3. Click `Print All QR Codes`.
4. Print at 100% scale. Labels are sized around 2 inches square.

Each QR points to:

```text
{SITE_URL}#/duck/{duck_id}
```

## Notes

- The admin password is client-side only so this can be deployed quickly for a small cruise game.
- The SQL allows anonymous reads and inserts for ducks and findings. Do not use this for sensitive data.
- Optional photos are compressed in the browser and uploaded to the public `duck-photos` bucket.
- The app uses CDN scripts for Supabase and QR generation. There is no build step.

