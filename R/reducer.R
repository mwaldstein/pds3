reduce <- function(dat) {
  obj_stack <- list(list())
  name_stack <- c()
  # Assign a value

  for (i in seq_along(dat)) {
    cmd <- dat[[i]]
    if (cmd$action == 'assignment') obj_stack[[1]][[cmd$name]] <- cmd$value
    else if (cmd$action == 'group_start') {
      obj_stack <- list(list(), unlist(obj_stack, recursive = F))
      name_stack <- c(cmd$name, name_stack)
    } else if (cmd$action == 'group_end') {
      obj_stack[[2]][[name_stack[1]]] <- obj_stack[[1]]
      obj_stack <- obj_stack[2:length(obj_stack)]
      name_stack <- name_stack[2:length(name_stack)]
    } else if (cmd$action == 'pointer') {
      obj_stack[[1]][[cmd$name]] <- list(value = cmd$value, offset = cmd$offset)
    }
  }

  return(obj_stack[[1]])
}
