#!/usr/bin/env bash
# Deploy Firebase Hosting for this repo. Run from project root: ./scripts/deploy-hosting.sh
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

if [[ -n "${GOOGLE_APPLICATION_CREDENTIALS:-}" && -f "${GOOGLE_APPLICATION_CREDENTIALS}" ]]; then
  echo "Using GOOGLE_APPLICATION_CREDENTIALS for deploy."
  exec npx firebase deploy --only hosting --project avantgarderms-6b933
fi

if [[ -n "${FIREBASE_TOKEN:-}" ]]; then
  echo "Using FIREBASE_TOKEN for deploy."
  exec npx firebase deploy --only hosting --project avantgarderms-6b933 --token "${FIREBASE_TOKEN}"
fi

if ! npx firebase projects:list >/dev/null 2>&1; then
  echo "Firebase CLI is not logged in or cannot list projects."
  echo "Run once on this machine:"
  echo "  firebase login --reauth"
  echo "Or set GOOGLE_APPLICATION_CREDENTIALS to your service account JSON, or FIREBASE_TOKEN (see .env.example)."
  exit 1
fi

exec npx firebase deploy --only hosting --project avantgarderms-6b933
