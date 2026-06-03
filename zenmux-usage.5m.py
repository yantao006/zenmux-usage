#!/usr/bin/env python3
# <xbar.title>ZenMux Usage</xbar.title>
# <xbar.version>1.0</xbar.version>
# <xbar.author>yantao006</xbar.author>
# <xbar.desc>Shows remaining ZenMux 5h and 7d quota in the menu bar.</xbar.desc>
# <xbar.dependencies>python3</xbar.dependencies>
#
# Setup:
#   mkdir -p ~/.config/zenmux
#   echo "YOUR_MANAGEMENT_KEY" > ~/.config/zenmux/key
#   chmod 600 ~/.config/zenmux/key

import json
import os
import urllib.error
import urllib.request
from datetime import datetime

KEY_FILE = os.path.expanduser("~/.config/zenmux/key")
ENDPOINT = "https://zenmux.ai/api/v1/management/subscription/detail"


def load_key():
    if os.path.exists(KEY_FILE):
        with open(KEY_FILE) as f:
            return f.read().strip()
    return os.environ.get("ZENMUX_MANAGEMENT_KEY", "")


def pct(used, max_):
    if max_ == 0:
        return 0.0
    return 100.0 * used / max_


def main():
    key = load_key()
    if not key:
        print("⚠ Z: no key")
        print("---")
        print(f"Key file not found: {KEY_FILE}")
        print("Run: mkdir -p ~/.config/zenmux && echo YOUR_KEY > ~/.config/zenmux/key")
        return

    try:
        req = urllib.request.Request(
            ENDPOINT,
            headers={"Authorization": f"Bearer {key}"},
        )
        with urllib.request.urlopen(req, timeout=10) as resp:
            body = json.loads(resp.read())
    except urllib.error.HTTPError as e:
        print("⚠ Z: HTTP error")
        print("---")
        print(f"HTTP {e.code}: {e.reason}")
        return
    except Exception as e:
        print("⚠ Z: error")
        print("---")
        print(str(e))
        return

    if not body.get("success"):
        print("⚠ Z: API error")
        print("---")
        print(str(body))
        return

    data = body["data"]
    h5 = data["quota_5_hour"]
    d7 = data["quota_7_day"]

    h5_rem = h5["remaining_flows"]
    h5_max = h5["max_flows"]
    d7_rem = d7["remaining_flows"]
    d7_max = d7["max_flows"]

    # Menu bar: show 5h remaining / max
    print(f"Z {h5_rem:.0f}/{h5_max:.0f}")

    print("---")

    # 5h quota
    h5_used_pct = pct(h5["used_flows"], h5_max)
    print(f"5h  {h5_rem:.1f} / {h5_max:.0f}  ({h5_used_pct:.1f}% used)")

    # 7d quota
    d7_used_pct = pct(d7["used_flows"], d7_max)
    print(f"7d  {d7_rem:.1f} / {d7_max:.0f}  ({d7_used_pct:.1f}% used)")

    print("---")
    print(f"Updated {datetime.now().strftime('%H:%M:%S')}")


main()
