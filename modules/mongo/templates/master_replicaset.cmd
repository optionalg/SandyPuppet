rs.initiate({"_id" : "<%= replSet %>","members" : [{"_id" : 0,"host" : "<%= mongoHostName %>:<%= port %>","priority" : 50}]})
