#!/usr/bin/env bash
set -Eeuo pipefail

read -r -p 'IP address: ' TARGET

if [[ ! $TARGET =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]]; then
    printf 'Error: enter a valid IPv4 address.\n' >&2
    exit 2
fi
IFS=. read -r -a OCTETS <<< "$TARGET"
for OCTET in "${OCTETS[@]}"; do
    if (( 10#$OCTET > 255 )); then
        printf 'Error: enter a valid IPv4 address.\n' >&2
        exit 2
    fi
done

if ! command -v nmap >/dev/null 2>&1; then
    printf 'Error: nmap is not installed or not in PATH.\n' >&2
    exit 127
fi

sudo -v
IP_SCAN_DIR="scans/${TARGET}"
mkdir -p -- "$IP_SCAN_DIR"

UDP_PREFIX="${IP_SCAN_DIR}/nmap-udp-scan"
SERVICE_PREFIX="${IP_SCAN_DIR}/nmap-udp-service-scan"

sudo nmap -sU --top-ports 1000 -Pn -n -T4 --open -oA "$UDP_PREFIX" "$TARGET"

PORTS=$(grep -oP '\d+(?=/open)' "${UDP_PREFIX}.gnmap" | sort -nu | paste -sd,)

if [[ -z $PORTS ]]; then
    exit 0
fi

sudo nmap -sU -sC -sV -Pn -n -p "$PORTS" "$TARGET" -oA "$SERVICE_PREFIX"
