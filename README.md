# About:

Using ipset lists to protect your server.

# How to use:

```bash
git clone --recursive "github-repo-site".git
cd shield-ipsets
. scripts/renew.sh
```
In `output/`, you will get `ipset.txt` and `netset.txt`.

### first use:
```bash
cd output/
. ../scripts/create-srv.sh
```

### refresh:
```bash
cd output/
. ../scripts/refresh-srv.sh
```

# Warning:
Someone used this tool may cause your server cannot access outside.
Because we used public malware site lists, your server could been used for cyber-attack.
You should scan your server carefully.

