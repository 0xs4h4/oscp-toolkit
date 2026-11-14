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

TCP_PREFIX="${IP_SCAN_DIR}/nmap-tcp-scan"
SERVICE_PREFIX="${IP_SCAN_DIR}/nmap-tcp-service-scan"

sudo nmap -p- -sS -Pn -n -T4 --open -oA "$TCP_PREFIX" "$TARGET"

PORTS=$(grep -oP '\d+(?=/open)' "${TCP_PREFIX}.gnmap" | sort -nu | paste -sd,)

if [[ -z $PORTS ]]; then
    exit 0
fi

sudo nmap -sC -sV -Pn -n -p "$PORTS" "$TARGET" -oA "$SERVICE_PREFIX"
