# Useful Commands

### APIで画像更新（ローカル）

Githubのアクションをローカルで試す

```
bash scripts/update_profile_stats.sh
```
scriptに不具合がある場合はこちら

```
curl -fsSL "https://{$PROFILE_STATS_URL}/api?username={$yourname}&count_private=true" -o img/profile_stats.svg
```

---

### 環境変数（ローカル）

環境変数に値をセット

```
set -a; source .env; set +a
```

環境変数の値を確認

```
echo "{$PROFILE_STATS_URL}"
```
