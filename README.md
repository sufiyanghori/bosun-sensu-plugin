# bosun-sensu-plugin
Send sensu metrics data to Bosun monitoring system 

## Files
* bosun_handler.json
* bosun_settings.json
* bosun.rb

## Installation

Create a handler file `bosun_handler.json` in `/etc/sensu/conf.d` with the following content, 

```json
{
  "handlers": {
    "bosun": {
      "type": "pipe",
      "command": "/etc/sensu/plugins/bosun.rb"
    }
  }
}
```

Now, create a file `bosun_settings.json` in `/etc/sensu/conf.d` to configure Bosun API end point, replacing with your own configuration:

{
  "bosun" : {
     "bosun_host" : "http://192.168.17.154",
     "bosun_port" : 8070,
     "bosun_tags" : {"tag1":"tag_value","tag2":"tag_value"}
   }
}
