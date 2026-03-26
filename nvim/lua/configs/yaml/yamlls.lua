vim.lsp.config("yamlls", {
    filetypes = { "yaml", "yml" },
    settings = {
        yaml = {
            schemaStore = {
                enable = false,
                url = "",
            },
            schemas = {
                kubernetes = "*.k8s.yaml",
                ["https://raw.githubusercontent.com/quantumblacklabs/kedro/develop/static/jsonschema/kedro-catalog-0.17.json"] = "conf/**/*.catalog*",
                ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*",
                ["http://json.schemastore.org/github-action.json"] = ".github/action.{yml,yaml}",
                ["https://json.schemastore.org/ansible-playbook.json"] = "roles/tasks/*.{yml,yaml}",
                ["http://json.schemastore.org/prettierrc"] = ".prettierrc.{yml,yaml}",
                ["https://json.schemastore.org/kustomization.json"] = "kustomization.{yml,yaml}",
                ["http://json.schemastore.org/ansible-playbook.json"] = "*play*.{yml,yaml}",
                ["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
                ["https://json.schemastore.org/dependabot-v2"] = ".github/dependabot.{yml,yaml}",
                ["https://json.schemastore.org/gitlab-ci"] = "*gitlab-ci*.{yml,yaml}",
                ["https://json.schemastore.org/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json"] = "*api*.{yml,yaml}",
                ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "*docker-compose*.{yml,yaml}",

                -- argocd json-schema
                ["/home/kabil/.config/nvim/json-schema/application_v1alpha1.json"] = "*.app.argocd.yaml",
                ["/home/kabil/.config/nvim/json-schema/appproject_v1alpha1.json"] = "*.appproject.argocd.yaml",

                -- certmanager json-schema
                ["/home/kabil/.config/nvim/json-schema/certificate_v1.json"] = "*.certificate.certmgr.yaml",
                ["/home/kabil/.config/nvim/json-schema/certificaterequest_v1.json"] = "*.certificate-req.certmgr.yaml",
                ["/home/kabil/.config/nvim/json-schema/clusterissuer_v1.json"] = "*.clusteriss.certmgr.yaml",
                ["/home/kabil/.config/nvim/json-schema/issuer_v1.json"] = "*.iss.certmgr.yaml",

                -- traefik json-schema
                ["/home/kabil/.config/nvim/json-schema/ingressroute_v1alpha1.json"] = "*.ingroute.traefik.yaml",
                ["/home/kabil/.config/nvim/json-schema/middleware_v1alpha1.json"] = "*.middleware.traefik.yaml",
                ["/home/kabil/.config/nvim/json-schema/traefikservice_v1alpha1.json"] = "*.svc.traefik.yaml",
                ["/home/kabil/.config/nvim/json-schema/tlsstore_v1alpha1.json"] = "*.tlsstore.traefik.yaml",

                -- prometheus-operator json-schema
                ["/home/kabil/.config/nvim/json-schema/alertmanager_v1.json"] = "*.alertmanager.monitor.yaml",
                ["/home/kabil/.config/nvim/json-schema/alertmanagerconfig_v1alpha1.json"] = "*.alertmanagerconfig.monitor.yaml",
                ["/home/kabil/.config/nvim/json-schema/podmonitor_v1.json"] = "*.podmonitor.monitor.yaml",
                ["/home/kabil/.config/nvim/json-schema/probe_v1.json"] = "*.probe.monitor.yaml",
                ["/home/kabil/.config/nvim/json-schema/prometheus_v1.json"] = "*.prom.monitor.yaml",
                ["/home/kabil/.config/nvim/json-schema/prometheusagent_v1alpha1.json"] = "*.promagent.monitor.yaml",
                ["/home/kabil/.config/nvim/json-schema/prometheusrule_v1.json"] = "*.promrule.monitor.yaml",
                ["/home/kabil/.config/nvim/json-schema/scrapeconfig_v1alpha1.json"] = "*.scrapeconfig.monitor.yaml",
                ["/home/kabil/.config/nvim/json-schema/servicemonitor_v1.json"] = "*.svcmonitor.monitor.yaml",
                ["/home/kabil/.config/nvim/json-schema/thanosruler_v1.json"] = "*.thanosruler.monitor.yaml",
            },
            format = { enable = true },
        },
    },
})
