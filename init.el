;;1 Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;;selectrum
;;https://zhuanlan.zhihu.com/p/450512406
(package-initialize)

(global-unset-key (kbd "C-SPC"))
(global-set-key (kbd "M-SPC") 'set-mark-command)
(put 'upcase-region 'disabled nil)


;; (add-hook 'c-mode-hook
;; 	  (lambda ()
;; 	    (fci-mode)
;; 	    (display-line-numbers-mode)
;; 	    (line-number-mode)
;; 	    (column-number-mode)
;; 	    (whitespace-mode)
;; 	    (setq c-default-style
;; 		  '((java-mode . "java")
;; 		    (awk-mode . "awk")
;; 		    (other . "linux")))
;; 	    (setq c-basic-offset 4)
;; 	    (setq tab-width 4)
;; 	    (setq backward-delete-char-untabify-method nil)))


;;下面是系统带出来的代码
;;customize-face带出来的代码
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(c-basic-offset 4)
 '(company-backends
   '(company-bbdb company-files
				  (company-dabbrev-code company-gtags company-etags company-keywords)
				  company-oddmuse company-dabbrev))
 '(custom-enabled-themes '(misterioso))
 '(global-company-mode t)
 '(helm-ag-base-command "ag --nocolor --nogroup --ignore-case")
 '(helm-ag-command-option "--all-text")
 '(helm-ag-ignore-buffer-patterns '("\\.txt\\'" "\\.mkd\\'"))
 '(helm-ag-insert-at-point 'symbol)
 '(highlight-symbol-foreground-color "blue")
 '(package-selected-packages
   '(ccls lsp-mode yasnippet lsp-treemacs helm-lsp projectile hydra flycheck company avy which-key helm-xref dap-mode))
 '(stupid-indent-level 4)
 '(tab-width 4)
 '(tool-bar-mode nil)
 '(warning-suppress-log-types '((lsp-mode) (lsp-mode) (lsp-mode)))
 '(warning-suppress-types '((lsp-mode) (lsp-mode))))
(put 'erase-buffer 'disabled nil)

