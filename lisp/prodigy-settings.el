;; Prodigy app and services
(defconst prodigy-python-apps
  '(airborne airborne-celery airborne-hyattfast bowman cessna fokker fasttrace))

(defconst prodigy-standard-python-service
  '((airborne :args ("manage.py" "runserver" "5000"))
    (airborne-celery
     :args ("manage.py" "celeryd" "-l" "info" "-c" "3" "-P" "eventlet" "-Q" "celery"))
    (airborne-hyattfast
     :args ("manage.py" "celeryd" "-l" "info" "-c" "1" "-P" "eventlet" "-Q" "hyatt_slow_queue"))
    (bowman
     :args ("worker" "-A" "bowman.celeryconfig" "-n" "bowman_celery"
            "-Q" "bowman_celery,bowman_booking_celery" "-P" "eventlet"
            "-c" "3" "-l" "info")
     :command "celery")
    (fasttrace :args ("-m" "fasttrace.web.app" "8080"))
    (fokker
     :args ("worker" "-A" "fokker.celery" "-n" "fokker-worker-1"
            "-Q" "fokker_search_celery,fokker_book_celery" "-c" "3"
            "-l" "info" "-P" "eventlet")
     :command "celery")
    (cessna
     :args ("-m" "celery.bin.worker" "-A" "cessna.celeryconfig" "-n" "cessna-worker"
            "-l" "info" "-c" "3" "-P" "eventlet" "-Q" "cessna_search_celery,cessna_book_celery")
    )
  ))

(defun prodigy-python-service-tag (appname)
  "Simple python virtualenv variables installed here."
  (let* ((appname-s (symbol-name appname))
         (envname (car (s-split "-" appname-s)))
         (tagname (intern (format "%s-tag" appname-s))))
    (prodigy-define-tag
      :name tagname
      :env '(("PYTHONHOME" (format "~/.virtualenvs/%s/" envname))
             ("PYTHONPATH" (format "~/projects/%s/" envname))
             ("VIRTUAL_ENV" (format "~/.virtualenvs/%s/" envname)))
      )))

(defun prodigy-python-service-example (appname)
  (let* ((appname-s (symbol-name appname))
         (envname (car (s-split "-" appname-s)))
         (tagname (intern (format "%s-tag" appname-s)))
         (override (cdr (assoc appname prodigy-standard-python-service))))
  (prodigy-define-service
    :name (s-capitalize appname-s)
    :command (or (plist-get override :command) "python")
    :args (plist-get override :args)
    :path (format "~/.virtualenvs/%s/bin" envname)
    :cwd (format "~/projects/%s/" envname)
    :tags `(work ,appname)
    :kill-signal 'sigkill
    )))

(defun prodigy-install-getgoing-apps ()
  (mapcar 'prodigy-python-service-tag prodigy-python-apps)
  (mapcar 'prodigy-python-service-example prodigy-python-apps)
  (message "Prodigy tags and services has been installed."))

;; Install all our app to prodigy
(prodigy-install-getgoing-apps)

(prodigy-define-service
  :name "Memcached"
  :command "/usr/local/bin/memcached"
  :args '("-I" "20M")
  :cwd "~"
  :tags '(work)
  :kill-signal 'sigkill)
(prodigy-define-service
  :name "ElasticSearch"
  :command "elasticsearch"
  :path '("/usr/local/bin/")
  :cwd "~"
  :tags '(work)
  :kill-signal 'sigkill)
(prodigy-define-service
  :name "RabbitMq"
  :command "rabbitmq-server"
  :path '("/usr/local/sbin/")
  :tags '(work)
  :kill-signal 'sigkill)
(prodigy-define-service
  :name "Hotreload Airborne"
  :command "node"
  :path '("/usr/local/bin/")
  :args (list "hotreload.js")
  :cwd "/Users/rmuslimov/projects/airborne/"
  :tags '(work)
  :kill-signal 'sigkill)

(provide 'prodigy-settings)
