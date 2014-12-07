RunScript "use_unbound.lua"
VirtualHost "localhost"
VirtualHost "unrelenting.technology"

admins = { "greg@unrelenting.technology" }

modules_enabled = { -- Documentation on modules can be found at: http://prosody.im/doc/modules
-- Generally required
	"roster"; "saslauth"; "tls"; "dialback"; "disco";
-- Not essential, but recommended
	"private"; "vcard"; "privacy";
-- Nice to have
	"version"; "uptime"; "time"; "ping"; "pep"; "register";
	"admin_adhoc"; -- Allows administration via an XMPP client that supports ad-hoc commands
	"bosh"; -- Enable BOSH clients, aka "Jabber over HTTP"
	-- "s2s_auth_dane";
}

modules_disabled = { }

ssl = {
	key = "/usr/local/etc/certs/key.0644.pem";
	certificate = "/usr/local/etc/certs/bundle.pem";
	dhparams = "/usr/local/etc/certs/dhparam.pem";
	cafile = "/usr/local/share/certs/ca-root-nss.crt";
	ciphers = "ECDHE-RSA-CHACHA20-POLY1305:HIGH+kEECDH:HIGH+kEDH:HIGH:!PSK:!3DES:!aNULL";
	options = { "no_sslv2", "no_sslv3", "no_ticket", "no_compression", "cipher_server_preference", "single_dh_use", "single_ecdh_use" };
}

c2s_require_encryption = true
s2s_secure_auth = true -- For more information see http://prosody.im/doc/s2s#security
s2s_insecure_domains = { "gmail.com" }
authentication = "internal_hashed"
allow_registration = false -- For more information see http://prosody.im/doc/creating_accounts
prosody_user = "prosody"
log = "*console"
