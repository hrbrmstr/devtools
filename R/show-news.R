#' Show package news
#'
#' @template devtools
#' @param latest if `TRUE`, only show the news for the most recent
#'   version.
#' @param ... other arguments passed on to `news`
#' @export
show_news <- function(pkg = ".", latest = TRUE, ...) {
  pkg <- as.package(pkg)
  news_path <- file.path(pkg$path, "NEWS")

  if (!file.exists(news_path)) {
    stop("No NEWS found", call. = FALSE)
  }

  check_dots_used()

  out <- utils::news(..., db = ("tools" %:::% ".news_reader_default")(news_path))
  if (latest) {
    ver <- numeric_version(out$Version)
    recent <- ver == max(ver)
    structure(out[recent, ],
      class = class(out),
      bad = attr(out, "bad")[recent]
    )
  } else {
    out
  }
}
