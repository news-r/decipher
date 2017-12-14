# decipher

Tools to develop, build and train Natural Language processing models.

![decipher sticker](decipher_sticker.png)

## Install

```r
devtools::install_git("http://chlxintgitl01.weforum.local/JCOE/decipher.git",
  credentials = git2r::cred_user_pass("login", "password"))
```

### Dependencies

This package relies on [openNLP](http://opennlp.apache.org/) CLI tools.

1. [Download](http://opennlp.apache.org/download.html) binary *AND* source files.
2. Unzip both the binary and the source folders.
3. Add `path/to/opennlp/bin` to path.

You're good to go.
