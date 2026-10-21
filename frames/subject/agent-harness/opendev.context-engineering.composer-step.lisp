;;; one step of the prompt composer: its name and what it does to the sections
;;; members: filter, sort, load, join
(defrule composer-step -> :nucleus composer-step/does)
(defrule composer-step/does -> :instruction "段階の名前と、それが節に対して行うことを 1 文で書く" :sample "Filter. Evaluate each section’s predicate against the current environment snapshot. Sections that return False are excluded before any file I/O occurs. For example, main-git-workflow.md is gated on in_git_repo; it is never loaded when the working directory is not a repository.")
