# Print DT table

Print DT table

## Usage

``` r
print_DT(df, ..., html_tags = FALSE, extra = FALSE)
```

## Arguments

- df:

  Dataframe/tibble to be printed.

- ...:

  Arguments passed on to
  [`DT::datatable`](https://rdrr.io/pkg/DT/man/datatable.html)

  `data`

  :   a data object (either a matrix or a data frame)

  `options`

  :   a list of initialization options (see
      <https://datatables.net/reference/option/>); the character options
      wrapped in
      [`htmlwidgets::JS()`](https://rdrr.io/pkg/htmlwidgets/man/JS.html)
      will be treated as literal JavaScript code instead of normal
      character strings; you can also set options globally via
      `[options](DT.options = list(...))`, and global options will be
      merged into this `options` argument if set

  `class`

  :   the CSS class(es) of the table; see
      <https://datatables.net/manual/styling/classes>

  `callback`

  :   the body of a JavaScript callback function with the argument
      `table` to be applied to the DataTables instance (i.e. `table`)

  `rownames`

  :   `TRUE` (show row names) or `FALSE` (hide row names) or a character
      vector of row names; by default, the row names are displayed in
      the first column of the table if exist (not `NULL`)

  `colnames`

  :   if missing, the column names of the data; otherwise it can be an
      unnamed character vector of names you want to show in the table
      header instead of the default data column names; alternatively,
      you can provide a *named* numeric or character vector of the form
      `'newName1' = i1, 'newName2' = i2` or
      `c('newName1' = 'oldName1', 'newName2' = 'oldName2', ...)`, where
      `newName` is the new name you want to show in the table, and `i`
      or `oldName` is the index of the current column name

  `container`

  :   a sketch of the HTML table to be filled with data cells; by
      default, it is generated from `htmltools::tags$table()` with a
      table header consisting of the column names of the data

  `caption`

  :   the table caption; a character vector or a tag object generated
      from `htmltools::tags$caption()`

  `filter`

  :   whether/where to use column filters; `none`: no filters;
      `bottom/top`: put column filters at the bottom/top of the table;
      range sliders are used to filter numeric/date/time columns, select
      lists are used for factor columns, and text input boxes are used
      for character columns; if you want more control over the styles of
      filters, you can provide a named list to this argument; see
      Details for more

  `escape`

  :   whether to escape HTML entities in the table: `TRUE` means to
      escape the whole table, and `FALSE` means not to escape it;
      alternatively, you can specify numeric column indices or column
      names to indicate which columns to escape, e.g. `1:5` (the first 5
      columns), `c(1, 3, 4)`, or `c(-1, -3)` (all columns except the
      first and third), or `c('Species', 'Sepal.Length')`; since the row
      names take the first column to display, you should add the numeric
      column indices by one when using `rownames`

  `style`

  :   either `'auto'`, `'default'`, `'bootstrap'`, or `'bootstrap4'`. If
      `'auto'`, and a **bslib** theme is currently active, then
      bootstrap styling is used in a way that "just works" for the
      active theme. Otherwise, [DataTables `'default'`
      styling](https://datatables.net/manual/styling/classes) is used.
      If set explicitly to `'bootstrap'` or `'bootstrap4'`, one must
      take care to ensure Bootstrap's HTML dependencies (as well as
      Bootswatch themes, if desired) are included on the page. Note,
      when set explicitly, it's the user's responsibility to ensure that
      only one unique `style` value is used on the same page, if
      multiple DT tables exist, as different styling resources may
      conflict with each other.

  `width,height`

  :   Width/Height in pixels (optional, defaults to automatic sizing)

  `elementId`

  :   An id for the widget (a random string by default).

  `fillContainer`

  :   `TRUE` to configure the table to automatically fill it's
      containing element. If the table can't fit fully into it's
      container then vertical and/or horizontal scrolling of the table
      cells will occur.

  `autoHideNavigation`

  :   `TRUE` to automatically hide navigational UI (only display the
      table body) when the number of total records is less than the page
      size. Note, it only works on the client-side processing mode and
      the `pageLength` option should be provided explicitly.

  `lazyRender`

  :   `FALSE` to render the table immediately on page load, otherwise
      delay rendering until the table becomes visible.

  `selection`

  :   the row/column selection mode (single or multiple selection or
      disable selection) when a table widget is rendered in a Shiny app;
      alternatively, you can use a list of the form
      `list(mode = 'multiple', selected = c(1, 3, 8), target = 'row', selectable = c(-2, -3))`
      to pre-select rows and control the selectable range; the element
      `target` in the list can be `'column'` to enable column selection,
      or `'row+column'` to make it possible to select both rows and
      columns (click on the footer to select columns), or `'cell'` to
      select cells. See details section for more info.

  `extensions`

  :   a character vector of the names of the DataTables extensions
      (<https://datatables.net/extensions/index>)

  `plugins`

  :   a character vector of the names of DataTables plug-ins
      (<https://rstudio.github.io/DT/plugins.html>). Note that only
      those plugins supported by the `DT` package can be used here. You
      can see the available plugins by calling
      `DT:::available_plugins()`

  `editable`

  :   `FALSE` to disable the table editor, or `TRUE` (or `"cell"`) to
      enable editing a single cell. Alternatively, you can set it to
      `"row"` to be able to edit a row, or `"column"` to edit a column,
      or `"all"` to edit all cells on the current page of the table. In
      all modes, start editing by doubleclicking on a cell. This
      argument can also be a list of the form
      `list(target = TARGET, disable = list(columns = INDICES))`, where
      `TARGET` can be `"cell"`, `"row"`, `"column"`, or `"all"`, and
      `INDICES` is an integer vector of column indices. Use the list
      form if you want to disable editing certain columns. You can also
      restrict the editing to accept only numbers by setting this
      argument to a list of the form
      `list(target = TARGET, numeric = INDICES)` where `INDICES` can be
      the vector of the indices of the columns for which you want to
      restrict the editing to numbers or `"all"` to restrict the editing
      to numbers for all columns. If you don't set `numeric`, then the
      editing is restricted to numbers for all numeric columns; set
      `numeric = "none"` to disable this behavior. It is also possible
      to edit the cells in text areas, which are useful for large
      contents. For that, set the `editable` argument to a list of the
      form `list(target = TARGET, area = INDICES)` where `INDICES` can
      be the vector of the indices of the columns for which you want the
      text areas, or `"all"` if you want the text areas for all columns.
      Of course, you can request the numeric editing for some columns
      and the text areas for some other columns by setting `editable` to
      a list of the form
      `list(target = TARGET, numeric = INDICES1, area = INDICES2)`.
      Finally, you can edit date cells with a calendar with
      `list(target = TARGET, date = INDICES)`; the target columns must
      have the `Date` type. If you don't set `date` in the `editable`
      list, the editing with the calendar is automatically set for all
      `Date` columns.

- html_tags:

  Logical. If TRUE, returns the table as a `tagList` object.

- extra:

  Logical. If TRUE, adds extra options like search to the datatable.

## Value

A DT object suitable to be used with
[`print()`](https://rdrr.io/r/base/print.html).