;; (add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
;; (load-theme 'zenburn t)

;; (add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
;; (load-theme 'monokai t)


;;(stupid-indent-mode)

;;下面这两个是注释快捷键
;;第一行是先绑定快捷键为C-x C-/。
;;但是这个命令有一个小问题，那就是只能针对当前选中的行（region）做操作。如果当前没有选中任何行的话就什么也不做。
;;第二部分就是优化快速注释快捷键了
;;(global-set-key (kbd "M-SPC") 'set-mark-command)
(global-set-key [?\C-x ?\C-/] 'comment-or-uncomment-region)
(defun my-comment-or-uncomment-region (beg end &optional arg)  
  (interactive (if (use-region-p)  
                   (list (region-beginning) (region-end) nil)  
                 (list (line-beginning-position)  
                       (line-beginning-position 2))))  
  (comment-or-uncomment-region beg end arg))
(global-set-key [remap comment-or-uncomment-region] 'my-comment-or-uncomment-region)

;; 下面这个是把特定的功能绑定到特定的按钮上面
;; 查看按钮绑定了什么功能，C-h c然后按下你要查询的按钮，
;; (global-set-key (kbd "C-M-q") 'query-replace)

;; copy region or whole line
;; \M-w为原来的复制
;;[?\C-x ?\C-/]
;;(global-set-key "\C-c"
;;别的需要C-c为前导按钮

;; (global-set-key [?\C-c ?\C-c]
(defun Copyyy()
;;(lambda ()
  (interactive)
  (if mark-active
      (kill-ring-save (region-beginning)
		      (region-end))
    (progn
      (kill-ring-save (line-beginning-position)
		      (line-end-position))
      (message "copied line"))))


;; kill region or whole line
;; \C-w为原来的剪切,\C+x不能用，会搞坏原来的保存退出按钮\C+x \C+s还有保存退出\C+x \C+s
;; 原来享用A-x的，发现冲突了，C-k代替原来的Kill line吧，原来的不好用很蠢，删一堆，好像到句号才停
;; (global-set-key "\C-d"
(defun Delett()
;; (lambda ()
  (interactive)
  (if mark-active
      (kill-region (region-beginning)
   (region-end))
    (progn
     (kill-region (line-beginning-position)
  (line-end-position))
     (message "killed line"))))


;;这个只能放在同一个文件下面操作
(add-hook 'c-mode-common-hook
  (lambda() 
    (local-set-key  (kbd "C-c o") 'ff-find-other-file)))


;;没啥用，还是要放环境变量
;;(add-to-list 'exec-path "~/.emacs.d/External-tools/Switch-H-C")
;;下面这个有时间可以优化，用find指令遍历寻找，自定义一个根目录。
;;简单一点的话，添加inc和src还有lib文件夹的操作，目前先将就用。
(defun Switching()
  (interactive)
  (find-file
   (shell-command-to-string
    (concat "Switching "
            (file-truename buffer-file-name)))))
;;很TM奇怪，怎么失效没法定义了？
;; (global-set-key (kbd "M-o") 'Switching)
(global-set-key (kbd "C-1") 'Switching)


(defvar my-keys-minor-mode-map (make-sparse-keymap) "my-keys-minor-mode keymap.")
;;(define-key my-keys-minor-mode-map (kbd "C-x g")   'magit-status)
;;(define-key my-keys-minor-mode-map (kbd "C-`")     'shell-pop)
(define-key my-keys-minor-mode-map [?\C-c ?\C-c] 'Copyyy())
(define-key my-keys-minor-mode-map (kbd "C-d")   'Delett())

(define-key my-keys-minor-mode-map (kbd "TAB")   'stupid-indent)
(define-key my-keys-minor-mode-map (kbd "<backtab>") 'stupid-outdent)

;; 这两个绑定会导致Meta键无效，不知道为啥
;; (define-key my-keys-minor-mode-map (kbd "C-[") 'forward-sexp)
;; (define-key my-keys-minor-mode-map (kbd "C-]") 'backward-sexp)
(define-key my-keys-minor-mode-map (kbd "M-[") 'forward-sexp)
(define-key my-keys-minor-mode-map (kbd "M-]") 'backward-sexp)

;;(define-key my-keys-minor-mode-map (kbd "TAB")   'c-indent-line-or-region)
;;(define-key my-keys-minor-mode-map (kbd "TAB")   'indent-for-tab-command)
;;(define-key my-keys-minor-mode-map (kbd "TAB")   'lisp-indent-adjust-parens)
;;(define-key my-keys-minor-mode-map (kbd "<backtab>") 'lisp-dedent-adjust-parens)
(define-minor-mode my-keys-minor-mode
  "A minor mode so that my key settings override annoying major modes."
  :init-value t :lighter "")
;;minor模式，按键绑定优先级最高，就不会再被别的模式抢占按键了。
(my-keys-minor-mode 1)




;;(local-unset-key (kbd "\C-z"))
;;原来是退出不保存，我改为undo
(define-key key-translation-map (kbd "C-z") (kbd "C-/"))


;;显示行号
(global-linum-mode t)

;;关闭向导
(setq inhibit-splash-screen t)

;;工具栏隐藏，就是那些图标，这个要
(tool-bar-mode 0)
;;菜单栏隐藏，这个不要
;;(menu-bar-mode 0)
;;滚动条隐藏，这个不要
;;(scroll-bar-mode 0) 

;;下面是简书上面学习的
;;https://www.jianshu.com/p/42ef1b18d959
;;如果要更多的包，进入包下载界面之后，输入package-refresh-contents便可，上万个，实在太慢了
(setq package-archives '(
    ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/") 
    ("gnu" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
    ("org" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/org/")))

;;好像第一次安装完就不会再运行了
(setq package-check-signature nil) ;个别时候会出现签名校验失败
 (require 'package) ;; 初始化包管理器
 (unless (bound-and-true-p package--initialized) 
    (package-initialize)) ;; 刷新软件源索引
 (unless package-archive-contents
     (package-refresh-contents))

(unless (package-installed-p 'use-package) 
    (package-refresh-contents) 
    (package-install 'use-package))

;;建议添加的配置（部分来自use-package官方建议)
;;不知道是啥，先加了吧
(eval-and-compile 
    (setq use-package-always-ensure t) ;不用每个包都手动添加:ensure t关键字 
    (setq use-package-always-defer t) ;默认都是延迟加载，不用每个包都手动添加:defer t 
    (setq use-package-always-demand nil) 
    (setq use-package-expand-minimally t) 
    (setq use-package-verbose t))

;;全部都是utf-8
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8) 
(set-terminal-coding-system 'utf-8) 
(set-keyboard-coding-system 'utf-8) 
(setq default-buffer-file-coding-system 'utf-8)

;;设置垃圾回收阈值，加速启动速度。
(setq gc-cons-threshold most-positive-fixnum)



;;高亮光标所在行
(global-hl-line-mode t)
;; (set-face-attribute hl-line-face nil :underline t)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "DejaVu Sans Mono" :foundry "PfEd" :slant normal :weight regular :height 120 :width normal))))
 '(company-tooltip-selection ((t (:background "dark orange"))))
 '(highlight ((t (:inherit region:backgrounddark olive green))))
 '(hl-line ((t (:background "#191919"))))
 '(lsp-face-semhl-comment ((t (:inherit shadow))))
 '(mode-line ((t (:background "dim gray" :foreground "#eeeeec"))))
 '(region ((t (:background "sienna" :foreground "#e1e1e0")))))


;;高亮匹配括号
(show-paren-mode 1)
;;同时高亮括号中的内容，这个留着吧
;; (setq-default show-paren-style 'expression)

(electric-pair-mode 1)
(setq electric-pair-pairs
      '((?\" . ?\")  ;; 添加双引号补齐
	(?\{ . ?\})  ;; 添加大括号补齐
	(?\' . ?\'))) ;; 添加单引号补齐



;; 学会自己绑定按钮，这里开始学习
;; 稳，果然是要看懂代码，加上两个函数的输入变量1，成功了
;; C-o改为向上插入一行
(global-set-key (kbd "C-o") '(lambda ()
    (interactive)                               
    (move-beginning-of-line 1)
    (open-line 1)))

;;<C-return>这个玩意就是C-h c里面在minibuff里面显示出来的
;;newline也是如此
;;后面慢慢学习改造
;;newline不加1也行，缺省会自动填充1
(global-set-key (kbd "<C-return>") '(lambda ()
	(interactive)                               
	(move-end-of-line 1)
	(newline 1)))


;;customize-face里面修改一下前置色便可
(require 'highlight-symbol)
;; (global-set-key [(control f3)] 'highlight-symbol)
;; (global-set-key [f3] 'highlight-symbol-next)
;; (global-set-key [(shift f3)] 'highlight-symbol-prev)
;; (global-set-key [(meta f3)] 'highlight-symbol-query-replace)
(global-set-key [f2] 'highlight-symbol)
(global-set-key [f3] 'highlight-symbol-next)
(global-set-key [f1] 'highlight-symbol-prev)
(global-set-key [f4] 'highlight-symbol-query-replace)
;; 这个可以用选择区域区代替，但是不如上面那个好用，直接spc下去。！表示全部替代
;; 不对劲，这个也要，上面那个只能是字符串一整串，下面那个可以任意
;;这个快捷键是移动一行往上，感觉意义不大，取缔edit-at-point-line-up
;;算了，C-S-r好像不是这么写，用下面那个把
(global-set-key (kbd "C-x r") 'replace-string)

;;这玩意没什么用，自带的ido完全满足(M-x customize 搜索ido)
;; (use-package ivy
;;   :ensure t)

;; (ivy-mode)
;; ;; ---- 设置两个变量为 True，还有一个可选的 ---
;; (setq ivy-use-virtual-buffers t)
;; (setq enable-recursive-minibuffers t)
;; ;;在minibuffer有效果，但是按多了会出问题，算了，用C-r和C-s这两个搜索去代替
;; (global-set-key (kbd "<tab>") 'ivy-partial-or-done)
;;没什么用
;; (global-set-key (kbd "<f7>") 'ivy-resume)
;;ivy-resume


;; 自动完成：company
;;改一下自动补全的候选来源company-backends,customize-face(好东西)
;;参考 https://www.freesion.com/article/28571157303/
(require 'company)
(add-hook 'after-init-hook 'global-company-mode); 全局开启
(setq company-show-numbers t); 显示序号
;;(setq company-idle-delay 0.2); 菜单延迟


(global-set-key [C-tab] '(lambda () (interactive) (insert-char 9 1)))
;;学到第三个后半段
;;如果只需要使用Emacs来记笔记，安排日程，那么毫无疑问Org-Mode,这个后续学习再说，


;;这个玩意就是安装lsp-m
(use-package lsp-mode
  :init
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq lsp-keymap-prefix "C-c l")
  :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
         (XXX-mode . lsp)
         ;; if you want which-key integration
         (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp)

;; optionally
(use-package lsp-ui :commands lsp-ui-mode)
;; if you are helm user
(use-package helm-lsp :commands helm-lsp-workspace-symbol)
;;这玩意不用
;; if you are ivy user
;;(use-package lsp-ivy :commands lsp-ivy-workspace-symbol)
;;(use-package lsp-treemacs :commands lsp-treemacs-errors-list)

;; optionally if you want to use debugger
(use-package dap-mode)
;; (use-package dap-LANGUAGE) to load the dap adapter for your language

;; optional if you want which-key integration
;; 这个玩意就是让你看这个快捷键后续绑定了什么快捷键，在minibuffer
;; (use-package which-key
;;     :config
;;     (which-key-mode))

;;lsp-mode重要的两句话
(add-hook 'c-mode-hook 'lsp)
(add-hook 'c++-mode-hook 'lsp)


(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
;;(package-initialize)

(setq package-selected-packages '(lsp-mode yasnippet lsp-treemacs helm-lsp
    projectile hydra flycheck company avy which-key helm-xref dap-mode))

(when (cl-find-if-not #'package-installed-p package-selected-packages)
  (package-refresh-contents)
  (mapc #'package-install package-selected-packages))

;; sample `helm' configuration use https://github.com/emacs-helm/helm/ for details
(helm-mode)
(require 'helm-xref)
;;C-x C-f
(define-key global-map [remap find-file] #'helm-find-files)
;;感觉没什么用
(define-key global-map [remap execute-extended-command] #'helm-M-x)
;;C-x b
(define-key global-map [remap switch-to-buffer] #'helm-mini)


(setq gc-cons-threshold (* 100 1024 1024)
      read-process-output-max (* 1024 1024)
      treemacs-space-between-root-nodes nil
      company-idle-delay 0.0
      company-minimum-prefix-length 1
      lsp-idle-delay 0.1)  ;; clangd is fast

(with-eval-after-load 'lsp-mode
  (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration)
  (require 'dap-cpptools)
  (yas-global-mode))

(lsp-ui-mode)



;; ((c++-mode . ((flycheck-gcc-include-path . (
;;                                        "/usr/include"
;;                                        "/home/cobbliu/thirdparty/gcc-4.9.2/include"
;;                                        "/home/admin/jinxin/project/include"
;;                                        "/home/admin/jinxin/project/chunkserver/include")))))


;; 没必要，直接定义一些按钮便可
;; ;;M-.
;; (define-key lsp-ui-mode-map [remap xref-find-definitions] #'lsp-ui-peek-find-definitions)
;; ;;M-?
;; (define-key lsp-ui-mode-map [remap xref-find-references] #'lsp-ui-peek-find-references)
(global-set-key [f11] 'lsp-ui-peek-find-definitions)
(global-set-key [f12] 'lsp-ui-peek-find-references)
(global-set-key  (kbd "M-<left>") 'xref-go-back)
(global-set-key  (kbd "M-<right>") 'xref-go-forward)


;;(lsp-treemacs-sync-mode 1)
(global-set-key [f10] 'lsp-treemacs-symbols)
;;有一些是C-g能解决
;;(global-set-key [f9] 'delete-window)
(global-set-key [f9] 'treemacs)

(projectile-mode +1)
;; Recommended keymap prefix on macOS
;;(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
;; Recommended keymap prefix on Windows/Linux
;;(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
(global-set-key [f5] 'projectile-find-file)


;;这个安装真的比windows简单多了。在windows下面折腾了一下emacs，发现ubuntu简直神一样简单
;;压根不需要加这个路径，直接环境变量就有
;; (add-to-list 'exec-path "D:/Emacs29/.emacs.d/External_Tools/ag")
(add-to-list 'load-path "~/.emacs.d/External-tools/helm-ag")
(require 'helm-ag)

;;该文件下的文件夹所有文件遍历，如果是想一个.c里面找，C-s
;;如果想遍历整个project，直接跳到ag.svn这个根目录
(global-set-key [f6] 'helm-ag)

;;emacs自带计算器，更好用，calculator(calc这个不太懂，不如前面那个)
;;各种转制，B-O-D-H(X)。q退出。计算就是正常计算。
(global-set-key [f7] 'calculator)

;;好东西，和bind-key双璧
(require 'stupid-indent-mode)
;;TAB等按钮重映射到minor-mode里面了

;; 真TM好东西
(require 'bind-key)
(bind-keys
  ;;真TM好东西，word意义不大，有-就断掉
  ;; ("C-S-e". edit-at-point-symbol-copy)
  ;; ("C-S-f". edit-at-point-symbol-cut)
  ;; ("C-S-g". edit-at-point-symbol-delete)
  ;; ("C-S-h". edit-at-point-symbol-paste)
  ("C-S-a". edit-at-point-symbol-copy)
  ("C-S-b". edit-at-point-symbol-cut)
  ("C-S-c". edit-at-point-symbol-delete)
  ;;替换符号，这个才是我要的东西
  ("C-S-d". edit-at-point-symbol-paste)

  ;; ("C-S-a". edit-at-point-word-copy)
  ;; ("C-S-b". edit-at-point-word-cut)
  ;; ("C-S-c". edit-at-point-word-delete)
  ;; ("C-S-d". edit-at-point-word-paste)

  ;;e被外部调用了，去掉e，同时去掉delete
  ("C-S-f". edit-at-point-word-copy)
  ("C-S-g". edit-at-point-word-cut)
  ;;("C-S-g". edit-at-point-word-delete)
  ("C-S-h". edit-at-point-word-paste)

  ("C-S-i". edit-at-point-str-copy)
  ("C-S-j". edit-at-point-str-cut)
  ("C-S-k". edit-at-point-str-delete)
  ("C-S-l". edit-at-point-str-paste)
  ("C-S-m". edit-at-point-line-copy)
  ("C-S-n". edit-at-point-line-cut)
  ("C-S-o". edit-at-point-line-delete)
  ("C-S-p". edit-at-point-line-paste)
  ("C-S-q". edit-at-point-line-dup)
  ("C-S-r". edit-at-point-line-up)
  ("C-S-s". edit-at-point-line-down)
  ("C-S-t". edit-at-point-paren-copy)
  ("C-S-u". edit-at-point-paren-cut)
  ("C-S-v". edit-at-point-paren-delete)
  ("C-S-w". edit-at-point-paren-paste)
  ("C-S-x". edit-at-point-paren-dup)
  ("C-S-y". edit-at-point-defun-copy)
  ("C-S-z". edit-at-point-defun-cut)
  ("C-{"  . edit-at-point-defun-delete)
  ("C-:"  . edit-at-point-defun-paste)
  ("C-\"" . edit-at-point-defun-dup))


;; 没啥用，原来找不到头文件，是因为包含了之后就报错了。
;; LSP-mode已经设置了根目录，所以flycheck能自然找到头文件。估计是ag之类的查找
;; (add-to-list 'auto-mode-alist '("\\.h\\'" . c-mode))


;;这个意义也不大
;;还是TM有意义，treemacs和LSP-Symbols-list转过去
(require 'window-number)
(window-number-mode 1)
(global-set-key  (kbd "C-x o") 'window-number-switch)
;;妈的，下面那个果然是换位置，这个也还行，就是数字太小
(global-set-key (kbd "M-o") 'ace-window)
;; ;;没啥叼用，后续删了吧，ijkl移动意义不大。
;; (require 'win-switch)
;; (win-switch-setup-keys-ijkl "\C-xo")
;;windower这个控件才是需要的,window-jump这个控件好像意义不大，太复杂
(global-set-key (kbd "<s-tab>") 'windower-switch-to-last-buffer)
(global-set-key (kbd "<s-o>") 'windower-toggle-single)
(global-set-key (kbd "s-\\") 'windower-toggle-split)
;;这个是修改边界大小，少用，去掉
;; (global-set-key (kbd "<s-M-left>") 'windower-move-border-left)
;; (global-set-key (kbd "<s-M-down>") 'windower-move-border-below)
;; (global-set-key (kbd "<s-M-up>") 'windower-move-border-above)
;; (global-set-key (kbd "<s-M-right>") 'windower-move-border-right)
;;这个才是跳窗口的好东西
;; (global-set-key (kbd "<s-S-left>") 'windower-swap-left)
;; (global-set-key (kbd "<s-S-down>") 'windower-swap-below)
;; (global-set-key (kbd "<s-S-up>") 'windower-swap-above)
;; (global-set-key (kbd "<s-S-right>") 'windower-swap-right)
;; 不知道是啥按钮，换一个
(global-set-key (kbd "M-j") 'windower-move-border-left)
(global-set-key (kbd "M-k") 'windower-move-border-below)
(global-set-key (kbd "M-i") 'windower-move-border-above)
(global-set-key (kbd "M-l") 'windower-move-border-right)

(global-set-key (kbd "M-J") 'windower-swap-left)
(global-set-key (kbd "M-K") 'windower-swap-below)
(global-set-key (kbd "M-I") 'windower-swap-above)
(global-set-key (kbd "M-L") 'windower-swap-right)


;;speedbar(+展开，-缩回来)指令感觉意义不大，直接tree和helm的C-x C-f直接代替更完美，体验更好
;; (require 'sr-speedbar)
;; (setq sr-speedbar-right-side nil)
;; (setq sr-speedbar-width 25)
;; (setq dframe-update-speed t)
;; (global-set-key (kbd "<f9>") (lambda()
;;           (interactive)
;;           (sr-speedbar-toggle)))


;; 没啥用，直接markdown-mode就完成了
;; 然后markdown-preview，然后chrome导出pdf，完美，不需要这么多东西
;; docx后续再说
;;  (require 'cl)
;;  ;; Add Packages
;;  (defvar my/packages '(
;;         markdown-mode
;;         ) "Default packages")

;; (defun haotianmichael/markdown-to-html ()
;;   (interactive)
;;   (start-process "grip" "*gfm-to-html*" "grip" (buffer-file-name) "5000")
;;   (browse-url (format "http://localhost:5000/%s.%s" (file-name-base) (file-name-extension (buffer-file-name)))))
;; (global-set-key (kbd "C-c m")   'haotianmichael/markdown-to-html)  ;给给函数绑定一个快捷键

(add-to-list 'load-path "~/.emacs.d/elpa")  
(autoload 'markdown-mode "markdown-mode.el"  
"Major mode for editing Markdown files" t)  
(setq auto-mode-alist  
(cons '(".markdown" . markdown-mode) auto-mode-alist))

(global-set-key (kbd "C-c p") 'markdown-preview)


;; (add-to-list 'load-path "~/.emacs.d/themes/rainbow-identifiers")
;; (require 'rainbow-identifiers)
;; (add-hook 'prog-mode-hook 'rainbow-identifiers-mode)
;; 下面那个虽然好用，但是好卡啊
;; 加了这句，完成操作，妈的，那会浪费我2天，果然还是要多读文档
(require 'ccls)
(setq ccls-executable "/usr/local/bin/ccls")

(use-package ccls
  :hook ((c-mode c++-mode objc-mode cuda-mode) .
         (lambda () (require 'ccls) (lsp))))

(setq ccls-sem-highlight-method 'font-lock)
;; alternatively, (setq ccls-sem-highlight-method 'overlay)

;; For rainbow semantic highlighting
(ccls-use-default-rainbow-sem-highlight)

