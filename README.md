# OSCP Toolkit

A personal collection of small scripts for authorized OSCP lab and exam-scope work.

## Scripts

| Script | Function |
| --- | --- |
| [nmap-tcp.sh](recon/nmap/nmap-tcp.sh) | Prompts for an IPv4 address, scans all TCP ports, extracts ports Nmap reports open, then runs default scripts and version detection on those ports. |
| [nmap-udp.sh](recon/nmap/nmap-udp.sh) | Prompts for an IPv4 address, scans the top 1,000 UDP ports, extracts ports Nmap reports open or open\|filtered, then runs UDP service detection on those ports. |

Both scripts request sudo access and display Nmap output in the terminal. They also save Nmap's `.nmap`, `.gnmap`, and `.xml` files under `scans/<IP>/`; Git ignores those generated scan files.

### Run

```bash
./recon/nmap/nmap-tcp.sh
./recon/nmap/nmap-udp.sh
```

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
