# OSCP Toolkit

A personal collection of small scripts for authorized OSCP lab and exam-scope work.

## Nmap TCP and UDP scans

The scripts prompt for one IPv4 address, request sudo access, then run a discovery scan followed by service detection for the discovered ports.

```bash
./recon/nmap/nmap-tcp.sh
./recon/nmap/nmap-udp.sh
```

Results are saved in per-target folders under `scans/<IP>/`:

- TCP: `nmap-tcp-scan.*` and `nmap-tcp-service-scan.*`
- UDP: `nmap-udp-scan.*` and `nmap-udp-service-scan.*`

Each Nmap scan produces `.nmap`, `.gnmap`, and `.xml` files. Scan output is ignored by Git.

### Requirements

- Bash
- Nmap
- `sudo`
- `grep` with PCRE support (`grep -P`), `sort`, and `paste`

On Kali, make the scripts executable if needed:

```bash
chmod +x recon/nmap/*.sh
```

UDP scan results can include `open|filtered`; that state is inconclusive and does not confirm that a UDP service is open. Validate candidates with the service scan and protocol-specific enumeration.

Only scan systems that are explicitly in scope and authorized.
