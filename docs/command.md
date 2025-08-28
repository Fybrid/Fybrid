# Useful Commands

```
bash scripts/update_profile_stats.sh
```

```
echo "$PROFILE_STATS_URL"
```

```
set -a; source .env; set +a
```

```
curl -fsSL "https://{$PROFILE_STATS_URL}/api?username={$yourname}&count_private=true&show_icons=true&theme=dracula" -o img/profile_stats.svg
```