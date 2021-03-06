;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; from [[http://mid.gmane.org/82bp6fjj71.wl%25kzhr@d1.dion.ne.jp][Kazuhiro Ito]]
;;
;; This lets us treat the (incorrect) MIME type image/jpg, which is
;; generated by Apple Mail, as image/jpeg.
;;
(let ((rule '(image jpg jpeg)))
     (ctree-set-calist-strictly
      'mime-preview-condition
      (list (cons 'type (car rule))(cons 'subtype (nth 1 rule))
	    '(body . visible)
	    (cons 'body-presentation-method #'mime-display-image)
	    (cons 'image-format (nth 2 rule)))))
