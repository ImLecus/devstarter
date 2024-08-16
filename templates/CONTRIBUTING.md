# How to add more templates

To add a new template to the project, follow these steps:

1. Create a `.sh` file with the name of the template in lowercase. For example, creating a template called `My language` must have a file called `mylanguage.sh`.

2. Add the identifier and name of the template into `src/templates.sh`. This step is necessary for the program to recognize the template in the `init` section.

3. Update README.md, adding the new template name at the end of the list in the **Templates** section.

4. Add the template color to `src/colors.sh`, or use an existing one. Make sure the name of the template in `src/templates.sh` has this style:
```bash
"${c_[template_color]}[template_name]"
```

5. Inside of the template file, the initial lines must contain this content:
```bash
#!/bin/bash
# [your template name] template
```

6. The template file must contain only a `make_template` function, that takes no
arguments and starts with `cd $cwd || exit`. To add a new file, create a local
variable with the name of the file without the extension, and then put the content inside a file:

```bash
    local main="print(\"Hello world!\")"
    echo "$main" > main.py || abort_process
```

7. To create a folder, make sure you use `mkdir -p` to avoid problems if the folder already exists.

8. Recommended the use of `cat` instead of `echo` or other ways to add text to a file.

### What you can not do creating a template

* Use a name that is already in use
* Use a confusing name or template
* Putting the name/id at other list positions instead of the last one
* Not following the style guide

### Once the template is finished

Create a pull request with the name `[your-template-name] template`. If everything is okay, the pull request will be accepted. 