(prodigy-define-service
  :name "Memcached"
  :command "/usr/local/bin/memcached"
  :args '("-I" "20M")
  :cwd "~"
  :tags '(work)
  :kill-signal 'sigkill
  :kill-process-buffer-on-stop t)
(prodigy-define-service
  :name "ElasticSearch"
  :command "elasticsearch"
  :path '("/usr/local/bin/")
  :cwd "~"
  :tags '(work)
  :kill-signal 'sigkill
  :kill-process-buffer-on-stop t)
(prodigy-define-service
  :name "RabbitMq"
  :command "rabbitmq-server"
  :path '("/usr/local/sbin/")
  :tags '(work)
  :kill-signal 'sigkill
  :kill-process-buffer-on-stop t)

(provide 'prodigy-settings)
