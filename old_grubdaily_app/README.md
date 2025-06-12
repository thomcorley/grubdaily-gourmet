# README

This is the Grubdaily rails app; a collection of my recipes. The recipes can be viewed at [www.grubdaily.com](www.grubdaily.com), which is a static site built with Jekyll. This app is a work-in-progress and will eventually replace the old static website.

The repository contains all of my old recipes in a mixture of CSV and YAML format, 69 in total. For instructions on how to import these recipes into the database, read on.

## Importing Legacy Recipes

_For the CSV recipes:_
```
importer = LegacyCsv::Importer.new
importer.import
```

_For the YAML recipes:_
```
importer = LegacyYaml::Importer.new
importer.import
```



