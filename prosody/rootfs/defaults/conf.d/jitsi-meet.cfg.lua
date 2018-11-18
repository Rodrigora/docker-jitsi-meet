admins = { "{{ .Env.JICOFO_AUTH_USER }}@{{ .Env.XMPP_AUTH_DOMAIN }}" }
plugin_paths = { "/prosody-plugins/" }

{{ if and .Env.ENABLE_AUTH .Env.ENABLE_TOKEN_AUTH .Env.ACCEPTED_ISSUERS }}
asap_accepted_issuers = { {{ .Env.ACCEPTED_ISSUERS }} }
{{ end }}

{{ if and .Env.ENABLE_AUTH .Env.ENABLE_TOKEN_AUTH .Env.ACCEPTED_AUDIENCES }}
asap_accepted_audiences = { {{ .Env.ACCEPTED_AUDIENCES }} }
{{ end }}

VirtualHost "{{ .Env.XMPP_DOMAIN }}"
{{ if .Env.ENABLE_AUTH }}
    {{ if .Env.ENABLE_TOKEN_AUTH }}
    authentication = "token"
    app_id = "{{ .Env.APP_ID }}"
    app_secret = "{{ .Env.APP_SECRET }}"
    allow_empty_token = false
    {{ else }}
    authentication = "internal_plain"
    {{ end }}
{{ else }}
    authentication = "anonymous"
{{ end }}
    ssl = {
            key = "/config/certs/{{ .Env.XMPP_DOMAIN }}.key";
            certificate = "/config/certs/{{ .Env.XMPP_DOMAIN }}.crt";
    }
    modules_enabled = {
        "bosh";
        "pubsub";
        "ping";
    }

    c2s_require_encryption = false

{{ if and .Env.ENABLE_AUTH .Env.ENABLE_GUESTS }}
VirtualHost "{{ .Env.XMPP_GUEST_DOMAIN }}"
    authentication = "anonymous"
    c2s_require_encryption = false
{{ end }}

VirtualHost "{{ .Env.XMPP_AUTH_DOMAIN }}"
    ssl = {
        key = "/config/certs/{{ .Env.XMPP_AUTH_DOMAIN }}.key";
        certificate = "/config/certs/{{ .Env.XMPP_AUTH_DOMAIN }}.crt";
    }
    authentication = "internal_plain"

Component "{{ .Env.XMPP_INTERNAL_MUC_DOMAIN }}" "muc"
    modules_enabled = {
      "ping";
    }
    storage = "none"
    muc_room_cache_size = 1000
    {{ if .Env.ENABLE_TOKEN_AUTH }}
    modules_enabled = { "token_verification" }
    {{ end }}

Component "{{ .Env.XMPP_MUC_DOMAIN }}" "muc"
    storage = "none"
    {{ if .Env.ENABLE_TOKEN_AUTH }}
    modules_enabled = { "token_verification" }
    {{ end }}

Component "focus.{{ .Env.XMPP_DOMAIN }}"
    component_secret = "{{ .Env.JICOFO_COMPONENT_SECRET }}"

