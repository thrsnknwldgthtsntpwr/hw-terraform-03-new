resource "local_file" "hosts_templatefile" {
  content = templatefile(
    "hosts.tftpl", 
    { 
      group_hosts = tolist(
        [
          {
            group = "webservers"
            hosts = yandex_compute_instance.web[*]
          },
          {
            group = "databases"
            hosts = values(yandex_compute_instance.db)
          },
          {
           group = "storage"
           hosts = yandex_compute_instance.storj[*]
          }
      ]
    )
  }
)
  filename = "hosts"
}