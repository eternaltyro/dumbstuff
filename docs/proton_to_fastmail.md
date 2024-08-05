# Migrating from Proton to Fastmail

## Proton services to consider 

1. Proton Mail - All mail content, aliases, custom domains, etc.
    - 
2. Proton Drive - 
3. Proton Pass - Not using.
4. Proton Calendar - Not using.
5. Proton Address book
6. Proton VPN - Not using.
7. Simple Login - Inventory all aliases.

## Prep work for Proton

- [x] Simplify folder structure
- [x] Remove labels - Fastmail allows Folders or Labels; not both.
- [ ] GPG private keys - Managed by Proton
- [ ] Export Address book and calendars if using
- [ ] Export sieve filters
- [ ] Inventory custom domains
- [ ] Reduce domain TTL in DNS (3600 -> 300 -> 60 sec)
- [ ] 

## Prep work on Fastmail

- [x] Sign-up for trial account
- [x] Create directory structure
- [ ] Setup Calendars
- [ ] Setup Thunderbird mail access using IMAP
- [ ] Setup Thunderbird calendar access using CalDAV (automatic)
- [ ] Setup Thunderbird address book access via CardDAV (auto)
- [ ] Setup WebDAV access on KDE Dolphin and LibreOffice (for remote)
- [ ] Setup MX records with low TTL and low priority ( `> 50` )
- [ ] Settup DKIM
- [ ] Configure masked emails on Bitwarden.

## Email migration
  but not both. Also, exporting emails using the import/export tool
  causes duplicates to be formed

  stop using Proton keys.

## Email alias migration.

We have two options: One, use FastMail masked emails 

# References
