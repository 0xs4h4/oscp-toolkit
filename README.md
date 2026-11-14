# OSCP Toolkit

A personal collection of small scripts for authorized OSCP lab and exam-scope work.

## Scripts

| Script | Function |
| --- | --- |
| [nmap-tcp.sh](recon/nmap/nmap-tcp.sh) | Full TCP port scan and service detection. |
| [nmap-udp.sh](recon/nmap/nmap-udp.sh) | Top 1,000 UDP port scan and service detection. |


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
