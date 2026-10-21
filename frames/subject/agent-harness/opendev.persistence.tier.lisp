;;; one tier of the settings: its name and what it holds
;;; members: built-in defaults, environment variables, user-global settings, project-local settings
(defrule tier -> :nucleus tier/holds)
(defrule tier/holds -> :instruction "階層の名前と、それが持つ設定を書く" :sample "Environment variables supply API credentials and CI/CD-specific overrides. API keys are only loaded from environment variables, never from configuration files, to prevent accidental exposure in version control. If a key is found in a configuration file, it is automatically stripped during loading.")
